insert into Student(login,jmeno,prijmeni) values('pla457', 'Jan', 'Plav�?ek');
insert into Student(login,jmeno,prijmeni) values('sob458', 'Yveta', 'Sobotov�');
insert into Student(login,jmeno,prijmeni) values('kru142','Dan','Krupa');

insert into Ucitel(login,jmeno,prijmeni) values('bay01', 'Josef', 'Bayer');
insert into Ucitel(login,jmeno,prijmeni) values('cod02', 'Stanislav', 'Codd');

insert into Kurz(kod,nazev) values('456-dais-01', 'Datab�zov� a informa?n� syst�my');
insert into Kurz(kod,nazev) values('456-tzd-01', 'Teorie zpracov�n� dat');
insert into Kurz(kod,nazev) values('456-pou-01', 'Po?�ta?ov� obrana a �tok');
insert into Kurz(kod,nazev) values('456-pv-01', 'Po?�ta?ov� viry');
insert into Kurz(kod,nazev) values('456-kg-01', 'Kryptografie');




insert into StudijniPlan(rok,login,kod) values(2009,'sob458','456-dais-01');
insert into StudijniPlan(rok,login,kod) values(2009,'pla457','456-tzd-01');
insert into StudijniPlan(rok,login,kod) values(2009,'kru142','456-dais-01');

insert into StudijniPlan(rok,login,kod) values(2009,'sob458','456-pv-01');
insert into StudijniPlan(rok,login,kod) values(2009,'pla457','456-pv-01');
insert into StudijniPlan(rok,login,kod) values(2009,'kru142','456-kg-01');

insert into StudijniPlan(rok,login,kod) values(2009,'sob458','456-pou-01');
insert into StudijniPlan(rok,login,kod) values(2009,'pla457','456-dais-01');
insert into StudijniPlan(rok,login,kod) values(2009,'kru142','456-pou-01');



insert into Garant(rok,login,kod) values(2009,'bay01','456-pou-01');
insert into Garant(rok,login,kod) values(2009,'cod02','456-tzd-01');

insert into Garant(rok,login,kod) values(2009,'bay01','456-pv-01');
insert into Garant(rok,login,kod) values(2009,'cod02','456-kg-01');
