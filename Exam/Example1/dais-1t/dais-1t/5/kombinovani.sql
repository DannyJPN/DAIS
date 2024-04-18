/*1, Vytvořte proceduru \texttt{SmazOsobu}, která bude mít jeden vstupní parametr \texttt{idOsoby}.
	Tato procedura nastaví osobě status na hodnotu 2, což signalizuje že je osoba vymazána.
	Smazaní je možné jenom v případě, že jsou všechny objednávky mazané osoby uzavřené (mají datum potvrzení a doručení zadány). V opačném případě procedura na obrazovku vypíše, že k smazaní nemůže dojít, protože osoba má neuzavřené objednávky. Při smazání dojde taktéž k smazání všech objednávek dané osoby a jejich položek. Procedura musí být řešena jak transakce.
	
*/

create or replace procedure SmazOsobu (id_osoby int)
as
  pocetNeuzavretych integer;
begin
  select count(*) into pocetNeuzavretych from objednavka where uID=id_osoby and (potvrzena is null or dorucena is null);
  if (pocetNeuzavretych > 0) then
    DBMS_OUTPUT.PUT_LINE ('K vymazaniu osoby nemoze dojst, pretoze osoba ma neuzavrete objednavky');
  else  
      delete from polozka where oID in (select oID from objednavka where uID=id_osoby); 
      delete from objednavka where uID=id_osoby;
      update osoba set status=2 where uID=id_osoby;
  end if;    
  commit;
exception
  when others then
     rollback;
end;


create or alter procedure SmazOsobu (@id_osoby int)
as
  declare @pocetNeuzavretych integer;
begin
begin tran
  begin try
  select @pocetNeuzavretych = count(*) from test.[Objednavka] where uID=@id_osoby and (potvrzena is null or dorucena is null);
  if (@pocetNeuzavretych > 0) 
    begin
       print 'K vymazaniu osoby nemoze dojst, pretoze osoba ma neuzavrete objednavky.';
    end
  else 
    begin 
      delete from test.[Polozka] where oID in (select oID from test.[Objednavka] where uID=@id_osoby); 
      delete from test.[Objednavka] where uID=@id_osoby;
      update test.[Osoba] set status=2 where uID=@id_osoby;
	end;    
  commit;
  end try
  begin catch
     rollback;
  end catch
end;

/*2, Přidejte do tabulky \texttt{Zbozi} sloupec \texttt{oblibenost} typu integer. Vytvořte bezparametrickou proceduru \texttt{NastavOblibenost}, která každému produktu nastaví oblíbenost hodnotami 1 až celkový počet produktů podle počtu prodaných kusů. Procedura zároveň vypíše na obrazovku výpis ve formě:

	Seznam nejoblíbenějších produktů:
	1. Název produktu            Celkový počet prodaných kusů
	2. Název produktu            Celkový počet prodaných kusů
	...

*/

alter table Zbozi add oblibenost integer null;

create or replace procedure NastavOblibenost
as
  CURSOR produkty is select zbozi.zID, zbozi.nazev, sum(kusu) pocet from zbozi, polozka 
  where zbozi.zID = polozka.zID group by  zbozi.zID, zbozi.nazev order by sum(kusu) desc;
  pocitadlo int;
begin
  pocitadlo := 1 
  DBMS_OUTPUT.PUT_LINE('Seznam nejoblibenejsich produktu:');
  for produkt in produkty loop
      update Zbozi set oblibenost = pocitadlo where zID=produkt.zID;
      DBMS_OUTPUT.PUT_LINE(pocitadlo || ' . ' || produkt.nazev || '  ' || produkt.pocet);
      pocitadlo := pocitadlo + 1;
  end loop;
end;

alter table test.[Zbozi] add oblibenost integer null;

create or alter procedure NastavOblibenost
as
  DECLARE produkty CURSOR for select zbozi.zID, zbozi.nazev, sum(kusu) pocet from test.[zbozi], test.[polozka] 
  where zbozi.zID = polozka.zID group by  zbozi.zID, zbozi.nazev order by sum(kusu) desc;
  DECLARE @pocitadlo int;
  DECLARE @zID int;
  DECLARE @nazev varchar(50);
  DECLARE @pocet int;
begin
  SET @pocitadlo = 1; 
  print 'Seznam nejoblibenejsich produktu:';
  open produkty;
  FETCH NEXT FROM produkty into @zID, @nazev, @pocet; 
  while @@FETCH_STATUS = 0
  begin
      update test.[zbozi] set oblibenost = @pocitadlo where zID=@zID;
      print CAST(@pocitadlo as char(2)) + ' . ' + @nazev + '  ' + CAST(@pocet as varchar(15));
      FETCH NEXT FROM produkty into @zID, @nazev, @pocet; 
	  SET @pocitadlo = @pocitadlo + 1;
  end;
  close produkty;
  deallocate produkty;
end;