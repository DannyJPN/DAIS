create or alter function Bilance (@p_season nchar(9),@p_playerID integer,@p_league nchar(5))
returns real
as

begin

declare @wins real,
@loses real;

Select @wins=cast(count(*) as real) from Zapas 
where sezona = @p_season and 
((id_domaciho_hrace = @p_playerID and skore_domaciho = 3) or( id_hostujiciho_hrace = @p_playerID and skore_hostujiciho = 3)) and
ID_ligy = @p_league;

Select @loses=cast(count(*) as real) from Zapas 
where sezona = @p_season and 
((id_domaciho_hrace = @p_playerID and skore_hostujiciho = 3) or( id_hostujiciho_hrace = @p_playerID and skore_domaciho = 3)) and
ID_ligy = @p_league;

if @loses + @wins =0
	begin
		return 0;
	end;

return cast((@wins *100) as real) / cast((@loses + @wins) as real);
	

end;
go
begin
declare @bilance real;
execute @bilance = Bilance '2018/2019',10,'OS5';
print @bilance;
end;
go
--____________________________________________________

create or alter function PointCount(@p_teamID integer)
returns integer
as
begin

declare @pointcount integer = 0;
declare @team integer;
declare @wins integer;
declare @loses integer;

declare teamcursor cursor for 
	(
		select ID from Druzstvo 
		where sezona in( select d.sezona from Druzstvo d where d.ID = @p_teamID) and
		ID_ligy in ( select d.ID_ligy from Druzstvo d where d.ID = @p_teamID) and 
		ID != @p_teamID
	)


	open teamcursor

   	fetch next from teamcursor into @team
		
    --Select přepracován oproti analýze, Detail funkce 5.2 c)
		Select @wins=count(*) from Zapas z 
		join hrac_druzstvo hdhome on
			(z.ID_domaciho_hrace = hdhome.ID_hrace )
		join hrac_druzstvo hdhost on 
			(z.ID_hostujiciho_hrace = hdhost.ID_hrace )
		where (hdhome.ID_druzstva = @p_teamID
		and hdhost.ID_druzstva = @team
		and z.skore_domaciho = 3
		)
		or
		(
			hdhome.ID_druzstva = @team
			and hdhost.ID_druzstva = @p_teamID
			and z.skore_hostujiciho = 3
		)

     --Select přepracován oproti analýze, Detail funkce 5.2 d)
		Select @loses=count(*) from Zapas z 
		join hrac_druzstvo hdhome on
			(z.ID_domaciho_hrace = hdhome.ID_hrace )
		join hrac_druzstvo hdhost on 
			(z.ID_hostujiciho_hrace = hdhost.ID_hrace )
		where 
		(
			hdhome.ID_druzstva = @p_teamID
			and hdhost.ID_druzstva = @team
			and z.skore_hostujiciho = 3
		)
		or
		(
			hdhome.ID_druzstva = @team
			and hdhost.ID_druzstva = @p_teamID
			and z.skore_domaciho = 3
		)

		if(@wins>@loses)
		begin
			set @pointcount = @pointcount +3;
		end
		else if(@wins=@loses)
		begin
			set @pointcount = @pointcount +1;
		end;
		

	while @@FETCH_STATUS =0
	begin
   	fetch next from teamcursor into @team
		
    --Select přepracován oproti analýze, Detail funkce 5.2 c)
		Select @wins=count(*) from Zapas z 
		join hrac_druzstvo hdhome on
			(z.ID_domaciho_hrace = hdhome.ID_hrace )
		join hrac_druzstvo hdhost on 
			(z.ID_hostujiciho_hrace = hdhost.ID_hrace )
		where (hdhome.ID_druzstva = @p_teamID
		and hdhost.ID_druzstva = @team
		and z.skore_domaciho = 3
		)
		or
		(
			hdhome.ID_druzstva = @team
			and hdhost.ID_druzstva = @p_teamID
			and z.skore_hostujiciho = 3
		)

     --Select přepracován oproti analýze, Detail funkce 5.2 d)
		Select @loses=count(*) from Zapas z 
		join hrac_druzstvo hdhome on
			(z.ID_domaciho_hrace = hdhome.ID_hrace )
		join hrac_druzstvo hdhost on 
			(z.ID_hostujiciho_hrace = hdhost.ID_hrace )
		where 
		(
			hdhome.ID_druzstva = @p_teamID
			and hdhost.ID_druzstva = @team
			and z.skore_hostujiciho = 3
		)
		or
		(
			hdhome.ID_druzstva = @team
			and hdhost.ID_druzstva = @p_teamID
			and z.skore_domaciho = 3
		)

		if(@wins>@loses)
		begin
			set @pointcount = @pointcount +3;
		end
		else if(@wins=@loses)
		begin
			set @pointcount = @pointcount +1;
		end;

	end;		
		close teamcursor;
		deallocate teamcursor;
return @pointcount;
end;
go
begin
declare @point real;
execute @point = PointCount 63;
print @point;
end;
go


select dbo.PointCount(40);
select dbo.Bilance( '2018/2019',10,'OS5');