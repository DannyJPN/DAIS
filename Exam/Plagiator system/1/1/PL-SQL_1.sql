DECLARE
  v_line VARCHAR(1000);
  v_amount INT;
BEGIN
  v_line := RPAD(' ', 30, ' ') || '  ';
  FOR v_store IN (SELECT idStore, name FROM Store)
  LOOP
    v_line := v_line || RPAD(v_store.name, 20, ' ');
  END LOOP;
  dbms_output.put_line(v_line);

  FOR v_product IN (SELECT idProduct, name FROM Product)
  LOOP
    v_line := RPAD(v_product.name, 30, ' ') || '  ';
    
    FOR v_store IN (SELECT idStore, name FROM Store)
    LOOP
      SELECT NVL(SUM(amount), 0) INTO v_amount
      FROM ProductStore
      WHERE idProduct = v_product.idProduct AND idStore = v_store.idStore;
      
      v_line := v_line || RPAD(v_amount, 20, ' ');
    END LOOP;
    
    dbms_output.put_line(v_line);
  END LOOP;
END;