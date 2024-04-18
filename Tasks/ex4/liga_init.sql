-- Init skript pro zadani Liga, DAIS 2013
-- 2013/02/27
DECLARE
  v_ligaNazev Liga.nazev%TYPE := 'Extraliga ledního hokeje';
  v_rocnikNazev Rocnik.nazev%TYPE := '2012/2013';
  v_idLiga Liga.idLiga%TYPE;
  v_idRocnik Rocnik.idRocnik%TYPE;
  v_idZapas Zapas.idZapas%TYPE;
BEGIN
  INSERT INTO Liga(nazev) VALUES(v_ligaNazev);
  SELECT idLiga INTO v_idLiga FROM Liga WHERE nazev = v_ligaNazev;

  INSERT INTO Rocnik(idLiga, nazev, zacatek, konec, pocet_kol) VALUES(v_idLiga, v_rocnikNazev, TO_DATE('25.09.2012', 'DD.MM.YYYY'), TO_DATE('11.04.2013', 'DD.MM.YYYY'), 52);
  SELECT idRocnik INTO v_idRocnik FROM Rocnik WHERE nazev = v_rocnikNazev;

  INSERT INTO Tym(idTym, nazev) VALUES(1, 'PSG Zlín');
  INSERT INTO Tym(idTym, nazev) VALUES(2, 'HC Slavia Praha');
  INSERT INTO Tym(idTym, nazev) VALUES(3, 'HC Škoda Plzeò');
  INSERT INTO Tym(idTym, nazev) VALUES(4, 'HC Oceláøi Tøinec');
  INSERT INTO Tym(idTym, nazev) VALUES(5, 'HC Sparta Praha');
  INSERT INTO Tym(idTym, nazev) VALUES(6, 'HC VERVA Litvínov');
  INSERT INTO Tym(idTym, nazev) VALUES(7, 'Rytíøi Kladno');
  INSERT INTO Tym(idTym, nazev) VALUES(8, 'HC MOUNTFIELD');
  INSERT INTO Tym(idTym, nazev) VALUES(9, 'HC VÍTKOVICE STEEL');
  INSERT INTO Tym(idTym, nazev) VALUES(10, 'HC ÈSOB Pardubice');
  INSERT INTO Tym(idTym, nazev) VALUES(11, 'HC Kometa Brno');
  INSERT INTO Tym(idTym, nazev) VALUES(12, 'HC Energie Karlovy Vary');
  INSERT INTO Tym(idTym, nazev) VALUES(13, 'Bílí Tygøi Liberec');
  INSERT INTO Tym(idTym, nazev) VALUES(14, 'Piráti Chomutov');
  
  INSERT INTO Ucastnik VALUES(v_idRocnik, 1, 94);
  INSERT INTO Ucastnik VALUES(v_idRocnik, 2, 94);
  INSERT INTO Ucastnik VALUES(v_idRocnik, 3, 89);
  INSERT INTO Ucastnik VALUES(v_idRocnik, 4, 86);
  INSERT INTO Ucastnik VALUES(v_idRocnik, 5, 86);
  INSERT INTO Ucastnik VALUES(v_idRocnik, 6, 83);
  INSERT INTO Ucastnik VALUES(v_idRocnik, 7, 77);
  INSERT INTO Ucastnik VALUES(v_idRocnik, 8, 76);
  INSERT INTO Ucastnik VALUES(v_idRocnik, 9, 75);
  INSERT INTO Ucastnik VALUES(v_idRocnik, 10, 73);
  INSERT INTO Ucastnik VALUES(v_idRocnik, 11, 72);
  INSERT INTO Ucastnik VALUES(v_idRocnik, 12, 67);
  INSERT INTO Ucastnik VALUES(v_idRocnik, 13, 63);
  INSERT INTO Ucastnik VALUES(v_idRocnik, 14, 57);

  -- vysledky 52. kola
  INSERT INTO Zapas(idRocnik, poradi_kola, domaci, hoste, datum, skore_domaci, skore_hoste, navsteva) VALUES(v_idRocnik, 52, 7, 12, to_date('26.2.2013 17:00', 'dd.mm.yyyy hh24:mi'), 1, 3, 2522);
  INSERT INTO Zapas(idRocnik, poradi_kola, domaci, hoste, datum, skore_domaci, skore_hoste, navsteva) VALUES(v_idRocnik, 52, 14, 6, to_date('26.2.2013 17:00', 'dd.mm.yyyy hh24:mi'), 5, 2, 4956);
  INSERT INTO Zapas(idRocnik, poradi_kola, domaci, hoste, datum, skore_domaci, skore_hoste, navsteva) VALUES(v_idRocnik, 52, 8, 2, to_date('26.2.2013 17:00', 'dd.mm.yyyy hh24:mi'), 0, 1, 4283);
  INSERT INTO Zapas(idRocnik, poradi_kola, domaci, hoste, datum, skore_domaci, skore_hoste, navsteva) VALUES(v_idRocnik, 52, 1, 10, to_date('26.2.2013 17:00', 'dd.mm.yyyy hh24:mi'), 4, 3, 5258);
  INSERT INTO Zapas(idRocnik, poradi_kola, domaci, hoste, datum, skore_domaci, skore_hoste, navsteva) VALUES(v_idRocnik, 52, 13, 9, to_date('26.2.2013 17:00', 'dd.mm.yyyy hh24:mi'), 2, 4, 3903);
  INSERT INTO Zapas(idRocnik, poradi_kola, domaci, hoste, datum, skore_domaci, skore_hoste, navsteva) VALUES(v_idRocnik, 52, 5, 11, to_date('26.2.2013 17:00', 'dd.mm.yyyy hh24:mi'), 6, 0, 6666);
  INSERT INTO Zapas(idRocnik, poradi_kola, domaci, hoste, datum, skore_domaci, skore_hoste, navsteva) VALUES(v_idRocnik, 52, 4, 3, to_date('26.2.2013 17:00', 'dd.mm.yyyy hh24:mi'), 4, 0, 3365);

  -- hraci, 1. branky a asistence obou tymu pro zapas Liberec - Vitkovice
  SELECT idZapas INTO v_idZapas FROM Zapas WHERE  poradi_kola=52 AND domaci=13 AND hoste=9;

  INSERT INTO Hrac VALUES(1, 'Lukáš', 'Klimek', 22, 'l');
  INSERT INTO TymHrac VALUES(9, 1, TO_DATE('01.09.2009', 'DD.MM.YYYY'), NULL);
  INSERT INTO Bodovani VALUES(v_idZapas, 1, 'g');

  INSERT INTO Hrac VALUES(2, 'Jan', 'Káòa', 388, 'p'); 
  INSERT INTO TymHrac VALUES(9, 2, TO_DATE('01.09.2006', 'DD.MM.YYYY'), NULL);
  INSERT INTO Bodovani VALUES(v_idZapas, 2, 'a');
  
  INSERT INTO Hrac VALUES(3, 'Tomáš', 'Pospíšil', 290, 'p');  
  INSERT INTO TymHrac VALUES(13, 3, TO_DATE('01.09.2012', 'DD.MM.YYYY'), NULL);
  INSERT INTO Bodovani VALUES(v_idZapas, 3, 'g');
  
  INSERT INTO Hrac VALUES(4, 'Jan', 'Víšek', 248, 'c');  
  INSERT INTO TymHrac VALUES(13, 4, TO_DATE('01.09.2005', 'DD.MM.YYYY'), NULL);
  INSERT INTO Bodovani VALUES(v_idZapas, 4, 'a');

  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
END;

-- select * from Liga;
-- select * from Rocnik;
-- select * from Tym;
-- select * from Bodovani;
-- select * from Zapas;
-- select * from TymHrac where idTym=9;
-- select * from Ucastnik;