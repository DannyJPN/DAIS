1, Vytvořte proceduru PridejReklamaci s parametry (p_nID, p_poradi, p_delka, p_cena), která bude sloužit pro vložení reklamace do tabulky Reklamace.
K vložení reklamace dojde jenom za dvou podmínek: 
1, Nákup s danym nID existuje v tabulce Nakup. Pokud neexistuje, procedura na obrazovku vypíše text "Reklamovany nakup s nID = p_nID neexistuje."
2, Celková cena reklamácii daného nákupu po pøidaní nesmí pøekroèit cenu nákupu. Pokud by celková cena mìla pøekroèit cenu nákupu, namísto vložení
   reklamace dojde k vyrazení produktu ( t.j. atribut \texttt{rok_ukonceni_vyroby} bude nastaven na aktuální rok) a procedura na obrazovku vypíše text 
   "Kvuli vysoke poruchovosti byl produkt s oznacenim \texttt{pID} vyrazen z vyroby."
V případe úspešného vložení reklamace do systému procedura na obrazovku vypíše text "Reklamace byla uspesne zaevidovana."
Celá procedura musí byt řešena jako transakce.

create or replace procedure PridejReklamaci(p_nID reklamace.nid%type, p_poradi reklamace.poradi%type, p_delka reklamace.delka%type, p_cena reklamace.cena%type)
as
  v_pocet int;
  v_cena_r int;
  v_cena_n int;
  v_pID nakup.pID%type;
begin
  select count(*) into v_pocet from Nakup where nID=p_nID;
  if (v_pocet = 1) then
     select sum(cena) into v_cena_r from Reklamace where nID=p_nID;     
     select cena into v_cena_n from Nakup where nID=p_nID;
     if (v_cena_r + p_cena > v_cena_n) then
       select pID into v_pID from nakup where nID = p_nID;
       update produkt set rok_ukonceni_vyroby = EXTRACT(YEAR from SYSDATE) where pID=v_pID;
       dbms_output.put_line('Kvoli vysokej poruchovosti bol produkt s oznacenim '|| v_pID ||' vyradeny z predaja.');
     else
        insert into reklamace values (p_nID, p_poradi, p_delka, p_cena);
        dbms_output.put_line('Reklamacia bola uspesne zaevidovana.');
     end if;
  else
    dbms_output.put_line('Reklamovany nakup s nID = ' || p_nID || '  neexistuje.');
  end if;
  commit;
exception
  when others then
    rollback;
end;


2, Napište proceduru VypisZakazniku s jedním parametrem p_usporadani typu varchar, který vypíše zakazniky v uspořádaní podle vstupního parametru. 
Možné hodnoty parametru p_usporadani:
a, 'jmeno' - vypsaný seznam zákazniků bude uspořádan abecedne podle jména zákazniků.
b, 'nakup' - vypsaný seznam zákazniků bude uspořádan podle počtu nákupů zákazniků od nejaktivnejších po nejméne aktivní.
c, 'reklamace' - vypisany zoznam zakazniků bude usporadany podle počtu reklamací zákazniků od nejaktivnejších po nejméne aktivní.

create or replace procedure VypisZakazniku (p_usporadani varchar2)
as
  CURSOR a is select jmeno from zakaznik order by jmeno;
  CURSOR b is select zakaznik.zID, jmeno, count(nID) from zakaznik, nakup where zakaznik.zID=nakup.zID group by zakaznik.zID, jmeno order by count(nID) desc;
  CURSOR c is select zakaznik.zID, jmeno, count(reklamace.nID) from zakaznik, nakup, reklamace where zakaznik.zID=nakup.zID and nakup.nID=reklamace.nID group by zakaznik.zID, jmeno order by count(reklamace.nID) desc;
begin
  if (p_usporadani = 'jmeno') then
    dbms_output.put_line('Usporadani zakazniku podle jmena:');
    for riadok in a loop
      dbms_output.put_line(riadok.jmeno);
    end loop;
  elsif (p_usporadani = 'nakup') then
    dbms_output.put_line('Usporadani zakazniku podle nakup:');
    for riadok in b loop
      dbms_output.put_line(riadok.jmeno);
    end loop;
  else
    dbms_output.put_line('Usporadani zakazniku podle jmena:');
    for riadok in c loop
      dbms_output.put_line(riadok.jmeno);
    end loop;
  end if;
