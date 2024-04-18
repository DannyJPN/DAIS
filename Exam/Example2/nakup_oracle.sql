--======================================================
--
-- Author: Radim Baca, Michal Kratky
-- Create date: 06.03.2017
-- Description: Create a tables database that are used in DAIS lectures
--
--======================================================

-- Drop tables
DROP TABLE Reklamace; 
DROP TABLE Nakup;
DROP TABLE Produkt; 
DROP TABLE Zakaznik; 

--Create tables
CREATE TABLE Produkt 
(
	pID INTEGER NOT NULL PRIMARY KEY, 
	oznaceni VARCHAR(20) NOT NULL, 
	znacka VARCHAR(30) NOT NULL, 
	rok_ukonceni_vyroby INTEGER
);

CREATE TABLE Zakaznik 
(
	zID INTEGER NOT NULL PRIMARY KEY, 
	jmeno VARCHAR(30) NOT NULL, 
	pohlavi VARCHAR(4), 
	rok_registrace INTEGER, 
	posilat_reklamu INTEGER, 
	email VARCHAR(50) NOT NULL
);

CREATE TABLE Nakup
(
	nID INTEGER NOT NULL PRIMARY KEY,
	zID INTEGER NOT NULL REFERENCES Zakaznik, 
	pID INTEGER NOT NULL REFERENCES Produkt, 
	den DATE NOT NULL,
	cena INTEGER NOT NULL, 
	kusu INTEGER NOT NULL
);

CREATE TABLE Reklamace 
(
	nID INTEGER NOT NULL REFERENCES Nakup,
	poradi INTEGER NOT NULL, 
	delka INTEGER, 
	cena INTEGER, 
	CONSTRAINT PK_Reklamace PRIMARY KEY (nID, poradi)
);

INSERT INTO Produkt VALUES (1, 'OSKA-01-2', 'Whirpool', 2012);
INSERT INTO Produkt VALUES (2, 'OSKA-01-4', 'Whirpool', 2012);
INSERT INTO Produkt VALUES (3, 'GEL-0006-7G', 'Whirpool', 2010);
INSERT INTO Produkt VALUES (4, 'WOS-50-K2', 'Electrolux', 2011);
INSERT INTO Produkt VALUES (5, 'WOS-40-K', 'Electrolux', 2012);
INSERT INTO Produkt VALUES (6, 'WOS-10-K80', 'Electrolux', NULL);
INSERT INTO Produkt VALUES (7, 'Rup-15-6', 'Humbuk', 2010);
INSERT INTO Produkt VALUES (8, 'HUP', 'Green line', 2012);
INSERT INTO Produkt VALUES (9, 'WAP 26', 'Green line', NULL);
INSERT INTO Produkt VALUES (10, 'Bongo Ultra 256', 'Green line', 2010);

INSERT INTO Zakaznik VALUES (1, 'olda', 'muz', NULL, 0, 'old.setrhand@gmail.com');
INSERT INTO Zakaznik VALUES (2, 'pepik', 'muz', 1999, 0, 'pepa.z.depa@gmail.com');
INSERT INTO Zakaznik VALUES (3, 'vinetu', 'muz', 2005, 1, 'winer.netu@seznam.cz');
INSERT INTO Zakaznik VALUES (4, 'sandokan', 'muz', 2006, 1, 'sandal.okanal@seznam.cz');
INSERT INTO Zakaznik VALUES (5, 'amazonka', 'zena', 2005, 0, 'amazonka@seznam.cz');
INSERT INTO Zakaznik VALUES (6, 'dryada', 'zena', 2006, 1, 'dr.ada@seznam.cz');
INSERT INTO Zakaznik VALUES (7, 'fantomas', 'muz', NULL, NULL, 'fantom.as@gmail.com');
INSERT INTO Zakaznik VALUES (8, 'kilian', 'muz', 2000, NULL, 'kilian.jornet@gmail.com');

