-- zad�n� 1A

-- Napi�te ulo�enou proceduru \textt{spReklamace} s parametry \textt{p_oznaceni} a \textt{p_jmeno},
-- kde \textt{p_oznaceni} p�edstavuje ozna�en� produktu a \textt{p_jmeno} jm�no z�kazn�ka.
-- Procedura najde posledn� n�kup dan�ho produktu dan�m z�kazn�kem a na
-- tento n�kup nav�e novou reklamaci, jej� cena bude nastavena na cenu
-- posledn�ho n�kupu. Pokud dan� produkt dan�m z�kazn�kem nikdy nebyl nakoupen,
-- procedura vyp�e text: "N�kup nelze nal�zt."

CREATE PROCEDURE spReklamace(@p_oznaceni VARCHAR(20), @p_jmeno VARCHAR(30)) AS
BEGIN
	DECLARE @v_pID INT;
	DECLARE @v_zID INT;
	
	DECLARE @v_maxDate DATETIME;
	DECLARE @v_poradi INT;
	DECLARE @v_nID INT;
	DECLARE @v_cena INT;
	
	SET @v_pID = (SELECT pID FROM test.Produkt WHERE oznaceni = @p_oznaceni);
	SET @v_zID = (SELECT zID FROM test.Zakaznik WHERE jmeno = @p_jmeno);
	SET @v_maxDate = (SELECT MAX(den) FROM test.Nakup WHERE pID = @v_pID AND zID = @v_zID);
	
	SELECT @v_nID = nID, @v_cena = cena FROM test.Nakup WHERE den = @v_maxDate;

	IF @v_nID IS NULL
	BEGIN
		PRINT 'N�kup nelze nal�zt.';
	END
	ELSE BEGIN
		SET @v_poradi = (SELECT MAX(poradi) + 1 FROM test.Reklamace WHERE nID = @v_nID);
		IF @v_poradi IS NULL
		BEGIN
			SET @v_poradi = 1;
		END;
		
		INSERT INTO test.Reklamace (nID, poradi, cena)
		VALUES (@v_nID, @v_poradi, @v_cena);
	END;
END;

-- Zad�n� 1B

-- P�idejte do tabulky \textt{Produkt} atribut \textt{skladem}, kter� bude p�edstavovat
-- aktu�ln� skladovou z�sobu dan�ho produktu. Napi�t� trigger \textt{tgKontrolaSkladu},
-- kter� po vlo�en� z�znamu do tabulky \textt{Nakup} sn�� hodnotu tohoto atrubutu
-- u p��slu�n�ho produktu o dan� po�et kus�. Jestli�e sn�en� povede k z�porn� skladov�
-- z�sob�, trigger vlo�en� z�znamu do tabulky \textt{Nakup} zabr�n�.

ALTER TABLE test.Produkt
ADD skladem INT;

CREATE TRIGGER tgKontrolaSkladu ON test.Nakup AFTER INSERT AS
BEGIN
	DECLARE @v_pID INT;
	DECLARE @v_kusu INT;
	DECLARE @v_skladem INT;
	
	-- Zjednoduseno - kurzor nebudu vyzadovat.
	SELECT @v_pID = pID, @v_kusu = kusu FROM inserted;
	
	SET @v_skladem = (SELECT skladem FROM test.Produkt WHERE pID = @v_pID);
	
	IF @v_skladem - @v_kusu < 0
	BEGIN
		RAISERROR('Nizka skladova zasoba', 16, 1);
		ROLLBACK;
	END
	ELSE BEGIN
		UPDATE test.Produkt
		SET skladem = skladem - @v_kusu
		WHERE pID = @v_pID;
	END;
END;

-- Zad�n� 2A

-- Napi�te anonymn� proceduru, kter� vyp�e tiskovou sestavu nejobl�ben�j��ch produkt� pro
-- jednotliv� z�kazn�ky. Pro ka�d�ho z�kazn�ka budou vyps�ny t�i jeho nejobl�ben�j�� produkty
-- tj. produkty, kter� si koupil dohromady v nejv�t��m mno�stv�. V p��pad� shodn�ho mno�stv� pou�ijte vzestupn�
-- abecedn� t��zen� dle ozna�en�. Celkov� mno�stv� nakoupen�ch kus� bude sou��st� v�pisu.

