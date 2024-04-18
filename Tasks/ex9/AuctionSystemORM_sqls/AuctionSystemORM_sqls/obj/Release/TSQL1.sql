alter table Student ADD tallness int not null;
alter table Student modify email varchar(30) null;
begin
dbms_output.put_line('attempt');
end;


execute dbms_output.put_line('attemptex');

BEGIN
INSERT INTO Student(login, fname, lname, tallness)VALUES ('buh05', 'Jan', 'Buhda', 175);
END;


DECLARE
    loginvar char(6);
    namevar varchar(30);
    surnamevar varchar(30);
    tallvar int;
    
begin
    loginvar := 'nov352';
    namevar := 'Josef';
    surnamevar := 'Novák';
    tallvar := 198;
    INSERT INTO Student(login, fname, lname, tallness)VALUES (loginvar, namevar, surnamevar, tallvar);
    
end; 





DECLARE
    loginvar Student.login%TYPE;
    namevar  Student.fname%TYPE;
    surnamevar  Student.lname%TYPE;
    tallvar  Student.tallness%TYPE;
    
begin
    loginvar := 'lev02';
    namevar := 'Ji?í';
    surnamevar := 'Levý';
    tallvar := 178;
    INSERT INTO Student(login, fname, lname, tallness)VALUES (loginvar, namevar, surnamevar, tallvar);
    
end; 



DECLARE
    loginvar Student.login%TYPE;
    namevar  Student.fname%TYPE;
    surnamevar  Student.lname%TYPE;
    tallvar  Student.tallness%TYPE;
    
begin
    select s.fname,s.lname,s.tallness,s.login into namevar,surnamevar,tallvar,loginvar from Student s
    where tallness = 198;
    
end; 


DECLARE
    rowvar Student%ROWTYPE;
    
begin
    select * into rowvar from Student s
    where tallness = 198;
    dbms_output.put_line('Student: ' || rowvar.fname || ' ' || rowvar.lname);
    
end; 


DECLARE
    loginvar Student.login%TYPE;
    namevar  Student.fname%TYPE;
    surnamevar  Student.lname%TYPE;
    tallvar  Student.tallness%TYPE;
    
begin
commit;
    loginvar := 'liu03';
    namevar := 'Wang';
    surnamevar := 'Liu Cchang';
    tallvar := 165;
    INSERT INTO Student(login, fname, lname, tallness)VALUES (loginvar, namevar, surnamevar, tallvar);

    INSERT INTO Student(login, fname, lname, tallness)VALUES (loginvar, namevar, surnamevar, tallvar);
    commit;
    exception when others then
    rollback;
    
end; 