INSERT INTO Nakup(nID, zID, pID, den, cena, kusu) VALUES (1, 2, 1, TO_DATE('03.08.2013 01:36', 'DD.MM.YYYY HH24:MI'), 3503, 0);
INSERT INTO Nakup(nID, zID, pID, den, cena, kusu) VALUES (2, 6, 1, TO_DATE('30.10.2012 23:38', 'DD.MM.YYYY HH24:MI'), 1668, 1);
INSERT INTO Nakup(nID, zID, pID, den, cena, kusu) VALUES (3, 5, 1, TO_DATE('21.05.2013 02:02', 'DD.MM.YYYY HH24:MI'), 220, 9);
INSERT INTO Nakup(nID, zID, pID, den, cena, kusu) VALUES (4, 7, 1, TO_DATE('19.07.2014 00:02', 'DD.MM.YYYY HH24:MI'), 394, 8);
INSERT INTO Nakup(nID, zID, pID, den, cena, kusu) VALUES (5, 3, 1, TO_DATE('14.01.2014 11:54', 'DD.MM.YYYY HH24:MI'), 2871, 4);
INSERT INTO Nakup(nID, zID, pID, den, cena, kusu) VALUES (6, 5, 1, TO_DATE('17.06.2014 10:45', 'DD.MM.YYYY HH24:MI'), 1047, 2);
INSERT INTO Nakup(nID, zID, pID, den, cena, kusu) VALUES (7, 7, 1, TO_DATE('24.04.2012 17:45', 'DD.MM.YYYY HH24:MI'), 917, 9);
INSERT INTO Nakup(nID, zID, pID, den, cena, kusu) VALUES (8, 3, 3, TO_DATE('03.12.2012 15:49', 'DD.MM.YYYY HH24:MI'), 4129, 9);
INSERT INTO Nakup(nID, zID, pID, den, cena, kusu) VALUES (9, 6, 3, TO_DATE('08.12.2012 21:28', 'DD.MM.YYYY HH24:MI'), 3420, 6);
INSERT INTO Nakup(nID, zID, pID, den, cena, kusu) VALUES (10, 3, 3, TO_DATE('14.09.2013 16:57', 'DD.MM.YYYY HH24:MI'), 4072, 8);
INSERT INTO Nakup(nID, zID, pID, den, cena, kusu) VALUES (11, 7, 3, TO_DATE('27.10.2012 08:20', 'DD.MM.YYYY HH24:MI'), 3698, 1);
INSERT INTO Nakup(nID, zID, pID, den, cena, kusu) VALUES (12, 7, 4, TO_DATE('20.07.2012 15:40', 'DD.MM.YYYY HH24:MI'), 4210, 1);
INSERT INTO Nakup(nID, zID, pID, den, cena, kusu) VALUES (13, 5, 4, TO_DATE('31.01.2014 14:00', 'DD.MM.YYYY HH24:MI'), 4339, 6);
INSERT INTO Nakup(nID, zID, pID, den, cena, kusu) VALUES (14, 1, 4, TO_DATE('10.10.2014 20:49', 'DD.MM.YYYY HH24:MI'), 2646, 8);
INSERT INTO Nakup(nID, zID, pID, den, cena, kusu) VALUES (15, 4, 4, TO_DATE('14.09.2012 09:46', 'DD.MM.YYYY HH24:MI'), 832, 2);
INSERT INTO Nakup(nID, zID, pID, den, cena, kusu) VALUES (16, 2, 4, TO_DATE('06.11.2013 15:43', 'DD.MM.YYYY HH24:MI'), 319, 3);
INSERT INTO Nakup(nID, zID, pID, den, cena, kusu) VALUES (17, 2, 4, TO_DATE('03.07.2013 20:55', 'DD.MM.YYYY HH24:MI'), 4670, 7);
INSERT INTO Nakup(nID, zID, pID, den, cena, kusu) VALUES (18, 1, 5, TO_DATE('13.08.2012 15:58', 'DD.MM.YYYY HH24:MI'), 3965, 7);
INSERT INTO Nakup(nID, zID, pID, den, cena, kusu) VALUES (19, 2, 6, TO_DATE('01.01.2014 23:17', 'DD.MM.YYYY HH24:MI'), 4581, 8);
INSERT INTO Nakup(nID, zID, pID, den, cena, kusu) VALUES (20, 4, 6, TO_DATE('23.08.2013 01:58', 'DD.MM.YYYY HH24:MI'), 4729, 8);
INSERT INTO Nakup(nID, zID, pID, den, cena, kusu) VALUES (21, 3, 6, TO_DATE('04.11.2014 15:38', 'DD.MM.YYYY HH24:MI'), 4098, 5);
INSERT INTO Nakup(nID, zID, pID, den, cena, kusu) VALUES (22, 3, 7, TO_DATE('01.08.2012 04:21', 'DD.MM.YYYY HH24:MI'), 2903, 3);
INSERT INTO Nakup(nID, zID, pID, den, cena, kusu) VALUES (23, 3, 8, TO_DATE('27.10.2012 19:24', 'DD.MM.YYYY HH24:MI'), 4655, 8);
INSERT INTO Nakup(nID, zID, pID, den, cena, kusu) VALUES (24, 3, 9, TO_DATE('12.07.2012 22:50', 'DD.MM.YYYY HH24:MI'), 3056, 9);
INSERT INTO Nakup(nID, zID, pID, den, cena, kusu) VALUES (25, 3, 9, TO_DATE('15.06.2012 07:49', 'DD.MM.YYYY HH24:MI'), 4190, 2);
INSERT INTO Nakup(nID, zID, pID, den, cena, kusu) VALUES (26, 7, 9, TO_DATE('11.08.2012 11:19', 'DD.MM.YYYY HH24:MI'), 2031, 1);
INSERT INTO Nakup(nID, zID, pID, den, cena, kusu) VALUES (27, 6, 9, TO_DATE('30.07.2014 06:38', 'DD.MM.YYYY HH24:MI'), 2912, 8);
INSERT INTO Nakup(nID, zID, pID, den, cena, kusu) VALUES (28, 7, 9, TO_DATE('29.11.2013 05:55', 'DD.MM.YYYY HH24:MI'), 3779, 9);
INSERT INTO Nakup(nID, zID, pID, den, cena, kusu) VALUES (29, 7, 9, TO_DATE('14.03.2013 00:34', 'DD.MM.YYYY HH24:MI'), 362, 1);
INSERT INTO Nakup(nID, zID, pID, den, cena, kusu) VALUES (30, 2, 10, TO_DATE('11.05.2012 17:03', 'DD.MM.YYYY HH24:MI'), 2253, 5);
INSERT INTO Nakup(nID, zID, pID, den, cena, kusu) VALUES (31, 4, 10, TO_DATE('09.02.2014 16:21', 'DD.MM.YYYY HH24:MI'), 4193, 0);
INSERT INTO Nakup(nID, zID, pID, den, cena, kusu) VALUES (32, 6, 10, TO_DATE('28.01.2012 20:25', 'DD.MM.YYYY HH24:MI'), 371, 9);

