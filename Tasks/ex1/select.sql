select * from Student;
select * from Ucitel;
select * from Garant;
select * from StudijniPlan;
select * from Kurz;




select student.* from Student s
join StudijniPlan sp on sp.login = s.login
join Garant g on g.kod = sp.kod
join Ucitel u on g.login = u.login
where sp.rok = 2009 and u.prijmeni = 'Codd';




--__________________________________________
select * from Kurz k
join StudijniPlan sp on sp.kod = k.kod
join Student s on sp.login = s.login
where sp.rok = 2009 and s.prijmeni = 'Plavá?ek';
--___________________________________________
select * from Kurz k
join StudijniPlan sp on sp.kod = k.kod
join Student s on sp.login = s.login
where s.prijmeni = 'Plavá?ek';
--___________________________________________
select distinct k.kod from Kurz k
join StudijniPlan sp on sp.kod = k.kod
where sp.rok = 2009;
--____________________________________________
select distinct u.* from Ucitel u
join Garant g on g.login = u.login
join StudijniPlan sp on sp.kod = g.kod
where sp.rok = 2009 and g.rok = 2009;




