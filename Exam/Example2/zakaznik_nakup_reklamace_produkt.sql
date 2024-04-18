--======================================================
--
-- Author: Radim Baca
-- Create date: 10.10.2016
-- Description: Create a tables database that are used in UDBS lectures
-- License: This code was writtend by Radim Baca and is the property of VSB-TUO 
--          This code MAY NOT BE USED without the expressed written consent of VSB-TUO.
-- Change history:
--
--======================================================

-- Drop table if they exists
IF OBJECT_ID('test.Reklamace ', 'U') IS NOT NULL
  DROP TABLE test.Reklamace 
IF OBJECT_ID('test.Nakup', 'U') IS NOT NULL
  DROP TABLE test.Nakup
IF OBJECT_ID('test.Produkt', 'U') IS NOT NULL
  DROP TABLE test.Produkt 
IF OBJECT_ID('test.Zakaznik', 'U') IS NOT NULL
  DROP TABLE test.Zakaznik 

--Create namespace
IF NOT EXISTS (
	SELECT  schema_name
	FROM    information_schema.schemata
	WHERE   schema_name = 'test' ) 
BEGIN
	EXEC sp_executesql N'CREATE SCHEMA test'
END
GO

--Create tables
CREATE TABLE test.Produkt 
(
	pID INTEGER NOT NULL PRIMARY KEY, 
	oznaceni VARCHAR(20) NOT NULL , 
	znacka VARCHAR(30) NOT NULL , 
	rok_ukonceni_vyroby INTEGER
);

CREATE TABLE test.Zakaznik 
(
	zID INTEGER NOT NULL PRIMARY KEY, 
	jmeno VARCHAR(30) NOT NULL , 
	pohlavi VARCHAR(4) , 
	rok_registrace INTEGER , 
	posilat_reklamu INTEGER , 
	email VARCHAR(50) NOT NULL
);

CREATE TABLE test.Nakup
(
	nID INTEGER NOT NULL PRIMARY KEY,
	zID INTEGER NOT NULL REFERENCES test.Zakaznik, 
	pID INTEGER NOT NULL REFERENCES test.Produkt, 
	den DATETIME2 NOT NULL,
	cena INTEGER NOT NULL , 
	kusu INTEGER NOT NULL
);

CREATE TABLE test.Reklamace 
(
	nID INTEGER NOT NULL REFERENCES test.Nakup,
	poradi INTEGER NOT NULL , 
	delka INTEGER , 
	cena INTEGER , 
	CONSTRAINT PK_Reklamace PRIMARY KEY (nID, poradi)
);

INSERT INTO test.Produkt VALUES (1, 'OSKA-01-2', 'Whirpool', 2012);
INSERT INTO test.Produkt VALUES (2, 'OSKA-01-4', 'Whirpool', 2012);
INSERT INTO test.Produkt VALUES (3, 'GEL-0006-7G', 'Whirpool', 2010);
INSERT INTO test.Produkt VALUES (4, 'WOS-50-K2', 'Electrolux', 2011);
INSERT INTO test.Produkt VALUES (5, 'WOS-40-K', 'Electrolux', 2012);
INSERT INTO test.Produkt VALUES (6, 'WOS-10-K80', 'Electrolux', NULL);
INSERT INTO test.Produkt VALUES (7, 'Rup-15-6', 'Humbuk', 2010);
INSERT INTO test.Produkt VALUES (8, 'HUP', 'Green line', 2012);
INSERT INTO test.Produkt VALUES (9, 'WAP 26', 'Green line', NULL);
INSERT INTO test.Produkt VALUES (10, 'Bongo Ultra 256', 'Green line', 2010);

INSERT INTO test.Zakaznik VALUES (1, 'olda', 'muz', NULL, 0, 'old.setrhand@gmail.com');
INSERT INTO test.Zakaznik VALUES (2, 'pepik', 'muz', 1999, 0, 'pepa.z.depa@gmail.com');
INSERT INTO test.Zakaznik VALUES (3, 'vinetu', 'muz', 2005, 1, 'winer.netu@seznam.cz');
INSERT INTO test.Zakaznik VALUES (4, 'sandokan', 'muz', 2006, 1, 'sandal.okanal@seznam.cz');
INSERT INTO test.Zakaznik VALUES (5, 'amazonka', 'zena', 2005, 0, 'amazonka@seznam.cz');
INSERT INTO test.Zakaznik VALUES (6, 'dryada', 'zena', 2006, 1, 'dr.ada@seznam.cz');
INSERT INTO test.Zakaznik VALUES (7, 'fantomas', 'muz', NULL, NULL, 'fantom.as@gmail.com');
INSERT INTO test.Zakaznik VALUES (8, 'kilian', 'muz', 2000, NULL, 'kilian.jornet@gmail.com');


