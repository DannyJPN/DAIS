

create or replace procedure AddStudent (p_login Student.login%TYPE, p_fname Student.fname%TYPE, p_lname Student.lname%TYPE,p_tallness Student.tallness%TYPE)
is
begin
insert into Student(login,fname,lname,tallness) values (p_login, p_fname, p_lname,p_tallness);
end AddStudent;



execute AddStudent('Jas467','Tomáš','Jasný',206);

create or replace function FAddStudent (p_login Student.login%TYPE, p_fname Student.fname%TYPE, p_lname Student.lname%TYPE,p_tallness Student.tallness%TYPE)
return char
is
begin
insert into Student(login,fname,lname,tallness) values (p_login, p_fname, p_lname,p_tallness);
return 'OK';
commit;
exception
    when others then
    rollback;
    return 'KO';
    
    
    
end FAddStudent;


set SERVEROUTPUT ON;
execute DBMS_OUTPUT.PUT_LINE(FAddStudent('Mod54','Petra','Modrá',168));
--_____________________________________

create or replace procedure StudentBecomeTeacher (p_login Student.login%TYPE,p_department teacher.department%TYPE )
is
person Student%ROWTYPE;
begin
    select * into person from Student where login = p_login;
    insert into Teacher (login, fname, lname,department) values (person.login,person.fname,person.lname,p_department);
    delete from Student where login = p_login;
    
commit;
exception
    when others then
    rollback;
end StudentBecomeTeacher;



execute StudentBecomeTeacher ('nov352','20');
--_________________________


create or replace procedure AddStudent2 ( p_fname Student.fname%TYPE, p_lname Student.lname%TYPE,p_tallness Student.tallness%TYPE)
is
begin
    
    insert into Student(login,fname,lname,tallness) values (substr(p_lname,0,3) || '00', p_fname, p_lname,p_tallness);
commit;
exception
    when others then
    rollback;
end AddStudent2;


execute AddStudent2('Filip','Starý',198);
--__________________________________________
create or replace procedure IsStudentTall (p_login Student.login%TYPE )
is
person Student%ROWTYPE;
aver_tall Student.tallness%TYPE;
begin
    select * into person from Student where login = p_login;
    select avg(tallness)into aver_tall from Student;
    if aver_tall>person.tallness then
        begin
            update Student
            set IsTall = 0
            where login = p_login;
        end;
    else
        begin
            update Student
            set IsTall = 1
            where login = p_login;
        end;
    end if;
commit;
exception
    when others then
    rollback;
end ;

execute IsStudentTall('Tol00');
--_______________________________________________

create or replace function LoginExist (p_login Student.login%TYPE )
return Student.login%TYPE
is
l Student.login%TYPE;
begin
    select login into l from Student where login = p_login;
    commit;
    return l;
exception
    when others then
    rollback;
    return 'null';
end ;

execute DBMS_OUTPUT.PUT_LINE(LoginExist('Tol00'));


--__________________________________________________
create or replace procedure AddStudent3 ( p_fname Student.fname%TYPE, p_lname Student.lname%TYPE,p_tallness Student.tallness%TYPE)
is
l Student.login%TYPE;
n int :=0;
begin
    
    l :=substr(p_lname,0,3)  || lpad(to_char(n),3,'0');
  
    while LoginExist(l) != 'null' loop
    n := n+1;
    l :=substr(p_lname,0,3)  || lpad(to_char(n),3,'0');
    DBMS_OUTPUT.PUT_LINE(l);
    DBMS_OUTPUT.PUT_LINE('___');
    end loop;
    insert into Student(login,fname,lname,tallness) values (l , p_fname, p_lname,p_tallness);
end AddStudent3;


execute AddStudent3('Jan','Tolba',206);