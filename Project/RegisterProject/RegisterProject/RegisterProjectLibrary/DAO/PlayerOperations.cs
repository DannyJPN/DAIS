using RegisterProjectLibrary.DTO;
using System;
using System.Collections.ObjectModel;
using System.Data.SqlClient;

namespace RegisterProjectLibrary.DAO
{
    public static class PlayerOperations
    {

        private static string fullselectstring = "select h.ID,h.Prijmeni,h.Jmeno,h.datum_narozeni,h.telefon,h.email from Hrac h ";
        private static string singleselectstring = "select h.ID,h.Prijmeni,h.Jmeno,h.datum_narozeni,h.telefon,h.email from Hrac h " +
        "where h.ID = @playerID ";


        private static string insertstring = "insert into Hrac (Prijmeni,jmeno,datum_narozeni,telefon,email) values (@surname,@name,@birthdate,@phone,@mail)";
        private static string deletestring = "delete from Hrac where id = @playerID";
        private static string updatestring = "update Hrac set prijmeni = @surname,jmeno=@name,datum_narozeni=@birthdate,telefon=@phone,email=@mail where ID = @playerID";

        private static string selectstring = "select h.ID,h.Prijmeni,h.Jmeno,h.datum_narozeni,h.telefon,h.email from Hrac h " +
        "where h.prijmeni  like '%'+@surname +'%' and  h.jmeno  like '%'+@name +'%'";

        private static string findteamsstring = "select d.ID as d_ID,d.nazev as d_nazev,d.sezona," +
            "l.ID_ligy,l.nazev as l_nazev," +
            "o.ID as o_ID,o.nazev as o_nazev,o.adresa,o.mesto,o.web,o.telefon_jednatele,o.email_jednatele," +
            "ok.zkratka as okres_zkratka,ok.nazev as okres_nazev," +
            "k.nazev as kraj_nazev,k.zkratka as kraj_zkratka from Druzstvo d 	" +
            "join Oddil o on o.id = d.ID_oddilu	" +
            "join Okres ok on ok.zkratka = o.okres_zkratka	" +
            "join kraj k on k.zkratka = ok.kraj_zkratka	" +
            "join liga l on l.ID_ligy = d.ID_ligy	" +
    "join hrac_druzstvo hd on hd.ID_druzstva = d.ID " +

    "where d.sezona = @season and hd.ID_hrace = @playerID" ;

        private static string findclubstring = "select o.ID,o.nazev,o.adresa,o.mesto,o.web,o.okres_zkratka,o.telefon_jednatele,o.email_jednatele,ok.nazev as okres_nazev,k.nazev as kraj_nazev,k.zkratka as kraj_zkratka from Oddil o " +
        "join Okres ok on ok.zkratka = o.okres_zkratka " +
        "join kraj k on k.zkratka = ok.kraj_zkratka " + 
       "where o.ID in (  select d.ID_oddilu from Druzstvo d join hrac_druzstvo hd on hd.ID_druzstva = d.ID  where d.sezona = @season and hd.ID_hrace = @playerID  )";

        private static string execbilance = "select dbo.Bilance( @season,@playerID,@leagueID);";

        public static void CommandFill(SqlCommand command,Player player )
        {
            command.Parameters.AddWithValue("@playerID", player.ID);
            command.Parameters.AddWithValue("@surname", player.Surname);
            command.Parameters.AddWithValue("@name", player.Name);
            command.Parameters.AddWithValue("@birthdate", player.Birthdate);
            command.Parameters.AddWithValue("@phone", player.Phonenumber == null?DBNull.Value:(object)player.Phonenumber);
            command.Parameters.AddWithValue("@mail", player.Email == "" ? DBNull.Value : (object)player.Email);


        }

        public static Player Select(int ID)
        {//1.1
            Database db = new Database();
            db.Connect();
            SqlCommand command = db.CreateCommand(singleselectstring);

            command.Parameters.AddWithValue("@playerID", ID);
            SqlDataReader reader = db.Select(command);

            Collection<Player> players = LoadData(reader);
            Player player = null;
            if (players.Count == 1)
            {
                player = players[0];
            }
            reader.Close();
            db.Close();
            if (player == null)
            {
                Console.WriteLine("Function 1.1 player ID search performed,no player with ID {0} found",ID);
            }
            else
            {
                Console.WriteLine("Function 1.1 player ID search performed,found : \n{0}",player);

            }


            return player;


        }
        public static Collection<Player> Select(string surname, string name)
        {//1.5
            Database db = new Database();
            db.Connect();
            SqlCommand command = db.CreateCommand(selectstring);

            command.Parameters.AddWithValue("@surname", surname);
            command.Parameters.AddWithValue("@name", name);

            SqlDataReader reader = db.Select(command);

            Collection<Player> players = LoadData(reader);
            db.Close();
            if (players.Count > 0)
            {
                Console.WriteLine("Function 1.5 player namesearch performed,found following for expressions \"{0}\" \"{1}\": ",name,surname);
                foreach (Player p in players)
                {
                    Console.WriteLine("{0}.\t {1}\t{2}",p.ID,p.Name,p.Surname);

                }

            }
            else
            {
                Console.WriteLine("Function 1.5 player namesearch performed,no match found");

            }

            return players;

        }
        public static Collection<Player> Select()
        {
            Database db = new Database();
            db.Connect();
            SqlCommand command = db.CreateCommand(fullselectstring);


            SqlDataReader reader = db.Select(command);

            Collection<Player>players= LoadData(reader);
            db.Close();
            return players;
        }

