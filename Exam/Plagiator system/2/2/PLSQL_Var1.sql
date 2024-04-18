-- Varianta 1, Ukol 1
create or replace 
PROCEDURE spPrintInvoices AS
  v_idInvoiceOld Invoice.idInvoice%TYPE;
BEGIN
  v_idInvoiceOld := 0;
  FOR v_rec IN (
    SELECT
      Invoice.idInvoice, Invoice.timestamp, NVL(T.total, 0) AS total,
      Product.idProduct, Product.name, ProductInvoice.amount, Product.cost,
      ProductInvoice.amount * Product.cost AS totalCost
    FROM
      Invoice
      LEFT JOIN ProductInvoice ON Invoice.idInvoice = ProductInvoice.idInvoice
      LEFT JOIN Product ON ProductInvoice.idProduct = Product.idProduct
      LEFT JOIN
      (
        SELECT Invoice.idInvoice, SUM(ProductInvoice.amount * Product.Cost) AS total
        FROM
          Invoice
          JOIN ProductInvoice ON Invoice.idInvoice = ProductInvoice.idInvoice
          JOIN Product ON ProductInvoice.idProduct = Product.idProduct
        GROUP BY Invoice.idInvoice
      ) T ON Invoice.idInvoice = T.idInvoice    
  )
  LOOP
    IF v_rec.idInvoice <> v_idInvoiceOld THEN
      dbms_output.put_line(v_rec.idInvoice || '; ' || v_rec.timestamp || '; celkem: ' || v_rec.total || ' kc');
    END IF;
    
    dbms_output.put_line('  * ' || v_rec.idProduct || '; ' || v_rec.name || '; ' || v_rec.amount ||
      ' ks; ' || v_rec.cost || ' kc; celkem: ' || v_rec.totalCost || ' kc');
    
    v_idInvoiceOld := v_rec.idInvoice;
  END LOOP;
END;

-- Varianta 1, Ukol 2
create or replace 
PROCEDURE spChangeInvoice(p_idProduct Product.idProduct%TYPE,
  p_invoiceSrc Invoice.idInvoice%TYPE, p_invoiceDst Invoice.idInvoice%TYPE) AS
  
  v_cntSrc Invoice.idInvoice%TYPE;
  v_cntDst INT;
  v_amount INT;
  v_cost FLOAT;
BEGIN
  IF p_invoiceSrc = p_invoiceDst THEN
    dbms_output.put_line('Zdrojova a cilova faktura se shoduje.');
    RETURN;
  END IF;
  
  SELECT COUNT(*) INTO v_cntSrc
  FROM ProductInvoice
  WHERE idInvoice = p_invoiceSrc AND idProduct = p_idProduct;

  SELECT COUNT(*) INTO v_cntDst
  FROM ProductInvoice
  WHERE idInvoice = p_invoiceDst AND idProduct = p_idProduct;
  
  IF v_cntSrc = 0 THEN
    dbms_output.put_line('Zdrojova faktura neobsahuje pozadovany produkt.');
    RETURN;
  END IF;

  IF v_cntDst > 0 THEN
    dbms_output.put_line('Cilova faktura jiz pozadovany produkt obsahuje.');
    RETURN;
  END IF;
  
  SELECT ProductInvoice.amount, ProductInvoice.amount * Product.cost INTO v_amount, v_cost
  FROM ProductInvoice JOIN Product ON ProductInvoice.idProduct = Product.idProduct
  WHERE ProductInvoice.idInvoice = p_invoiceSrc AND ProductInvoice.idProduct = p_idProduct;
  
  UPDATE Invoice
  SET cost = cost - v_cost
  WHERE idInvoice = p_invoiceSrc;
  
  UPDATE Invoice
  SET cost = cost + v_cost
  WHERE idInvoice = p_invoiceDst;  
  
  DELETE FROM ProductInvoice
  WHERE idInvoice = p_invoiceSrc AND idProduct = p_idProduct;
  
  INSERT INTO ProductInvoice (idProduct, idInvoice, amount)
  VALUES (p_idProduct, p_invoiceDst, v_amount);
  
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
END;