INSERT [test].[Nakup] ([nID], [zID], [pID], [den], [cena], [kusu]) VALUES (1, 2, 1, CAST(N'2013-08-01 01:36:00.0000000' AS DateTime2), 3503, 0)
INSERT [test].[Nakup] ([nID], [zID], [pID], [den], [cena], [kusu]) VALUES (2, 6, 1, CAST(N'2012-10-30 23:38:00.0000000' AS DateTime2), 1668, 1)
INSERT [test].[Nakup] ([nID], [zID], [pID], [den], [cena], [kusu]) VALUES (3, 5, 1, CAST(N'2013-05-21 02:02:00.0000000' AS DateTime2), 220, 9)
INSERT [test].[Nakup] ([nID], [zID], [pID], [den], [cena], [kusu]) VALUES (4, 7, 1, CAST(N'2014-07-19 00:02:00.0000000' AS DateTime2), 394, 8)
INSERT [test].[Nakup] ([nID], [zID], [pID], [den], [cena], [kusu]) VALUES (5, 3, 1, CAST(N'2014-01-14 11:54:00.0000000' AS DateTime2), 2871, 4)
INSERT [test].[Nakup] ([nID], [zID], [pID], [den], [cena], [kusu]) VALUES (6, 5, 1, CAST(N'2014-06-17 10:45:00.0000000' AS DateTime2), 1047, 2)
INSERT [test].[Nakup] ([nID], [zID], [pID], [den], [cena], [kusu]) VALUES (7, 7, 1, CAST(N'2012-04-24 17:45:00.0000000' AS DateTime2), 917, 9)
INSERT [test].[Nakup] ([nID], [zID], [pID], [den], [cena], [kusu]) VALUES (8, 3, 3, CAST(N'2012-12-03 15:49:00.0000000' AS DateTime2), 4129, 9)
INSERT [test].[Nakup] ([nID], [zID], [pID], [den], [cena], [kusu]) VALUES (9, 6, 3, CAST(N'2012-12-08 21:28:00.0000000' AS DateTime2), 3420, 6)
INSERT [test].[Nakup] ([nID], [zID], [pID], [den], [cena], [kusu]) VALUES (10, 3, 3, CAST(N'2013-09-14 16:57:00.0000000' AS DateTime2), 4072, 8)
INSERT [test].[Nakup] ([nID], [zID], [pID], [den], [cena], [kusu]) VALUES (11, 7, 3, CAST(N'2012-10-27 08:20:00.0000000' AS DateTime2), 3698, 1)
INSERT [test].[Nakup] ([nID], [zID], [pID], [den], [cena], [kusu]) VALUES (12, 7, 4, CAST(N'2012-07-20 15:40:00.0000000' AS DateTime2), 4210, 1)
INSERT [test].[Nakup] ([nID], [zID], [pID], [den], [cena], [kusu]) VALUES (13, 5, 4, CAST(N'2014-01-31 14:00:00.0000000' AS DateTime2), 4339, 6)
INSERT [test].[Nakup] ([nID], [zID], [pID], [den], [cena], [kusu]) VALUES (14, 1, 4, CAST(N'2014-10-10 20:49:00.0000000' AS DateTime2), 2646, 8)
INSERT [test].[Nakup] ([nID], [zID], [pID], [den], [cena], [kusu]) VALUES (15, 4, 4, CAST(N'2012-09-14 09:46:00.0000000' AS DateTime2), 832, 2)
INSERT [test].[Nakup] ([nID], [zID], [pID], [den], [cena], [kusu]) VALUES (16, 2, 4, CAST(N'2013-11-06 15:43:00.0000000' AS DateTime2), 319, 3)
INSERT [test].[Nakup] ([nID], [zID], [pID], [den], [cena], [kusu]) VALUES (17, 2, 4, CAST(N'2013-07-03 20:55:00.0000000' AS DateTime2), 4670, 7)
INSERT [test].[Nakup] ([nID], [zID], [pID], [den], [cena], [kusu]) VALUES (18, 1, 5, CAST(N'2012-08-13 15:58:00.0000000' AS DateTime2), 3965, 7)
INSERT [test].[Nakup] ([nID], [zID], [pID], [den], [cena], [kusu]) VALUES (19, 2, 6, CAST(N'2014-01-01 23:17:00.0000000' AS DateTime2), 4581, 8)
INSERT [test].[Nakup] ([nID], [zID], [pID], [den], [cena], [kusu]) VALUES (20, 4, 6, CAST(N'2013-08-23 01:58:00.0000000' AS DateTime2), 4729, 8)
INSERT [test].[Nakup] ([nID], [zID], [pID], [den], [cena], [kusu]) VALUES (21, 3, 6, CAST(N'2014-11-04 15:38:00.0000000' AS DateTime2), 4098, 5)
INSERT [test].[Nakup] ([nID], [zID], [pID], [den], [cena], [kusu]) VALUES (22, 3, 7, CAST(N'2012-08-01 04:21:00.0000000' AS DateTime2), 2903, 3)
INSERT [test].[Nakup] ([nID], [zID], [pID], [den], [cena], [kusu]) VALUES (23, 3, 8, CAST(N'2012-10-27 19:24:00.0000000' AS DateTime2), 4655, 8)
INSERT [test].[Nakup] ([nID], [zID], [pID], [den], [cena], [kusu]) VALUES (24, 3, 9, CAST(N'2012-07-12 22:50:00.0000000' AS DateTime2), 3056, 9)
INSERT [test].[Nakup] ([nID], [zID], [pID], [den], [cena], [kusu]) VALUES (25, 3, 9, CAST(N'2012-06-15 07:49:00.0000000' AS DateTime2), 4190, 2)
INSERT [test].[Nakup] ([nID], [zID], [pID], [den], [cena], [kusu]) VALUES (26, 7, 9, CAST(N'2012-08-11 11:19:00.0000000' AS DateTime2), 2031, 1)
INSERT [test].[Nakup] ([nID], [zID], [pID], [den], [cena], [kusu]) VALUES (27, 6, 9, CAST(N'2014-07-30 06:38:00.0000000' AS DateTime2), 2912, 8)
INSERT [test].[Nakup] ([nID], [zID], [pID], [den], [cena], [kusu]) VALUES (28, 7, 9, CAST(N'2013-11-29 05:55:00.0000000' AS DateTime2), 3779, 9)
INSERT [test].[Nakup] ([nID], [zID], [pID], [den], [cena], [kusu]) VALUES (29, 7, 9, CAST(N'2013-03-14 00:34:00.0000000' AS DateTime2), 362, 1)
INSERT [test].[Nakup] ([nID], [zID], [pID], [den], [cena], [kusu]) VALUES (30, 2, 10, CAST(N'2012-05-11 17:03:00.0000000' AS DateTime2), 2253, 5)
INSERT [test].[Nakup] ([nID], [zID], [pID], [den], [cena], [kusu]) VALUES (31, 4, 10, CAST(N'2014-02-09 16:21:00.0000000' AS DateTime2), 4193, 0)
INSERT [test].[Nakup] ([nID], [zID], [pID], [den], [cena], [kusu]) VALUES (32, 6, 10, CAST(N'2012-01-28 20:25:00.0000000' AS DateTime2), 371, 9)

