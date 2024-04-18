create or alter trigger TeamMembershipValidity 
on hrac_druzstvo
for insert,update
as
begin 
	declare @ID_hrace integer;
	declare @ID_druzstva integer;
	declare @season nchar(9);
	declare @currentcount integer=0;
	declare @validcount integer=0;

	DECLARE newitems CURSOR FOR select * from inserted
	OPEN newitems
	FETCH NEXT FROM newitems INTO @ID_hrace,@ID_druzstva
   		select @season=sezona from druzstvo d where d.ID = @ID_druzstva
		
		select @currentcount = count(*) from hrac_druzstvo hd
		join Druzstvo d on d.ID = hd.ID_druzstva
		where hd.ID_hrace =@ID_hrace and d.sezona = @season
	
		if(@currentcount > 3)
		begin
			print '';
			throw 50000,'Moc t�m�',1;
		end;
			
		else if (@currentcount between 1 and 3)
		begin
			print 'Po��t�me d�le';

			select @validcount=count(*) from hrac_druzstvo hd
			join Druzstvo d on d.ID = hd.ID_druzstva
			where hd.ID_hrace = @ID_hrace
			and d.sezona = @season
			and d.ID_oddilu in ( SELECT d.ID_oddilu from druzstvo d where d.ID = @ID_druzstva )
			and d.ID_ligy not in ( SELECT d.ID_ligy from druzstvo d where d.ID = @ID_druzstva )
			if(@currentcount != @validcount)
			begin
				print '';
				throw 50001,'chyba p��slu�nosti',2;
			end;
		end;
		else 
		begin
			print 'Povolit';
		end;


	WHILE @@FETCH_STATUS = 0
	BEGIN

    	FETCH NEXT FROM newitems INTO @ID_hrace,@ID_druzstva
   		select @season=sezona from druzstvo d where d.ID = @ID_druzstva
		
		select @currentcount = count(*) from hrac_druzstvo hd
		join Druzstvo d on d.ID = hd.ID_druzstva
		where hd.ID_hrace =@ID_hrace and d.sezona = @season
	
		if(@currentcount > 3)
		begin
			print '';
			throw 50000,'Moc t�m�',1;
		end;
			
		else if (@currentcount between 1 and 3)
		begin
			print 'Po��t�me d�le';

			select @validcount=count(*) from hrac_druzstvo hd
			join Druzstvo d on d.ID = hd.ID_druzstva
			where hd.ID_hrace = @ID_hrace
			and d.sezona = @season
			and d.ID_oddilu in ( SELECT d.ID_oddilu from druzstvo d where d.ID = @ID_druzstva )
			and d.ID_ligy not in ( SELECT d.ID_ligy from druzstvo d where d.ID = @ID_druzstva )
			if(@currentcount != @validcount)
			begin
				print '';
				throw 50001,'chyba p��slu�nosti',2;
			end;
		end;
		else 
		begin
			print 'Povolit';
		end;



	END
CLOSE newitems
DEALLOCATE newitems
	



end;
go
--insert into hrac_druzstvo(ID_hrace,ID_druzstva) values (666,63);
go



--_______________________________________________________

create or alter trigger MatchCount 
on zapas
for insert,update
as
begin 
declare @first_player_matches integer;
declare @second_player_matches integer;
declare @homeplayerID integer;
declare @hostplayerID integer;
declare @date date;
   --kurzor nepou��v� v�echny parametry vlo�en�ho z�znamu,jen ty kter� pot�ebuje-zm�na proti anal�ze
DECLARE newitems CURSOR FOR select ID_domaciho_hrace,ID_hostujiciho_hrace,datum from inserted
	OPEN newitems
	FETCH NEXT FROM newitems INTO @homeplayerID,@hostplayerID,@date
	
    	Select @first_player_matches=count(*) from Zapas z
		where (z.ID_domaciho_hrace = @homeplayerID or z.ID_hostujiciho_hrace = @homeplayerID) and 
		z.datum = @date


		Select @second_player_matches=count(*) from Zapas z
		where (z.ID_domaciho_hrace = @hostplayerID or z.ID_hostujiciho_hrace = @hostplayerID) and 
		z.datum = @date	

    
    
    
    WHILE @@FETCH_STATUS = 0
	BEGIN
	FETCH NEXT FROM newitems INTO @homeplayerID,@hostplayerID,@date
	
    	Select @first_player_matches=count(*) from Zapas z
		where (z.ID_domaciho_hrace = @homeplayerID or z.ID_hostujiciho_hrace = @homeplayerID) and 
		z.datum = @date


		Select @second_player_matches=count(*) from Zapas z
		where (z.ID_domaciho_hrace = @hostplayerID or z.ID_hostujiciho_hrace = @hostplayerID) and 
		z.datum = @date	

	END
CLOSE newitems
DEALLOCATE newitems



