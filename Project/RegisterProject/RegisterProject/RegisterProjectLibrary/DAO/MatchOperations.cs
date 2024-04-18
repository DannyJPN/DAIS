using System;
using RegisterProjectLibrary.DTO;
using System.Collections.ObjectModel;
using System.Data.SqlClient;
using System.Collections.Generic;

namespace RegisterProjectLibrary.DAO
{

    public static class MatchOperations
    {


        private static string fullselectstring = "Select z.ID_domaciho_hrace , z.ID_hostujiciho_hrace , z.skore_domaciho , z.skore_hostujiciho , z.datum, z.sezona," +
        "homeh.ID as homeh_ID,homeh.Prijmeni as homeh_prijmeni,homeh.Jmeno as homeh_jmeno,homeh.datum_narozeni as homeh_datum_narozeni,homeh.telefon as homeh_telefon,homeh.email as homeh_email," +
        "hosth.ID as hosth_ID,hosth.Prijmeni as hosth_prijmeni,hosth.Jmeno as hosth_jmeno,hosth.datum_narozeni as hosth_datum_narozeni,hosth.telefon as hosth_telefon,hosth.email as hosth_email," +
        "l.ID_ligy,l.nazev as liga_nazev from Zapas z " +
        "join liga l on z.ID_ligy = l.ID_ligy " +
        "join hrac homeh on homeh.id = z.ID_domaciho_hrace " +
        "join hrac hosth on hosth.id = z.ID_hostujiciho_hrace ";

        private static string insertstring ="insert into Zapas (ID_domaciho_hrace,ID_hostujiciho_hrace,skore_domaciho,skore_hostujiciho,datum,ID_ligy,sezona) values (@homeplayerID,@hostplayerID,@homescore,@hostscore,@date,@league,@season)";
        private static string deletestring = "delete from Zapas where ID_domaciho_hrace = @homeplayerID and ID_hostujiciho_hrace = @hostplayerID and ID_ligy=@league and sezona=@season";
        private static string updatestring = "update Zapas set ID_domaciho_hrace=@homeplayerID,ID_hostujiciho_hrace=@hostplayerID,skore_domaciho=@homescore,skore_hostujiciho=@hostscore,datum=@date,ID_ligy=@league,sezona=@season " +
        " where ID_domaciho_hrace = @homeplayerID and ID_hostujiciho_hrace = @hostplayerID and ID_ligy=@league and sezona=@season";

        private static string selectstring = "Select z.ID_domaciho_hrace , z.ID_hostujiciho_hrace , z.skore_domaciho , z.skore_hostujiciho , z.datum, z.sezona,"+
        "homeh.ID as homeh_ID,homeh.Prijmeni as homeh_prijmeni,homeh.Jmeno as homeh_jmeno,homeh.datum_narozeni as homeh_datum_narozeni,homeh.telefon as homeh_telefon,homeh.email as homeh_email,"+
		"hosth.ID as hosth_ID,hosth.Prijmeni as hosth_prijmeni,hosth.Jmeno as hosth_jmeno,hosth.datum_narozeni as hosth_datum_narozeni,hosth.telefon as hosth_telefon,hosth.email as hosth_email,"+
		"l.ID_ligy,l.nazev as liga_nazev from Zapas z "+
        "join liga l on z.ID_ligy = l.ID_ligy "+
        "join hrac homeh on homeh.id = z.ID_domaciho_hrace "+
        "join hrac hosth on hosth.id = z.ID_hostujiciho_hrace " +    
        "where sezona = @season and " +
"((z.id_domaciho_hrace = @searched_player_ID) or(z.id_hostujiciho_hrace = @searched_player_ID)) and " +
"z.ID_ligy = @league " +
"order by z.datum";






        public static void CommandFill(SqlCommand command,Match match)
        {
            command.Parameters.AddWithValue("@homeplayerID",match.HomePlayer.ID);
            command.Parameters.AddWithValue("@hostplayerID",match.HostPlayer.ID);
            command.Parameters.AddWithValue("@homescore",match.HomePlayerScore);
            command.Parameters.AddWithValue("@hostscore",match.HostPlayerScore);
            command.Parameters.AddWithValue("@date",match.DateOfOccurrence);
            command.Parameters.AddWithValue("@league",match.CompetitionClass.ID);
            command.Parameters.AddWithValue("@season",match.Season);


        }

