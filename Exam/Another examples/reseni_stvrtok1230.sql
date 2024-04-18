alter table zakaznik add premium int check (premium in (0,1, 2))

1, Vytvoøte trigger na tabulku \texttt{Zakaznik}, který bude provádìt kontrolu poètu nákupù u zákazníka v pøípadì, že se zákazníkovi snažíme nastavit hodnotu u atributu \texttt{premium}. Pokud nesplòuje podmínku pro nastavení dané hondoty vyvolejte vyjímku. Ukažte na testovacích datech, že trigger funguje. 
select * from zakaznik
select zid, count(*) from nakup
group by zid

create or replace trigger kontrolaPremium
before insert or update
on zakaznik
for each row
declare
  v_pocet_nakupu int;
  e_premium_does_not_correspond exception;
begin
    select count(*) into v_pocet_nakupu
    from nakup n
    where n.zid = :new.zid;
    
    if v_pocet_nakupu < 3 and :new.premium != 0 or 
      v_pocet_nakupu >= 3 and v_pocet_nakupu <= 5 and :new.premium != 1 or
      v_pocet_nakupu > 5 and :new.premium != 2 then
      raise e_premium_does_not_correspond;
    end if;
end;
/

update zakaznik
set premium = 0
where zid = 1


update zakaznik
set premium = 1
where zid = 1

2, Vytvoøte proceduru \texttt{nastaveniPremiovychUctu(pocet int)}, která nastaví hodnoty atributu \texttt{premium} dle požadavkù. V atributu \texttt{pocet} navíc vrátí poèet záznamù, které mají nastavenu hodnotu špatnì.

create or replace procedure nastaveniPremiovychUctu(pocet out int) as
  chyba int := 0;
begin
  select count(*) into chyba
  from zakaznik
  where zid in 
  (
    select zid
    from nakup n
    group by n.zid
    having count(*) < 3
  ) and (premium != 0 or premium is null);
  pocet := chyba;

  select count(*) into chyba
  from zakaznik
  where zid in 
  (
    select zid
    from nakup n
    group by n.zid
    having count(*) >= 3 and count(*) <= 5
  ) and (premium != 1 or premium is null);
  pocet := pocet + chyba;

  select count(*) into chyba
  from zakaznik
  where zid in 
  (
    select zid
    from nakup n
    group by n.zid
    having count(*) > 5
  ) and (premium != 2 or premium is null);
  pocet := pocet + chyba;

  update zakaznik
  set premium = 0
  where zid in 
  (
    select zid
    from nakup n
    group by n.zid
    having count(*) < 3
  );
  
  update zakaznik
  set premium = 1
  where zid in 
  (
    select zid
    from nakup n
    group by n.zid
    having count(*) >= 3 and count(*) <= 5
  );  
  

  update zakaznik
  set premium = 2
  where zid in 
  (
    select zid
    from nakup n
    group by n.zid
    having count(*) > 5
  );    
end;

set serveroutput on
declare 
  v_pocet int;
begin
  nastaveniPremiovychUctu(v_pocet);
  dbms_output.put_line(v_pocet);
end;
