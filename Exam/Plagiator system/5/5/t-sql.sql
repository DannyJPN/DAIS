-- 1

BEGIN
	DECLARE @p_year INT;
	SET @p_year = 2013;
	
	DECLARE @v_total INT;
	DECLARE @v_amount INT;
	DECLARE @v_date DATETIME;
	DECLARE @v_monthName VARCHAR(50);
	DECLARE @v_line VARCHAR(1000);
	DECLARE @v_bar INT;
	
	SELECT @v_total = ISNULL(SUM([count]), 0)
	FROM Delivery
	WHERE YEAR([date]) = @p_year;
	
	DECLARE @v_month INT;
	SET @v_month = 1;
	WHILE @v_month <= 12
	BEGIN
		SET @v_date = CAST((CAST(@p_year AS VARCHAR) + '-' + CAST(@v_month AS VARCHAR) + '-1') AS DATETIME);
		SET @v_monthName = DATENAME(month, @v_date);

		SET @v_line = LEFT(@v_monthName + REPLICATE(' ', 10), 10) + '|';	
		
		SELECT @v_amount = ISNULL(SUM([count]), 0)
		FROM Delivery
		WHERE YEAR([date]) = @p_year AND MONTH([date]) = @v_month;
		
		SET @v_line += RIGHT(REPLICATE(' ', 8) + CAST(@v_amount AS VARCHAR), 8) + ' |';
		
		IF @v_total != 0
			SET @v_bar = 100 * @v_amount / @v_total;
		ELSE
			SET @v_bar = 0;
		
		SET @v_line += REPLICATE('#', @v_bar) + REPLICATE(' ', 100 - @v_bar) + '|';
		
		PRINT @v_line;
		SET @v_month += 1;
	END;	
END;

-- 2
BEGIN
	DECLARE @p_year INT;
	SET @p_year = 2013;
	
	DECLARE @v_total INT;
	DECLARE @v_amount INT;
	DECLARE @v_line VARCHAR(1000);
	DECLARE @v_bar INT;
	DECLARE @v_name VARCHAR(30);
	DECLARE @v_productId INT;
	
	SELECT @v_total = ISNULL(SUM([count]), 0)
	FROM Delivery
	WHERE YEAR([date]) = @p_year;
	
	DECLARE c CURSOR FOR
	SELECT productId, [name]
	FROM Product
	ORDER BY [name];

	OPEN c;
	
	FETCH FROM c INTO @v_productId, @v_name;
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @v_line = LEFT(@v_name + REPLICATE(' ', 30), 30) + '|';	
		
		SELECT @v_amount = ISNULL(SUM([count]), 0)
		FROM Delivery
		WHERE YEAR([date]) = @p_year AND productId = @v_productId;
		
		SET @v_line += RIGHT(REPLICATE(' ', 8) + CAST(@v_amount AS VARCHAR), 8) + ' |';
		
		IF @v_total != 0
			SET @v_bar = 100 * @v_amount / @v_total;
		ELSE
			SET @v_bar = 0;
		
		SET @v_line += REPLICATE('#', @v_bar) + REPLICATE(' ', 100 - @v_bar) + '|';
		
		PRINT @v_line;
		FETCH FROM c INTO @v_productId, @v_name;
	END;	
	
	CLOSE c;
	DEALLOCATE c;
END;


-- 3
BEGIN
	DECLARE @p_year INT;
	SET @p_year = 2013;
	
	DECLARE @v_total INT;
	DECLARE @v_amount INT;
	DECLARE @v_line VARCHAR(1000);
	DECLARE @v_bar INT;
	DECLARE @v_name VARCHAR(30);
	DECLARE @v_customerId INT;
	
	SELECT @v_total = ISNULL(SUM([count]), 0)
	FROM ProductInvoice JOIN Invoice ON ProductInvoice.[order] = Invoice.[order]
	WHERE YEAR([date]) = @p_year;
	
	DECLARE c CURSOR FOR
	SELECT customerId, [lname] + ' ' + [fname]
	FROM Customer
	ORDER BY [lname], [fname];

	OPEN c;
	
	FETCH FROM c INTO @v_customerId, @v_name;
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @v_line = LEFT(@v_name + REPLICATE(' ', 20), 20) + '|';	
		
		SELECT @v_amount = ISNULL(SUM([count]), 0)
		FROM ProductInvoice JOIN Invoice ON ProductInvoice.[order] = Invoice.[order]
		WHERE YEAR([date]) = @p_year AND customerId = @v_customerId;
		
		SET @v_line += RIGHT(REPLICATE(' ', 8) + CAST(@v_amount AS VARCHAR), 8) + ' |';
		
		IF @v_total != 0
			SET @v_bar = 100 * @v_amount / @v_total;
		ELSE
			SET @v_bar = 0;
		
		SET @v_line += REPLICATE('#', @v_bar) + REPLICATE(' ', 100 - @v_bar) + '|';
		
		PRINT @v_line;
		FETCH FROM c INTO @v_customerId, @v_name;
	END;	
	
	CLOSE c;
	DEALLOCATE c;
END;


-- 4

