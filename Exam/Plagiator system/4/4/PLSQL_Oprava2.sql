create or replace 
TRIGGER InsertInvoiceProduct BEFORE INSERT ON ProductInvoice FOR EACH ROW
DECLARE
  v_maxAmount INT;
  v_idStore INT;
  v_cost FLOAT;
BEGIN
  SELECT NVL(MAX(amount), 0) INTO v_maxAmount
  FROM ProductStore
  WHERE idProduct = :new.idProduct;

  IF :new.amount > v_maxAmount THEN
    dbms_output.put_line('Produkt nenalezen v pozadovanem mnozstvi');
  ELSE
    SELECT MIN(idStore) INTO v_idStore
    FROM ProductStore
    WHERE idProduct = :new.idProduct;
    
    UPDATE ProductStore
    SET amount = amount - :new.amount
    WHERE idProduct = :new.idProduct AND idStore = v_idStore;
    
    SELECT cost INTO v_cost
    FROM Product
    WHERE idProduct = :new.idProduct;
    
    UPDATE Invoice
    SET cost = cost + v_cost * :new.amount
    WHERE idInvoice = :new.idInvoice;
  END IF;
END;