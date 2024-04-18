

CREATE TABLE hrac 
    (
     id      INTEGER NOT NULL  identity ,
     jmeno   nvarchar (50) NOT NULL , 
     prijmeni NVARCHAR (50) NOT NULL , 
     datum_narozeni date NOT NULL ,
     telefon INTEGER ,
     email NVARCHAR (100)    ,
     constraint hr_pk primary key (id)   ,
     constraint hrac_datum check (datum_narozeni <= cast(GETDATE()as date)),
     constraint hrac_telefon check(telefon between 100000000 and 1000000000  ) ,
     constraint hrac_email check(email like '%@%')
     )
go

CREATE TABLE liga 
    (
    ID_ligy     NCHAR(5) NOT NULL ,
    nazev   nvarchar (30) NOT NULL ,
    constraint li_pk primary key (ID_ligy)
	)
go

create table kraj
(
         zkratka nchar(1) not null,
         nazev nvarchar(30) not null,
          constraint kraj_pk primary key (zkratka)
)
go

create table okres
(
         zkratka nchar(2) not null,
         nazev nvarchar(30) not null,
         kraj_zkratka nchar (1) not null,
         constraint okr_pk primary key (zkratka),
         constraint okr_kr_fk FOREIGN KEY ( kraj_zkratka)        REFERENCES kraj ( zkratka) 
)
go



CREATE TABLE oddil 
    (
     id      INTEGER NOT NULL  identity ,
     nazev   nvarchar (80) NOT NULL , 
     okres_zkratka NCHAR (2) NOT NULL , 
     mesto NVARCHAR (40) NOT NULL,
     adresa NVARCHAR(100), 
     web nvarchar(100) ,
     telefon_jednatele INTEGER  ,
     email_jednatele NVARCHAR (100)    ,
     constraint od_pk primary key (id)  ,
     constraint oddil_telefon check(telefon_jednatele between 100000000 and 1000000000  ) ,
     constraint oddil_email check(email_jednatele like '%@%')
     
     )
go

create table druzstvo
    (
   	id      INTEGER NOT NULL  identity ,
    nazev   NVARCHAR (80) NOT NULL , 
     sezona NCHAR (9) NOT NULL ,
     ID_oddilu INTEGER NOT NULL            ,
     ID_ligy  NCHAR(5) NOT NULL          ,
     constraint dru_fk  primary key (id),
    constraint dru_od_fk FOREIGN KEY (ID_oddilu)        REFERENCES oddil (id)   ,
    constraint dru_lig_fk FOREIGN KEY (ID_ligy)        REFERENCES liga (ID_ligy)  ,
    constraint dru_sezona check (LEN(sezona)=9 and  
     SUBSTRING(sezona,1,4) +1 =  SUBSTRING(sezona,6,4) and 
	   SUBSTRING(sezona,5,1) = '/'),
    
    )
go





CREATE TABLE hrac_druzstvo 
    (
    
    ID_hrace      INTEGER NOT NULL ,
    ID_druzstva   INTEGER NOT NULL ,
      constraint  hra_dr_pk primary key (ID_hrace,ID_druzstva),
      constraint dru_hra_dru_id_fk FOREIGN KEY (ID_druzstva)        REFERENCES druzstvo (id),
	  constraint dru_hra_hra_id_fk FOREIGN KEY (ID_hrace)        REFERENCES hrac ( id)
	 ) 
go



CREATE TABLE zapas 
    (
     sezona   nvarchar (9) NOT NULL ,
     ID_domaciho_hrace INTEGER NOT NULL , 
     ID_hostujiciho_hrace INTEGER NOT NULL, 
     skore_domaciho    integer NOT NULL ,
     skore_hostujiciho   integer NOT NULL ,
     ID_ligy  NCHAR(5) NOT NULL          ,
     datum   date NOT NULL ,
     constraint zap_datum check (datum <= cast(GETDATE()as date)),
     constraint zap_pk primary key (id_domaciho_hrace,id_hostujiciho_hrace,sezona,ID_ligy),
	 constraint zap_hrd_id_fk FOREIGN KEY ( ID_domaciho_hrace )        REFERENCES hrac ( id),
	 constraint zap_hrh_id_fk FOREIGN KEY ( ID_hostujiciho_hrace )        REFERENCES hrac ( id)  ,
     constraint zap_lig_fk FOREIGN KEY ( ID_ligy)        REFERENCES liga ( ID_ligy) ,
     constraint  zap_sezona check (LEN(sezona)=9 and  
     SUBSTRING(sezona,1,4) +1 =  SUBSTRING(sezona,6,4)
      and SUBSTRING(sezona,5,1) = '/'), 
     constraint zap_skore_dom   check (skore_domaciho between 0 and 3),
     constraint zap_skore_host check (skore_hostujiciho between 0 and 3) 
     ) 
go
	
 


 
 
 