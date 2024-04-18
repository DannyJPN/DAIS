select * from Substance;
select * from Measurement;


--1


alter table Substance
add   over_limit int ;
alter table Substance
add   over_avg int ;

update Substance set over_limit = 0;
update Substance set over_avg = 0;



create or replace trigger tg_SubstanceLimit before insert on Measurement for each row
declare
lmt int;
aver real;
begin
    select limit into lmt from Substance where substance_id = :NEW.substance_id;
    select avg(concentration) into aver from Measurement where substance_id = :NEW.substance_id;
    if(:NEW.concentration > lmt ) then
        begin
            update Substance set over_limit = over_limit+1 where substance_id = :NEW.substance_id; 
        end;
    end if;
    if(:NEW.concentration > aver ) then
        begin
            update Substance set over_avg = over_avg+1 where substance_id = :NEW.substance_id; 
        end;
    end if;
    
    
end; 




--2
create or replace function f_GetMeasurementXML(p_from date,p_to date)
return CLOB
is XMLoutput CLOB;
begin
    XMLoutput := '';
    for one_line in (select st.station_id,st.station_name,me.meas_id,me.meas_date,me.concentration,su.substance_id,su.substance_name,su.limit
                        from measurement me join station st on st.station_id = me.station_id join substance su on su.substance_id = me.substance_id
                        where me.meas_date > p_from and me.meas_date <p_to) 
    loop
   
        XMLoutput := XMLoutput
        ||  '<report>' || chr(13) || chr(10)
             ||  '<station id = '  ||  one_line.station_id  ||  'name = '  ||  one_line.station_name   || '>'  || chr(13) || chr(10)
               ||   '<measurement id = ' || one_line.meas_id || '>'  || chr(13) || chr(10)
                     || '<date>' || to_char(one_line.meas_date,'DD.MM.YYYY') || '</date>' || chr(13) || chr(10)
                     || '<concentration>' || one_line.concentration || '</concentration>' || chr(13) || chr(10)
                     || '<substance>' || one_line.substance_id || chr(13) || chr(10)
                        || ' <name>' || one_line.substance_name || '</name>' || chr(13) || chr(10)
                         || '<limit>' || one_line.limit  || '</limit>' || chr(13) || chr(10)
                     || '</substance>' || chr(13) || chr(10)
                 || '</measurement>' || chr(13) || chr(10)
             || '</station>' || chr(13) || chr(10)
         || '</report>' || chr(13) || chr(10);
        
    
    end loop;

    return XMLoutput;
end;

execute dbms_output.put_line( SUBSTR( f_GetMeasurementXML(to_date('2017-01-01', 'YYYY-MM-DD'),to_date('2017-06-01', 'YYYY-MM-DD') ),1,1000) );
select st.station_id,st.station_name,me.meas_id,me.meas_date,me.concentration,su.substance_id,su.substance_name,su.limit
                        from measurement me join station st on st.station_id = me.station_id join substance su on su.substance_id = me.substance_id
                        where me.meas_date >to_date('2017-01-01', 'YYYY-MM-DD') and me.meas_date <to_date('2017-06-01', 'YYYY-MM-DD');