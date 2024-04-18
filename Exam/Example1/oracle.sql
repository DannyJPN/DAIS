/*
Created: 12/3/2018
Modified: 12/3/2018
Model: Uzivatel objednavka zbozi zamestnanec pobocka
Company: FEI V�B-TU Ostrava
Database: Oracle
*/

-- drop tables
drop table Polozka;
drop table Objednavka;
drop table Osoba;
drop table Zbozi;
drop table Zamestnanec;
drop table Pobocka;


-- create tables
CREATE TABLE Osoba(
  "uID" Int NOT NULL PRIMARY KEY,
  jmeno Varchar(30) NOT NULL,
  mesto Varchar(30) NOT NULL,
  rok_narozeni Int NULL,
  stat Varchar(30) NULL,
  zeme Varchar(30) NOT NULL,
  status Int NOT NULL);

CREATE TABLE Zbozi (
  zID Int NOT NULL PRIMARY KEY,
  kategorie Int NOT NULL,
  nazev Varchar(30) NOT NULL,
  rok_vyroby Int NOT NULL,
  aktualni_cena Int NOT NULL);

CREATE TABLE Pobocka (
  pID Int NOT NULL PRIMARY KEY,
  mesto Varchar(30) NOT NULL,
  stat Varchar(30) NULL,
  zeme Varchar(30) NOT NULL,
  status Int NOT NULL);

CREATE TABLE Zamestnanec (
  zaID Int NOT NULL PRIMARY KEY,
  pID Int NOT NULL REFERENCES Pobocka(pID),
  jmeno Varchar(30) NOT NULL,
  datum_narozeni Date NOT NULL,
  platova_trida Int NOT NULL);

CREATE TABLE Objednavka (
  "oID" Int NOT NULL PRIMARY KEY,
  "uID" Int NOT NULL REFERENCES Osoba("uID"),
  vytvorena Date NOT NULL,
  potvrzena Date NULL,
  dorucena Date NULL,
  zaID Int NOT NULL REFERENCES Zamestnanec(zaID));


CREATE TABLE Polozka (
  "oID" Int NOT NULL REFERENCES Objednavka("oID"),
  zID Int NOT NULL REFERENCES Zbozi(zID),
  cena Int NOT NULL,
  kusu Int NOT NULL,
  CONSTRAINT PK_polozka PRIMARY KEY ("oID",zID));

BEGIN

-- insert records
INSERT INTO Osoba("uID", jmeno, mesto,rok_narozeni, stat, zeme, status) VALUES(1, 'Bernoulli', 'Venice', 1654, NULL, 'Italy', 1);
INSERT INTO Osoba("uID", jmeno, mesto,rok_narozeni, stat, zeme, status) VALUES(2, 'Bernoulli', 'Venice',  1667, NULL, 'Italy', 1);
INSERT INTO Osoba("uID", jmeno, mesto,rok_narozeni, stat, zeme, status) VALUES(3, 'Bernoulli', 'Mila',  1695, NULL, 'Italy', 1);
INSERT INTO Osoba("uID", jmeno, mesto,rok_narozeni, stat, zeme, status) VALUES(4, 'Bernoulli', 'Roma',  1700, NULL, 'Italy', 2);
INSERT INTO Osoba("uID", jmeno, mesto,rok_narozeni, stat, zeme, status) VALUES(5, 'Bernoulli', 'Madrid',  1710, NULL, 'Spai', 1);
INSERT INTO Osoba("uID", jmeno, mesto,rok_narozeni, stat, zeme, status) VALUES(6, 'Euler', 'Atlanta', 1707, 'Georgia', 'United States of America', 1);
INSERT INTO Osoba("uID", jmeno, mesto,rok_narozeni, stat, zeme, status) VALUES(7, 'Rousseau', 'Philadelphia', 1712, 'Pennsylvania', 'United States of America', 1);
INSERT INTO Osoba("uID", jmeno, mesto,rok_narozeni, stat, zeme, status) VALUES(8, 'Laplace', 'Albany', 1749, 'New York', 'United States of America', 2);
INSERT INTO Osoba("uID", jmeno, mesto,rok_narozeni, stat, zeme, status) VALUES(9, 'Leibniz', 'Berli', 1646, NULL, 'Germany', 1);
INSERT INTO Osoba("uID", jmeno, mesto,rok_narozeni, stat, zeme, status) VALUES(10, 'Descartes', 'Paris', 1596, NULL, 'France', 1);
INSERT INTO Osoba("uID", jmeno, mesto,rok_narozeni, stat, zeme, status) VALUES(11, 'Newto', 'Londo', 1642, 'England', 'Great Britai', 1);
INSERT INTO Osoba("uID", jmeno, mesto,rok_narozeni, stat, zeme, status) VALUES(12, 'Kepler', 'Prague', NULL, NULL, 'Austria-Hungary', 1);
INSERT INTO Osoba("uID", jmeno, mesto,rok_narozeni, stat, zeme, status) VALUES(13, 'Bayes', 'Londo', 1701, 'England', 'Great Britai', 1);
INSERT INTO Osoba("uID", jmeno, mesto,rok_narozeni, stat, zeme, status) VALUES(14, 'al-Kashi', ' Kasha', NULL, NULL, 'Ira', 1);
INSERT INTO Osoba("uID", jmeno, mesto,rok_narozeni, stat, zeme, status) VALUES(15, 'Lagrange', 'Paris', 1736, NULL, 'France', 1);
INSERT INTO Osoba("uID", jmeno, mesto,rok_narozeni, stat, zeme, status) VALUES(16, 'Chongzhi', ' Kunsha', NULL, NULL, 'China', 1);
INSERT INTO Osoba("uID", jmeno, mesto,rok_narozeni, stat, zeme, status) VALUES(17, 'Sangamagrama', ' Dehli', NULL, 'Kerala', 'India', 1);

