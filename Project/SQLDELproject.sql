/*
ALTER TABLE hrac_druzstvo    DROP CONSTRAINT hr_dr_prisl_druzstvo_fk  
ALTER TABLE hrac_druzstvo    DROP CONSTRAINT hr_dr_prisl_hrac_fk  
ALTER TABLE zapas    DROP CONSTRAINT zapas_hrac1_fk  
ALTER TABLE zapas    DROP CONSTRAINT zapas_hrac2_fk     
ALTER TABLE druzstvo_liga    DROP CONSTRAINT dr_li_druzstvo_fk 
ALTER TABLE druzstvo_liga    DROP CONSTRAINT dr_li_liga_fk 
ALTER TABLE druzstvo    DROP CONSTRAINT druzstvo_oddil_fk  
*/

select * from druzstvo;

drop table hrac_druzstvo ;
go
drop table zapas ;
go
drop table hrac ;
go
drop table druzstvo;
go
drop table oddil; 
go
drop table okres;
go
drop table liga;
go
drop table kraj;
go


