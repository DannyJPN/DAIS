/* 1, Napiste bezparametricku proceduru NastavNespolahlivost, ktora prejde vsetkych zakaznikov a spocita, kolko maju objednavok, ktore zaplatili po termine 14 dni (tzn. datum potvrdenia - datum vytvorenia 
je vacsi ako 14 dni). Do tychto objednavok je nutne zapocitat aj objednavky, ktore datum potvrdenia vyplneny nemaju. Na zaklade poctu nezaplatenych objednavok
sa nastavi nespolahlivost zakaznikov (atribut status) nasledovne:

pocet objednavok = 0 - status 0
pocet objednavok 1 - 3 - status 1
pocet objednavok > 3 - status 2

Procedura bude riesena ako transakcia. */

Create or replace procedure NastavNespolahlivost
as
  CURSOR zakaznici is select "uID", count(*) pocet from objednavka
                        where round(nvl(potvrzena,sysdate) - vytvorena) > 14
                        group by "uID";
begin
  for zak in zakaznici loop
     if (zak.pocet = 0) then
        update osoba set status = 0 where "uID"=zak."uID";
     elsif (zak.pocet >= 1) and (zak.pocet < 3) then
        update osoba set status = 1 where "uID"=zak."uID";
     else
        update osoba set status = 2 where "uID"=zak."uID";
     end if;
  end loop;
  commit; 
exception
  when others then
     rollback;
end;

Create or alter procedure NastavNespolehlivost
as
  DECLARE zakaznici CURSOR for select uID, count(*) pocet from test.[objednavka]
                        where datediff(day,vytvorena,isnull(potvrzena,getdate())) > 14
                        group by uID;
  DECLARE @uID integer;
  DECLARE @pocet integer;
begin
  begin tran;
  begin try
  open zakaznici;
  FETCH NEXT FROM zakaznici into @uID, @pocet;
  while @@FETCH_STATUS = 0
    begin
      if (@pocet = 0) 
	    begin
			update test.[osoba] set status = 0 where uID=@uID;
        end;
      else
	    begin
		  if  (@pocet >= 1) and  (@pocet < 3)
		    begin
			  update test.[osoba] set status = 1 where uID=@uID;
			end;
		  else
		    begin
			  update test.[osoba] set status = 2 where uID=@uID;
			end;
		end;

	   FETCH NEXT FROM zakaznici into @uID, @pocet; 
	end;

  close zakaznici;
  deallocate zakaznici;
  commit;
  end try
  begin catch
	close zakaznici;
	deallocate zakaznici;
    rollback;
  end catch
end;


/* 2, Vytvorte tabulku ObjednavkaZaloha, ktora bude mat rovnaku strukturu ako tabulka Objednavka a navyse atribut suma typu integer. Vytvorte proceduru ZalohujObjednavky 
s parametrom rok, ktora bude prevadzat zalohy objednavok, ktore boli vytvorene v roku zadanom parametrom. Pri zalohovani sa okrem presunutia informacii o objednavke
do atributu suma spocita celkova suma objednavky (pocet kusu * cena) a polozky objednavky budu vymazane. K zalohe moze dojst len v pripade, ze vsetky objednavky
v zadanom roku su uzavrete (maju zadany datum dorucenia). V opacnom pripade procedura vypise informacnu hlasku, ze k zmazaniu dojst nemoze. Procedura bude riesena 
ako transakcia.

*/

Create table ObjednavkaZaloha (
  "oID" Int NOT NULL PRIMARY KEY,
  "uID" Int NOT NULL,
  vytvorena Date NOT NULL,
  potvrzena Date NULL,
  dorucena Date NULL,
  suma integer,
  zaID Int NOT NULL);


create or replace procedure ZalohujObjednavky(p_rok integer)
as
  v_pocet integer;
  
begin
  select count(*) into v_pocet from objednavka where extract(year from vytvorena) = p_rok and (potvrzena is null or dorucena is null);
  if (v_pocet = 0) then
    insert into ObjednavkaZaloha ("oID", "uID", vytvorena, potvrzena, dorucena, suma, zaID)
    select "oID", "uID", vytvorena, potvrzena, dorucena, (select sum(kusu*cena) from polozka where o."oID" = polozka."oID"), zaID from objednavka o
      where extract(year from vytvorena) = p_rok and (potvrzena is null or dorucena is null);
    delete from polozka where "oID" in (select "oID" from objednavka where extract(year from vytvorena) = p_rok);
    delete from objednavka where extract(year from vytvorena) = p_rok;
  else
     DBMS_OUTPUT.PUT_LINE('K vymazaniu dojst nemoze');
  end if;
    commit; 
exception
  when others then
     rollback;
end;

CREATE TABLE test.[ObjednavkaZaloha]
(
 [oID] Int NOT NULL,
 [uID] Int NOT NULL,
 [vytvorena] Datetime2 NOT NULL,
 [potvrzena] Datetime2 NULL,
 [dorucena] Datetime2 NULL,
 [zaID] Int NOT NULL,
 suma integer NOT NULL,
)

create or alter procedure ZalohujObjednavky(@p_rok integer)
as
  DECLARE @v_pocet integer;
  
begin
 begin tran;
 begin try
  select @v_pocet = count(*) from test.[objednavka] where year(vytvorena) = @p_rok and (potvrzena is null or dorucena is null);
  if (@v_pocet = 0) 
    begin
      insert into test.[ObjednavkaZaloha] (oID, uID, vytvorena, potvrzena, dorucena, suma, zaID)
      select oID, uID, vytvorena, potvrzena, dorucena, (select sum(kusu*cena) from test.[polozka] where o.oID = polozka.oID), zaID from test.[objednavka] o
        where year(vytvorena) = @p_rok and (potvrzena is null or dorucena is null);
      delete from test.[polozka] where oID in (select oID from test.[objednavka] where year(vytvorena) = @p_rok);
      delete from test.[objednavka] where year(vytvorena) = @p_rok;
    end
  else
     print 'K vymazaniu dojst nemoze';
    commit;
  end try	 
  begin catch
     rollback;
  end catch
end;