-- P��klad v�pisu:
-- pepik
--   WOS-50-K2 (10)
--   WOS-10-K80 (8)
--   Bongo Ultra 256 (5)
-- vinetu
--   GEL-0006-7G (17)
--   WAP 26 (11)
--   HUP (8)

BEGIN
	DECLARE @v_zID INT;
	DECLARE @v_pID INT;
	DECLARE @v_jmeno VARCHAR(30);
	DECLARE @v_oznaceni VARCHAR(20);
	DECLARE @v_kusu INT;
	
	DECLARE c1 CURSOR FOR SELECT zID, jmeno FROM test.Zakaznik;
	OPEN c1;
	
	FETCH FROM c1 INTO @v_zID, @v_jmeno;
	WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT @v_jmeno;
		
		DECLARE c2 CURSOR FOR SELECT TOP 3 test.Produkt.pID, test.Produkt.oznaceni, SUM(test.Nakup.kusu)
		FROM test.Produkt JOIN test.Nakup ON test.Produkt.pID = test.Nakup.pID
		WHERE test.Nakup.zID = @v_zID
		GROUP BY test.Produkt.pID, test.Produkt.oznaceni
		ORDER BY SUM(test.Nakup.kusu) DESC, test.Produkt.oznaceni
		
		OPEN c2;
		
		FETCH FROM c2 INTO @v_pID, @v_oznaceni, @v_kusu;
		WHILE @@FETCH_STATUS = 0
		BEGIN
			PRINT '  ' + @v_oznaceni + ' (' + CAST(@v_kusu AS VARCHAR) + ')';
			FETCH FROM c2 INTO @v_pID, @v_oznaceni, @v_kusu;
		END;
		
		CLOSE c2;
		DEALLOCATE c2;
		
		FETCH FROM c1 INTO @v_zID, @v_jmeno;
	END;		
	
	CLOSE c1;
	DEALLOCATE c1;
END;


-- Zad�n� 2B

-- Napi�te anonymn� proceduru, kter� pro ka�d� produkt vyp�e t�i z�kazn�ky, kte�� si
-- tento produkt kupovali dohromady v nejv�t��m mno�stv�. V p��pad� shodn�ho mno�stv�
-- bude rozhodovat abecedn� t��zen� dle jm�na z�kazn�ka. Celkov� mno�stv� nakoupen�ch kus� bude sou��st� v�pisu

-- pozn. reseni - viz predchozi priklad, jen obracene pouziti tabulek test.Produkt a test.Zakaznik.

BEGIN
	DECLARE @v_zID INT;
	DECLARE @v_pID INT;
	DECLARE @v_jmeno VARCHAR(30);
	DECLARE @v_oznaceni VARCHAR(20);
	DECLARE @v_kusu INT;
	
	DECLARE c1 CURSOR FOR SELECT pID, oznaceni FROM test.Produkt;
	OPEN c1;
	
	FETCH FROM c1 INTO @v_pID, @v_oznaceni;
	WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT @v_oznaceni;
		
		DECLARE c2 CURSOR FOR SELECT TOP 3 test.Zakaznik.zID, test.Zakaznik.jmeno, SUM(test.Nakup.kusu)
		FROM test.Zakaznik JOIN test.Nakup ON test.Zakaznik.zID = test.Nakup.zID
		WHERE test.Nakup.pID = @v_pID
		GROUP BY test.Zakaznik.zID, test.Zakaznik.jmeno
		ORDER BY SUM(test.Nakup.kusu) DESC, test.Zakaznik.jmeno
		
		OPEN c2;
		
		FETCH FROM c2 INTO @v_zID, @v_jmeno, @v_kusu;
		WHILE @@FETCH_STATUS = 0
		BEGIN
			PRINT '  ' + @v_jmeno + ' (' + CAST(@v_kusu AS VARCHAR) + ')';
		FETCH FROM c2 INTO @v_zID, @v_jmeno, @v_kusu;
		END;
		
		CLOSE c2;
		DEALLOCATE c2;
		
		FETCH FROM c1 INTO @v_pID, @v_oznaceni;
	END;		
	
	CLOSE c1;
	DEALLOCATE c1;
END;