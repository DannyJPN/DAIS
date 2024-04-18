-- Drop skript pro zadani Obchod a sklad, DAIS 2014
-- Oracle
-- 2013/03/15

DROP TRIGGER delivery_insert;
DROP SEQUENCE delivery_seq;
DROP TRIGGER store_insert;
DROP SEQUENCE store_seq;
DROP TRIGGER product_insert;
DROP SEQUENCE product_seq;
DROP TRIGGER employee_insert;
DROP SEQUENCE employee_seq;
DROP TRIGGER customer_insert;
DROP SEQUENCE customer_seq;
DROP TRIGGER distributor_insert;
DROP SEQUENCE distributor_seq;
DROP TRIGGER invoice_insert;
DROP SEQUENCE invoice_seq;

DROP TABLE Delivery;
DROP TABLE Distributor;
DROP TABLE ProductStore;
DROP TABLE Store;
DROP TABLE ProductInvoice;
DROP TABLE Invoice;
DROP TABLE Product;
DROP TABLE Employee;
DROP TABLE Customer;