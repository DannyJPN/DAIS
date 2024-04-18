ALTER TRIGGER TG_UpdateTotalCost ON ProductInvoice AFTER INSERT AS
BEGIN
	DECLARE @idInvoice INT;
	DECLARE @idProduct INT;
	DECLARE @amount FLOAT;
	DECLARE @idCustomer INT;
	DECLARE @timestamp DATE;
	DECLARE @productCostActual FLOAT;
	DECLARE @productCostHistory FLOAT;
	DECLARE @productCost FLOAT;
	DECLARE @count INT;
		
	SELECT
		@idInvoice = inserted.idInvoice, @idProduct = inserted.idProduct, @amount = inserted.amount,
		@idCustomer = Invoice.idCustomer, @timestamp = Invoice.timestamp, @productCostActual = Product.cost
	FROM
		inserted
		JOIN Invoice ON Invoice.idInvoice = inserted.idInvoice
		JOIN Product ON Product.idProduct = inserted.idProduct;

	SELECT @productCostHistory = cost
	FROM CostHistory
	WHERE
		idProduct = @idProduct 
		AND [from] <= @timestamp
		AND [to] >= @timestamp
	
	IF @productCostHistory IS NOT NULL
	BEGIN
		SET @productCost = @productCostHistory;
	END
	ELSE BEGIN
		SET @productCost = @productCostActual;
	END;
	
	SELECT @count = COUNT(*)
	FROM Invoice
	WHERE
		idCustomer = @idCustomer AND MONTH(timestamp) = MONTH(@timestamp) AND
		YEAR(timestamp) = YEAR(@timestamp) AND idInvoice != @idInvoice;

	IF @count >= 2
	BEGIN
		SET @productCost *= 0.75;
	END;
	
	UPDATE Invoice
	SET cost += @productCost * @amount
	WHERE idInvoice = @idInvoice;
END;