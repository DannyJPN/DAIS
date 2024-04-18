DECLARE
  v_cost FLOAT;
BEGIN
  FOR v_delivery IN
  (
    SELECT
      Delivery.idDelivery, Delivery.idStore, Delivery.timestamp,
      Store.name AS storeName,
      (
        SELECT COUNT(*)
        FROM DeliveryProduct WHERE DeliveryProduct.idDelivery = Delivery.idDelivery
      ) AS cnt
    FROM Delivery JOIN Store ON Delivery.idStore = Store.idStore
    )
  LOOP
    dbms_output.put_line(v_delivery.timestamp || ' ' || v_delivery.storeName || ' ' || v_delivery.cnt);
    FOR v_product IN
    (
      SELECT Product.idProduct, Product.name, Product.cost, DeliveryProduct.amount
      FROM DeliveryProduct JOIN Product ON DeliveryProduct.idProduct = Product.idProduct
      WHERE DeliveryProduct.idDelivery = v_delivery.idDelivery
    )
    LOOP
      SELECT NVL(MIN(cost), v_product.cost) INTO v_cost
      FROM CostHistory
      WHERE
    		CostHistory.idProduct = v_product.idProduct AND
				CostHistory."from" <= v_delivery.timestamp AND
				CostHistory."to" >= v_delivery.timestamp;
      
      dbms_output.put_line('  ' || v_product.name || '; ' || v_product.amount || '; ' || v_cost || ' Kc');
    END LOOP;
  END LOOP;
END;