INSERT INTO Zbozi(zID, kategorie, nazev, rok_vyroby, aktualni_cena) VALUES(1, 1, 'Cook Toend U2', 2012, 2500);
INSERT INTO Zbozi(zID, kategorie, nazev, rok_vyroby, aktualni_cena) VALUES(2, 1, 'Cook Toend trend', 2012, 3560);
INSERT INTO Zbozi(zID, kategorie, nazev, rok_vyroby, aktualni_cena) VALUES(3, 1, 'Fridge Hemenex R2-D2', 2012, 5200);
INSERT INTO Zbozi(zID, kategorie, nazev, rok_vyroby, aktualni_cena) VALUES(4, 1, 'Fridge Storelot D2 KJ2', 2010, 4800);
INSERT INTO Zbozi(zID, kategorie, nazev, rok_vyroby, aktualni_cena) VALUES(5, 1, 'Cook Withoutfear UBG', 2011, 9500);
INSERT INTO Zbozi(zID, kategorie, nazev, rok_vyroby, aktualni_cena) VALUES(6, 1, 'Wacher Cleanfast X2-Kl', 2006, 1800);
INSERT INTO Zbozi(zID, kategorie, nazev, rok_vyroby, aktualni_cena) VALUES(7, 1, 'Cook Withoutfear', 2013, 2890);
INSERT INTO Zbozi(zID, kategorie, nazev, rok_vyroby, aktualni_cena) VALUES(8, 2, 'Grass-cutter Handy 6K', 2012, 8920);
INSERT INTO Zbozi(zID, kategorie, nazev, rok_vyroby, aktualni_cena) VALUES(9, 2, 'Grass-cutter Jede Tam', 2012, 12920);
INSERT INTO Zbozi(zID, kategorie, nazev, rok_vyroby, aktualni_cena) VALUES(10, 2, 'Hatched Cool 5', 2010, 980);
INSERT INTO Zbozi(zID, kategorie, nazev, rok_vyroby, aktualni_cena) VALUES(11, 2, 'Saw 5', 2010, 1980);
INSERT INTO Zbozi(zID, kategorie, nazev, rok_vyroby, aktualni_cena) VALUES(12, 3, 'Easy machine', 2014, 8531);

INSERT INTO Pobocka(pID, mesto, stat, zeme, status) VALUES(1, 'Venice', NULL, 'Italy', 1);
INSERT INTO Pobocka(pID, mesto, stat, zeme, status) VALUES(2, 'San Francisco', 'California', 'United States of America', 1);
INSERT INTO Pobocka(pID, mesto, stat, zeme, status) VALUES(3, 'Philadelphia', 'Pennsylvania', 'United States of America', 1);
INSERT INTO Pobocka(pID, mesto, stat, zeme, status) VALUES(4, 'Dehli', NULL, 'India', 1);

