select * from  hrac_druzstvo ;
select * from  zapas ;
select * from  hrac ;
select * from  druzstvo;
select * from  oddil; 
select * from  okres;
select * from  liga;
select * from  kraj;

select * from druzstvo
where ID_ligy = 'OS5' and sezona = '2018/2019'

select * from druzstvo
where ID_oddilu = 69

select * from druzstvo
where ID= 42


select * from hrac_druzstvo 
join Druzstvo d on d.ID = ID_druzstva
where ID_druzstva = 42



declare @ID int = 45;
Select * from Zapas 
where 
((id_domaciho_hrace = @ID) or( id_hostujiciho_hrace = @ID)) 



select ID_Domaciho_hrace,sezona,ID_ligy,count(ID_Hostujiciho_hrace)
from zapas
group by ID_domaciho_hrace,sezona,ID_ligy
having count(ID_Hostujiciho_hrace) > 1;



Select count(*) from Zapas 
where sezona = '2018/2019' and 
((id_domaciho_hrace = 10 and skore_domaciho = 3) or( id_hostujiciho_hrace = 10 and skore_hostujiciho = 3)) and
ID_ligy = 'OS5';

Select count(*) from Zapas 
where sezona = '2018/2019' and 
((id_domaciho_hrace = 10 and skore_hostujiciho = 3) or( id_hostujiciho_hrace = 10 and skore_domaciho = 3)) and
ID_ligy = 'OS5';




    Select * from Druzstvo d
        join hrac_druzstvo hd on d.ID = hd.ID_druzstva 
        where hd.ID_hrace = 10 and 
        d.sezona = '2018/2019' and
        d.ID_ligy = 'OS5';




	select * from Hrac h 
    join hrac_druzstvo hd on hd.ID_hrace = h.ID 
    where hd.ID_druzstva = 20;


Select * from Zapas 
where 
((id_domaciho_hrace = 6) or( id_hostujiciho_hrace = 6)) 


	select z.ID_domaciho_hrace,z.ID_hostujiciho_hrace,z.skore_domaciho,z.skore_hostujiciho,z.datum,z.ID_ligy,z.sezona from Zapas z
    where z.ID_domaciho_hrace = 10 and z.sezona = '2018/2019' and z.ID_ligy = 'OS5'
    union 
    (select z.ID_hostujiciho_hrace,z.ID_domaciho_hrace,z.skore_hostujiciho,z.skore_domaciho,z.datum,z.ID_ligy,z.sezona from Zapas z
    where z.ID_hostujiciho_hrace = 10 and z.sezona = '2018/2019' and z.ID_ligy = 'OS5');
        
        
        
		Select z.ID_domaciho_hrace , z.ID_hostujiciho_hrace , z.skore_domaciho , z.skore_hostujiciho , z.datum, z.sezona,
		homeh.ID as homeh_ID,homeh.Prijmeni as homeh_surname,homeh.Jmeno as homeh_name,homeh.datum_narozeni as homeh_date,homeh.telefon as homeh_phone,homeh.email as homeh_email,
		hosth.ID as hosth_ID,hosth.Prijmeni as hosth_surname,hosth.Jmeno as hosth_name,hosth.datum_narozeni as hosth_date,hosth.telefon as hosth_phone,hosth.email as hosth_email,
		l.ID_ligy,l.nazev as league_name from Zapas z 
		join liga l on z.ID_ligy = l.ID_ligy
		join hrac homeh on homeh.id = z.ID_domaciho_hrace
        join hrac hosth on hosth.id = z.ID_hostujiciho_hrace
		where z.sezona = '2018/2019' and 
