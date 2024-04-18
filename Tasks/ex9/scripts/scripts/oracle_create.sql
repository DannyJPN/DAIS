CREATE TABLE "User" (
 idUser                      INT GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
 login                       VARCHAR(10) NOT NULL,
 name                        VARCHAR(20) NOT NULL,
 surname                     VARCHAR(20) NOT NULL,
 address                     VARCHAR(40),
 telephone                   VARCHAR(12),
 maximum_unfinisfed_auctions INTEGER NOT NULL,
 last_visit                  TIMESTAMP,
 type                        VARCHAR(10) NOT NULL);

INSERT INTO "User" (login,name,surname,address,telephone,maximum_unfinisfed_auctions,last_visit,type) VALUES('kra28', 'Michal', 'Kr�tk�', 'adresa', '123456789', 0, NULL, 'U');
INSERT INTO "User" (login,name,surname,address,telephone,maximum_unfinisfed_auctions,last_visit,type) VALUES('bed157', 'Pavel', 'Bedn�r', 'adresa', '123456789', 0, NULL, 'U');

INSERT INTO "User" (login,name,surname,address,telephone,maximum_unfinisfed_auctions,last_visit,type) VALUES ('test', 'test', 'test', 'home', 2,2, null, 'U');

select * FROM "User";

CREATE TABLE Category (
  idCategory	INTEGER GENERATED BY DEFAULT AS IDENTITY NOT NULL PRIMARY KEY,
  name			VARCHAR(30) NOT NULL,
  description	VARCHAR(100));
  
INSERT INTO Category(name) VALUES('hardware');
INSERT INTO Category(name) VALUES('furniture');
INSERT INTO Category(name) VALUES('tool');

CREATE TABLE Auction (
  idAuction				INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  owner					INTEGER NOT NULL REFERENCES "User",
  name					VARCHAR(20) NOT NULL,
  description			VARCHAR(100) NOT NULL,
  description_detail	VARCHAR(2000),
  creation				TIMESTAMP NOT NULL,
  "end"					TIMESTAMP NOT NULL,
  category				INTEGER NOT NULL REFERENCES Category,
  min_bid_value			INTEGER,
  max_bid_value			INTEGER,
  max_bid_user			INTEGER REFERENCES "User");

DECLARE  
v_idCategory INT;
BEGIN
  SELECT idCategory into v_idCategory FROM Category WHERE name = 'furniture';  

  INSERT INTO Auction(owner, name, description, creation, "end", category, min_bid_value)
    VALUES(1, 'wardrobe', '1 year old, 90x40x200cm', TO_TIMESTAMP( '2013-04-21 17:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP( '2013-04-28 17:00', 'YYYY-MM-DD HH24:MI'),  v_idCategory, 2000);
  INSERT INTO Auction(owner, name, description, creation, "end", category, min_bid_value,max_bid_user)
    VALUES(1, 'wardrobe', '3 year old, 70x50x190cm', TO_TIMESTAMP( '2013-04-22 13:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP( '2013-04-29 17:00', 'YYYY-MM-DD HH24:MI'),  v_idCategory, 1000,2);
  commit;
end;

/*

DROP TABLE Auction;
DROP TABLE Category;
DROP TABLE "User";
*/