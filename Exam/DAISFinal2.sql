select * from city;
select * from measurement;
select * from station;
select * from source;
select * from substance;



--1
alter table City add latitude_min real;
/
alter table City add latitude_max real;
/
create or replace procedure SetAttributesOfAllCities
as
maxlat real;
minlat real;
begin
    for c in (select city_id from city) loop
        select max(latitude) into maxlat from  
        (
      
        select latitude from source so
        where so.city_id = c.city_id
        union 
            (
                select latitude from station st where st.city_id = c.city_id
            )
        )t ;  
        
        select min(latitude) into minlat from  
        (
      
        select latitude from source so
        where so.city_id = c.city_id
        union 
            (
                select latitude from station st where st.city_id = c.city_id
            )
        )t ; 
        
        update city set latitude_max = maxlat,latitude_min = minlat where city_id = c.city_id;
    end loop;

commit;
exception
when others then
rollback;
end;
/

execute SetAttributesOfAllCities();
--2

create or replace procedure GetBadMeasurements(p_station_id station.station_id%TYPE,p_month_from int,p_month_to int,p_humidity measurement.humidity%TYPE := NULL,p_wind measurement.wind%TYPE := NULL)
as
counter int :=0;
lowwind real;
highwind real;
lowhumidity real;
highhumidity real;

begin

if(p_humidity is null and p_wind is null) then
    begin
        select count(*) into counter from measurement mea
        join substance su on su.substance_id = mea.substance_id and su.limit < mea.concentration
        where extract(month from mea.meas_date) between p_month_from and p_month_to and mea.station_id = p_station_id;
    end;
elsif(p_humidity is null and p_wind is not null) then
    begin
    lowwind := 0.85*p_wind;
    highwind := 1.15*p_wind;
        select count(*) into counter from measurement mea
        join substance su on su.substance_id = mea.substance_id and su.limit < mea.concentration
        where extract(month from mea.meas_date) between p_month_from and p_month_to and mea.station_id = p_station_id
           and mea.wind between lowwind and highwind;
       
    end;
elsif(p_humidity is not null and p_wind is  null) then
    begin
    lowhumidity := 0.85*p_humidity;
    highhumidity := 1.15*p_humidity;
        select count(*) into counter from measurement mea
        join substance su on su.substance_id = mea.substance_id and su.limit < mea.concentration
        where extract(month from mea.meas_date) between p_month_from and p_month_to and mea.station_id = p_station_id
           and mea.humidity between lowhumidity and highhumidity;
   
    end;
elsif(p_humidity is not null and p_wind is not null) then
    begin
        lowwind := 0.85*p_wind;
        highwind := 1.15*p_wind;
        lowhumidity := 0.85*p_humidity;
        highhumidity := 1.15*p_humidity;
         select count(*) into counter from measurement mea
        join substance su on su.substance_id = mea.substance_id and su.limit < mea.concentration
        where extract(month from mea.meas_date) between p_month_from and p_month_to and mea.station_id = p_station_id
           and mea.humidity between lowhumidity and highhumidity and mea.wind between lowwind and highwind;
   
        
    end;
end if;

dbms_output.put_line('Po?et špatných m??ení: ' || counter);
end;
/
execute GetBadMeasurements(4,2,3);

select * from measurement mea
        join substance su on su.substance_id = mea.substance_id and su.limit < mea.concentration
        where extract(month from mea.meas_date) between 2 and 3 and mea.station_id = 4;
        
        
        
    