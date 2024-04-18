

create or replace procedure PrintProductAnalysis
is
os_name osoba.jmeno%TYPE;
ord_count int;
begin
for zb in (select ZID,nazev from Zbozi order by ZID)loop    
    select count(*) into ord_count from Polozka where zid = zb.zid;
    dbms_output.put_line(zb.nazev||' è. '||zb.ZID);
    if ord_count =0 then
    begin
    dbms_output.put_line('Zbozi nebylo objednano');
    
    end;
    else
    begin
        for item in(select * from(
             select o."uID",sum(p.kusu) as counter
             from Objednavka o
             join Polozka pol on  pol."oID" = o."oID"
             where p.zID = zb.zid 
             group by o."uID"
             order by counter DESC
                )t
            where rownum <=3)
            loop
                select jmeno into os_name from Osoba where "uID" = item."uID";
                dbms_output.put_line('    '||'Zakaznik '||os_name||' ' || item.counter || 'x');
            
            end loop;
    end;
    end if;
end loop;        
    
end;
/
select distinct zid from Polozka order by zid; 
select * from Objednavka;
select * from Zbozi;
select * from Polozka where "oID" = 4;
/
execute PrintProductAnalysis();
/
alter table Objednavka add CelkovaCena real;
/

create or replace trigger TotalPrice 
before update or delete or insert on Polozka
for each row
declare suma int;
begin
    if (INSERTING) then
        begin
            select distinct pol."oID" into suma from Polozka pol where pol."oID" = :NEW."oID";
            update Objednavka Set CelkovaCena = suma where "oID" = :NEW."oID";
        end;
    
    elsif (DELETING) then
        begin
            select distinct pol."oID" into suma from Polozka pol where pol."oID" = :OLD."oID";
            update Objednavka Set CelkovaCena = suma where "oID" = :OLD."oID";
        
        end;
    
    elsif(UPDATING) then
    begin
        if (:OLD."oID" != :NEW."oID")then
            begin
            select distinct pol."oID" into suma from Polozka pol where pol."oID" = :OLD."oID";
            update Objednavka Set CelkovaCena = suma where "oID" = :OLD."oID";
            
            select distinct pol."oID" into suma from Polozka pol where pol."oID" = :NEW."oID";
            update Objednavka Set CelkovaCena = suma where "oID" = :NEW."oID";
            end;
        elsif(:OLD.cena != :NEW.cena or :OLD.kusu != :NEW.kusu )then
            begin
            select distinct pol."oID" into suma from Polozka pol where pol."oID" = :NEW."oID";
            update Objednavka Set CelkovaCena = suma where "oID" = :NEW."oID";
            end;
        end if;
    end;
    
    end if;
end;






















