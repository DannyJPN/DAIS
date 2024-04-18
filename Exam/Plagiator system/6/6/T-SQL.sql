-- Vypis zamestnancu a jimi vystavenych faktur
BEGIN
	DECLARE @prevEmployeeId INT;
	DECLARE @employeeId INT;
	DECLARE @eFname VARCHAR(20);
	DECLARE @eLname VARCHAR(30);
	DECLARE @cFname VARCHAR(20);
	DECLARE @cLname VARCHAR(30);
	DECLARE @date DATETIME;
	DECLARE @cost INT;
	DECLARE @line VARCHAR(1000);

	DECLARE c CURSOR FOR
	SELECT
		Employee.employeeId, Employee.fname, Employee.lname,
		Invoice.cost, Invoice.date, Customer.fname, Customer.lname
	FROM
		Employee
		LEFT JOIN Invoice ON Employee.employeeId = Invoice.employeeId
		LEFT JOIN Customer ON Invoice.customerId = Customer.customerId
	ORDER BY
		Employee.lname, Employee.fname
	
	OPEN c;

	SET @prevEmployeeId = -1;
	FETCH NEXT FROM c INTO @employeeId, @eFname, @eLname, @cost, @date, @cFname, @cLname
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @employeeId != @prevEmployeeId
		BEGIN
			SET @line = @eFname + ' ' + @eLname;
			SET @prevEmployeeId = @employeeId;
			PRINT @line;
		END;
		FETCH NEXT FROM c INTO @employeeId, @eFname, @eLname, @cost, @date, @cFname, @cLname
		
		SET @line = RIGHT(REPLICATE(' ', 20) + CAST(@cost AS VARCHAR), 10) + ' Kc, ';
		SET @line = @line + CAST(@date AS VARCHAR) + ', ' + @cFname + ' ' + @cLname
		
		PRINT @line;
	END;
	
	CLOSE c;
	DEALLOCATE c;
END;

-- Vypis zakazniku a faktury pro ne vystavene
BEGIN
	DECLARE @prevCustomerId INT;
	DECLARE @customerId INT;
	DECLARE @cFname VARCHAR(20);
	DECLARE @cLname VARCHAR(30);
	DECLARE @eFname VARCHAR(20);
	DECLARE @eLname VARCHAR(30);
	DECLARE @date DATETIME;
	DECLARE @cost INT;
	DECLARE @line VARCHAR(1000);

	DECLARE c CURSOR FOR
	SELECT
		Customer.customerId, Customer.fname, Customer.lname,
		Invoice.cost, Invoice.date, Employee.fname, Employee.lname
	FROM
		Customer
		LEFT JOIN Invoice ON Invoice.customerId = Customer.customerId
		LEFT JOIN Employee ON Employee.employeeId = Invoice.employeeId
	ORDER BY
		Customer.lname, Customer.fname
	
	OPEN c;

	SET @prevCustomerId = -1;
	FETCH NEXT FROM c INTO @customerId, @cFname, @cLname, @cost, @date, @eFname, @eLname
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @customerId != @prevCustomerId
		BEGIN
			SET @line = @cFname + ' ' + @cLname;
			SET @prevCustomerId = @customerId;
			PRINT @line;
		END;
		FETCH NEXT FROM c INTO @customerId, @cFname, @cLname, @cost, @date, @eFname, @eLname
		
		SET @line = RIGHT(REPLICATE(' ', 20) + CAST(@cost AS VARCHAR), 10) + ' Kc, ';
		SET @line = @line + CAST(@date AS VARCHAR) + ', ' + @eFname + ' ' + @eLname
		
		PRINT @line;
	END;
	
	CLOSE c;
	DEALLOCATE c;
END;