((z.id_domaciho_hrace = 10) or( z.id_hostujiciho_hrace = 10)) and
z.ID_ligy = 'OS5'
order by datum;

 select * from 
    (select z.ID_domaciho_hrace ,z.ID_hostujiciho_hrace ,z.skore_domaciho ,z.skore_hostujiciho ,z.datum,z.ID_ligy,z.sezona from Zapas z 
    where z.ID_domaciho_hrace = 10 and z.sezona = '2018/2019' and z.ID_ligy = 'OS5' 
    union 
    (select z.ID_domaciho_hrace ,z.ID_hostujiciho_hrace ,z.skore_domaciho ,z.skore_hostujiciho ,z.datum,z.ID_ligy,z.sezona from Zapas z 
    where z.ID_hostujiciho_hrace = 10 and z.sezona = '2018/2019' and z.ID_ligy = 'OS5' ))t order by t.datum;


	
	select o.ID,o.nazev,o.adresa,o.mesto,o.web,o.okres_zkratka,o.telefon_jednatele,o.email_jednatele from Oddil o
    where o.nazev like '%Pingpong%';
	
	select * from hrac where prijmeni like '%Wang%';



	select d.ID,d.nazev,d.sezona,d.sezona,l.ID_ligy,l.nazev,o.ID,o.nazev,o.adresa,o.mesto,o.web,o.okres_zkratka,o.telefon_jednatele,o.email_jednatele,ok.nazev as okres_nazev,k.nazev as kraj_nazev,k.zkratka as kraj_zkratka from Druzstvo d 	join Oddil o on o.id = d.ID_oddilu	join Okres ok on ok.zkratka = o.okres_zkratka	join kraj k on k.zkratka = ok.kraj_zkratka	join liga l on l.ID_ligy = d.ID_ligy	
	where d.ID = 20;














declare @p_teamID integer = 2100

	select ID from Druzstvo 
		where sezona in( select d.sezona from Druzstvo d where d.ID = @p_teamID) and
		ID_ligy in ( select d.ID_ligy from Druzstvo d where d.ID = @p_teamID) and 
		ID != @p_teamID
--29,76

declare @p_teamID integer = 2100
declare @team1 integer = 29
declare @team2 integer = 76
	Select count(*) from Zapas z 
		join hrac_druzstvo hdhome on
			(z.ID_domaciho_hrace = hdhome.ID_hrace )
		join hrac_druzstvo hdhost on 
			(z.ID_hostujiciho_hrace = hdhost.ID_hrace )
		where (hdhome.ID_druzstva = @p_teamID
		and hdhost.ID_druzstva = @team1
		and z.skore_domaciho = 3
		)
		or
		(
			hdhome.ID_druzstva = @team1
			and hdhost.ID_druzstva = @p_teamID
			and z.skore_hostujiciho = 3
		)

			Select count(*) from Zapas z 
		join hrac_druzstvo hdhome on
			(z.ID_domaciho_hrace = hdhome.ID_hrace )
		join hrac_druzstvo hdhost on 
			(z.ID_hostujiciho_hrace = hdhost.ID_hrace )
		where (hdhome.ID_druzstva = @p_teamID
		and hdhost.ID_druzstva = @team2
		and z.skore_domaciho = 3
		)
		or
		(
			hdhome.ID_druzstva = @team2
			and hdhost.ID_druzstva = @p_teamID
			and z.skore_hostujiciho = 3
		)


		Select count(*) from Zapas z 
		join hrac_druzstvo hdhome on
			(z.ID_domaciho_hrace = hdhome.ID_hrace )
		join hrac_druzstvo hdhost on 
			(z.ID_hostujiciho_hrace = hdhost.ID_hrace )
		where 
		(
			hdhome.ID_druzstva = @p_teamID
			and hdhost.ID_druzstva = @team1
			and z.skore_hostujiciho = 3
		)
		or
		(
			hdhome.ID_druzstva = @team1
			and hdhost.ID_druzstva = @p_teamID
			and z.skore_domaciho = 3
		)

		Select count(*) from Zapas z 
		join hrac_druzstvo hdhome on
			(z.ID_domaciho_hrace = hdhome.ID_hrace )
		join hrac_druzstvo hdhost on 
			(z.ID_hostujiciho_hrace = hdhost.ID_hrace )
		where 
		(
			hdhome.ID_druzstva = @p_teamID
			and hdhost.ID_druzstva = @team2
			and z.skore_hostujiciho = 3
		)
		or
		(
			hdhome.ID_druzstva = @team2
			and hdhost.ID_druzstva = @p_teamID
			and z.skore_domaciho = 3
		)


select * from (
select h.id,h.jmeno,h.prijmeni,d.ID_ligy,d.nazev 
,
( select count(*) from hrac_druzstvo hd1
join druzstvo d1 on d1.id = hd1.ID_druzstva
where hd1.ID_hrace = h.id and d1.sezona = '2018/2019'

) teams
from hrac_druzstvo hd
join hrac h on h.id = hd.ID_hrace
join druzstvo d on d.id = hd.ID_druzstva
where d.sezona = '2018/2019'
)t
where t.teams>1


select * from Druzstvo where sezona = '2018/2019' and ID_ligy='EXL'

select * from liga










