create or replace procedure AreStudentsTall 
is
l Student.login%TYPE ;
aver_tall Student.tallness%TYPE;
begin
select avg(tallness)into aver_tall from Student;
    for person in (select * from Student) loop
        if aver_tall>person.tallness then
            begin
                update Student
                set IsTall = 0
                where login = person.login;
            end;
        else
            begin
                update Student
                set IsTall = 1
                where login = person.login;
            end;
        end if;
    
    end loop;
end ;

execute AreStudentsTall();

--Rather standard update command

    
   