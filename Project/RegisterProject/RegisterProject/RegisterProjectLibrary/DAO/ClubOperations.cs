using RegisterProjectLibrary.DTO;
using System;
using System.Collections.ObjectModel;
using System.Data.SqlClient;

namespace RegisterProjectLibrary.DAO
{

    public static class ClubOperations
    {
        private static string fullselectstring = "select o.ID,o.nazev,o.adresa,o.mesto,o.web,o.okres_zkratka,o.telefon_jednatele,o.email_jednatele,ok.nazev as okres_nazev,k.nazev as kraj_nazev,k.zkratka as kraj_zkratka from Oddil o " +
        "join Okres ok on ok.zkratka = o.okres_zkratka "+
        "join kraj k on k.zkratka = ok.kraj_zkratka "; 
        private static string singleselectstring = "select o.ID,o.nazev,o.adresa,o.mesto,o.web,o.okres_zkratka,o.telefon_jednatele,o.email_jednatele,ok.nazev as okres_nazev,k.nazev as kraj_nazev,k.zkratka as kraj_zkratka from Oddil o " +
        "join Okres ok on ok.zkratka = o.okres_zkratka " +
        "join kraj k on k.zkratka = ok.kraj_zkratka "+ 
            "where o.ID = @clubID";

        private static string insertstring ="insert into Oddil (nazev,adresa,mesto,web,okres_zkratka,telefon_jednatele,email_jednatele) values (@name,@address,@city,@web,@district_abbreviation,@manager_phone,@manager_email)";
        private static string deletestring = "delete from Oddil where id = @clubID";
        private static string updatestring = "update Oddil set nazev=@name,adresa=@address,mesto=@city,web=@web,okres_zkratka=@district_abbreviation,telefon_jednatele=@manager_phone,email_jednatele=@manager_email where ID = @clubID";

        private static string selectstring = "select o.ID,o.nazev,o.adresa,o.mesto,o.web,o.okres_zkratka,o.telefon_jednatele,o.email_jednatele,ok.nazev as okres_nazev,k.nazev as kraj_nazev,k.zkratka as kraj_zkratka from Oddil o " +
        "join Okres ok on ok.zkratka = o.okres_zkratka " +
        "join kraj k on k.zkratka = ok.kraj_zkratka " +
            "where o.nazev like '%'+@name+'%'";

        private static string findteamsstring = "select d.ID as d_ID,d.nazev as d_nazev,d.sezona," +
            "l.ID_ligy,l.nazev as l_nazev," +
            "o.ID as o_ID,o.nazev as o_nazev,o.adresa,o.mesto,o.web,o.telefon_jednatele,o.email_jednatele," +
            "ok.zkratka as okres_zkratka,ok.nazev as okres_nazev," +
            "k.nazev as kraj_nazev,k.zkratka as kraj_zkratka from Druzstvo d 	" +
            "join Oddil o on o.id = d.ID_oddilu	" +
            "join Okres ok on ok.zkratka = o.okres_zkratka	" +
            "join kraj k on k.zkratka = ok.kraj_zkratka	" +
            "join liga l on l.ID_ligy = d.ID_ligy	" +
            "where d.ID_oddilu = @clubID and d.sezona=@season";
    



