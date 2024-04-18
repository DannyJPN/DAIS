BEGIN
	DECLARE @timestamp DATE;
	DECLARE @count INT;
	DECLARE @storeName VARCHAR(30);
	DECLARE @productName VARCHAR(100);
	DECLARE @productCost FLOAT;
	DECLARE @idProduct INT;
	DECLARE @idDelivery INT;
	DECLARE @amount INT;
	DECLARE @cost FLOAT;

	DECLARE cOuter CURSOR FOR
	SELECT
		idDelivery, Delivery.timestamp, Store.name,
		(SELECT COUNT(*) FROM DeliveryProduct WHERE DeliveryProduct.idDelivery = Delivery.idDelivery) AS [cnt]
	FROM Delivery JOIN Store ON Delivery.idStore = Store.idStore
	ORDER BY Delivery.timestamp;
	
	OPEN cOuter;
	
	FETCH FROM cOuter INTO @idDelivery, @timestamp, @storeName, @count;
	WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT CAST(@timestamp AS VARCHAR) + ' ' + @storeName + ' ' + CAST(@count AS VARCHAR);
		
		DECLARE cInner CURSOR FOR
		SELECT Product.idProduct, Product.name, Product.cost, DeliveryProduct.amount
		FROM DeliveryProduct JOIN Product ON DeliveryProduct.idProduct = Product.idProduct
		WHERE DeliveryProduct.idDelivery = @idDelivery;
		
		OPEN cInner;
		FETCH FROM cInner INTO @idProduct, @productName, @productCost, @amount;
		WHILE @@FETCH_STATUS = 0
		BEGIN
			SET @cost = NULL;
			SELECT @cost = cost
			FROM CostHistory
			WHERE
				CostHistory.idProduct = @idProduct AND
				CostHistory.[from] <= @timestamp AND
				CostHistory.[to] >= @timestamp;
		
			IF @cost IS NULL
			BEGIN
				SET @cost = @productCost;
			END;
				
			PRINT '  ' + @productName + '; ' + CAST(@amount AS VARCHAR) + '; ' + CAST(@cost AS VARCHAR) + ' Kc';
					
			FETCH FROM cInner INTO @idProduct, @productName, @productCost, @amount;
		END;
		
		CLOSE cInner;
		DEALLOCATE cInner;
			
		FETCH FROM cOuter INTO @idDelivery, @timestamp, @storeName, @count;
	END;
	
	CLOSE cOuter;
	DEALLOCATE cOuter;
END;