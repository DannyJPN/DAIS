create table Student
(
    login char(6) primary key not null ,
    jmeno varchar(30) not null,
    prijmeni varchar(50) not null
    

);


create table Ucitel
(
    login char(5) primary key not null ,
    jmeno varchar(30) not null,
    prijmeni varchar(50) not null
    

);

create table Kurz
(
    kod char(11) primary key not null,
    nazev varchar(50) not null
    

);

create table Garant
(
    rok int not null check (rok between 1000 and 9999),
    kod char(11),
    login char(5),
    primary key (login,rok,kod),
    foreign key (login) references Ucitel(login),
    foreign key (kod) references Kurz(kod)
    
);

create table StudijniPlan
(
    rok int not null check (rok between 1000 and 9999),
    kod char(11),
    login char(6),
    primary key (login,rok,kod),
    foreign key (login) references Student(login),
    foreign key (kod) references Kurz(kod)
    
);

