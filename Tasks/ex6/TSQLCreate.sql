CREATE TABLE Student 
(
login    CHAR(6) PRIMARY KEY,
fname    VARCHAR(30) NOT NULL,
lname    VARCHAR(50) NOT NULL,
email    VARCHAR(50) NOT NULL
);
go
CREATE TABLE Teacher 
(
login CHAR(6) NOT NULL PRIMARY KEY,
fname VARCHAR(30) NOT NULL,
lname VARCHAR(50) NOT NULL,
email VARCHAR(50) NOT NULL,
department INT NOT NULL,
specialization VARCHAR(30) NULL
);

drop table Student