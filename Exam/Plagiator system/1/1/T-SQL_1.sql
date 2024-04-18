BEGIN
	DECLARE cProduct CURSOR FOR
	SELECT idProduct, name
	FROM Product;

	DECLARE cStore CURSOR FOR
	SELECT idStore, name
	FROM Store;
	
	DECLARE @idProduct INT;
	DECLARE @productName VARCHAR(100);
	DECLARE @idStore INT;
	DECLARE @storeName VARCHAR(30);
	DECLARE @line NVARCHAR(500);
	DECLARE @amount INT;

	SET @line = dbo.LPAD('', 30, ' ') + '  ';
	OPEN cStore;
	FETCH FROM cStore INTO @idStore, @storeName;
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @line += dbo.LPAD(@storeName, 20, ' ');
		FETCH FROM cStore INTO @idStore, @storeName;
	END;
	CLOSE cStore;
	PRINT @line;
	
	OPEN cProduct;
	FETCH FROM cProduct INTO @idProduct, @productName;
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @line = dbo.LPAD(@productName, 30, ' ') + '  ';
	
		OPEN cStore;
		FETCH FROM cStore INTO @idStore, @storeName;
		WHILE @@FETCH_STATUS = 0
		BEGIN
			SET @amount = 0;
		
			SELECT @amount = amount
			FROM ProductStore
			WHERE idProduct = @idProduct AND idStore = @idStore;
		
			SET @line += dbo.LPAD(@amount, 20, ' ');
		
			FETCH FROM cStore INTO @idStore, @storeName;
		END;
		
		PRINT @line;
		
		FETCH FROM cProduct INTO @idProduct, @productName;
		CLOSE cStore;	
	END;	
	CLOSE cProduct;
	
	DEALLOCATE cProduct;
	DEALLOCATE cStore;
END;