        public static int Insert(Player player)
        {//1.2
            Database db = new Database();
            db.Connect();
            SqlCommand command = db.CreateCommand(insertstring);
            CommandFill(command, player);
            int ret = db.ExecuteNonQuery(command);
            db.Close();

            
            if (ret > 0)
            {
                Console.WriteLine("Function 1.2 player insert performed,inserted following: \n{0} ", player);
            }
            else
            {
                Console.WriteLine("Function 1.2 player insert not performed,insert failed ");

            }
            return ret;

        }
        public static int Delete(Player player)
        {//1.4

            Database db = new Database();
            db.Connect();
            SqlCommand command = db.CreateCommand(deletestring);

            command.Parameters.AddWithValue("@playerID", player.ID);
            int ret = db.ExecuteNonQuery(command);

            db.Close();
            
            if (ret > 0)
            {
                Console.WriteLine("Function 1.4 player delete  performed,deleted following: \n{0} ", player);
            }
            else
            {
                Console.WriteLine("Function 1.4 player delete not performed,delete failed ");

            }
            return ret;

        }
        public static int Update(Player player)
        {//1.3
            Database db = new Database();
            db.Connect();
            SqlCommand command = db.CreateCommand(updatestring);
            CommandFill(command, player);
            int ret = db.ExecuteNonQuery(command);
            db.Close();
           
            if (ret > 0)
            {
                Console.WriteLine("Function 1.3 player update  performed,updated following: \n{0} ", player);
            }
            else
            {
                Console.WriteLine("Function 1.3 player update not performed,update failed ");

            }

            return ret;


        }
        public static void Bilance(Player player,string season,string leagueID)
        {//5.1
            Database db = new Database();
            db.Connect();
            SqlCommand command = db.CreateCommand(execbilance);
            command.Parameters.AddWithValue("@playerID", player.ID);
            command.Parameters.AddWithValue("@season", season);
            command.Parameters.AddWithValue("@leagueID", leagueID);

            double ret = Math.Round(Convert.ToDouble(command.ExecuteScalar()),2);
            db.Close();
            player.Bilance= ret;

        }

        public static void FindTeams(Player player, string season)
        {
            Database db = new Database();
            db.Connect();
            SqlCommand command = db.CreateCommand(findteamsstring);

            command.Parameters.AddWithValue("@season", season);
            command.Parameters.AddWithValue("@playerID", player.ID);

            SqlDataReader reader = db.Select(command);

            player.Teams= TeamOperations.LoadData(reader);


        }
        public static void FindClub(Player player, string season)
        {
            Database db = new Database();
            db.Connect();
            SqlCommand command = db.CreateCommand(findclubstring);

            command.Parameters.AddWithValue("@season", season);
            command.Parameters.AddWithValue("@playerID", player.ID);

            SqlDataReader reader = db.Select(command);
            Collection<Club> clubs = ClubOperations.LoadData(reader);
            Club club = null;
            if (clubs.Count == 1)
            {
                club = clubs[0];
            }
            reader.Close();
            db.Close();
            player.HomeClub=club;
            
        }

        public static Collection<Player> LoadData(SqlDataReader reader)
        {
            Collection<Player> players = new Collection<Player>();

            while (reader.Read())
            {
                Player p = new Player();
                p.ID = Convert.ToInt32(reader["ID"]);
                p.Name = Convert.ToString(reader["jmeno"]);
                p.Surname = Convert.ToString(reader["prijmeni"]);
                p.Birthdate = Convert.ToDateTime(reader["datum_narozeni"]);
          
                p.Phonenumber = reader.IsDBNull(reader.GetOrdinal("telefon")) ? null : (int?)(Convert.ToInt32(reader["telefon"]) );
                p.Email = reader.IsDBNull(reader.GetOrdinal("email")) ? null : Convert.ToString(reader["email"]);
                
                players.Add(p);




            }
            return players;

        }

    }

}
