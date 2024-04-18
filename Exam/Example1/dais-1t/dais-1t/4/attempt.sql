/*pøidejte do tabulky Osoba atribut maximalniPocetPolozek typu int.
Atribut maximalniPocetPolozek bude vyjad¡rovat maxim´aln´? po¡cet polo¡zek na jedn´e objedn´avce dan´e
osoby. Vytvo¡rte trigger (¡re¡st¡e pouze operaci INSERT), kter ´y bude kontrolovat, zda-li maximum u osoby nen´?
p¡rekro¡ceno. Pokud je po¡cet p¡rekro¡cen, tak vyvol´a vyj´?mku. Uka¡zte na testovac´?ch datech, ¡ze trigger funguje.*/

select * from objednavka;
/
alter table Osoba add maximalniPocetPolozek int;
/
select * from Polozka;
select * from Objednavka;
select p."oID" ,count(*) from Polozka p join Objednavka o on p."oID" = o."oID" group by p."oID";
/
create or replace trigger MaxCheck
before insert
on Polozka
for each row
declare 
os_count int;
os_max int;
my_exc exception;
begin
    select count(*) into os_count from Polozka p 
    where p."oID" = :NEW."oID" ;

   
    select os.maximalniPocetPolozek into os_max from Objednavka o    
    join Osoba os on o."uID" = os."uID"
    where o."oID" = :NEW."oID" ;
    
    dbms_output.put_line('os count:' || os_count||'    os max:'|| os_max);
    if(os_count >= os_max) then
        begin
            raise my_exc;   
        end;
    else
        begin
            dbms_output.put_line('OK!');
           
        end;
    end if;
    /*
    exception
    when my_exc then
        begin
                dbms_output.put_line('Overflow!');
                
        end;
    when others then
        begin
                dbms_output.put_line('Other error!');
                
        end;
    */
    
end;
/
select * from Osoba;
select * from Polozka where "oID" = 5;
select * from objednavka;

update osoba 
set maximalnipocetpolozek = 5;
/
update objednavka 
set celkovacena = 0
where celkovacena is null;

/
select o."oID", count(*)
from objednavka o
join polozka p on o."oID" = p."oID"
group by o."oID"
having count(*) = 4;
/
select *
from polozka
where "oID" = 3;
/
set serveroutput on
begin
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(3, 6, 2405, 8); -- projde ok
exception 
when others then
dbms_output.put_line('external error!');
end;
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(3, 4, 2405, 8); -- zavola se vyjimka
delete from Polozka where "oID" = 4 and cena >10000;

--2
/*Vytvo¡rte pr´azdnou tabulku Objednavka old, kter´a bude m´?t identickou strukturu s tabulkou Objednavka
a jeden atribut nav´?c presun typu date. Napi¡ste proceduru
objednavka presun(p zastarale date, p pocet polozek int, p pocet int), kter´a p¡resune z tabulky
Objednavka v¡sechny objedn´avky, kde dorucena < p zastarale a nav´?c pouze objedn´avky maj´?c´?
v´?ce ne¡z p pocet polozek polo¡zek. Do hodnoty atributu presun dejte aktualn´? datum. V atributu p pocet
vrat’te po¡cet p¡resunut´ych z´aznam°u a proceduru napi¡ste jako transakci. Uka¡zte na testovac´?m vol´an´?, ¡ze procedura
funguje. (10b)*/
select * from Objednavka;
/
select * from Objednavka_old;
/

create or replace procedure Transport(p_old_at date,p_itemcount int, p_count out int )
as
itemcount int;
begin
for ord in  (  select o.*,(select count(*) from Polozka p where p."oID" = o."oID")as icount
    from objednavka o
    where o.dorucena < p_old_at)
    loop
        dbms_output.put_line(ord."oID"||' '|| ord."uID"||' '||ord.vytvorena||' '||ord.potvrzena||' '||ord.dorucena||' '||ord.zaid||' '||ord.celkovacena||' '||ord.icount);
    
    
    end loop;
    
end;
/
execute Transport();
CREATE TABLE objednavka_old AS
SELECT * FROM objednavka WHERE "oID"> 1000;
/
alter table objednavka_old add presun date;