  public static void CommandFill(SqlCommand command,Club club)
        {
            command.Parameters.AddWithValue("@clubID", club.ID);
            command.Parameters.AddWithValue("@name", club.Name);
            command.Parameters.AddWithValue("@address", club.Address == "" ? DBNull.Value : (object)club.Address);
            command.Parameters.AddWithValue("@city", club.City);
            command.Parameters.AddWithValue("@district_abbreviation", club.HomeDistrict.Code);
            command.Parameters.AddWithValue("@manager_phone", club.ManagerPhoneNumber == null ? DBNull.Value : (object)club.ManagerPhoneNumber);
            command.Parameters.AddWithValue("@manager_email", club.ManagerEmail == "" ? DBNull.Value : (object)club.ManagerEmail);
            command.Parameters.AddWithValue("@web", club.Web == "" ? DBNull.Value : (object)club.Web);


        }
        public static Club Select(int ID)
        {//3.1
            Database db = new Database();
            db.Connect();
            SqlCommand command = db.CreateCommand(singleselectstring);
            command.Parameters.AddWithValue("@clubID", ID);
            SqlDataReader reader = db.Select(command);
            Collection<Club> clubs = LoadData(reader);
            Club club = null;
            if (clubs.Count == 1)
            {
                club = clubs[0];
            }
            reader.Close();
            db.Close();
            if (club == null)
            {
                Console.WriteLine("Function 3.1 club ID search performed,no club with ID {0} found", ID);
            }
            else
            {
                Console.WriteLine("Function 3.1 club ID search performed,found : \n{0}", club);

            }
            return club;



        }
        public static Collection<Club> Select(string name)
        {
            Database db = new Database();
            db.Connect();
            SqlCommand command = db.CreateCommand(selectstring);

            command.Parameters.AddWithValue("@name", name);
            SqlDataReader reader = db.Select(command);

            Collection<Club> clubs = LoadData(reader);
            db.Close();
            return clubs;

        }
        public static Collection<Club> Select()
        {
            Database db = new Database();
            db.Connect();
            SqlCommand command = db.CreateCommand(fullselectstring);

          
            SqlDataReader reader = db.Select(command);

            Collection<Club> clubs= LoadData(reader);
            db.Close();
            return clubs;

        }
        public static int Insert(Club club)
        {//3.3
            Database db = new Database();
            db.Connect();
            SqlCommand command = db.CreateCommand(insertstring);
            CommandFill(command, club);
            int ret = db.ExecuteNonQuery(command);
            db.Close();
            if (ret > 0)
            {
                Console.WriteLine("Function 3.3 club insert performed,inserted following: \n{0} ", club);
            }
            else
            {
                Console.WriteLine("Function 3.3 club insert not performed,insert failed ");

            }
            return ret;

        }
        public static int Delete(Club club)
        {//3.2

            Database db = new Database();
            db.Connect();
            SqlCommand command = db.CreateCommand(deletestring);

            command.Parameters.AddWithValue("@clubID", club.ID);
            int ret = db.ExecuteNonQuery(command);

            db.Close();
            if (ret > 0)
            {
                Console.WriteLine("Function 3.2 club delete  performed,deleted following: \n{0} ", club);
            }
            else
            {
                Console.WriteLine("Function 3.2 club delete not performed,delete failed ");

            }
            return ret;

        }
        public static int Update(Club club)
        {//3.4
            Database db = new Database();
            db.Connect();
            SqlCommand command = db.CreateCommand(updatestring);
            CommandFill(command, club);
            int ret = db.ExecuteNonQuery(command);
            db.Close();
            if (ret > 0)
            {
                Console.WriteLine("Function 2.4 club update  performed,updated following: \n{0} ", club);
            }
            else
            {
                Console.WriteLine("Function 2.4 club update not performed,update failed ");

            }
            return ret;


        }
        public static void FindTeams(Club club, string season)
        {
            Database db = new Database();
            db.Connect();
            SqlCommand command = db.CreateCommand(findteamsstring);

            command.Parameters.AddWithValue("@clubID", club.ID);
            command.Parameters.AddWithValue("@season", season);

            SqlDataReader reader = db.Select(command);

            club.Teams= TeamOperations.LoadData(reader);



        }
        public static void FindMembers(Club club, string season)
        {
            FindTeams(club, season);
            Collection < Player > members = new Collection<Player>();
            foreach(Team team in club.Teams)
            {
                TeamOperations.FindMembers(team);

                foreach (Player member in team.Members)
                {
                    if (!members.Contains(member))
                    {
                        members.Add(member);

                    }

                }



            }

            club.Members= members;
        }

        public static Collection<Club> LoadData(SqlDataReader reader)
        {
            Collection<Club> clubs = new Collection<Club>();

            while (reader.Read())
            {
                Club c = new Club();
                c.ID = Convert.ToInt32(reader["ID"]);
                c.Name = Convert.ToString(reader["nazev"]);
                c.Web = reader.IsDBNull(reader.GetOrdinal("web")) ? "" : Convert.ToString(reader["web"]);
                c.Address = reader.IsDBNull(reader.GetOrdinal("adresa")) ? "": Convert.ToString(reader["adresa"]);
                c.City = reader.IsDBNull(reader.GetOrdinal("mesto"))?"": Convert.ToString(reader["mesto"]);
                District homedistrict = new District();
                Region homeregion = new Region();
                homeregion.Code = Convert.ToString(reader["kraj_zkratka"]);
                homeregion.Name = Convert.ToString(reader["kraj_nazev"]);
                homedistrict.HomeRegion = homeregion;
                homedistrict.Code = Convert.ToString(reader["okres_zkratka"]);
                homedistrict.Name = Convert.ToString(reader["okres_nazev"]);
                c.HomeDistrict = homedistrict;
                c.ManagerPhoneNumber = reader.IsDBNull(reader.GetOrdinal("telefon_jednatele")) ? null : (int?)(Convert.ToInt32(reader["telefon_jednatele"]));
                c.ManagerEmail = reader.IsDBNull(reader.GetOrdinal("email_jednatele")) ? "" : Convert.ToString(reader["email_jednatele"]);

                clubs.Add(c);




            }
            return clubs;
        }


    }
}