INSERT INTO Reklamace (nID, poradi, delka, cena) VALUES (1, 1, 8, 2356);
INSERT INTO Reklamace (nID, poradi, delka, cena) VALUES (1, 2, 4, 7575);
INSERT INTO Reklamace (nID, poradi, delka, cena) VALUES (2, 1, 1, 2170);
INSERT INTO Reklamace (nID, poradi, delka, cena) VALUES (2, 2, 15, 1778);
INSERT INTO Reklamace (nID, poradi, delka, cena) VALUES (2, 3, 6, 7717);
INSERT INTO Reklamace (nID, poradi, delka, cena) VALUES (3, 1, 13, 207);
INSERT INTO Reklamace (nID, poradi, delka, cena) VALUES (4, 1, 11, 654);
INSERT INTO Reklamace (nID, poradi, delka, cena) VALUES (4, 2, 15, 2031);
INSERT INTO Reklamace (nID, poradi, delka, cena) VALUES (6, 1, 20, 1491);
INSERT INTO Reklamace (nID, poradi, delka, cena) VALUES (6, 2, 6, 1048);
INSERT INTO Reklamace (nID, poradi, delka, cena) VALUES (6, 3, 6, 7561);
INSERT INTO Reklamace (nID, poradi, delka, cena) VALUES (6, 4, 3, 646);
INSERT INTO Reklamace (nID, poradi, delka, cena) VALUES (7, 1, 8, 1536);
INSERT INTO Reklamace (nID, poradi, delka, cena) VALUES (7, 2, 1, 798);
INSERT INTO Reklamace (nID, poradi, delka, cena) VALUES (7, 3, 5, 31115);
INSERT INTO Reklamace (nID, poradi, delka, cena) VALUES (7, 4, 6, 1763);
INSERT INTO Reklamace (nID, poradi, delka, cena) VALUES (11, 1, 10, 4163);
INSERT INTO Reklamace (nID, poradi, delka, cena) VALUES (11, 2, 17, 2985);
INSERT INTO Reklamace (nID, poradi, delka, cena) VALUES (14, 1, 8, 2861);
INSERT INTO Reklamace (nID, poradi, delka, cena) VALUES (14, 2, 2, 2381);
INSERT INTO Reklamace (nID, poradi, delka, cena) VALUES (18, 1, 14, 3404);
INSERT INTO Reklamace (nID, poradi, delka, cena) VALUES (18, 2, 16, 2939);
INSERT INTO Reklamace (nID, poradi, delka, cena) VALUES (22, 1, 14, 1994);
INSERT INTO Reklamace (nID, poradi, delka, cena) VALUES (22, 2, 18, 25039);
INSERT INTO Reklamace (nID, poradi, delka, cena) VALUES (22, 3, 13, 2594);
INSERT INTO Reklamace (nID, poradi, delka, cena) VALUES (24, 1, 2, 4813);
INSERT INTO Reklamace (nID, poradi, delka, cena) VALUES (24, 2, 7, 2749);
INSERT INTO Reklamace (nID, poradi, delka, cena) VALUES (24, 3, 2, 76084);
INSERT INTO Reklamace (nID, poradi, delka, cena) VALUES (25, 1, 18, 91486);
INSERT INTO Reklamace (nID, poradi, delka, cena) VALUES (25, 2, 2, 2756);
INSERT INTO Reklamace (nID, poradi, delka, cena) VALUES (25, 3, 14, 4482);
INSERT INTO Reklamace (nID, poradi, delka, cena) VALUES (25, 4, 18, 3388);
INSERT INTO Reklamace (nID, poradi, delka, cena) VALUES (27, 1, 17, 3630);
INSERT INTO Reklamace (nID, poradi, delka, cena) VALUES (27, 2, 8, 3872);
INSERT INTO Reklamace (nID, poradi, delka, cena) VALUES (27, 3, 12, 1912);
INSERT INTO Reklamace (nID, poradi, delka, cena) VALUES (28, 1, 14, 9259);
INSERT INTO Reklamace (nID, poradi, delka, cena) VALUES (29, 1, 5, 237);
INSERT INTO Reklamace (nID, poradi, delka, cena) VALUES (29, 2, 4, 251);
INSERT INTO Reklamace (nID, poradi, delka, cena) VALUES (29, 3, 7, 595);
INSERT INTO Reklamace (nID, poradi, delka, cena) VALUES (30, 1, 7, 2288);
INSERT INTO Reklamace (nID, poradi, delka, cena) VALUES (30, 2, 3, 3286);
INSERT INTO Reklamace (nID, poradi, delka, cena) VALUES (30, 3, 11, 4736);
INSERT INTO Reklamace (nID, poradi, delka, cena) VALUES (31, 1, 7, 3151);

COMMIT;