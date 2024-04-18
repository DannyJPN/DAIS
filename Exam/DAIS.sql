--1
create or replace procedure ShowSubstances 
is
begin

for substant in
    (select su.substance_name,count(mea.meas_id) as overflows from measurement mea 
    join substance su on su.substance_id = mea.substance_id and su.limit<mea.concentration
    group by su.substance_name
    order by overflows)
    loop
    dbms_output.put_line(substant.substance_name || ' Celkem pøekroèení: ' || substant.overflows);
        for town_subs in (            
            select c.city_name, count(mea.meas_id) as overflow from measurement mea 
            join substance su on su.substance_id = mea.substance_id and su.limit<mea.concentration
            join station st on st.station_id = mea.station_id
            join city c on c.city_id = st.city_id
            where su.substance_name = substant.substance_name
            group by c.city_name, mea.substance_id)
            loop
            dbms_output.put_line('   - '||town_subs.city_name || ' Pøekroèení: ' || town_subs.overflow);
            
            end loop;
    end loop;
end;

execute ShowSubstances();


--2
create table Origin
(
source_id int,
substance_id int,
emision real,
primary key(source_id,substance_id),
foreign key (source_id) references Source(source_id),
foreign key (substance_id) references Substance(substance_id)


);

drop table Origin;
select * from Origin;

create or replace procedure SetEmission
is
concentration_sum measurement.concentration%TYPE;
sourcecount int;
subs_id substance.substance_id%TYPE;
meascount int;
begin
select substance_id into subs_id  from substance where substance_name like '%PM10%' ;

for sour in (select source_id,city_id from Source where source_type like '%Lokální%') loop

select count(*) into sourcecount from source sourc where sourc.city_id = sour.city_id and source_type like '%Lokální%';

 select count(mea.concentration) into meascount from measurement mea
    join substance su on su.substance_id =subs_id  
    join station st on st.station_id = mea.station_id
    join city c on c.city_id = st.city_id
    join source so on so.city_id = c.city_id
    where so.source_id = sour.source_id;
    
    
if(sourcecount > 0 and meascount >0) then
begin
    -- DBMS_OUTPUT.PUT_LINE(sourcecount);
    -- DBMS_OUTPUT.PUT_LINE(meascount);
    
    
    select sum(mea.concentration) into concentration_sum from measurement mea
    join substance su on su.substance_id = subs_id
    join station st on st.station_id = mea.station_id
    join city c on c.city_id = st.city_id
    where so.source_id = sour.source_id
    group by so.source_id;
    
    
    
    insert into Origin(source_id,substance_id,emision) values (sour.source_id,subs_id,concentration_sum/sourcecount);
end;
end if;
    
end loop;
commit;
exception
    when others then
    DBMS_OUTPUT.PUT_LINE('error');
    rollback;
    




end;

execute SetEmission();
