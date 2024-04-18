select * from Student go
select * from Teacher go

create or alter procedure AddStudent(@p_login char(6), @p_fname varchar(30), @p_lname varchar(50), @p_email varchar(50))
as
begin
insert into Student(login,fname,lname,email) values (@p_login,@p_fname,@p_lname,@p_email) 

end;

execute AddStudent 'jan223','Tomáš','Janský','tjansky@mail.cz' 
go



create or alter procedure PAddStudent(@p_login char(6), @p_fname varchar(30), @p_lname varchar(50), @p_email varchar(50),@p_result varchar(5) out)
as
begin
begin try
insert into Student(login,fname,lname,email) values (@p_login,@p_fname,@p_lname,@p_email) 
set @p_result = 'ok';
end try
begin catch
set @p_result = 'error';
end catch


end;
go

begin 
declare @res varchar(5)
execute PAddStudent 'jan222','Tomáš','Janova','tjanovsky@mail.cz',@res out ;
print @res;
end;
go

create or alter procedure StudentBecomeTeacher(@p_login char(6),@p_depart int)
as

begin
declare @stlogin    CHAR(6);
declare @stfname    VARCHAR(30);
declare @stlname    VARCHAR(50);
declare @stemail    VARCHAR(50)
begin try

		begin transaction
		select @stlogin=login,@stfname=fname,@stlname=lname,@stemail=email from Student where login = @p_login
		insert into Teacher(login,fname,lname,email,department) values (@stlogin,@stfname,@stlname,@stemail,@p_depart);
		delete from Student where login = @p_login;

print    'commit'
COMMIT
END try

BEGIN catch
print  'rollback'
ROLLBACK
END catch


end;
go
execute StudentBecomeTeacher 'jan222',3 
go

create or alter procedure AddStudent2( @p_fname varchar(30), @p_lname varchar(50))
as
begin
declare @v_login char(6)
declare @v_email varchar(50)

set @v_login = lower(substring(@p_lname,1,3)+'000');
set @v_email = @v_login+'@vsb.cz';

insert into Student(login,fname,lname,email) values (@v_login,@p_fname,@p_lname,@v_email) 

end;
go
execute AddStudent2 'Jan','Novák' 
go


create or alter procedure IsStudentTall(@p_login char(6))
as

begin
declare @aver int;

select @aver=avg(tallness) from Student;
if(select tallness from Student where login = @p_login) > @aver 
begin 
update Student set istall = 1 where login = @p_login; 
end;

else
begin 
update Student set istall = 0 where login = @p_login; 
end;


end;
go
execute IsStudentTall 'jan223' 
go

create or alter function LoginExists(@p_login char(6))
returns bit
as

begin
if exists(select * from Student where @p_login = login)
begin
return 1;
end;

return 0;



end;

go

create or alter procedure AddStudent3( @p_fname varchar(30), @p_lname varchar(50),@p_tallness int)
as
begin
declare @v_login char(6)
declare @v_lognum int
set @v_lognum = 0;
declare @v_email varchar(50)
declare @v_mailnum int
set @v_mailnum = 0;

set @v_login = lower(substring(@p_lname,1,3)+right('000'+cast(@v_lognum as varchar),3));
set @v_email = @v_login+'@vsb.cz';

while dbo.LoginExists( @v_login) = 1
begin
set @v_lognum =@v_lognum +1;
set @v_login = lower(substring(@p_lname,1,3)+right('000'+cast(@v_lognum as varchar),3));
set @v_email = @v_login+'@vsb.cz';

end


insert into Student(login,fname,lname,email,tallness) values (@v_login,@p_fname,@p_lname,@v_email,@p_tallness) 

end;
go
execute AddStudent3 'Jan','Novák' ,154
go