INSERT INTO Zamestnanec(zaID, pID, jmeno, datum_narozeni, platova_trida) VALUES(1, 2, 'Frank Rogers', TO_DATE('1970,5,16', 'YYYY,MM,DD'), 3);
INSERT INTO Zamestnanec(zaID, pID, jmeno, datum_narozeni, platova_trida) VALUES(2, 2, 'Frederik Jones', TO_DATE('1975,1,10', 'YYYY,MM,DD'), 2);
INSERT INTO Zamestnanec(zaID, pID, jmeno, datum_narozeni, platova_trida) VALUES(3, 2, 'Alexis Hubert', TO_DATE('1970,2,11', 'YYYY,MM,DD'), 2);
INSERT INTO Zamestnanec(zaID, pID, jmeno, datum_narozeni, platova_trida) VALUES(4, 2, 'Kate Rogers', TO_DATE('1975,3,1', 'YYYY,MM,DD'), 1);
INSERT INTO Zamestnanec(zaID, pID, jmeno, datum_narozeni, platova_trida) VALUES(5, 1, 'Alberta Polidiary', TO_DATE('1960,10,12', 'YYYY,MM,DD'), 3);
INSERT INTO Zamestnanec(zaID, pID, jmeno, datum_narozeni, platova_trida) VALUES(6, 1, 'Francesca Aterini', TO_DATE('1976,11,1', 'YYYY,MM,DD'), 2);
INSERT INTO Zamestnanec(zaID, pID, jmeno, datum_narozeni, platova_trida) VALUES(7, 1, 'Alonzo Fereira', TO_DATE('1962,6,25', 'YYYY,MM,DD'), 2);
INSERT INTO Zamestnanec(zaID, pID, jmeno, datum_narozeni, platova_trida) VALUES(8, 3, 'David Wu Che', TO_DATE('1970,2,1', 'YYYY,MM,DD'), 3);
INSERT INTO Zamestnanec(zaID, pID, jmeno, datum_narozeni, platova_trida) VALUES(9, 3, 'Thomas Camero', TO_DATE('1955,1,2', 'YYYY,MM,DD'), 3);
INSERT INTO Zamestnanec(zaID, pID, jmeno, datum_narozeni, platova_trida) VALUES(10, 3, 'Jane Jugaschvili', TO_DATE('1962,8,19', 'YYYY,MM,DD'), 2);
INSERT INTO Zamestnanec(zaID, pID, jmeno, datum_narozeni, platova_trida) VALUES(11, 3, 'Oliver Dream', TO_DATE('1965,9,2', 'YYYY,MM,DD'), 2);
INSERT INTO Zamestnanec(zaID, pID, jmeno, datum_narozeni, platova_trida) VALUES(12, 3, 'Hubert Novy', TO_DATE('1992,12,13', 'YYYY,MM,DD'), 1);
INSERT INTO Zamestnanec(zaID, pID, jmeno, datum_narozeni, platova_trida) VALUES(13, 4, 'Ananda Burma', TO_DATE('1973,5,5', 'YYYY,MM,DD'), 2);
INSERT INTO Zamestnanec(zaID, pID, jmeno, datum_narozeni, platova_trida) VALUES(14, 4, 'Kishan Pradeep', TO_DATE('1978,6,7', 'YYYY,MM,DD'), 3);


INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(2, 1, TO_DATE('2014-03-17 17:50:18', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-03-17 21:35:18', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-03-21 10:43:18', 'YYYY-MM-DD HH24:MI:SS'), 10);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(3, 1, TO_DATE('2014-11-15 23:05:12', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, 4);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(4, 1, TO_DATE('2014-01-15 04:13:11', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-01-15 06:42:11', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-01-17 18:19:11', 'YYYY-MM-DD HH24:MI:SS'), 9);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(5, 1, TO_DATE('2014-11-18 22:45:51', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-11-19 01:27:51', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-11-25 02:33:51', 'YYYY-MM-DD HH24:MI:SS'), 1);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(6, 1, TO_DATE('2014-01-25 10:49:34', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-01-25 12:14:34', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-01-26 02:25:34', 'YYYY-MM-DD HH24:MI:SS'), 4);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(7, 1, TO_DATE('2014-03-04 03:29:02', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-03-04 04:16:02', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-03-11 23:56:02', 'YYYY-MM-DD HH24:MI:SS'), 8);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(8, 1, TO_DATE('2014-01-12 07:36:34', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-01-12 09:59:34', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-01-12 19:30:34', 'YYYY-MM-DD HH24:MI:SS'), 9);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(9, 2, TO_DATE('2014-03-21 16:48:27', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-03-21 19:13:27', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-03-30 07:20:27', 'YYYY-MM-DD HH24:MI:SS'), 1);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(10, 2, TO_DATE('2014-01-04 18:44:57', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-01-04 22:22:57', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-01-08 01:46:57', 'YYYY-MM-DD HH24:MI:SS'), 4);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(11, 2, TO_DATE('2014-10-21 02:07:19', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-10-21 04:42:19', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-10-27 12:56:19', 'YYYY-MM-DD HH24:MI:SS'), 6);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(12, 3, TO_DATE('2014-04-14 15:51:45', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-04-14 19:19:45', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-04-16 13:34:45', 'YYYY-MM-DD HH24:MI:SS'), 1);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(13, 3, TO_DATE('2014-08-28 08:47:48', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-08-28 10:36:48', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-09-07 03:46:48', 'YYYY-MM-DD HH24:MI:SS'), 11);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(14, 3, TO_DATE('2014-08-18 09:05:50', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, 5);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(15, 4, TO_DATE('2014-06-13 15:20:13', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, 1);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(16, 4, TO_DATE('2014-08-08 18:40:55', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-08-08 19:12:55', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-08-18 03:50:55', 'YYYY-MM-DD HH24:MI:SS'), 2);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(17, 4, TO_DATE('2014-01-18 21:37:12', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-01-18 23:12:12', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-01-22 13:31:12', 'YYYY-MM-DD HH24:MI:SS'), 13);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(18, 4, TO_DATE('2014-02-27 07:06:22', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-02-27 09:35:22', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-03-02 14:51:22', 'YYYY-MM-DD HH24:MI:SS'), 1);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(19, 4, TO_DATE('2014-12-06 17:44:44', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-12-06 20:14:44', 'YYYY-MM-DD HH24:MI:SS'), NULL, 3);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(20, 4, TO_DATE('2014-11-17 14:28:09', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-11-17 15:08:09', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-11-19 02:34:09', 'YYYY-MM-DD HH24:MI:SS'), 12);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(21, 6, TO_DATE('2014-01-11 08:10:59', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-01-11 09:40:59', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-01-21 05:23:59', 'YYYY-MM-DD HH24:MI:SS'), 13);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(22, 6, TO_DATE('2014-06-11 16:58:17', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-06-11 18:38:17', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-06-20 11:26:17', 'YYYY-MM-DD HH24:MI:SS'), 7);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(23, 6, TO_DATE('2014-03-17 11:41:55', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-03-17 14:23:55', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-03-21 07:11:55', 'YYYY-MM-DD HH24:MI:SS'), 1);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(24, 6, TO_DATE('2014-08-11 20:12:01', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-08-11 22:48:01', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-08-12 08:51:01', 'YYYY-MM-DD HH24:MI:SS'), 1);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(25, 6, TO_DATE('2014-08-19 09:57:13', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-08-19 11:23:13', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-08-27 14:09:13', 'YYYY-MM-DD HH24:MI:SS'), 10);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(26, 6, TO_DATE('2014-04-27 04:38:49', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-04-27 06:58:49', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-04-29 22:06:49', 'YYYY-MM-DD HH24:MI:SS'), 10);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(27, 6, TO_DATE('2014-06-12 19:20:35', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-06-12 22:57:35', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-06-17 13:14:35', 'YYYY-MM-DD HH24:MI:SS'), 4);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(28, 6, TO_DATE('2014-09-17 09:05:45', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-09-17 11:52:45', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-09-26 06:59:45', 'YYYY-MM-DD HH24:MI:SS'), 7);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(29, 6, TO_DATE('2014-08-01 21:20:31', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-08-01 22:45:31', 'YYYY-MM-DD HH24:MI:SS'), NULL, 5);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(30, 7, TO_DATE('2014-06-05 15:11:09', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-06-05 18:54:09', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-06-08 01:08:09', 'YYYY-MM-DD HH24:MI:SS'), 8);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(31, 7, TO_DATE('2014-10-27 09:56:09', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-10-27 12:25:09', 'YYYY-MM-DD HH24:MI:SS'), NULL, 1);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(32, 7, TO_DATE('2014-07-02 13:00:26', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-07-02 13:45:26', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-07-08 13:56:26', 'YYYY-MM-DD HH24:MI:SS'), 8);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(33, 7, TO_DATE('2014-11-11 19:22:21', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-11-11 23:03:21', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-11-19 05:43:21', 'YYYY-MM-DD HH24:MI:SS'), 5);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(34, 7, TO_DATE('2014-03-06 11:22:48', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-03-06 12:52:48', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-03-16 07:36:48', 'YYYY-MM-DD HH24:MI:SS'), 9);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(35, 8, TO_DATE('2014-09-09 03:43:02', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, 5);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(36, 8, TO_DATE('2014-12-01 16:52:28', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, 3);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(37, 8, TO_DATE('2014-02-03 15:05:33', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-02-03 15:54:33', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-02-07 05:09:33', 'YYYY-MM-DD HH24:MI:SS'), 4);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(38, 9, TO_DATE('2014-06-11 14:23:32', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, 1);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(39, 10, TO_DATE('2014-04-24 20:51:30', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-04-24 23:18:30', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-04-28 18:51:30', 'YYYY-MM-DD HH24:MI:SS'), 6);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(40, 10, TO_DATE('2014-01-05 14:39:56', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, 12);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(41, 10, TO_DATE('2014-10-28 10:59:35', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-10-28 13:20:35', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-11-07 02:50:35', 'YYYY-MM-DD HH24:MI:SS'), 10);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(42, 10, TO_DATE('2014-08-05 12:52:44', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-08-05 13:23:44', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-08-11 07:50:44', 'YYYY-MM-DD HH24:MI:SS'), 12);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(43, 10, TO_DATE('2014-03-20 21:26:21', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-03-21 01:11:21', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-03-29 03:44:21', 'YYYY-MM-DD HH24:MI:SS'), 9);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(44, 10, TO_DATE('2014-02-08 18:51:58', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-02-08 21:14:58', 'YYYY-MM-DD HH24:MI:SS'), NULL, 4);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(45, 10, TO_DATE('2014-11-18 01:58:52', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, 4);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(46, 10, TO_DATE('2014-05-24 02:54:57', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-05-24 04:18:57', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-05-27 08:01:57', 'YYYY-MM-DD HH24:MI:SS'), 6);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(47, 11, TO_DATE('2014-03-28 13:35:31', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, 2);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(48, 11, TO_DATE('2014-01-22 18:08:06', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-01-22 19:41:06', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-01-31 06:43:06', 'YYYY-MM-DD HH24:MI:SS'), 10);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(49, 11, TO_DATE('2014-02-09 11:46:25', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-02-09 14:14:25', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-02-17 04:49:25', 'YYYY-MM-DD HH24:MI:SS'), 2);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(50, 11, TO_DATE('2014-09-16 06:54:04', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-09-16 08:27:04', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-09-19 09:57:04', 'YYYY-MM-DD HH24:MI:SS'), 2);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(51, 11, TO_DATE('2014-11-17 20:10:10', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-11-17 21:56:10', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-11-26 09:56:10', 'YYYY-MM-DD HH24:MI:SS'), 12);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(52, 11, TO_DATE('2014-03-08 14:39:41', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-03-08 17:16:41', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-03-10 17:18:41', 'YYYY-MM-DD HH24:MI:SS'), 11);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(53, 11, TO_DATE('2014-09-18 08:03:07', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-09-18 11:36:07', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-09-18 19:37:07', 'YYYY-MM-DD HH24:MI:SS'), 10);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(54, 11, TO_DATE('2014-07-04 17:29:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-07-04 17:50:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-07-08 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 13);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(55, 12, TO_DATE('2014-06-15 16:49:16', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-06-15 17:36:16', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-06-16 10:20:16', 'YYYY-MM-DD HH24:MI:SS'), 6);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(56, 12, TO_DATE('2014-01-13 08:21:21', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-01-13 09:44:21', 'YYYY-MM-DD HH24:MI:SS'), NULL, 2);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(57, 12, TO_DATE('2014-06-03 00:06:47', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-06-03 00:38:47', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-06-04 18:04:47', 'YYYY-MM-DD HH24:MI:SS'), 9);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(58, 12, TO_DATE('2014-04-13 13:27:37', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-04-13 14:52:37', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-04-21 09:32:37', 'YYYY-MM-DD HH24:MI:SS'), 9);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(59, 12, TO_DATE('2014-12-13 12:31:46', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-12-13 15:11:46', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-12-16 22:49:46', 'YYYY-MM-DD HH24:MI:SS'), 14);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(60, 12, TO_DATE('2014-04-02 07:28:27', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-04-02 08:09:27', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-04-09 11:40:27', 'YYYY-MM-DD HH24:MI:SS'), 12);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(61, 12, TO_DATE('2014-06-21 14:28:57', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-06-21 15:17:57', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-06-29 02:20:57', 'YYYY-MM-DD HH24:MI:SS'), 2);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(62, 12, TO_DATE('2014-02-03 14:03:26', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-02-03 17:39:26', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-02-05 11:20:26', 'YYYY-MM-DD HH24:MI:SS'), 10);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(63, 12, TO_DATE('2014-12-18 10:51:10', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-12-18 13:35:10', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-12-22 03:24:10', 'YYYY-MM-DD HH24:MI:SS'), 14);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(64, 13, TO_DATE('2014-12-28 10:31:08', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-12-28 11:10:08', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-01-03 14:20:08', 'YYYY-MM-DD HH24:MI:SS'), 13);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(65, 13, TO_DATE('2014-01-14 07:22:28', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-01-14 09:58:28', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-01-19 16:35:28', 'YYYY-MM-DD HH24:MI:SS'), 11);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(66, 13, TO_DATE('2014-02-25 20:13:18', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-02-25 20:56:18', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-03-07 16:17:18', 'YYYY-MM-DD HH24:MI:SS'), 7);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(67, 13, TO_DATE('2014-07-03 05:48:55', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-07-03 09:17:55', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-07-12 21:50:55', 'YYYY-MM-DD HH24:MI:SS'), 7);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(68, 13, TO_DATE('2014-12-15 17:05:49', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-12-15 18:40:49', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-12-15 22:29:49', 'YYYY-MM-DD HH24:MI:SS'), 12);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(69, 13, TO_DATE('2014-03-08 12:21:59', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-03-08 13:52:59', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-03-12 23:56:59', 'YYYY-MM-DD HH24:MI:SS'), 9);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(70, 13, TO_DATE('2014-03-25 20:35:45', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-03-25 23:08:45', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-04-03 02:37:45', 'YYYY-MM-DD HH24:MI:SS'), 13);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(71, 13, TO_DATE('2014-06-04 06:58:13', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-06-04 09:26:13', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-06-10 14:59:13', 'YYYY-MM-DD HH24:MI:SS'), 9);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(72, 13, TO_DATE('2014-09-23 10:54:28', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-09-23 12:21:28', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-09-28 04:25:28', 'YYYY-MM-DD HH24:MI:SS'), 9);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(73, 15, TO_DATE('2014-06-15 06:42:30', 'YYYY-MM-DD HH24:MI:SS'), NULL, NULL, 7);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(74, 15, TO_DATE('2014-09-17 02:26:21', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-09-17 03:59:21', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-09-23 23:36:21', 'YYYY-MM-DD HH24:MI:SS'), 1);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(75, 15, TO_DATE('2014-03-19 17:40:30', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-03-19 21:05:30', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-03-20 10:35:30', 'YYYY-MM-DD HH24:MI:SS'), 6);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(76, 15, TO_DATE('2014-04-05 22:21:57', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-04-05 23:10:57', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-04-06 00:56:57', 'YYYY-MM-DD HH24:MI:SS'), 13);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(77, 15, TO_DATE('2014-01-22 07:25:27', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-01-22 10:11:27', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-01-29 19:47:27', 'YYYY-MM-DD HH24:MI:SS'), 13);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(78, 15, TO_DATE('2014-02-11 18:11:39', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-02-11 18:44:39', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-02-21 10:52:39', 'YYYY-MM-DD HH24:MI:SS'), 9);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(79, 15, TO_DATE('2014-11-05 14:02:48', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-11-05 15:47:48', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-11-13 06:01:48', 'YYYY-MM-DD HH24:MI:SS'), 4);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(80, 15, TO_DATE('2014-08-28 16:35:53', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-08-28 17:08:53', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-09-02 21:33:53', 'YYYY-MM-DD HH24:MI:SS'), 13);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(81, 16, TO_DATE('2014-12-18 21:49:51', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-12-18 23:21:51', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-12-28 02:09:51', 'YYYY-MM-DD HH24:MI:SS'), 11);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(82, 16, TO_DATE('2014-12-18 07:50:11', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-12-18 09:14:11', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-12-22 04:28:11', 'YYYY-MM-DD HH24:MI:SS'), 12);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(83, 16, TO_DATE('2014-03-17 12:51:25', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-03-17 14:32:25', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-03-22 22:57:25', 'YYYY-MM-DD HH24:MI:SS'), 1);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(84, 16, TO_DATE('2014-10-22 10:24:23', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-10-22 10:49:23', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-10-26 18:55:23', 'YYYY-MM-DD HH24:MI:SS'), 2);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(85, 16, TO_DATE('2014-07-17 18:58:37', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-07-17 22:47:37', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-07-25 07:21:37', 'YYYY-MM-DD HH24:MI:SS'), 9);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(86, 16, TO_DATE('2014-11-27 10:59:37', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-11-27 13:32:37', 'YYYY-MM-DD HH24:MI:SS'), NULL, 10);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(87, 16, TO_DATE('2014-08-25 08:50:50', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-08-25 09:38:50', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-09-01 11:55:50', 'YYYY-MM-DD HH24:MI:SS'), 12);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(88, 16, TO_DATE('2014-04-21 02:45:53', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-04-21 03:28:53', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-04-25 10:12:53', 'YYYY-MM-DD HH24:MI:SS'), 3);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(89, 16, TO_DATE('2014-03-28 23:03:42', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-03-28 23:36:42', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-03-30 02:46:42', 'YYYY-MM-DD HH24:MI:SS'), 1);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(90, 17, TO_DATE('2014-04-13 16:41:43', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-04-13 20:18:43', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-04-16 20:26:43', 'YYYY-MM-DD HH24:MI:SS'), 10);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(91, 17, TO_DATE('2014-04-09 07:27:41', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-04-09 10:09:41', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-04-14 17:19:41', 'YYYY-MM-DD HH24:MI:SS'), 4);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(92, 17, TO_DATE('2014-10-19 13:22:14', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-10-19 16:06:14', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-10-22 20:34:14', 'YYYY-MM-DD HH24:MI:SS'), 1);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(93, 17, TO_DATE('2014-01-02 15:40:48', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-01-02 16:09:48', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-01-08 22:26:48', 'YYYY-MM-DD HH24:MI:SS'), 9);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(94, 17, TO_DATE('2014-07-07 03:13:54', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-07-07 04:43:54', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-07-15 15:57:54', 'YYYY-MM-DD HH24:MI:SS'), 13);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(95, 17, TO_DATE('2014-03-10 14:27:19', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-03-10 15:55:19', 'YYYY-MM-DD HH24:MI:SS'), NULL, 12);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(96, 17, TO_DATE('2014-05-21 12:19:21', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-05-21 14:07:21', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-05-23 22:08:21', 'YYYY-MM-DD HH24:MI:SS'), 12);
INSERT INTO Objednavka("oID", "uID", vytvorena, potvrzena, dorucena, zaID) VALUES(97, 17, TO_DATE('2014-09-03 22:42:29', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-09-04 02:21:29', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-09-06 15:33:29', 'YYYY-MM-DD HH24:MI:SS'), 2);


INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(2, 1, 2405, 8);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(2, 8, 9082, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(2, 10, 1347, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(3, 1, 2548, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(3, 8, 9217, 9);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(3, 11, 2351, 3);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(3, 12, 8529, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(4, 1, 2425, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(4, 7, 3180, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(4, 8, 9029, 3);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(5, 2, 3647, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(5, 8, 9069, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(5, 9, 13026, 5);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(6, 1, 2441, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(6, 2, 3684, 9);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(6, 10, 1296, 5);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(7, 3, 5565, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(8, 2, 3823, 7);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(9, 4, 5089, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(9, 7, 3038, 3);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(9, 9, 12965, 4);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(9, 11, 2252, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(10, 2, 3821, 5);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(10, 3, 5169, 4);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(10, 7, 2799, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(10, 9, 12941, 3);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(10, 11, 2030, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(11, 2, 3845, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(11, 6, 1970, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(12, 3, 5489, 7);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(12, 4, 4995, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(13, 2, 3612, 5);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(13, 12, 8548, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(14, 2, 3782, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(14, 6, 1758, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(14, 8, 9068, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(14, 9, 12954, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(14, 11, 2299, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(15, 4, 4824, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(15, 7, 2812, 3);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(15, 10, 1363, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(15, 11, 2065, 8);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(16, 4, 4746, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(16, 7, 3251, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(16, 10, 891, 4);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(16, 11, 2252, 4);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(17, 7, 2934, 4);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(17, 10, 1303, 6);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(18, 8, 9306, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(18, 9, 12875, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(18, 11, 2349, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(19, 1, 2414, 8);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(19, 3, 5354, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(19, 5, 9702, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(19, 12, 8890, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(20, 4, 5129, 6);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(21, 1, 2622, 4);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(21, 4, 4804, 9);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(21, 11, 2021, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(22, 1, 2743, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(22, 10, 1141, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(23, 3, 5499, 3);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(23, 5, 9707, 3);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(23, 7, 2987, 6);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(23, 11, 2186, 3);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(23, 12, 8841, 3);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(24, 1, 2661, 3);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(24, 6, 1726, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(24, 7, 2996, 4);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(24, 8, 9300, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(24, 10, 1335, 3);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(25, 3, 5515, 9);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(25, 5, 9653, 3);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(25, 6, 2127, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(25, 11, 2062, 4);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(26, 6, 1950, 5);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(26, 8, 8885, 5);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(26, 11, 1900, 3);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(26, 12, 8825, 4);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(27, 2, 3489, 6);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(27, 3, 5130, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(27, 8, 8925, 7);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(27, 11, 2225, 6);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(28, 3, 5216, 7);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(28, 9, 13269, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(29, 4, 5047, 9);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(29, 8, 9012, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(29, 10, 1243, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(29, 11, 2174, 4);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(30, 1, 2534, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(30, 9, 13122, 4);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(31, 6, 2167, 4);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(31, 11, 2322, 6);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(32, 1, 2454, 6);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(32, 7, 2964, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(32, 9, 13069, 7);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(32, 10, 883, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(33, 3, 5536, 6);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(34, 1, 2745, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(34, 5, 9883, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(34, 11, 2124, 9);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(35, 1, 2441, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(35, 5, 9567, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(35, 7, 3174, 3);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(36, 9, 13248, 3);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(37, 1, 2703, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(38, 3, 5316, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(38, 4, 5124, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(38, 11, 2162, 3);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(39, 3, 5508, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(40, 4, 4873, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(41, 1, 2412, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(41, 2, 3528, 4);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(41, 6, 2075, 3);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(41, 8, 9290, 9);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(41, 11, 2288, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(42, 4, 5182, 4);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(42, 7, 2807, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(42, 12, 8515, 3);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(43, 1, 2512, 3);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(43, 7, 2817, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(44, 2, 3833, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(44, 3, 5440, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(44, 9, 13137, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(44, 11, 2164, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(44, 12, 8665, 5);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(45, 5, 9815, 5);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(45, 7, 3214, 3);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(45, 8, 9317, 3);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(45, 9, 13262, 7);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(45, 11, 1978, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(46, 3, 5256, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(46, 6, 2104, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(46, 9, 13023, 6);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(47, 3, 5202, 4);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(47, 5, 9600, 4);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(47, 10, 1167, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(47, 11, 1945, 9);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(48, 2, 3949, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(48, 3, 5204, 5);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(48, 9, 12959, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(48, 11, 1893, 5);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(49, 1, 2518, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(49, 6, 1961, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(49, 8, 9073, 8);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(49, 11, 2373, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(50, 12, 8895, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(51, 1, 2593, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(51, 6, 1861, 4);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(51, 7, 2856, 3);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(51, 10, 1171, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(52, 1, 2563, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(52, 4, 4967, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(52, 6, 1947, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(52, 12, 8549, 6);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(53, 3, 5540, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(53, 6, 2054, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(53, 10, 1292, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(53, 12, 8600, 7);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(54, 1, 2607, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(54, 5, 9493, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(54, 12, 8497, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(55, 3, 5414, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(55, 4, 4760, 3);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(55, 6, 1720, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(55, 7, 2965, 4);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(56, 5, 9798, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(56, 11, 2148, 3);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(57, 3, 5145, 3);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(57, 8, 9317, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(57, 10, 1230, 5);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(57, 12, 8847, 5);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(58, 4, 5112, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(58, 9, 13270, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(59, 1, 2740, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(59, 5, 9743, 3);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(59, 9, 12987, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(60, 1, 2760, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(60, 3, 5187, 3);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(60, 4, 5112, 5);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(60, 11, 2346, 5);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(61, 1, 2467, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(62, 9, 13274, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(63, 10, 1350, 8);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(63, 11, 1957, 3);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(64, 3, 5327, 5);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(64, 5, 9516, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(64, 6, 2149, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(65, 2, 3740, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(66, 3, 5261, 3);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(66, 4, 4786, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(66, 5, 9880, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(67, 8, 9060, 6);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(68, 2, 3818, 3);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(68, 8, 9144, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(68, 10, 1294, 3);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(69, 1, 2540, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(69, 2, 3889, 5);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(69, 4, 5081, 3);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(70, 9, 13145, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(71, 2, 3775, 3);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(71, 4, 5118, 4);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(71, 6, 1911, 3);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(72, 1, 2832, 3);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(73, 2, 3703, 6);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(73, 5, 9741, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(73, 6, 1706, 5);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(73, 10, 1174, 6);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(73, 12, 8858, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(74, 1, 2802, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(74, 4, 5056, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(74, 5, 9489, 8);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(74, 8, 9002, 3);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(74, 10, 1055, 9);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(75, 4, 4973, 7);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(76, 1, 2892, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(76, 9, 12913, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(76, 11, 2083, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(76, 12, 8816, 5);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(77, 6, 1882, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(77, 7, 2890, 6);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(77, 8, 9185, 9);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(77, 12, 8491, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(78, 5, 9542, 4);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(78, 6, 1872, 3);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(78, 8, 8869, 8);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(78, 9, 13195, 5);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(79, 2, 3759, 3);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(79, 5, 9568, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(79, 7, 3253, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(79, 10, 1156, 7);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(80, 8, 8938, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(80, 10, 1084, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(80, 11, 1955, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(81, 3, 5281, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(81, 7, 3235, 8);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(81, 8, 8877, 4);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(81, 11, 2039, 8);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(81, 12, 8679, 3);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(82, 5, 9444, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(82, 6, 1934, 3);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(82, 12, 8514, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(83, 11, 2098, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(84, 1, 2709, 8);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(84, 3, 5553, 4);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(84, 6, 2086, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(84, 9, 12967, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(85, 2, 3499, 4);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(85, 3, 5123, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(85, 5, 9474, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(85, 10, 961, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(85, 12, 8670, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(86, 3, 5519, 5);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(87, 2, 3560, 5);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(87, 5, 9868, 4);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(87, 8, 9061, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(87, 9, 13117, 7);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(87, 12, 8545, 3);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(88, 9, 13258, 3);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(89, 6, 1809, 3);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(89, 9, 13125, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(90, 4, 5099, 5);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(90, 7, 3241, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(90, 8, 9003, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(90, 10, 1126, 3);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(90, 11, 2096, 4);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(91, 6, 2152, 5);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(92, 4, 5162, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(92, 8, 9200, 7);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(93, 4, 5049, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(94, 7, 3198, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(95, 4, 5006, 4);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(95, 5, 9743, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(95, 11, 2227, 3);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(96, 4, 4861, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(96, 11, 2297, 2);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(97, 3, 5428, 1);
INSERT INTO Polozka("oID", zID, cena, kusu) VALUES(97, 5, 9635, 2);

COMMIT;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
END;