BEGIN
	DECLARE @p_year INT;
	SET @p_year = 2013;
	
	DECLARE @v_total INT;
	DECLARE @v_amount INT;
	DECLARE @v_line VARCHAR(1000);
	DECLARE @v_bar INT;
	DECLARE @v_name VARCHAR(30);
	DECLARE @v_productId INT;
	
	SELECT @v_total = ISNULL(SUM([count]), 0)
	FROM ProductInvoice JOIN Invoice ON ProductInvoice.[order] = Invoice.[order]
	WHERE YEAR([date]) = @p_year;
	
	DECLARE c CURSOR FOR
	SELECT productId, [name]
	FROM Product
	ORDER BY [name];

	OPEN c;
	
	FETCH FROM c INTO @v_productId, @v_name;
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @v_line = LEFT(@v_name + REPLICATE(' ', 30), 30) + '|';	
		
		SELECT @v_amount = ISNULL(SUM([count]), 0)
		FROM ProductInvoice JOIN Invoice ON ProductInvoice.[order] = Invoice.[order]
		WHERE YEAR([date]) = @p_year AND productId = @v_productId;
		
		SET @v_line += RIGHT(REPLICATE(' ', 8) + CAST(@v_amount AS VARCHAR), 8) + ' |';
		
		IF @v_total != 0
			SET @v_bar = 100 * @v_amount / @v_total;
		ELSE
			SET @v_bar = 0;
		
		SET @v_line += REPLICATE('#', @v_bar) + REPLICATE(' ', 100 - @v_bar) + '|';
		
		PRINT @v_line;
		FETCH FROM c INTO @v_productId, @v_name;
	END;	
	
	CLOSE c;
	DEALLOCATE c;
END;

-- 5
ALTER TRIGGER CheckDelivery ON Delivery FOR INSERT AS
BEGIN
	DECLARE @v_productId INT;
	DECLARE @v_storeId INT;
	DECLARE @v_count INT;

	DECLARE c CURSOR FOR
	SELECT productId, storeId, [count]
	FROM inserted;
	OPEN c;
	
	FETCH NEXT FROM c INTO @v_productId, @v_storeId, @v_count;
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF NOT EXISTS(SELECT * FROM ProductStore WHERE productId = @v_productId AND storeId = @v_storeId)
		BEGIN
			INSERT INTO ProductStore(productId, storeId, [count])
			VALUES (@v_productId, @v_storeId, @v_count);
		END
		ELSE BEGIN
			UPDATE ProductStore
			SET [count] = [count] + @v_count
			WHERE productId = @v_productId AND storeId = @v_storeId;
		END;
		
		FETCH NEXT FROM c INTO @v_productId, @v_storeId, @v_count;
	END;
	
	CLOSE c;
	DEALLOCATE c;
END;

-- 6
ALTER TRIGGER RecomputeInvoice ON ProductInvoice FOR INSERT, UPDATE AS
BEGIN
	DECLARE @v_order INT;
	DECLARE @v_cost MONEY;
	
	DECLARE c CURSOR FOR
	SELECT DISTINCT [order]
	FROM ProductInvoice;

	OPEN c;
	
	FETCH NEXT FROM c INTO @v_order;
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SELECT
			@v_cost = ISNULL(SUM(ProductInvoice.[count] * Product.[cost]), 0)
		FROM
			ProductInvoice
			JOIN Product ON ProductInvoice.productId = Product.productId
		WHERE
			[order] = @v_order;
		
		UPDATE Invoice
		SET [cost] = @v_cost
		WHERE [order] = @v_order;
	
		FETCH NEXT FROM c INTO @v_order;
	END;
	
	CLOSE c;
	DEALLOCATE c;
END;

-- 7
BEGIN
	DECLARE @p_order INT;
	SET @p_order = 1;

	DECLARE @v_prevProductId INT;
	DECLARE @v_productId INT;
	DECLARE @v_productName VARCHAR(50);
	DECLARE @v_storeName VARCHAR(50);
	DECLARE @v_count INT;

	DECLARE c CURSOR FOR
	SELECT
		Product.productId, Product.name, Store.name, ProductStore.[count]
	FROM
		Invoice
		JOIN ProductInvoice ON Invoice.[order] = ProductInvoice.[order]
		JOIN Product ON ProductInvoice.productId = Product.productId
		JOIN ProductStore ON Product.productId = ProductStore.productId
		JOIN Store ON ProductStore.storeId = Store.storeId
	WHERE
		Invoice.[order] = @p_order
	ORDER BY
		Product.name, ProductStore.[count] DESC;
	
	OPEN c;
	FETCH NEXT FROM c INTO @v_productId, @v_productName, @v_storeName, @v_count;
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @v_prevProductId IS NULL OR @v_productId != @v_prevProductId
		BEGIN
			IF @v_prevProductId IS NOT NULL
				PRINT '';
			PRINT @v_productName;
		END;
		
		PRINT '  ' + LEFT(@v_storeName + REPLICATE(' ', 20), 20) + ': ' + CAST(@v_count AS VARCHAR);		
		
		SET @v_prevProductId = @v_productId;
		FETCH NEXT FROM c INTO @v_productId, @v_productName, @v_storeName, @v_count;
	END;
	
	CLOSE c;
	DEALLOCATE c;
END;

-- 8
BEGIN
	DECLARE @p_date DATETIME;
	SET @p_date = '2013-10-04';
	
	DECLARE @v_expense MONEY;
	DECLARE @v_receipt MONEY;
	DECLARE @v_profit MONEY;
	DECLARE @v_count INT;
	DECLARE @v_result MONEY;
	
	SELECT @v_expense = ISNULL(SUM(Product.[cost] * Delivery.[count]), 0)
	FROM
		Delivery
		JOIN Product ON Delivery.productId = Product.productId
	WHERE
		MONTH(Delivery.[date]) = MONTH(@p_date);	

	SELECT @v_receipt = ISNULL(SUM(Invoice.[cost]), 0)
	FROM
		Invoice
	WHERE
		MONTH(Invoice.[date]) = MONTH(@p_date);	
		
	SET @v_profit = @v_receipt - @v_expense;
	
	SELECT @v_count = COUNT(*)
	FROM Employee
	WHERE NOT (@p_date < [from] OR ([to] IS NOT NULL AND @p_date > [to]));
	
	SET @v_result = @v_profit / @v_count;
	PRINT @v_result;
END;