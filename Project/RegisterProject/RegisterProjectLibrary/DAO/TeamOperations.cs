using RegisterProjectLibrary.DTO;
using System;
using System.Collections.ObjectModel;
using System.Data.SqlClient;

namespace RegisterProjectLibrary.DAO
{

    public static class TeamOperations
    {
        private static string fullselectstring = "select d.ID as d_ID,d.nazev as d_nazev,d.sezona," +
            "l.ID_ligy,l.nazev as l_nazev," +
            "o.ID as o_ID,o.nazev as o_nazev,o.adresa,o.mesto,o.web,o.telefon_jednatele,o.email_jednatele," +
            "ok.zkratka as okres_zkratka,ok.nazev as okres_nazev," +
            "k.nazev as kraj_nazev,k.zkratka as kraj_zkratka from Druzstvo d 	" +
            "join Oddil o on o.id = d.ID_oddilu	" +
            "join Okres ok on ok.zkratka = o.okres_zkratka	" +
            "join kraj k on k.zkratka = ok.kraj_zkratka	" +
            "join liga l on l.ID_ligy = d.ID_ligy	";
        private static string singleselectstring = "select d.ID as d_ID,d.nazev as d_nazev,d.sezona," +
            "l.ID_ligy,l.nazev as l_nazev," +
            "o.ID as o_ID,o.nazev as o_nazev,o.adresa,o.mesto,o.web,o.telefon_jednatele,o.email_jednatele," +
            "ok.zkratka as okres_zkratka,ok.nazev as okres_nazev," +
            "k.nazev as kraj_nazev,k.zkratka as kraj_zkratka from Druzstvo d 	" +
            "join Oddil o on o.id = d.ID_oddilu	" +
            "join Okres ok on ok.zkratka = o.okres_zkratka	" +
            "join kraj k on k.zkratka = ok.kraj_zkratka	" +
            "join liga l on l.ID_ligy = d.ID_ligy	"+
        "where d.ID = @teamID";

        private static string insertstring ="insert into Druzstvo (nazev,sezona,ID_oddilu,ID_ligy) values (@name,@season,@clubID,@leagueID)";
        private static string deletestring = "delete from Druzstvo where id = @teamID";
        private static string updatestring = "update Druzstvo set nazev=@name,sezona=@season,ID_oddilu=@clubID,ID_ligy=@leagueID where ID = @teamID";

        private static string selectstring = "select d.ID as d_ID,d.nazev as d_nazev,d.sezona," +
            "l.ID_ligy,l.nazev as l_nazev," +
            "o.ID as o_ID,o.nazev as o_nazev,o.adresa,o.mesto,o.web,o.telefon_jednatele,o.email_jednatele," +
            "ok.zkratka as okres_zkratka,ok.nazev as okres_nazev," +
            "k.nazev as kraj_nazev,k.zkratka as kraj_zkratka from Druzstvo d 	" +
            "join Oddil o on o.id = d.ID_oddilu	" +
            "join Okres ok on ok.zkratka = o.okres_zkratka	" +
            "join kraj k on k.zkratka = ok.kraj_zkratka	" +
            "join liga l on l.ID_ligy = d.ID_ligy	" +
        "where d.nazev like '%'+@name+'%'";

        private static string findmembersstring = "select h.ID,h.Prijmeni,h.Jmeno,h.datum_narozeni,h.telefon,h.email from Hrac h " +
        "join hrac_druzstvo hd on hd.ID_hrace = h.ID " +
        "where hd.ID_druzstva = @teamID";

        private static string execpoints = "select dbo.PointCount(@teamID);";
        private static string addplayer = "insert into hrac_druzstvo (ID_hrace,ID_druzstva) values (@playerID,@teamID)";
        private static string removeplayer = "delete from hrac_druzstvo where ID_hrace=@playerID and ID_druzstva=@teamID";

