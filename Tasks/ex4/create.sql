-- UDBS/DAIS 2018/2019
-- Oracle, create.sql
CREATE TABLE city (
    city_id   INTEGER NOT NULL PRIMARY KEY,
    city_name VARCHAR(100) NOT NULL,
    zip       VARCHAR(5) NOT NULL);	

CREATE TABLE source(
    source_id    INTEGER NOT NULL PRIMARY KEY,
    source_name  VARCHAR(50) NOT NULL,
    source_type  VARCHAR (50) NOT NULL,
    longitude    REAL NOT NULL,
    latitude     REAL NOT NULL,
    city_id INTEGER NOT NULL,
	FOREIGN KEY (city_id) REFERENCES city(city_id));

CREATE TABLE station (
    station_id   INTEGER NOT NULL PRIMARY KEY,
    station_name VARCHAR(50) NOT NULL,
    longitude    REAL NOT NULL,
    latitude     REAL NOT NULL,
    elevation    INTEGER NOT NULL,
    city_id INTEGER NOT NULL,
	FOREIGN KEY (city_id) REFERENCES city(city_id));

CREATE TABLE substance (
    substance_id   INTEGER NOT NULL PRIMARY KEY,
    substance_name VARCHAR(50) NOT NULL,
    limit          REAL NOT NULL);

CREATE TABLE measurement (
    meas_id                INTEGER NOT NULL PRIMARY KEY,
    meas_date              DATE NOT NULL,
    humidity               INTEGER NOT NULL,
    wind                   INTEGER NOT NULL,
    pressure               REAL NOT NULL,
    temperature            REAL NOT NULL,
    station_id			       INTEGER NOT NULL,
    substance_id           INTEGER NOT NULL,
    concentration          REAL NOT NULL,
	FOREIGN KEY (station_id) REFERENCES station(station_id), 
	FOREIGN KEY (substance_id) REFERENCES substance(substance_id));