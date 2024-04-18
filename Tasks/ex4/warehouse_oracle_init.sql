-- Init skript pro zadani Obchod a sklad, DAIS 2014
-- Oracle
-- 2013/03/20

BEGIN
  INSERT INTO Customer(fname, lname, street, city) VALUES('Karel', 'Pondìlí', 'Èapkova 23', 'Ostrava');
  INSERT INTO Customer(fname, lname, street, city) VALUES('Jiøí', 'Úterý', 'Karafiátová 7', 'Ostrava');
  INSERT INTO Customer(fname, lname, street, city) VALUES('Jana', 'Støedová', '17. listopadu 15', 'Ostrava');
  INSERT INTO Customer(fname, lname, street, city) VALUES('Kateøina', 'Ètvrtková', 'Masarykova 9', 'Frýdek-Místek');
  INSERT INTO Customer(fname, lname, street, city) VALUES('Kateøina', 'Pátková', 'Masarykova 8', 'Havíøov');
  INSERT INTO Customer(fname, lname, street, city) VALUES('Petr', 'Sobota', 'Hlavní tøída 45', 'Ostrava');
  INSERT INTO Customer(fname, lname, street, city) VALUES('Petr', 'Nedìle', 'Námìstí hrdinù 34', 'Havíøov');

  INSERT INTO Employee(fname, lname, "from", "to", salary) VALUES('Karel', 'Ráno', TO_DATE('23.03.2009', 'DD.MM.YYYY'), NULL, 20000);
  INSERT INTO Employee(fname, lname, "from", "to", salary) VALUES('Jiøí', 'Odpoledne', TO_DATE('01.07.2007', 'DD.MM.YYYY'), NULL, 21000);
  INSERT INTO Employee(fname, lname, "from", "to", salary) VALUES('Jana', 'Veèerová', TO_DATE('01.01.2014', 'DD.MM.YYYY'), NULL, 12000);
  INSERT INTO Employee(fname, lname, "from", "to", salary) VALUES('Kateøina', 'Malá', TO_DATE('01.01.2013', 'DD.MM.YYYY'), NULL, 15000);
  INSERT INTO Employee(fname, lname, "from", "to", salary) VALUES('Kateøina', 'Velká', TO_DATE('01.08.2012', 'DD.MM.YYYY'), NULL, 17000);
  INSERT INTO Employee(fname, lname, "from", "to", salary) VALUES('Petr', 'Široký', TO_DATE('01.08.2011', 'DD.MM.YYYY'), NULL, 18000);
  INSERT INTO Employee(fname, lname, "from", "to", salary) VALUES('Petr', 'Turna', TO_DATE('01.01.1996', 'DD.MM.YYYY'), NULL, 30000);

  INSERT INTO Product(name, cost) VALUES ('GIGABYTE GeForce GTX 750 Ti (GV-N75TOC-2GI)', 3790);
  INSERT INTO Product(name, cost) VALUES ('ASUS NVIDIA GTX650TI-2GD5', 3691);
  INSERT INTO Product(name, cost) VALUES ('GIGABYTE GV-NTITAN-6GD-B', 22490);
  INSERT INTO Product(name, cost) VALUES ('Samsung 840 EVO 250GB (MZ-7TE250BW)', 3890);
  INSERT INTO Product(name, cost) VALUES ('Asus RT-AC68U', 4990);
  INSERT INTO Product(name, cost) VALUES ('Zebra GK420, 203dpi, USB, print server, DT', 11086);
  INSERT INTO Product(name, cost) VALUES ('OPTOMA plátno DS-3084PMG+', 2290);
  INSERT INTO Product(name, cost) VALUES ('SENCOR SCG 1050BK', 349);
  INSERT INTO Product(name, cost) VALUES ('ASROCK B75M-DGS R2.0', 1177);
  INSERT INTO Product(name, cost) VALUES ('Zyxel WAP3205', 1139);
  INSERT INTO Product(name, cost) VALUES ('XIAOMI Mi3 16GB - èernostøíbrný', 12890);
  INSERT INTO Product(name, cost) VALUES ('Tablet ACER ICONIA TAB (NT.L3JEE.001)', 3404);
  INSERT INTO Product(name, cost) VALUES ('Delock adaptér stereo jack 3,5 mm 4 pin samice > 2 x stereo', 68);

  INSERT INTO Store(name) VALUES ('Ostrava-Poruba');
  INSERT INTO Store(name) VALUES ('Havíøov');
  INSERT INTO Store(name) VALUES ('Karviná');
  INSERT INTO Store(name) VALUES ('Olomouc');
  INSERT INTO Store(name) VALUES ('Brno');

  INSERT INTO Distributor(name) VALUES('Dell');
  INSERT INTO Distributor(name) VALUES('Asus');
  INSERT INTO Distributor(name) VALUES('HP');
  INSERT INTO Distributor(name) VALUES('GigaVelkoobchod');
  INSERT INTO Distributor(name) VALUES('IBM');
  INSERT INTO Distributor(name) VALUES('Acer');
  INSERT INTO Distributor(name) VALUES('MSI CZ');


  INSERT INTO ProductStore(storeId, productId, count) VALUES(1, 1, 10);
  INSERT INTO ProductStore(storeId, productId, count) VALUES(1, 2, 12);
  INSERT INTO ProductStore(storeId, productId, count) VALUES(1, 3, 0);
  INSERT INTO ProductStore(storeId, productId, count) VALUES(1, 4, 20);
  INSERT INTO ProductStore(storeId, productId, count) VALUES(1, 5, 30);
  INSERT INTO ProductStore(storeId, productId, count) VALUES(1, 6, 40);
  INSERT INTO ProductStore(storeId, productId, count) VALUES(1, 7, 30);
  INSERT INTO ProductStore(storeId, productId, count) VALUES(1, 8, 20);
  INSERT INTO ProductStore(storeId, productId, count) VALUES(1, 9, 0);
  INSERT INTO ProductStore(storeId, productId, count) VALUES(1, 10, 10);
  INSERT INTO ProductStore(storeId, productId, count) VALUES(1, 11, 20);
  INSERT INTO ProductStore(storeId, productId, count) VALUES(1, 12, 30);
  INSERT INTO ProductStore(storeId, productId, count) VALUES(1, 13, 0);
  
  INSERT INTO ProductStore(storeId, productId, count) VALUES(2, 3, 30);
  INSERT INTO ProductStore(storeId, productId, count) VALUES(2, 9, 30);
  INSERT INTO ProductStore(storeId, productId, count) VALUES(2, 13, 30); 

  INSERT INTO ProductStore(storeId, productId, count) VALUES(3, 1, 77);
  INSERT INTO ProductStore(storeId, productId, count) VALUES(3, 3, 13);
  INSERT INTO ProductStore(storeId, productId, count) VALUES(3, 6, 22); 
  INSERT INTO ProductStore(storeId, productId, count) VALUES(3, 7, 82); 

  INSERT INTO ProductStore(storeId, productId, count) VALUES(4, 3, 1);
  INSERT INTO ProductStore(storeId, productId, count) VALUES(4, 6, 18); 
  INSERT INTO ProductStore(storeId, productId, count) VALUES(4, 12, 26); 

  INSERT INTO ProductStore(storeId, productId, count) VALUES(5, 1, 1);
  INSERT INTO ProductStore(storeId, productId, count) VALUES(5, 6, 18); 
  INSERT INTO ProductStore(storeId, productId, count) VALUES(5, 8, 26); 
  INSERT INTO ProductStore(storeId, productId, count) VALUES(5, 10, 26); 
  INSERT INTO ProductStore(storeId, productId, count) VALUES(5, 11, 26); 
  INSERT INTO ProductStore(storeId, productId, count) VALUES(5, 13, 26); 

  INSERT INTO Delivery(distributorId, storeId, productId, count, corruptCount, "date") VALUES (1, 1, 1, 50, 0, TO_DATE('01.10.2013', 'DD.MM.YYYY'));
  INSERT INTO Delivery(distributorId, storeId, productId, count, corruptCount, "date") VALUES (1, 1, 6, 150, 11, TO_DATE('23.02.2014', 'DD.MM.YYYY'));

  INSERT INTO Delivery(distributorId, storeId, productId, count, corruptCount, "date") VALUES (2, 1, 2, 25, 1, TO_DATE('12.11.2012', 'DD.MM.YYYY'));
  INSERT INTO Delivery(distributorId, storeId, productId, count, corruptCount, "date") VALUES (2, 1, 3, 70, 0, TO_DATE('16.03.2014', 'DD.MM.YYYY'));
  INSERT INTO Delivery(distributorId, storeId, productId, count, corruptCount, "date") VALUES (2, 2, 13, 32, 2, TO_DATE('22.08.2013', 'DD.MM.YYYY'));

  INSERT INTO Delivery(distributorId, storeId, productId, count, corruptCount, "date") VALUES (3, 1, 7, 95, 0, TO_DATE('10.07.2012', 'DD.MM.YYYY'));
  INSERT INTO Delivery(distributorId, storeId, productId, count, corruptCount, "date") VALUES (3, 2, 6, 51, 0, TO_DATE('03.05.2013', 'DD.MM.YYYY'));
  INSERT INTO Delivery(distributorId, storeId, productId, count, corruptCount, "date") VALUES (3, 3, 11, 50, 0, TO_DATE('06.12.2013', 'DD.MM.YYYY'));
  INSERT INTO Delivery(distributorId, storeId, productId, count, corruptCount, "date") VALUES (3, 4, 12, 170, 0, TO_DATE('28.03.2013', 'DD.MM.YYYY'));

  INSERT INTO Delivery(distributorId, storeId, productId, count, corruptCount, "date") VALUES (4, 4, 1, 58, 13, TO_DATE('01.09.2013', 'DD.MM.YYYY'));
  INSERT INTO Delivery(distributorId, storeId, productId, count, corruptCount, "date") VALUES (4, 4, 11, 85, 6, TO_DATE('07.10.2013', 'DD.MM.YYYY'));
  INSERT INTO Delivery(distributorId, storeId, productId, count, corruptCount, "date") VALUES (4, 2, 2, 15, 2, TO_DATE('17.11.2012', 'DD.MM.YYYY'));
  INSERT INTO Delivery(distributorId, storeId, productId, count, corruptCount, "date") VALUES (4, 2, 6, 7, 1, TO_DATE('13.02.2014', 'DD.MM.YYYY'));
  INSERT INTO Delivery(distributorId, storeId, productId, count, corruptCount, "date") VALUES (4, 2, 13, 320, 86, TO_DATE('04.01.2014', 'DD.MM.YYYY'));

  INSERT INTO Delivery(distributorId, storeId, productId, count, corruptCount, "date") VALUES (5, 1, 1, 50, 10, TO_DATE('26.08.2013', 'DD.MM.YYYY'));
  INSERT INTO Delivery(distributorId, storeId, productId, count, corruptCount, "date") VALUES (5, 2, 2, 50, 9, TO_DATE('02.06.2012', 'DD.MM.YYYY'));
  INSERT INTO Delivery(distributorId, storeId, productId, count, corruptCount, "date") VALUES (5, 3, 3, 35, 7, TO_DATE('16.10.2013', 'DD.MM.YYYY'));
  INSERT INTO Delivery(distributorId, storeId, productId, count, corruptCount, "date") VALUES (5, 4, 4, 70, 11, TO_DATE('08.02.2014', 'DD.MM.YYYY'));
  INSERT INTO Delivery(distributorId, storeId, productId, count, corruptCount, "date") VALUES (5, 5, 5, 132, 12, TO_DATE('19.01.2014', 'DD.MM.YYYY'));
  INSERT INTO Delivery(distributorId, storeId, productId, count, corruptCount, "date") VALUES (5, 5, 6, 72, 9, TO_DATE('11.02.2013', 'DD.MM.YYYY'));


  INSERT INTO Invoice("date", "cost", status, customerId, employeeId) VALUES(SYSDATE, 3638, 'e', 1, 1);
  INSERT INTO Invoice("date", "cost", status, customerId, employeeId) VALUES(TO_DATE('10.07.2012', 'DD.MM.YYYY'), 26988000, 'e', 1, 7);
  INSERT INTO Invoice("date", "cost", status, customerId, employeeId) VALUES(TO_DATE('16.03.2014', 'DD.MM.YYYY'), 343666, 'o', 3, 1);
  INSERT INTO Invoice("date", "cost", status, customerId, employeeId) VALUES(TO_DATE('16.10.2013', 'DD.MM.YYYY'), 18320, 'z', 2, 2);
  INSERT INTO Invoice("date", "cost", status, customerId, employeeId) VALUES(TO_DATE('19.01.2014', 'DD.MM.YYYY'), 137400, 'z', 1, 4);
  INSERT INTO Invoice("date", "cost", status, customerId, employeeId) VALUES(TO_DATE('01.10.2013', 'DD.MM.YYYY'), 6980, 's', 3, 4);
  INSERT INTO Invoice("date", "cost", status, customerId, employeeId) VALUES(TO_DATE('16.03.2014', 'DD.MM.YYYY'), 8239, 's', 6, 7);
  INSERT INTO Invoice("date", "cost", status, customerId, employeeId) VALUES(SYSDATE, 126429, 's', 4, 2);
  INSERT INTO Invoice("date", "cost", status, customerId, employeeId) VALUES(TO_DATE('22.08.2013', 'DD.MM.YYYY'), 940970, 'z', 6, 6);
  INSERT INTO Invoice("date", "cost", status, customerId, employeeId) VALUES(TO_DATE('17.11.2012', 'DD.MM.YYYY'), 30636, 'z', 1, 1);
  INSERT INTO Invoice("date", "cost", status, customerId, employeeId) VALUES(TO_DATE('04.01.2014', 'DD.MM.YYYY'), 509929, 'e', 2, 3);
  


  INSERT INTO ProductInvoice("order", productId, "count") VALUES(1, 13, 20);
  INSERT INTO ProductInvoice("order", productId, "count") VALUES(1, 10, 2);
  INSERT INTO ProductInvoice("order", productId, "count") VALUES(2, 3, 1200);
  INSERT INTO ProductInvoice("order", productId, "count") VALUES(3, 6, 31);
  INSERT INTO ProductInvoice("order", productId, "count") VALUES(4, 7, 8);
  INSERT INTO ProductInvoice("order", productId, "count") VALUES(5, 7, 60);
  INSERT INTO ProductInvoice("order", productId, "count") VALUES(6, 8, 20);
  INSERT INTO ProductInvoice("order", productId, "count") VALUES(7, 9, 7);
  INSERT INTO ProductInvoice("order", productId, "count") VALUES(8, 10, 111);
  INSERT INTO ProductInvoice("order", productId, "count") VALUES(9, 11, 73);
  INSERT INTO ProductInvoice("order", productId, "count") VALUES(10, 12, 9);
  INSERT INTO ProductInvoice("order", productId, "count") VALUES(11, 1, 62);
  INSERT INTO ProductInvoice("order", productId, "count") VALUES(11, 6, 21);
  INSERT INTO ProductInvoice("order", productId, "count") VALUES(11, 10, 37);
 
  
  COMMIT;
EXCEPTION  
  WHEN OTHERS THEN  
    ROLLBACK;
END;

-- select * from Product;
-- select * from Invoice;
-- select * from ProductInvoice;
-- select * from Delivery;
