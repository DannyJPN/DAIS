-- Varianta 2, Ukol 1
create or replace 
PROCEDURE spPrintStores AS
  v_idStoreOld INT;
BEGIN
  v_idStoreOld := 0;
  FOR v_rec IN (
  SELECT
	  Store.idStore, Store.name, NVL(T.total, 0) AS total,
	  Product.idProduct, Product.name AS productName, ProductStore.amount,
    Product.cost, ProductStore.amount * Product.cost AS totalCost
	FROM
	  Store
	  LEFT JOIN ProductStore ON Store.idStore = ProductStore.idStore
	  LEFT JOIN Product ON ProductStore.idProduct = Product.idProduct
	  LEFT JOIN
	  (
	    SELECT Store.idStore, SUM(ProductStore.amount * Product.Cost) AS total
	    FROM
        Store
        JOIN ProductStore ON Store.idStore = ProductStore.idStore
        JOIN Product ON ProductStore.idProduct = Product.idProduct
      GROUP BY Store.idStore
    ) T ON Store.idStore = T.idStore
  )
  LOOP
    IF v_rec.idStore <> v_idStoreOld THEN
      dbms_output.put_line(v_rec.idStore || '; ' || v_rec.name || '; celkem: ' || v_rec.total || ' kc');
    END IF;
    
    IF v_rec.idProduct IS NOT NULL THEN
      dbms_output.put_line('  * ' || v_rec.idProduct || '; ' || v_rec.productName || '; ' ||
        v_rec.amount || ' ks; ' || v_rec.cost || ' kc; celkem: ' || v_rec.totalCost || ' kc');
    END IF;
    
    v_idStoreOld := v_rec.idStore;
  END LOOP;
END;

-- Varianta 2, Ukol 2
create or replace 
PROCEDURE spChangeStore(p_idProduct Product.idProduct%TYPE,
  p_storeSrc Store.idStore%TYPE, p_storeDst Store.idStore%TYPE, p_amount INT) AS
  
  v_amountAvailable INT;
  v_cntSrc INT;
  v_cntDst INT;
BEGIN
  IF p_storeSrc = p_storeDst THEN
    dbms_output.put_line('Zdrojovy a cilovy sklad se shoduji.');
    RETURN;
  END IF;

  SELECT COUNT(*) INTO v_cntSrc
  FROM ProductStore
  WHERE idProduct = p_idProduct AND idStore = p_storeSrc;

  SELECT COUNT(*) INTO v_cntDst
  FROM ProductStore
  WHERE idProduct = p_idProduct AND idStore = p_storeDst;
  
  IF v_cntSrc = 0 THEN
    dbms_output.put_line('Zdrojovy sklad neobsahuje pozadovany produkt.');
    RETURN;
  END IF;
  
  SELECT amount INTO v_amountAvailable
  FROM ProductStore
  WHERE idProduct = p_idProduct AND idStore = p_storeSrc;
  
  IF v_amountAvailable < p_amount THEN
    dbms_output.put_line('Zdrojovy sklad neobsahuje pozadovane mnozstvi produktu.');
    RETURN;
  END IF;

  IF v_amountAvailable = p_amount THEN
    DELETE FROM ProductStore
    WHERE idProduct = p_idProduct AND idStore = p_storeSrc;    
  ELSE
    UPDATE ProductStore
    SET amount = amount - p_amount
    WHERE idProduct = p_idProduct AND idStore = p_storeSrc;  
  END IF;
  
  IF v_cntDst > 0 THEN
    UPDATE ProductStore
    SET amount = amount + p_amount	
    WHERE idProduct = p_idProduct AND idStore = p_storeDst;
  ELSE
    INSERT INTO ProductStore(idProduct, idStore, amount)
    VALUES (p_idProduct, p_storeDst, p_amount);
  END IF;
  
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
END;