        public static void CommandFill(SqlCommand command,Team team )
        {
            command.Parameters.AddWithValue("@teamID", team.ID);
            command.Parameters.AddWithValue("@name", team.Name);
            command.Parameters.AddWithValue("@season", team.SeasonOfExistence);
            command.Parameters.AddWithValue("@clubID", team.HomeClub.ID);
            command.Parameters.AddWithValue("@leagueID", team.CompetitionClass.ID);



        }
        public static Team Select(int ID)
        {//2.1
            Database db = new Database();
            db.Connect();
            SqlCommand command = db.CreateCommand(singleselectstring);

            command.Parameters.AddWithValue("@teamID", ID);
            SqlDataReader reader = db.Select(command);

            Collection<Team> teams = LoadData(reader);
            Team team = null;
            if (teams.Count == 1)
            {
                team = teams[0];
            }
            reader.Close();
            db.Close();

            if (team == null)
            {
                Console.WriteLine("Function 2.1 team ID search performed,no team with ID {0} found", ID);
            }
            else
            {
                Console.WriteLine("Function 2.1 team ID search performed,found : \n{0}", team);

            }
            return team;

        }
        public static Collection<Team> Select(string name)
        {
            Database db = new Database();
            db.Connect();
            SqlCommand command = db.CreateCommand(selectstring);

            command.Parameters.AddWithValue("@name", name);
            SqlDataReader reader = db.Select(command);

            Collection<Team> teams = LoadData(reader);
            db.Close();
            return teams;
        }
        public static Collection<Team> Select()
        {
            Database db = new Database();
            db.Connect();
            SqlCommand command = db.CreateCommand(fullselectstring);
            
            SqlDataReader reader = db.Select(command);
            Collection<Team> teams = LoadData(reader);
            db.Close();
            return teams; 

        }
        public static int Insert(Team team)
        {//2.2
            Database db = new Database();
            db.Connect();
            SqlCommand command = db.CreateCommand(insertstring);
            CommandFill(command, team);
            int ret = db.ExecuteNonQuery(command);
            db.Close();

            if (ret > 0)
            {
                Console.WriteLine("Function 2.2 team insert performed,inserted following: \n{0} ", team);
            }
            else
            {
                Console.WriteLine("Function 2.2 team insert not performed,insert failed ");

            }
            return ret;

        }
        public static int Delete(Team team)
        {//2.3

            Database db = new Database();
            db.Connect();
            SqlCommand command = db.CreateCommand(deletestring);

            command.Parameters.AddWithValue("@teamID", team.ID);
            int ret = db.ExecuteNonQuery(command);

            db.Close();
            if (ret > 0)
            {
                Console.WriteLine("Function 2.3 team delete  performed,deleted following: \n{0} ", team);
            }
            else
            {
                Console.WriteLine("Function 2.3 team delete not performed,delete failed ");

            }

            return ret;

        }
        public static int Update(Team team)
        {//2.4
            Database db = new Database();
            db.Connect();
            SqlCommand command = db.CreateCommand(updatestring);
            CommandFill(command, team);
            int ret = db.ExecuteNonQuery(command);
            db.Close();
            if (ret > 0)
            {
                Console.WriteLine("Function 2.4 team update  performed,updated following: \n{0} ", team);
            }
            else
            {
                Console.WriteLine("Function 2.4 team update not performed,update failed ");

            }
            return ret;


        }
        public static void Points(Team team)
        {//5.2
            Database db = new Database();
            db.Connect();
            SqlCommand command = db.CreateCommand(execpoints);
            command.Parameters.AddWithValue("@teamID", team.ID);
            int ret = Convert.ToInt32(command.ExecuteScalar());
            db.Close();
            team.Points= ret;


        }
        public static void FindMembers(Team team)
        {
            Database db = new Database();
            db.Connect();
            SqlCommand command = db.CreateCommand(findmembersstring);
            
            command.Parameters.AddWithValue("@teamID", team.ID);
            SqlDataReader reader = db.Select(command);

            team.Members= PlayerOperations.LoadData(reader);


        }
        public static Collection<Team> LoadData(SqlDataReader reader)
        {
            Collection<Team> teams = new Collection<Team>();

            while (reader.Read())
            {

                Region r = new Region();
                r.Code = Convert.ToString(reader["kraj_zkratka"]);
                r.Name = Convert.ToString(reader["kraj_nazev"]);
                District d = new District();
                d.HomeRegion = r;
                d.Code = Convert.ToString(reader["okres_zkratka"]);
                d.Name = Convert.ToString(reader["okres_nazev"]);
                Club c = new Club();
                c.HomeDistrict = d;
                c.ID = Convert.ToInt32(reader["o_ID"]);
                c.Name = Convert.ToString(reader["o_nazev"]);
                c.Web = reader.IsDBNull(reader.GetOrdinal("web")) ? "" : Convert.ToString(reader["web"]);
                c.Address = reader.IsDBNull(reader.GetOrdinal("adresa")) ? "" : Convert.ToString(reader["adresa"]);
                c.City = Convert.ToString(reader["mesto"]);

                League l = new League();
                l.ID = Convert.ToString(reader["ID_ligy"]);
                l.Name = Convert.ToString(reader["l_nazev"]);
                Team t = new Team();
                t.ID = Convert.ToInt32(reader["d_ID"]);
                t.Name = Convert.ToString(reader["d_nazev"]);
                t.CompetitionClass = l;
                t.HomeClub = c;
                t.SeasonOfExistence = Convert.ToString(reader["sezona"]);
                teams.Add(t);




            }
            return teams;
        }
        public static int AddPlayer(Team team,Player player)
        {//2.4a,neboť přidání hráče je úprava nad vazební tabulkou a bude se volat z Družstva
            Database db = new Database();
            db.Connect();
            SqlCommand command = db.CreateCommand(addplayer);
            command.Parameters.AddWithValue("@playerID", player.ID);
            command.Parameters.AddWithValue("@teamID", team.ID);

            int ret = db.ExecuteNonQuery(command);
            db.Close();
            if (ret > 0)
            {
                Console.WriteLine("Function 2.4a addplayer performed,player ID {0} is now member of team {1} ", player.Name + " " +player.Surname,team.Name);
            }
            else
            {
                Console.WriteLine("Function 2.4a addplayer performed,player ID {0} is already member of team {1} ", player.Name + " " + player.Surname, team.Name);

            }
            return ret;

        }
        public static int RemovePlayer(Team team, Player player)
        {//2.4b,neboť odebrání hráče je úprava nad vazební tabulkou a bude se volat z Družstva
            Database db = new Database();
            db.Connect();
            SqlCommand command = db.CreateCommand(removeplayer);
            command.Parameters.AddWithValue("@playerID", player.ID);
            command.Parameters.AddWithValue("@teamID", team.ID);

            int ret = db.ExecuteNonQuery(command);
            db.Close();
            if (ret > 0)
            {
                Console.WriteLine("Function 2.4b removeplayer performed,player ID {0} was removed from team {1} ", player.Name + " " + player.Surname, team.Name);
            }
            else
            {
                Console.WriteLine("Function 2.4b removeplayer performed,player ID {0} is not member of team {1} ", player.Name + " " + player.Surname, team.Name);

            }
            return ret;
        }
    }

}
