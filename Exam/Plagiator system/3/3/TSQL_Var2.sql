-- Varianta 2, Ukol 1
ALTER PROCEDURE [dbo].[spPrintStores] AS
BEGIN
	DECLARE @v_idStore INT;
	DECLARE @v_idStoreOld INT;
	DECLARE @v_storeName VARCHAR(100);
	DECLARE @v_total INT;
	DECLARE @v_idProduct INT;
	DECLARE @v_name VARCHAR(100);
	DECLARE @v_amount INT;
	DECLARE @v_cost FLOAT;
	DECLARE @v_totalCost FLOAT;
	
	DECLARE c CURSOR FOR
	SELECT
		Store.idStore, Store.name, ISNULL(T.total, 0) AS [total],
		Product.idProduct, Product.name, ProductStore.amount, Product.cost,
		ProductStore.amount * Product.cost AS [totalCost]
	FROM
		Store
		LEFT JOIN ProductStore ON Store.idStore = ProductStore.idStore
		LEFT JOIN Product ON ProductStore.idProduct = Product.idProduct
		LEFT JOIN
		(
			SELECT Store.idStore, SUM(ProductStore.amount * Product.Cost) AS [total]
			FROM
				Store
				JOIN ProductStore ON Store.idStore = ProductStore.idStore
				JOIN Product ON ProductStore.idProduct = Product.idProduct
			GROUP BY Store.idStore
		) T ON Store.idStore = T.idStore;
		
	OPEN c;
		
	SET @v_idStoreOld = 0;
	FETCH FROM c INTO @v_idStore, @v_storeName, @v_total, @v_idProduct, @v_name, @v_amount, @v_cost, @v_totalCost;
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @v_idStore != @v_idStoreOld
		BEGIN
			PRINT CAST(@v_idStore AS VARCHAR) + '; ' + @v_storeName + '; celkem: ' + CAST(@v_total AS VARCHAR) + ' kc';
		END;
		
		IF @v_idProduct IS NOT NULL
		BEGIN
			PRINT '  * ' + CAST(@v_idProduct AS VARCHAR) + '; ' + @v_name + '; ' + CAST(@v_amount AS VARCHAR) + ' ks; ' +
				CAST(@v_cost AS VARCHAR) + ' kc; celkem: ' + CAST(@v_totalCost AS VARCHAR) + ' kc';
		END;
	
		SET @v_idStoreOld = @v_idStore;
		FETCH FROM c INTO @v_idStore, @v_storeName, @v_total, @v_idProduct, @v_name, @v_amount, @v_cost, @v_totalCost;
	END;	
	
	CLOSE c;
	DEALLOCATE c;
END;

-- Varianta 2, Ukol 2
ALTER PROCEDURE [dbo].[spChangeStore](@p_idProduct INT, @p_storeSrc INT, @p_storeDst INT, @p_amount INT) AS
BEGIN
	DECLARE @v_amountAvailable INT;
	
	SELECT @v_amountAvailable = amount
	FROM ProductStore
	WHERE idProduct = @p_idProduct AND idStore = @p_storeSrc;
	
	IF @p_storeSrc = @p_storeDst
	BEGIN
		PRINT 'Zdrojovy a cilovy sklad se shoduji.';
		RETURN;
	END;
	
	IF @v_amountAvailable IS NULL
	BEGIN
		PRINT 'Zdrojovy sklad neobsahuje pozadovany produkt.';
		RETURN;
	END;
	
	IF @v_amountAvailable < @p_amount
	BEGIN
		PRINT 'Zdrojovy sklad neobsahuje pozadovane mnozstvi produktu.';
		RETURN;
	END;
	
	BEGIN TRANSACTION;
	BEGIN TRY
		IF @v_amountAvailable = @p_amount
		BEGIN
			DELETE FROM ProductStore
			WHERE idProduct = @p_idProduct AND idStore = @p_storeSrc;
		END
		ELSE BEGIN
			UPDATE ProductStore
			SET amount = amount - @p_amount
			WHERE idProduct = @p_idProduct AND idStore = @p_storeSrc;
		END;
		
		IF EXISTS(SELECT * FROM ProductStore WHERE idProduct = @p_idProduct AND idStore = @p_storeDst)
		BEGIN
			UPDATE ProductStore
			SET amount = amount + @p_amount	
			WHERE idProduct = @p_idProduct AND idStore = @p_storeDst;
		END
		ELSE BEGIN
			INSERT INTO ProductStore(idProduct, idStore, amount)
			VALUES (@p_idProduct, @p_storeDst, @p_amount);
		END;
	
		COMMIT;
	END TRY
	BEGIN CATCH
		ROLLBACK;
	END CATCH;	
END;