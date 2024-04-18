create or replace procedure CopyTableStructure(tablename varchar)
is fullname varchar(100);
command varchar(5000);
attrib varchar(1000);
begin
    fullname := tablename || '_old';
    command := 'create table ' || fullname || '(';
    for cols in (select * from USER_TAB_COLUMNS where TABLE_NAME = tablename) loop
            attrib := cols.COLUMN_NAME || ' ' || cols.DATA_TYPE ;
            if( cols.DATA_TYPE = 'CHAR' or cols.DATA_TYPE = 'VARCHAR2') then
            begin
                attrib := attrib || '(' || cols.DATA_LENGTH || ')';
            end;
            end if;
            if( cols.NULLABLE = 'N') then
            begin
                attrib := attrib || ' not null';
            end;
            end if;       
            attrib := attrib || ',';
            command := command || attrib;
    end loop;
        command := substr(command,0,length(command)-1);
        command := command || ')';
        dbms_output.put_line(command);
        execute immediate command;
end;
execute CopyTableStructure('STUDENT'); 