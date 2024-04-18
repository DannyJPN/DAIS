create or replace trigger kontrolMaximalCapacity
before insert on polozka
for each row
declare
  maxPolozek int;
  aktualniPocetPolozek int;
  objednavkaPlna exception;
begin
  select maximalniPocetPolozek into maxPolozek 
    from osoba os
    join objednavka ob on os."uID" = ob."uID"
    where ob."oID" = :NEW."oID";
    
  select count(*) into aktualniPocetPolozek
    from polozka p
    where p."oID" = :NEW."oID";
    
  if aktualniPocetPolozek >= maxPolozek then
    raise objednavkaPlna;
  end if;
end;
/
create or replace TRIGGER CalculateOrderTotalPrice
BEFORE INSERT OR UPDATE OR DELETE
ON Polozka
FOR EACH ROW
DECLARE
  v_orderTotalPrice INT;
BEGIN  
  -- determine operation
  CASE
    WHEN inserting THEN
      -- get current order total price and update
      select NVL(CelkovaCena, 0) INTO v_orderTotalPrice FROM Objednavka WHERE "oID" = :NEW."oID";
      UPDATE Objednavka SET CelkovaCena = v_orderTotalPrice + (:NEW.Cena * :NEW.Kusu) WHERE "oID" = :NEW."oID";

    WHEN updating THEN
      BEGIN
        -- check whether item was assigned to different order
        IF (:NEW."oID" != :OLD."oID") THEN
          BEGIN
            -- get new order total price and update
            select NVL(CelkovaCena, 0) INTO v_orderTotalPrice FROM Objednavka WHERE "oID" = :NEW."oID";
            UPDATE Objednavka SET CelkovaCena = v_orderTotalPrice + (:NEW.Cena * :NEW.Kusu) WHERE "oID" = :NEW."oID";
            
            -- get old order total price and update
            select NVL(CelkovaCena, 0) INTO v_orderTotalPrice FROM Objednavka WHERE "oID" = :OLD."oID";
            UPDATE Objednavka SET CelkovaCena = v_orderTotalPrice - (:OLD.Cena * :OLD.Kusu) WHERE "oID" = :OLD."oID";
          END;
        ELSIF(:NEW.Cena != :OLD.Cena OR :NEW.Kusu != :OLD.Kusu) THEN
          BEGIN
            -- item count or price was changed
            
            -- get new order total price and update
            select NVL(CelkovaCena, 0) INTO v_orderTotalPrice FROM Objednavka WHERE "oID" = :NEW."oID";
            UPDATE Objednavka SET CelkovaCena = v_orderTotalPrice - (:OLD.Cena * :OLD.Kusu - :NEW.Cena * :NEW.Kusu) WHERE "oID" = :OLD."oID";
          END;
        END IF;
        
      END;
      
    WHEN deleting THEN
      -- get current order total price
      select NVL(CelkovaCena, 0) INTO v_orderTotalPrice FROM Objednavka WHERE "oID" = :OLD."oID";
  
      -- update order total price change
      UPDATE Objednavka SET CelkovaCena = v_orderTotalPrice - (:OLD.Cena * :OLD.Kusu) WHERE "oID" = :OLD."oID";
      
  END CASE;
  
END;