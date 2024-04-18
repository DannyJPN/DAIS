-- Create skript pro zadani Obchod a sklad, DAIS 2014
-- Oracle
-- 2013/03/15

CREATE TABLE Customer (
  customerId NUMBER NOT NULL PRIMARY KEY, 
  fname      VARCHAR2(20)  NOT NULL,
  lname      VARCHAR2(30)  NOT NULL,
  street     VARCHAR2(30)  NOT NULL,
  city       VARCHAR2(30)  NOT NULL);
  
CREATE TABLE Employee (
  employeeId NUMBER NOT NULL PRIMARY KEY, 
  fname      VARCHAR2(20)  NOT NULL,
  lname      VARCHAR2(30)  NOT NULL,
  "from"     DATE NOT NULL,
  "to"       DATE,
  salary     NUMBER NOT NULL);
  
CREATE TABLE Product (
  productId NUMBER NOT NULL PRIMARY KEY, 
  name      VARCHAR2(100)  NOT NULL UNIQUE,
  cost      NUMBER NOT NULL);

CREATE TABLE Invoice (
  "order"      NUMBER NOT NULL PRIMARY KEY, 
  "date"     DATE NOT NULL,
  "cost"       NUMBER NOT NULL,
  status     CHAR(1) NOT NULL,
  customerId NUMBER NOT NULL REFERENCES Customer,
  employeeId NUMBER NOT NULL REFERENCES Employee);
  
CREATE TABLE ProductInvoice (
  "order"      NUMBER NOT NULL REFERENCES Invoice,
  productId    NUMBER NOT NULL REFERENCES Product,
  "count"      NUMBER NOT NULL,
  PRIMARY KEY("order", productId));
  
CREATE TABLE Store (
  storeId    NUMBER NOT NULL PRIMARY KEY,
  name       VARCHAR(20) NOT NULL);

CREATE TABLE ProductStore (
  storeId    NUMBER NOT NULL REFERENCES Store,
  productId  NUMBER NOT NULL REFERENCES Product,
  count      NUMBER NOT NULL,
  PRIMARY KEY(storeId, productId));
  
CREATE TABLE Distributor (
  distributorId    NUMBER NOT NULL PRIMARY KEY,
  name             VARCHAR(30) NOT NULL);

CREATE TABLE Delivery (
  deliveryId       NUMBER NOT NULL PRIMARY KEY, 
  distributorId    NUMBER NOT NULL REFERENCES Distributor,
  storeId          NUMBER NOT NULL REFERENCES Store,
  productId        NUMBER NOT NULL REFERENCES Product,
  count            NUMBER NOT NULL,
  corruptCount     NUMBER NOT NULL,
  "date"           DATE NOT NULL);
  
-------------------------------------
-- Autoincrement values of synthetic primary keys
CREATE SEQUENCE customer_seq 
  start with 1 
  increment by 1 
  nomaxvalue; 

CREATE TRIGGER customer_insert
  before insert on Customer
  for each row
begin
  select customer_seq.nextval into :new.customerId from dual;
end;
/

CREATE SEQUENCE employee_seq 
  start with 1 
  increment by 1 
  nomaxvalue; 

CREATE TRIGGER employee_insert
  before insert on Employee
  for each row
begin
  select employee_seq.nextval into :new.employeeId from dual;
end;
/

CREATE SEQUENCE product_seq 
  start with 1 
  increment by 1 
  nomaxvalue; 

CREATE TRIGGER product_insert
  before insert on Product
  for each row
begin
  select product_seq.nextval into :new.productId from dual;
end;
/

CREATE SEQUENCE store_seq 
  start with 1 
  increment by 1 
  nomaxvalue; 

CREATE TRIGGER store_insert
  before insert on Store
  for each row
begin
  select store_seq.nextval into :new.storeId from dual;
end;
/ 

CREATE SEQUENCE delivery_seq 
  start with 1 
  increment by 1 
  nomaxvalue; 

CREATE TRIGGER delivery_insert
  before insert on Delivery
  for each row
begin
  select delivery_seq.nextval into :new.deliveryId from dual;
end;
/ 

CREATE SEQUENCE distributor_seq 
  start with 1 
  increment by 1 
  nomaxvalue; 

CREATE TRIGGER distributor_insert
  before insert on distributor
  for each row
begin
  select distributor_seq.nextval into :new.distributorId from dual;
end;
/

CREATE SEQUENCE invoice_seq 
  start with 1 
  increment by 1 
  nomaxvalue; 

CREATE TRIGGER invoice_insert
  before insert on Invoice
  for each row
begin
  select invoice_seq.nextval into :new."order" from dual;
end;
/ 