end;


--__________________________________________________________
go
create or alter trigger MatchValidity 
on zapas
for insert,update
as
begin 

 declare @count1 integer; 
 declare @count2 integer; 
 declare @hometeamID integer; 
 declare @hostteamID integer;
 
 declare @homeplayerID integer;
 declare @hostplayerID integer;
 declare @season nchar(9);
 declare @league nchar(5);
   --kurzor nepou��v� v�echny parametry vlo�en�ho z�znamu,jen ty kter� pot�ebuje-zm�na proti anal�ze
DECLARE newitems CURSOR FOR select ID_domaciho_hrace,ID_hostujiciho_hrace,sezona,ID_ligy from inserted
	OPEN newitems
    FETCH NEXT FROM newitems INTO @homeplayerID,@hostplayerID,@season,@league
	--dom�c�   
        Select @count1=count(d.ID) from Druzstvo d
        join hrac_druzstvo hd on d.ID = hd.ID_druzstva 
        where hd.ID_hrace = @homeplayerID and 
        d.sezona = @season and
        d.ID_ligy = @league;
        
        if (@count1 <= 0)
        begin
            print '';
            throw 50002,'Hr�� nen� v sezon� aktivn�',3;
        
        end; 
        else if (@count1 > 1)
        begin
            print '';
            throw 50003,'Hr�� je chybn� p�i�azen na soupisky dru�stev',4;
        end;
        
        Select @hometeamID=d.ID from Druzstvo d
        join hrac_druzstvo hd on d.ID = hd.ID_druzstva
        where hd.ID_hrace = @homeplayerID and 
        d.sezona = @season and
        d.ID_ligy = @league;
 --host           
   	    Select @count2=count(d.ID) from Druzstvo d
        join hrac_druzstvo hd on d.ID = hd.ID_druzstva 
        where hd.ID_hrace = @hostplayerID and 
        d.sezona = @season and
        d.ID_ligy = @league;
        
        if (@count2 <= 0)
        begin
            print '';
            throw 50002,'Hr�� nen� v sezon� aktivn�',3;
        
        end; 
        else if (@count2 > 1)
        begin
            print '';
            throw 50003,'Hr�� je chybn� p�i�azen na soupisky dru�stev',4;
        end;
        
        Select @hostteamID=d.ID from Druzstvo d
        join hrac_druzstvo hd on d.ID = hd.ID_druzstva
        where hd.ID_hrace = @hostplayerID and 
        d.sezona = @season and
        d.ID_ligy = @league;
     
        if(@hometeamID = @hostteamID)
        begin
            print '';
            throw 50004,'Spoluhr��i nemohou hr�t proti sob�',5;
        
        end;       
                                  
	
    
    
    
    
    
    
	WHILE @@FETCH_STATUS = 0
	BEGIN
    FETCH NEXT FROM newitems INTO @homeplayerID,@hostplayerID,@season,@league
	--dom�c�   
        Select @count1=count(d.ID) from Druzstvo d
        join hrac_druzstvo hd on d.ID = hd.ID_druzstva 
        where hd.ID_hrace = @homeplayerID and 
        d.sezona = @season and
        d.ID_ligy = @league;
        
        if (@count1 <= 0)
        begin
            print '';
            throw 50002,'Hr�� nen� v sezon� aktivn�',3;
        
        end; 
        else if (@count1 > 1)
        begin
            print '';
            throw 50003,'Hr�� je chybn� p�i�azen na soupisky dru�stev',4;
        end;
        
        Select @hometeamID=d.ID from Druzstvo d
        join hrac_druzstvo hd on d.ID = hd.ID_druzstva
        where hd.ID_hrace = @homeplayerID and 
        d.sezona = @season and
        d.ID_ligy = @league;
 --host           
   	    Select @count2=count(d.ID) from Druzstvo d
        join hrac_druzstvo hd on d.ID = hd.ID_druzstva 
        where hd.ID_hrace = @hostplayerID and 
        d.sezona = @season and
        d.ID_ligy = @league;
        
        if (@count2 <= 0)
        begin
            print '';
            throw 50002,'Hr�� nen� v sezon� aktivn�',3;
        
        end; 
        else if (@count2 > 1)
        begin
            print '';
            throw 50003,'Hr�� je chybn� p�i�azen na soupisky dru�stev',4;
        end;
        
        Select @hostteamID=d.ID from Druzstvo d
        join hrac_druzstvo hd on d.ID = hd.ID_druzstva
        where hd.ID_hrace = @hostplayerID and 
        d.sezona = @season and
        d.ID_ligy = @league;
     
        if(@hometeamID = @hostteamID)
        begin
            print '';
            throw 50004,'Spoluhr��i nemohou hr�t proti sob�',5;
        
        end;       
                                  
	 
	END
CLOSE newitems
DEALLOCATE newitems



end;