/*
drop procedure PrintDtoForUser
drop procedure PrintDtoForTable
drop function Initcap
drop function ConvertDataType
go
*/


/*snippet from web to substitute oracle initcap funcion
FIRST LETTER IS IN UPPERCASE THE REST IN LOWERCASE
*/
CREATE FUNCTION Initcap (@Str varchar(max))
RETURNS varchar(max) AS
BEGIN
  DECLARE @Result varchar(2000)
  SET @Str = LOWER(@Str) + ' '
  SET @Result = ''
  WHILE 1=1
  BEGIN
    IF PATINDEX('% %',@Str) = 0 BREAK
    SET @Result = @Result + UPPER(Left(@Str,1))+
    SubString  (@Str,2,CharIndex(' ',@Str)-1)
    SET @Str = SubString(@Str,
      CharIndex(' ',@Str)+1,Len(@Str))
  END
  SET @Result = Left(@Result,Len(@Result))
  RETURN @Result
END 
go

create function ConvertDataType(@typeId int, @isNullable bit)
returns varchar(max)
as
BEGIN
	DECLARE @typeName varchar(max);
	SET @typeName =
	CASE @typeId
		WHEN 56 THEN 'int'
		WHEN 40 THEN 'DateTime'
		WHEN 61 THEN 'DateTime'
		WHEN 104 THEN 'bool'
		WHEN 106 THEN 'decimal'
		WHEN 231 THEN 'string'
		WHEN 167 THEN 'string'
		WHEN 239 THEN 'string'
		WHEN 241 THEN 'XElement'
		ELSE 'unknown (' + CAST(@typeId AS NVARCHAR) + ')'
	END;
	IF @isNullable = 1 AND @typeId != 231 AND @typeId != 239 AND @typeId != 241 AND @typeId != 167
		SET @typeName = @typeName + '?'
	return @typeName + ' ';
end
go

create /* alter */  procedure PrintDtoForUser(@p_user VARCHAR(7))
as
	DECLARE c_tables CURSOR LOCAL FOR SELECT table_name FROM information_schema.tables WHERE table_catalog=@p_user;

	DECLARE @name varchar(256);
	DECLARE @out nvarchar(max) = '';
	DECLARE @br char(1) = CHAR(10)
	DECLARE @tab char(1) = CHAR(9)

	DECLARE @a_name varchar(256);
	DECLARE @a_type int;
	DECLARE @a_nullable bit;
begin
	open c_tables
	FETCH NEXT FROM c_tables INTO @name
	WHILE @@FETCH_STATUS = 0
	BEGIN
		set @out = @out + @br + 'public class ' + @name;
        set @out = @out + @br + '{';

		DECLARE c_attr CURSOR LOCAL FOR SELECT cols.name, cols.system_type_id, cols.is_nullable FROM sys.columns cols JOIN sys.tables tbl ON cols.object_id = tbl.object_id where tbl.name=@name;
		open c_attr
		FETCH NEXT FROM c_attr INTO @a_name,@a_type,@a_nullable
		WHILE @@FETCH_STATUS = 0
		BEGIN
			set @out = @out + @br + @tab + 'public ' + dbo.ConvertDataType(@a_type,@a_nullable) + dbo.Initcap(@a_name) + ' { get; set;}';
			FETCH NEXT FROM c_attr INTO @a_name,@a_type,@a_nullable

		end
		close c_attr
		deallocate c_attr
		set @out = @out + @br + '}' + @br;
		FETCH NEXT FROM c_tables INTO @name

	END
	close c_tables
	print @out
end
go

/*create*/ alter  procedure PrintDtoForTable(@p_table VARCHAR(30))
as
	DECLARE @name varchar(256);
	DECLARE @out nvarchar(max) = '';
	DECLARE @br char(1) = CHAR(10)
	DECLARE @tab char(1) = CHAR(9)

	DECLARE @a_name varchar(256);
	DECLARE @a_type int;
	DECLARE @a_nullable bit;
begin
	set @out = @out + @br + 'public class ' + @p_table;
    set @out = @out + @br + '{';

	DECLARE c_attr CURSOR LOCAL FOR SELECT cols.name, cols.system_type_id, cols.is_nullable FROM sys.columns cols JOIN sys.tables tbl ON cols.object_id = tbl.object_id where tbl.name=@p_table;
	open c_attr
	FETCH NEXT FROM c_attr INTO @a_name,@a_type,@a_nullable
	WHILE @@FETCH_STATUS = 0
	BEGIN
		set @out = @out + @br + @tab + 'public ' + dbo.ConvertDataType(@a_type,@a_nullable) + dbo.Initcap(@a_name) + ' { get; set;}';
		FETCH NEXT FROM c_attr INTO @a_name,@a_type,@a_nullable

	end
	close c_attr
	deallocate c_attr
	set @out = @out + @br + '}' + @br;

	print @out
end
go

/*
exec PrintDtoForUser 'bed157'
exec PrintDtoForTable 'User'
*/