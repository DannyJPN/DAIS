
create or replace trigger OperationCount before insert or update or delete on Student
begin
    if(INSERTING) then
        begin 
            update Statistics set operationcount = operationcount +1 where operation = 'INSERT';
        end;
    elsif(DELETING) then
        begin
            update Statistics set operationcount = operationcount +1 where operation = 'DELETE';
        end;
    elsif(UPDATING) then
        begin
            update Statistics set operationcount = operationcount +1 where operation = 'UPDATE';
        end;
    
    end if;
end;

create or replace trigger HistoryRecord before update  on Student for each row
begin
    if (UPDATING('login')) then
        begin
            insert into StudentHistory (login,columnName,oldValue,newvalue,datetime) 
            values (:OLD.login,'login',:OLD.login,:NEW.login,CURRENT_TIMESTAMP);
        end;
    elsif (UPDATING('fname')) then
        begin
            insert into StudentHistory (login,columnName,oldValue,newvalue,datetime) 
            values (:OLD.login,'fname',:OLD.fname,:NEW.fname,CURRENT_TIMESTAMP);
        end;
    elsif (UPDATING('lname')) then
        begin
            insert into StudentHistory (login,columnName,oldValue,newvalue,datetime) 
            values (:OLD.login,'lname',:OLD.lname,:NEW.lname,CURRENT_TIMESTAMP);
        end;
    elsif (UPDATING('email')) then
        begin
            insert into StudentHistory (login,columnName,oldValue,newvalue,datetime) 
            values (:OLD.login,'email',:OLD.email,:NEW.email,CURRENT_TIMESTAMP);
        end;
    elsif (UPDATING('tallness')) then
        begin
            insert into StudentHistory (login,columnName,oldValue,newvalue,datetime) 
            values (:OLD.login,'tallness',:OLD.tallness,:NEW.tallness,CURRENT_TIMESTAMP);
        end;
    
    end if;

   
end;


    
create or replace trigger Course_guard before insert  on Course_student for each row
declare 
cnt int;
cap int;
begin
    select count(*) into cnt from Course_student where code = :NEW.code;
    select capacity into cap from Course where code = :NEW.code;
    if(cnt  >= cap ) then
        begin 
           dbms_output.put_line('OUT OF CAPACITY');
        end;
    
    end if;
end;




create or replace trigger Course_guard2 before insert or update  on Course_student for each row
declare 
cnt int;
cap int;
exceed exception;
begin
    select count(*) into cnt from Course_student where code = :NEW.code;
    select capacity into cap from Course where code = :NEW.code;
    if(cnt+1  >= cap ) then
        begin 
           dbms_output.put_line('OUT OF CAPACITY');
           raise exceed;
        end;
    
    end if;
end;




