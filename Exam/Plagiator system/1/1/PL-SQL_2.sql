create or replace 
TRIGGER tgInvoiceProduct AFTER INSERT ON ProductInvoice FOR EACH ROW
DECLARE
  v_idCustomer INT;
  v_idInvoice INT;
  v_idProduct INT;
  v_timestamp DATE;
  v_productCost FLOAT;
  v_historyCost FLOAT;
  v_cost FLOAT;
  v_amount FLOAT;
  v_cnt INT;
BEGIN
  v_idInvoice := :new.idInvoice;
  v_idProduct := :new.idProduct;
  v_amount := :new.amount;
  
  SELECT idCustomer, timestamp INTO v_idCustomer, v_timestamp
  FROM invoice
  WHERE idInvoice = v_idInvoice;
  
  SELECT SUM(cost) INTO v_historyCost
  FROM CostHistory
  WHERE idProduct = v_idProduct AND "from" <= v_timestamp AND "to" >= v_timestamp;
  
  SELECT cost INTO v_productCost 
  FROM Product
  WHERE idProduct = v_idProduct;
  
  v_cost := NVL(v_historyCost, v_productCost);
  
  SELECT COUNT(*) INTO v_cnt
  FROM Invoice
  WHERE
    idCustomer = v_idCustomer AND idInvoice <> v_idInvoice AND
    EXTRACT(MONTH FROM timestamp) = EXTRACT(MONTH FROM v_timestamp) AND
    EXTRACT(YEAR FROM timestamp) = EXTRACT(YEAR FROM v_timestamp);
    
  IF v_cnt >= 2 THEN
    UPDATE Invoice
    SET cost = cost + v_amount * v_cost * 0.75
    WHERE idInvoice = v_idInvoice;
  ELSE
    UPDATE Invoice
    SET cost = cost + v_amount * v_cost
    WHERE idInvoice = v_idInvoice;  END IF;
END;