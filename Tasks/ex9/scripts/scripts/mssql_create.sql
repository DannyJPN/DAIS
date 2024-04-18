CREATE TABLE "User" (
 idUser                      INTEGER NOT NULL PRIMARY KEY IDENTITY,
 login                       VARCHAR(10) NOT NULL,
 name                        VARCHAR(20) NOT NULL,
 surname                     VARCHAR(20) NOT NULL,
 address                     VARCHAR(40),
 telephone                   VARCHAR(12),
 maximum_unfinisfed_auctions INTEGER NOT NULL,
 last_visit                  DATETIME,
 type                        VARCHAR(10) NOT NULL);

go
SET IDENTITY_INSERT "User" ON
INSERT INTO "User" (idUser,[login],name,surname,[address],telephone,maximum_unfinisfed_auctions,last_visit,[type]) VALUES(1, 'kra28', 'Michal', 'Krátký', 'adresa', '123456789', 0, NULL, 'U');
INSERT INTO "User" (idUser,[login],name,surname,[address],telephone,maximum_unfinisfed_auctions,last_visit,[type])  VALUES(2, 'bed157', 'Pavel', 'Bednár', 'adresa', '123456789', 0, NULL, 'U');
SET IDENTITY_INSERT "User" OFF
go
CREATE TABLE Category (
  idCategory	INTEGER PRIMARY KEY IDENTITY,
  name			VARCHAR(30) NOT NULL,
  description	VARCHAR(100));
  
INSERT INTO Category(name) VALUES('hardware');
INSERT INTO Category(name) VALUES('furniture');
INSERT INTO Category(name) VALUES('tool');

CREATE TABLE Auction (
  idAuction				INTEGER PRIMARY KEY IDENTITY,
  owner					INTEGER NOT NULL REFERENCES "User",
  name					VARCHAR(20) NOT NULL,
  description			VARCHAR(100) NOT NULL,
  description_detail	VARCHAR(2000),
  creation				DATETIME NOT NULL,
  "end"					DATETIME NOT NULL,
  category				INTEGER NOT NULL REFERENCES Category,
  min_bid_value			INTEGER,
  max_bid_value			INTEGER,
  max_bid_user			INTEGER REFERENCES "User");
  
DECLARE @idCategory INT;
SELECT @idCategory=idCategory FROM Category WHERE name = 'furniture';  

INSERT INTO Auction(owner, name, description, creation, "end", category, min_bid_value)
  VALUES(1, 'wardrobe', '1 year old, 90x40x200cm', CONVERT(DATETIME, '2013-04-21 17:00', 120), CONVERT(DATETIME, '2013-04-28 17:00', 120),  @idCategory, 2000);
INSERT INTO Auction(owner, name, description, creation, "end", category, min_bid_value,max_bid_user)
  VALUES(1, 'wardrobe', '3 year old, 70x50x190cm', CONVERT(DATETIME, '2013-04-22 13:00', 120), CONVERT(DATETIME, '2013-04-29 17:00', 120),  @idCategory, 1000,2);


/*

DROP TABLE Auction;
DROP TABLE Category;
DROP TABLE "User";
*/