        public static Collection<Match> Select(int searchedplayerID, string season, string leagueID)
        {//4.1
            Database db = new Database();
            db.Connect();
            SqlCommand command = db.CreateCommand(selectstring);

            command.Parameters.AddWithValue("@searched_player_ID", searchedplayerID);
            command.Parameters.AddWithValue("@season", season);
            command.Parameters.AddWithValue("@league", leagueID);

            SqlDataReader reader = db.Select(command);

            Collection<Match> matches = LoadData(reader);
            db.Close();
          
             Console.WriteLine("Function 4.1 match filter list  performed,{0} matches found ",matches.Count );
                
           
            return matches;

        }
        public static Collection<Match> Select()
        {
            Database db = new Database();
            db.Connect();
            SqlCommand command = db.CreateCommand(fullselectstring);

           

            SqlDataReader reader = db.Select(command);

            Collection<Match> matches = LoadData(reader);
            db.Close();

            return matches;

        }
        public static void AdaptedPrint(int searchedplayerID,Collection<Match> matches)
        {
            foreach (Match match in matches)
            {
                string fullhomeplayername = String.Format("{0} {1}", match.HomePlayer.Surname, match.HomePlayer.Name);
                string fullhostplayername = String.Format("{0} {1}", match.HostPlayer.Surname, match.HostPlayer.Name);
               string output = 
                    String.Format("{0} - {1}\t{2}:{3}\t{4}\t{5}",
                match.HomePlayer.ID == searchedplayerID? fullhomeplayername:fullhostplayername,
                match.HomePlayer.ID == searchedplayerID ? fullhostplayername : fullhomeplayername,
                match.HomePlayer.ID == searchedplayerID ? match.HomePlayerScore: match.HostPlayerScore,
                match.HomePlayer.ID == searchedplayerID ? match.HostPlayerScore: match.HomePlayerScore,
                match.DateOfOccurrence.ToShortDateString(),
                match.CompetitionClass.ID
                );
                Console.WriteLine(output);


            }
        }
        public static List<string[]> AdaptedOutput(int searchedplayerID, Collection<Match> matches)
        {
            List<string[]> matchlist = new List<string[]>();
            foreach (Match match in matches)
            {
                string fullhomeplayername = String.Format("{0} {1}", match.HomePlayer.Surname, match.HomePlayer.Name);
                string fullhostplayername = String.Format("{0} {1}", match.HostPlayer.Surname, match.HostPlayer.Name);
                string[] output = new string[] {
                 match.DateOfOccurrence.ToShortDateString(),
                 match.HomePlayer.ID == searchedplayerID ? fullhomeplayername : fullhostplayername,
                 match.HomePlayer.ID == searchedplayerID ? fullhostplayername : fullhomeplayername,
                 match.CompetitionClass.ID,
                 match.HomePlayer.ID == searchedplayerID ? match.HomePlayerScore.ToString() : match.HostPlayerScore.ToString(),
                 match.HomePlayer.ID == searchedplayerID ? match.HostPlayerScore.ToString() : match.HomePlayerScore.ToString(),
                 match.Season

                 };
                matchlist.Add(output);


            }
            return matchlist;
        }


        public static int Insert(Match match)
        {//4.2
            Database db = new Database();
            db.Connect();
            SqlCommand command = db.CreateCommand(insertstring);
            CommandFill(command, match);
            int ret = db.ExecuteNonQuery(command);
            db.Close();
            if (ret > 0)
            {
                Console.WriteLine("Function 4.2 match insert performed,inserted following: \n{0} ", match);
            }
            else
            {
                Console.WriteLine("Function 4.2 match insert not performed,insert failed ");

            }
            return ret;

        }
        public static int Delete(Match match)
        {//4.4

            Database db = new Database();
            db.Connect();
            SqlCommand command = db.CreateCommand(deletestring);

            command.Parameters.AddWithValue("@homeplayerID", match.HomePlayer.ID);
            command.Parameters.AddWithValue("@hostplayerID", match.HostPlayer.ID);
            command.Parameters.AddWithValue("@league", match.CompetitionClass.ID);
            command.Parameters.AddWithValue("@season", match.Season);

            int ret = db.ExecuteNonQuery(command);

            db.Close();

            if (ret > 0)
            {
                Console.WriteLine("Function 4.4 match delete performed,deleted following: \n{0} ", match);
            }
            else
            {
                Console.WriteLine("Function 4.4 match delete not performed,insert failed ");

            }
            return ret;

        }
        public static int Update(Match match)
        {//4.3
            Database db = new Database();
            db.Connect();
            SqlCommand command = db.CreateCommand(updatestring);
            CommandFill(command, match);
            int ret = db.ExecuteNonQuery(command);
            db.Close();
            if (ret > 0)
            {
                Console.WriteLine("Function 4.3 match update performed,inserted following: \n{0} ", match);
            }
            else
            {
                Console.WriteLine("Function 4.3 match update not performed,insert failed ");

            }
            return ret;


        }
        public static Collection<Match> LoadData(SqlDataReader reader)
        {
            Collection<Match> matches = new Collection<Match>();

            while (reader.Read())
            {
                Player home = new Player();
                Player host = new Player();
                League league = new League();

                home.ID = Convert.ToInt32(reader["homeh_ID"]);
                home.Name = Convert.ToString(reader["homeh_jmeno"]);
                home.Surname = Convert.ToString(reader["homeh_prijmeni"]);
                home.Birthdate = Convert.ToDateTime(reader["homeh_datum_narozeni"]);
                home.Phonenumber = reader.IsDBNull(reader.GetOrdinal("homeh_telefon")) ? null : (int?)(Convert.ToInt32(reader["homeh_telefon"]));
                home.Email = reader.IsDBNull(reader.GetOrdinal("homeh_email")) ? null : Convert.ToString(reader["homeh_email"]);

                host.ID = Convert.ToInt32(reader["hosth_ID"]);
                host.Name = Convert.ToString(reader["hosth_jmeno"]);
                host.Surname = Convert.ToString(reader["hosth_prijmeni"]);
                host.Birthdate = Convert.ToDateTime(reader["hosth_datum_narozeni"]);
                host.Phonenumber = reader.IsDBNull(reader.GetOrdinal("hosth_telefon")) ? null : (int?)(Convert.ToInt32(reader["hosth_telefon"]));
                host.Email = reader.IsDBNull(reader.GetOrdinal("hosth_email")) ? null : Convert.ToString(reader["hosth_email"]);

                league.ID = Convert.ToString(reader["ID_ligy"]);
                league.Name = Convert.ToString(reader["liga_nazev"]);

                Match m = new Match();
                m.HomePlayer = home;
                m.HostPlayer = host;
               
                m.HomePlayerScore = Convert.ToInt32(reader["skore_domaciho"]);
                m.HostPlayerScore = Convert.ToInt32(reader["skore_hostujiciho"]);
                m.Season = Convert.ToString(reader["sezona"]);
                m.CompetitionClass = league;
                m.DateOfOccurrence = Convert.ToDateTime(reader["datum"]);

                matches.Add(m);




            }
            return matches;

        }



    }


}
