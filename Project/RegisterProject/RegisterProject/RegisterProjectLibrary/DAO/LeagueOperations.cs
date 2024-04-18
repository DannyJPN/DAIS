using System;
using System.Collections.ObjectModel;
using System.Data.SqlClient;
using RegisterProjectLibrary.DTO;

namespace RegisterProjectLibrary.DAO
{
    public class LeagueOperations
    {
        private static string fullselectstring = "select l.ID_ligy,l.nazev from Liga l";
        private static string singleselectstring = "select l.ID_ligy,l.nazev from Liga l " +
        "where l.ID_ligy = @leagueID ";
               
        public static League Select(string ID)
        {
            Database db = new Database();
            db.Connect();
            SqlCommand command = db.CreateCommand(singleselectstring);

            command.Parameters.AddWithValue("@leagueID", ID);
            SqlDataReader reader = db.Select(command);

            Collection<League> leagues = LoadData(reader);
            League league = null;
            if (leagues.Count == 1)
            {
                league = leagues[0];
            }
            reader.Close();
            db.Close();
            return league;

        }
        public static Collection<League> Select()
        {
            Database db = new Database();
            db.Connect();
            SqlCommand command = db.CreateCommand(fullselectstring);

     
            SqlDataReader reader = db.Select(command);

            Collection<League> leagues = LoadData(reader);
            
            db.Close();
            return leagues;

        }


        public static Collection<League> LoadData(SqlDataReader reader)
        {
            Collection<League> leagues = new Collection<League>();

            while (reader.Read())
            {
                League l = new League();
                l.ID = Convert.ToString(reader["ID_ligy"]);
                l.Name = Convert.ToString(reader["nazev"]);
                

                leagues.Add(l);




            }
            return leagues;
        }
    }
}
