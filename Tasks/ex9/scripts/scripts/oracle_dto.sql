create or replace function ConvertDataType(p_attr IN user_tab_cols%ROWTYPE)
return varchar2
AS
  v_out varchar2(256);
  
BEGIN
--ORACLE DOES NOT HAVE BOOLEAN DATATYPE. MODIFY THIS FUNCTION BASED ON YOUR BOOLEAN SUBSTITUTION
v_out:=
  CASE p_attr.data_type
   WHEN 'NUMBER' THEN  (CASE WHEN p_attr.data_scale > 0 THEN 'double' ELSE 'int' END)
   WHEN 'VARCHAR2' THEN  'string'
   WHEN 'FLOAT' THEN  'float'
   WHEN 'TIMESTAMP(6)' THEN  'DateTime'
   WHEN 'DATE' THEN  'DateTime'
   WHEN 'CHAR' THEN  'string'
   ELSE 'unknown (' || p_attr.data_type ||')'
  END;
  if (v_out != 'string' and p_attr.nullable = 'Y') then
    return v_out || '? '; --nullable datatype in c#
  else
    return v_out || ' ';
  end if;
END;
/
create or replace procedure PrintDto(p_user IN dba_tables.owner%TYPE)
as
  CURSOR c_tables IS SELECT table_name  FROM dba_tables where owner=p_user;
  v_out CLOB; --varchar is limited to 4000 chars. CLOB is prefered for long strings
  br char :=chr(10);
  tab char :=chr(9);
begin
  for t in c_tables loop
      --class header
      v_out := v_out || br || 'public class ' || t.table_name;
      v_out := v_out || br || '{';
      for attr in (SELECT * FROM user_tab_cols WHERE table_name = t.table_name) loop
        --dbms_output.put_line(attr.COLUMN_NAME);  
        v_out := v_out || br || tab || 'public ' || ConvertDataType(attr) || initcap(attr.column_name) || ' { get; set;}'; --function initcap convert sting to have first letter uppercase and rest in lowercase
      end loop;
      v_out := v_out || br || '}' || br;
  end loop;
  dbms_output.put_line(v_out);
end;


/*
exec PrintDto ('BED157');
*/