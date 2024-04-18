-- Create skript pro zadani Liga, DAIS 2013
-- 2013/02/27

CREATE TABLE Liga ( 
  idLiga NUMBER NOT NULL PRIMARY KEY, 
  nazev VARCHAR2 (30)  NOT NULL UNIQUE);

CREATE TABLE Rocnik ( 
  idRocnik NUMBER  NOT NULL PRIMARY KEY, 
  idLiga NUMBER  NOT NULL  REFERENCES Liga, 
  nazev VARCHAR2 (30)  NOT NULL,
  zacatek DATE  NOT NULL,
  konec DATE  NOT NULL,
  pocet_kol NUMBER  NOT NULL);
  
CREATE TABLE Tym ( 
  idTym NUMBER  NOT NULL PRIMARY KEY, 
  nazev VARCHAR2 (30)  NOT NULL);
  
CREATE TABLE Zapas (
  idZapas NUMBER  NOT NULL PRIMARY KEY,
  idRocnik NUMBER  NOT NULL REFERENCES Rocnik,
  poradi_kola NUMBER  NOT NULL,
  domaci NUMBER REFERENCES Tym,
  hoste NUMBER REFERENCES Tym,
  datum DATE  NOT NULL, 
  skore_domaci NUMBER, 
  skore_hoste NUMBER,
  navsteva NUMBER);  

CREATE TABLE Hrac ( 
  idHrac NUMBER  NOT NULL PRIMARY KEY, 
  jmeno VARCHAR2 (30)  NOT NULL, 
  prijmeni VARCHAR2 (30)  NOT NULL, 
  body NUMBER  NOT NULL, 
  post CHAR (1)  NOT NULL);

CREATE TABLE Bodovani ( 
  idZapas INTEGER NOT NULL REFERENCES Zapas,
  idHrac NUMBER  NOT NULL REFERENCES Hrac,
  typ CHAR (1)  NOT NULL);

CREATE TABLE TymHrac ( 
  idTym NUMBER  NOT NULL REFERENCES Tym, 
  idHrac NUMBER  NOT NULL REFERENCES Hrac, 
  zacatek DATE  NOT NULL , 
  konec DATE);

CREATE TABLE Ucastnik ( 
  idRocnik NUMBER  NOT NULL REFERENCES Rocnik,
  idTym NUMBER  NOT NULL REFERENCES Tym,
  body NUMBER  NOT NULL);
  
-------------------------------------
-- Autoincrement values of synthetic primary keys
create sequence liga_seq 
  start with 1 
  increment by 1 
  nomaxvalue; 

create trigger liga_insert
  before insert on Liga
  for each row
begin
  select liga_seq.nextval into :new.idLiga from dual;
end;
/

create sequence rocnik_seq 
  start with 1 
  increment by 1 
  nomaxvalue; 

create trigger rocnik_insert
  before insert on Rocnik
  for each row
begin
  select rocnik_seq.nextval into :new.idRocnik from dual;
end;
/

create sequence zapas_seq 
  start with 1 
  increment by 1 
  nomaxvalue; 

create trigger zapas_insert
  before insert on Zapas
  for each row
begin
  select zapas_seq.nextval into :new.idZapas from dual;
end;
/