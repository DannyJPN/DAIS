1,Pøidejte do tabulky \texttt{Nakup} atribut \texttt{zaruka} typu \texttt{int}. Atribut \texttt{zaruka} bude vyjadøovat poèet dní od nákupu, kdy je možné vytvoøit reklamaci. Vytvoøte trigger na tabulce \texttt{Reklamace}, který bude kontrolovat, zda-li je zboží v záruce. Pokud není, vyvolá vyjímku. Ukažte na testovacích datech, že trigger funguje.

alter table nakup add zaruka in

select n.nid, current_date - den  from nakup n

update nakup 
set zaruka = 1000

select * from reklamace where nid = 4

insert into reklamace values (2, 3, 10, 5566);

select * from reklamace where nid = 2

insert into reklamace values (2, 4, 10, 5566);


create or replace trigger kontrolaZaruky 
before insert
on reklamace
for each row
declare
  v_end_date date;
  e_after_end_date exception;
begin
   select n.DEN + zaruka into v_end_date from nakup n where n.nid = :NEW.nid;
   if v_end_date < current_date 
   then
     raise e_after_end_date;
   end if;
end;
/

2, Vytvoøte prázdnou tabulku \texttt{Nakup\_old}, která bude mít identickou strukturu s tabulkou \texttt{Nakup} a jeden atribut navíc \texttt{presun} typu \texttt{date}. Napište proceduru\\ \texttt{nakup\_presun(p\_zastarale date, p\_pocet int)}, která pøesune z tabulky \texttt{Nakup} všechny záznamy, kde \texttt{den < p\_zastarale}. Do hodnoty atributu \texttt{presun} dejte aktualní datum. V atributu \texttt{p\_pocet} vrate poèet pøesunutých záznamù a proceduru napište jako transakci. Ukažte na testovacím volání, že procedura funguje.


drop table Nakup_old
create table Nakup_old as select * from nakup where nid > 1000;
alter table Nakup_old add presun date;

desc nakup_old;
select * from nakup_old;
select * from nakup;

create or replace procedure nakup_presun(p_zastarale date, p_pocet out int) as
begin
  select count(*) into p_pocet
  from nakup n
  where n.den < p_zastarale;

  insert into nakup_old 
  select n.nid, n.zid, n.pid, n.den, n.cena, n.kusu, current_date 
  from nakup n
  where n.den < p_zastarale;
      
  delete from reklamace r
  where r.nid in 
  (
    select nid 
    from nakup n
    where n.den < p_zastarale
  );
  
  delete from nakup n
  where n.den < p_zastarale;
  
  commit;
exception
  when others then
    p_pocet := 0;
    rollback;
end;


set serveroutput on
declare 
  v_pocet int;
begin
  nakup_presun(TO_DATE('1.1.2013','DD.MM.YYYY'), v_pocet);
  dbms_output.put_line(v_pocet);
end;
/
