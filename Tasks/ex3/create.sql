create table Statistics
(
operation char(6) not null primary key,
operationcount int not null
);

create table StudentHistory
(
login char(6) primary key not null,
columnName varchar(20) not null,
oldValue varchar(30)  not null,
newValue varchar(30) not null,
datetime timestamp  not null


);


create table Course
(
code char(11) not null primary key,
name varchar(50),
capacity int not null
);

create table Course_student
(
login char(6) not null,
code char(11) not null,
primary key (login,code),
foreign key (login) references Student(login),
foreign key (code) references Course(code)

);

