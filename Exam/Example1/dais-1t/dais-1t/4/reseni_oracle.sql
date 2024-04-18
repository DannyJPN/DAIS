
-- ******************** priklad cislo jedna
alter table osoba add maximalniPocetPolozek int;

-- trigger
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

-- test funkcnosti
update osoba 
set maximalnipocetpolozek = 5

select o."oID", count(*)
from objednavka o
join polozka p on o."oID" = p."oID"
group by o."oID"
having count(*) = 4

select *
from polozka
where "oID" = 3

INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(3, 2, 2405, 8); -- projde ok
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(3, 3, 2405, 8); -- zavola se vyjimka

-- ********************************* Druhy priklad
drop table objednavka_old;
CREATE TABLE objednavka_old AS SELECT * FROM objednavka WHERE "oID" > 1000;
alter table objednavka_old add presun date;

select * from objednavka_old;

create or replace procedure objednavka_presun(
  p_zastarale date, 
  p_pocet_polozek int, 
  p_pocet out int)
as  
begin
  select  count(*) into p_pocet
  from
  (
    select 1
    from Objednavka o
    join polozka p on o."oID" = p."oID"
    where dorucena < p_zastarale
    group by o."oID"
    having count(*) > p_pocet_polozek
  );

  insert into objednavka_old
    select  o."oID", uID, vytvorena, potvrzena, dorucena, zaID, current_date 
    from Objednavka o
    join polozka p on o."oID" = p."oID"
    where dorucena < p_zastarale
    group by o."oID"
    having count(*) > p_pocet_polozek;
    
  delete from polozka p
  where p."oID" in
  (
      select o."oID"
      from Objednavka o
      join polozka p on o."oID" = p."oID"
      where dorucena < p_zastarale
      group by o."oID"
      having count(*) > p_pocet_polozek  
  );
  
  delete from Objednavka o
  where o."oID" in
  (
      select o."oID"
      from Objednavka o
      join polozka p on o."oID" = p."oID"
      where dorucena < p_zastarale
      group by o."oID"
      having count(*) > p_pocet_polozek  
  )  ;
  
  commit;
exception
  when others then
    p_pocet := 0;
    rollback;  
end;
/