-- zadání 1A

-- Napište uloženou proceduru \textt{spReklamace} s parametry \textt{p_oznaceni} a \textt{p_jmeno},
-- kde \textt{p_oznaceni} pøedstavuje oznaèení produktu a \textt{p_jmeno} jméno zákazníka.
-- Procedura najde poslední nákup daného produktu daným zákazníkem a na
-- tento nákup naváže novou reklamaci, jejíž cena bude nastavena na cenu
-- posledního nákupu. Pokud daný produkt daným zákazníkem nikdy nebyl nakoupen,
-- procedura vypíše text: "Nákup nelze nalézt."

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
		PRINT 'Nákup nelze nalézt.';
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

-- Zadání 1B

-- Pøidejte do tabulky \textt{Produkt} atribut \textt{skladem}, který bude pøedstavovat
-- aktuální skladovou zásobu daného produktu. Napištì trigger \textt{tgKontrolaSkladu},
-- který po vložení záznamu do tabulky \textt{Nakup} sníží hodnotu tohoto atrubutu
-- u pøíslušného produktu o daný poèet kusù. Jestliže snížení povede k záporné skladové
-- zásobì, trigger vložení záznamu do tabulky \textt{Nakup} zabrání.

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

-- Zadání 2A

-- Napište anonymní proceduru, která vypíše tiskovou sestavu nejoblíbenìjších produktù pro
-- jednotlivé zákazníky. Pro každého zákazníka budou vypsány tøi jeho nejoblíbenìjší produkty
-- tj. produkty, které si koupil dohromady v nejvìtším množství. V pøípadì shodného množství použijte vzestupné
-- abecední tøízení dle oznaèení. Celkové množství nakoupených kusù bude souèástí výpisu.

-- Pøíklad výpisu:
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


-- Zadání 2B

-- Napište anonymní proceduru, která pro každý produkt vypíše tøi zákazníky, kteøí si
-- tento produkt kupovali dohromady v nejvìtším množství. V pøípadì shodného množství
-- bude rozhodovat abecední tøízení dle jména zákazníka. Celkové množství nakoupených kusù bude souèástí výpisu

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