end;

3, Napište proceduru VypisZakazniku s dvěma parametry (rok_od, rok_do), která vypíše celkovou tržbu zákazniků mužského a ženského pohlaví v časovém rozmezí
mezi roky rok_od a rok_do. Vstupní parametry nemusí být definovaní (můžou obsahovat hodnotu -1). Pokud:
1, Oba vstupní parametry budou definované, výstup bude ve formě "Muzi mezi roky rok_od a rok_do nakoupili za celkovou trzbu x Kc. Zeny mezi roky rok_od a rok_do nakoupili za celkovou trzbu x Kc.". 
2, Bude definován jenom parametr rok_od, výstup bude ve formě "Muzi od roku rok_od nakoupili za celkovou trzbu x Kc. Zeny od roku rok_od nakoupili za celkovou trzbu x Kc.". 
3, Bude definován jenom parametr rok_do, výstup bude ve formě "Muzi do roku rok_do nakoupili za celkovou trzbu x Kc. Zeny do roku rok_do nakoupili za celkovou trzbu x Kc.". 
4, Nebude definován ani jeden parametr, výstup bude ve formě "Muzi celkove nakoupili za celkovou trzbu x Kc. Zeny celkove nakoupili za celkovou trzbu x Kc.". 

create or replace procedure VypisZakazniku (rok_od integer, rok_do integer)
as
  sumM integer;
  sumZ integer;
begin
  if (rok_od != -1) then
    if (rok_do != -1) then
      select NVL(sum(cena),0) into sumM from nakup, zakaznik where zakaznik.zId = nakup.zID and EXTRACT(YEAR from den) >= rok_od and EXTRACT(YEAR from den) >= rok_od and pohlavi='muz';
      select NVL(sum(cena),0) into sumZ from nakup, zakaznik where zakaznik.zId = nakup.zID and EXTRACT(YEAR from den) >= rok_od and EXTRACT(YEAR from den) <= rok_od and pohlavi='zena';
      dbms_output.put_line('Muzi mezi roky ' || rok_od || ' a ' || rok_do || ' nakoupili za celkovou trzbu ' || sumM || ' Kc.');
      dbms_output.put_line('Zeny mezi roky ' || rok_od || ' a ' || rok_do || ' nakoupili za celkovou trzbu ' || sumZ || ' Kc.');   
    else
      select NVL(sum(cena),0) into sumM from nakup, zakaznik where zakaznik.zId = nakup.zID and EXTRACT(YEAR from den) >= rok_od and pohlavi='muz';
      select NVL(sum(cena),0) into sumZ from nakup, zakaznik where zakaznik.zId = nakup.zID and EXTRACT(YEAR from den) <= rok_od and pohlavi='zena';
      dbms_output.put_line('Muzi od roku ' || rok_od || ' nakoupili za celkovou trzbu ' || sumM || ' Kc.');
      dbms_output.put_line('Zeny od roku ' || rok_od || ' nakoupili za celkovou trzbu ' || sumZ || ' Kc.');   
    end if;
  else
    if (rok_do != -1) then
      select NVL(sum(cena),0) into sumM from nakup, zakaznik where zakaznik.zId = nakup.zID and EXTRACT(YEAR from den) <= rok_do and pohlavi='muz';
      select NVL(sum(cena),0) into sumZ from nakup, zakaznik where zakaznik.zId = nakup.zID and EXTRACT(YEAR from den) <= rok_do and pohlavi='zena';
      dbms_output.put_line('Muzi do roku ' || rok_do || ' nakoupili za celkovou trzbu ' || sumM || ' Kc.');
      dbms_output.put_line('Zeny do roku ' || rok_do || ' nakoupili za celkovou trzbu ' || sumZ || ' Kc.');   
    else
      select NVL(sum(cena),0) into sumM from nakup, zakaznik where zakaznik.zId = nakup.zID and pohlavi='muz';
      select NVL(sum(cena),0) into sumZ from nakup, zakaznik where zakaznik.zId = nakup.zID and pohlavi='zena';
      dbms_output.put_line('Muzi celkove nakoupili za celkovou trzbu ' || sumM || ' Kc.');
      dbms_output.put_line('Zeny celkove nakoupili za celkovou trzbu ' || sumZ || ' Kc.');
    end if;
  end if;
end;