-- Trigger - kontrola, zda jsem schopny pokryt polozky faktury, ridim se podle skladoveho mnozstvi
ALTER TRIGGER TG_CheckCapacity ON ProductInvoice AFTER INSERT AS
BEGIN
	DECLARE @productId INT;
	DECLARE @cnt INT;
	DECLARE @store INT;

	DECLARE c CURSOR FOR
	SELECT productId, ISNULL(SUM("count"), 0) AS [cnt]
	FROM inserted
	GROUP BY productId;
	
	OPEN c;
	FETCH NEXT FROM c INTO @productId, @cnt;
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SELECT @store = SUM("count")
		FROM ProductStore
		WHERE productId = @productId;
		
		IF @cnt > @store
		BEGIN
			ROLLBACK;
			RAISERROR 50001 'Nedostatecne skladove mnozstvi';
		END;
			
		FETCH NEXT FROM c INTO @productId, @cnt;
	END;
	
	CLOSE c;
	DEALLOCATE c;
END;

-- Transakce - presun ve skladu
BEGIN
	DECLARE @productId INT;
	DECLARE @oldStoreId INT;
	DECLARE @newStoreId INT;
	DECLARE @count INT;

	DECLARE @oldCnt INT;
	
	BEGIN TRANSACTION;
	BEGIN TRY
		SELECT @oldCnt = "count"
		FROM ProductStore
		WHERE productId = @productId AND storeId = @oldStoreId;
	
		IF @oldCnt IS NULL
		BEGIN
			RAISERROR 50001 'Neexistuje zaznam o produktu na skladu';
		END;
		IF @oldCnt < @count
		BEGIN
			RAISERROR 50001 'Pozadovane mnozstvi nelze presunout';
		END;
		
		UPDATE ProductStore
		SET "count" = "count" - @count
		WHERE productId = @productId AND storeId = @oldStoreId;
		
		IF EXISTS(SELECT * FROM ProductStore WHERE productId = @productId AND storeId = @newStoreId)
		BEGIN
			UPDATE ProductStore
			SET "count" = "COUNT" + @count
			WHERE storeId = @newStoreId;
		END
		ELSE BEGIN
			INSERT INTO ProductStore (storeId, productId, "count")
			VALUES (@newStoreId, @productId, @count);
		END;
	
		COMMIT;
	END TRY
	BEGIN CATCH
		ROLLBACK;
	END CATCH;
END;

-- Trigger pro vlozeni datumu, kdy byla faktura odeslana a kdy byla zaplacena
--ALTER TABLE Invoice
--ADD dateInvoiced DATE

--ALTER TABLE Invoice
--ADD datePayed DATE

ALTER TRIGGER TG_InvoiceStatusDates ON Invoice AFTER UPDATE AS
BEGIN
	DECLARE @oldStatus CHAR(1);
	DECLARE @newStatus CHAR(1);
	DECLARE @order INT;
	
	SET @oldStatus = (SELECT Status FROM deleted);
	SET @newStatus = (SELECT Status FROM inserted);
	SET @order = (SELECT "order" FROM inserted);
	
	IF @oldStatus = 'e' AND @newStatus = 'o'
	BEGIN
		UPDATE Invoice
		SET dateInvoiced = GETDATE()
		WHERE "order" = @order;
	END;
	
	IF @oldStatus = 'o' AND @newStatus = 'z'
	BEGIN
		UPDATE Invoice
		SET datePayed = GETDATE()
		WHERE "order" = @order;
	END;
END;

-- Inventura - zjistim, co jsem nakoupil, prodal a porovnam s tim, co mam na sklade
BEGIN
	DECLARE @productId INT;
	DECLARE @name VARCHAR(100);
	DECLARE @cnt1 INT;
	DECLARE @cnt2 INT;

	DECLARE c CURSOR FOR
	SELECT productId, name
	FROM Product;
	
	OPEN c;
	FETCH NEXT FROM c INTO @productId, @name;
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SELECT @cnt1 = ISNULL(SUM("count"), 0) - ISNULL(SUM(corruptCount), 0)
		FROM Delivery
		WHERE productId = @productId;
		
		SELECT @cnt1 = @cnt1 - ISNULL(SUM("count"), 0)
		FROM ProductInvoice
		WHERE productId = @productId;
		
		SELECT @cnt2 = ISNULL(SUM("count"), 0)
		FROM ProductStore
		WHERE productId = @productId;
		
		IF @cnt1 != @cnt2
		BEGIN
			PRINT @name;
		END;
		
		FETCH NEXT FROM c INTO @productId, @name;
	END;
	
	CLOSE c;
	DEALLOCATE c;
END;