INSERT [test].[Reklamace] ([nID], [poradi], [delka], [cena]) VALUES (1, 1, 8, 2356)
INSERT [test].[Reklamace] ([nID], [poradi], [delka], [cena]) VALUES (1, 2, 4, 7575)
INSERT [test].[Reklamace] ([nID], [poradi], [delka], [cena]) VALUES (2, 1, 1, 2170)
INSERT [test].[Reklamace] ([nID], [poradi], [delka], [cena]) VALUES (2, 2, 15, 1778)
INSERT [test].[Reklamace] ([nID], [poradi], [delka], [cena]) VALUES (2, 3, 6, 7717)
INSERT [test].[Reklamace] ([nID], [poradi], [delka], [cena]) VALUES (3, 1, 13, 207)
INSERT [test].[Reklamace] ([nID], [poradi], [delka], [cena]) VALUES (4, 1, 11, 654)
INSERT [test].[Reklamace] ([nID], [poradi], [delka], [cena]) VALUES (4, 2, 15, 2031)
INSERT [test].[Reklamace] ([nID], [poradi], [delka], [cena]) VALUES (6, 1, 20, 1491)
INSERT [test].[Reklamace] ([nID], [poradi], [delka], [cena]) VALUES (6, 2, 6, 1048)
INSERT [test].[Reklamace] ([nID], [poradi], [delka], [cena]) VALUES (6, 3, 6, 7561)
INSERT [test].[Reklamace] ([nID], [poradi], [delka], [cena]) VALUES (6, 4, 3, 646)
INSERT [test].[Reklamace] ([nID], [poradi], [delka], [cena]) VALUES (7, 1, 8, 1536)
INSERT [test].[Reklamace] ([nID], [poradi], [delka], [cena]) VALUES (7, 2, 1, 798)
INSERT [test].[Reklamace] ([nID], [poradi], [delka], [cena]) VALUES (7, 3, 5, 31115)
INSERT [test].[Reklamace] ([nID], [poradi], [delka], [cena]) VALUES (7, 4, 6, 1763)
INSERT [test].[Reklamace] ([nID], [poradi], [delka], [cena]) VALUES (11, 1, 10, 4163)
INSERT [test].[Reklamace] ([nID], [poradi], [delka], [cena]) VALUES (11, 2, 17, 2985)
INSERT [test].[Reklamace] ([nID], [poradi], [delka], [cena]) VALUES (14, 1, 8, 2861)
INSERT [test].[Reklamace] ([nID], [poradi], [delka], [cena]) VALUES (14, 2, 2, 2381)
INSERT [test].[Reklamace] ([nID], [poradi], [delka], [cena]) VALUES (18, 1, 14, 3404)
INSERT [test].[Reklamace] ([nID], [poradi], [delka], [cena]) VALUES (18, 2, 16, 2939)
INSERT [test].[Reklamace] ([nID], [poradi], [delka], [cena]) VALUES (22, 1, 14, 1994)
INSERT [test].[Reklamace] ([nID], [poradi], [delka], [cena]) VALUES (22, 2, 18, 25039)
INSERT [test].[Reklamace] ([nID], [poradi], [delka], [cena]) VALUES (22, 3, 13, 2594)
INSERT [test].[Reklamace] ([nID], [poradi], [delka], [cena]) VALUES (24, 1, 2, 4813)
INSERT [test].[Reklamace] ([nID], [poradi], [delka], [cena]) VALUES (24, 2, 7, 2749)
INSERT [test].[Reklamace] ([nID], [poradi], [delka], [cena]) VALUES (24, 3, 2, 76084)
INSERT [test].[Reklamace] ([nID], [poradi], [delka], [cena]) VALUES (25, 1, 18, 91486)
INSERT [test].[Reklamace] ([nID], [poradi], [delka], [cena]) VALUES (25, 2, 2, 2756)
INSERT [test].[Reklamace] ([nID], [poradi], [delka], [cena]) VALUES (25, 3, 14, 4482)
INSERT [test].[Reklamace] ([nID], [poradi], [delka], [cena]) VALUES (25, 4, 18, 3388)
INSERT [test].[Reklamace] ([nID], [poradi], [delka], [cena]) VALUES (27, 1, 17, 3630)
INSERT [test].[Reklamace] ([nID], [poradi], [delka], [cena]) VALUES (27, 2, 8, 3872)
INSERT [test].[Reklamace] ([nID], [poradi], [delka], [cena]) VALUES (27, 3, 12, 1912)
INSERT [test].[Reklamace] ([nID], [poradi], [delka], [cena]) VALUES (28, 1, 14, 9259)
INSERT [test].[Reklamace] ([nID], [poradi], [delka], [cena]) VALUES (29, 1, 5, 237)
INSERT [test].[Reklamace] ([nID], [poradi], [delka], [cena]) VALUES (29, 2, 4, 251)
INSERT [test].[Reklamace] ([nID], [poradi], [delka], [cena]) VALUES (29, 3, 7, 595)
INSERT [test].[Reklamace] ([nID], [poradi], [delka], [cena]) VALUES (30, 1, 7, 2288)
INSERT [test].[Reklamace] ([nID], [poradi], [delka], [cena]) VALUES (30, 2, 3, 3286)
INSERT [test].[Reklamace] ([nID], [poradi], [delka], [cena]) VALUES (30, 3, 11, 4736)
INSERT [test].[Reklamace] ([nID], [poradi], [delka], [cena]) VALUES (31, 1, 7, 3151)