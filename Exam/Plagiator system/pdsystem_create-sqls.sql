-- Plagiarism Detection System
-- 12.03.2015
-- CREATE TABLE SQL script

CREATE TABLE DocType (
  idType INT PRIMARY KEY,
  type   VARCHAR(20) NOT NULL
);

CREATE TABLE Document (
  idDoc  INT PRIMARY KEY,
  title  VARCHAR(100) NOT NULL,
  text   TEXT NOT NULL,
  year   INT NOT NULL,
  publisher  VARCHAR(100) NOT NULL,
  plagiarism NUMERIC(1) NOT NULL,
  idType     INT  REFERENCES DocType NOT NULL
);

CREATE TABLE Term (
  idTerm INT PRIMARY KEY,
  term   VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE DocTerm (
  idDoc     INT REFERENCES Document,
  idTerm    INT REFERENCES Term,
  frequency INT NOT NULL,
  PRIMARY KEY(idDoc, idTerm)
);

CREATE TABLE DocNgram (
  idDoc   INT REFERENCES Document,
  idTerm1 INT REFERENCES Term,
  idTerm2 INT REFERENCES Term,
  idTerm3 INT REFERENCES Term,
  idTerm4 INT REFERENCES Term,
  frequency INT NOT NULL,
  PRIMARY KEY(idDoc, idTerm1, idTerm2, idTerm3, idTerm4)
);

CREATE TABLE Author (
  idAuthor INT PRIMARY KEY,
  fname    VARCHAR(30) NOT NULL,
  lname    VARCHAR(30) NOT NULL
);

CREATE TABLE DocAuthor (
  idDoc    INT REFERENCES Document,
  idAuthor INT REFERENCES Author,
  PRIMARY KEY (idDoc, idAuthor)
);

CREATE TABLE Country (
  idCountry INT PRIMARY KEY,
  country VARCHAR(30) NOT NULL,
  code    CHAR(3) NOT NULL
);

CREATE TABLE Organization (
  idOrg     INT PRIMARY KEY,
  name      VARCHAR(50) NOT NULL,
  address   VARCHAR(50) NOT NULL,
  idCountry INT REFERENCES Country  NOT NULL
);

CREATE TABLE AuthorOrg (
  idAuthor  INT REFERENCES Author,
  idOrg     INT REFERENCES Organization,
  "from"    DATE NOT NULL,
  "to"      DATE,
  PRIMARY KEY (idAuthor, idOrg)
);