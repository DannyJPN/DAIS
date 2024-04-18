-- Varianta 1, Ukol 1

ALTER PROCEDURE [dbo].[spPrintInvoices] AS
BEGIN
	DECLARE @v_idInvoice INT;
	DECLARE @v_idInvoiceOld INT;
	DECLARE @v_timestamp DATE;
	DECLARE @v_total INT;
	DECLARE @v_idProduct INT;
	DECLARE @v_name VARCHAR(100);
	DECLARE @v_amount INT;
	DECLARE @v_cost FLOAT;
	DECLARE @v_totalCost FLOAT;

	DECLARE c CURSOR FOR
	SELECT
		Invoice.idInvoice, Invoice.[timestamp], ISNULL(T.total, 0) AS [total],
		Product.idProduct, Product.name, ProductInvoice.amount, Product.cost,
		ProductInvoice.amount * Product.cost AS [totalCost]
	FROM
		Invoice
		LEFT JOIN ProductInvoice ON Invoice.idInvoice = ProductInvoice.idInvoice
		LEFT JOIN Product ON ProductInvoice.idProduct = Product.idProduct
		LEFT JOIN
		(
			SELECT Invoice.idInvoice, SUM(ProductInvoice.amount * Product.Cost) AS [total]
			FROM
				Invoice
				JOIN ProductInvoice ON Invoice.idInvoice = ProductInvoice.idInvoice
				JOIN Product ON ProductInvoice.idProduct = Product.idProduct
			GROUP BY Invoice.idInvoice
		) T ON Invoice.idInvoice = T.idInvoice;
		
	OPEN c;
	
	SET @v_idInvoiceOld = 0;
	FETCH FROM c INTO @v_idInvoice, @v_timestamp, @v_total, @v_idProduct, @v_name, @v_amount, @v_cost, @v_totalCost;
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @v_idInvoice != @v_idInvoiceOld
		BEGIN
			PRINT CAST(@v_idInvoice AS VARCHAR) + '; ' + CAST(@v_timestamp AS VARCHAR) + '; celkem: ' + CAST(@v_total AS VARCHAR) + ' kc';
		END;
		
		IF @v_idProduct != NULL
		BEGIN
			PRINT '  * ' + CAST(@v_idProduct AS VARCHAR) + '; ' + @v_name + '; ' + CAST(@v_amount AS VARCHAR) + ' ks; ' +
				CAST(@v_cost AS VARCHAR) + ' kc; celkem: ' + CAST(@v_totalCost AS VARCHAR) + ' kc';
		END;
	
		SET @v_idInvoiceOld = @v_idInvoice;
		FETCH FROM c INTO @v_idInvoice, @v_timestamp, @v_total, @v_idProduct, @v_name, @v_amount, @v_cost, @v_totalCost;
	END;	
	
	CLOSE c;
	DEALLOCATE c;
END;

-- Varianta 1, Ukol 2
ALTER PROCEDURE [dbo].[spChangeInvoice](@p_idProduct INT, @p_invoiceSrc INT, @p_invoiceDst INT) AS
BEGIN
	DECLARE @v_cost FLOAT;
	DECLARE @v_amount INT;
	
	IF @p_invoiceSrc = @p_invoiceDst
	BEGIN
		PRINT 'Zdrojova a cilova faktura se shoduje.';
		RETURN;
	END;
	
	IF @p_idProduct NOT IN (SELECT idProduct FROM ProductInvoice WHERE idInvoice = @p_invoiceSrc)
	BEGIN
		PRINT 'Zdrojova faktura neobsahuje pozadovany produkt.';
		RETURN;
	END;
		
	IF @p_idProduct IN (SELECT idProduct FROM ProductInvoice WHERE idInvoice = @p_invoiceDst)
	BEGIN
		PRINT 'Cilova faktura jiz pozadovany produkt obsahuje.';
		RETURN;
	END;
	
	BEGIN TRANSACTION
	BEGIN TRY	
		SELECT @v_amount = ProductInvoice.amount, @v_cost = ProductInvoice.amount * Product.cost
		FROM ProductInvoice JOIN Product ON ProductInvoice.idProduct = Product.idProduct
		WHERE ProductInvoice.idInvoice = @p_invoiceSrc AND ProductInvoice.idProduct = @p_idProduct;
		
		UPDATE Invoice
		SET cost = cost - @v_cost
		WHERE idInvoice = @p_invoiceSrc;
		
		UPDATE Invoice
		SET cost = cost + @v_cost
		WHERE idInvoice = @p_invoiceDst;
		
		DELETE FROM ProductInvoice
		WHERE idInvoice = @p_invoiceSrc AND idProduct = @p_idProduct;

		INSERT INTO ProductInvoice (idProduct, idInvoice, amount)
		VALUES (@p_idProduct, @p_invoiceDst, @v_amount);
		
		COMMIT;
	END TRY
	BEGIN CATCH
		ROLLBACK;
	END CATCH;
END;