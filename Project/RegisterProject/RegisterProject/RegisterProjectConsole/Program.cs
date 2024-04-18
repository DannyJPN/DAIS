using RegisterProjectLibrary.DAO;
using RegisterProjectLibrary.DTO;
using System;
using System.Collections.ObjectModel;
using System.Data.SqlClient;
using System.Linq;

namespace RegisterProjectConsole
{
    class Program
    {
        static void Main(string[] args)
        {
            //DataTable dataTable = new DataTable();
            //dataTable.Load(command.ExecuteReader(System.Data.CommandBehavior.SchemaOnly));

            Console.WriteLine("\n______________________________\n");
            Console.WriteLine("Init state");
            Console.WriteLine("Players count:\t{0}", PlayerOperations.Select().Count);
            Console.WriteLine("Team count:\t{0}", TeamOperations.Select().Count);
            Console.WriteLine("Club count:\t{0}", ClubOperations.Select().Count);
            Console.WriteLine("Match count:\t{0}", MatchOperations.Select().Count);
            
            
            Console.WriteLine("Creating");
            Player p = new Player();
            p.Name = "Wang";
            p.Surname = "Yi";
            p.Birthdate = new DateTime(1975,8,9);
            p.Phonenumber = new Random(DateTime.Now.Millisecond).Next(100000000,999999999);
            
            try
            {PlayerOperations.Insert(p); }
            catch (SqlException sqlex)
            {
                Console.WriteLine("Player sqlex No.{0}\nMessage: {1}" ,sqlex.Number,sqlex.Message);
            }

            Console.WriteLine("\n______________________________\n");
            Team t = new Team();
            t.Name = "TTC Ostrava 2016 D";
            t.SeasonOfExistence = "2018/2019";
            t.CompetitionClass = LeagueOperations.Select("OS5");
            t.HomeClub = ClubOperations.Select(69);
            
            try
            { TeamOperations.Insert(t);}
            catch (SqlException sqlex)
            {
                Console.WriteLine("Team sqlex No.{0}\nMessage: {1}", sqlex.Number, sqlex.Message);
            }


            Console.WriteLine("\n______________________________\n");
            Club c = new Club();
            c.Name = "PingPong club Ostrava";
            c.ManagerEmail = "pingpongostrava@seznam.cz";
            c.HomeDistrict = DistrictOperations.Select("OV");
            c.City = "Ostrava";
            
            try
            {ClubOperations.Insert(c); }
            catch (SqlException sqlex)
            {
                Console.WriteLine("Club sqlex No.{0}\nMessage: {1}", sqlex.Number, sqlex.Message);
            }

            Console.WriteLine("\n______________________________\n");
            Match m = new Match();
            m.HomePlayer = PlayerOperations.Select(4);
            m.HostPlayer = PlayerOperations.Select(10);
            m.CompetitionClass = LeagueOperations.Select("OS5");
            m.DateOfOccurrence = new DateTime(2019,3,3);
            m.HomePlayerScore = 3;
            m.HostPlayerScore = 2;
            m.Season = "2018/2019";
            
            try
            { MatchOperations.Insert(m);}
            catch (SqlException sqlex)
            {
                Console.WriteLine("Match sqlex No.{0}\nMessage: {1}", sqlex.Number, sqlex.Message);
            }

            Console.WriteLine("\n______________________________\n");
            Console.WriteLine("State after creation:");
            Console.WriteLine("Players count:\t{0}", PlayerOperations.Select().Count);
            Console.WriteLine("Team count:\t{0}", TeamOperations.Select().Count);
            Console.WriteLine("Club count:\t{0}", ClubOperations.Select().Count);
            Console.WriteLine("Match count:\t{0}", MatchOperations.Select().Count);

            Console.WriteLine("\n______________________________\n");
            Team loadteam = TeamOperations.Select(42);
            Console.WriteLine(loadteam);

            Console.WriteLine("\n______________________________\n");
            Collection<Match> one_player_matches = MatchOperations.Select(10,"2018/2019","OS5");
            Console.WriteLine("matches count: "+one_player_matches.Count);
            Console.WriteLine("Adapted output: ");
            MatchOperations.AdaptedPrint(10, one_player_matches);
            Console.WriteLine("Raw output:");
            foreach (Match one_m in one_player_matches)
            {
                Console.WriteLine(one_m);
            }

            Console.WriteLine("\n______________________________\n");
            Collection<Player> ladies_with_s = PlayerOperations.Select("ová","S");
            foreach (Player pl in ladies_with_s)
            {
                Console.WriteLine(pl);
            }


            Console.WriteLine("\n______________________________\n");
            Player player_to_update = PlayerOperations.Select(6);


            try
            {
                player_to_update.Phonenumber = new Random(DateTime.Now.Millisecond).Next(100000000, 999999999);
                PlayerOperations.Update(player_to_update);
            }
            catch (SqlException sqlex)
            {
                Console.WriteLine("Player sqlex No.{0}\nMessage: {1}", sqlex.Number, sqlex.Message);
            }
            catch (NullReferenceException)
            {
                Console.WriteLine("Player No.{0} nonexistent", player_to_update.ID);
            }

            Console.WriteLine("\n______________________________\n");
            Team team_to_update = TeamOperations.Select(6);
            
           
            try
            {
                string league_id = String.Format("{0}L", new Random(DateTime.Now.Millisecond).Next(1,3));
                team_to_update.CompetitionClass = LeagueOperations.Select(league_id);
                TeamOperations.Update(team_to_update);
            }
            catch (SqlException sqlex)
            {
                Console.WriteLine("Team sqlex No.{0}\nMessage: {1}", sqlex.Number, sqlex.Message);
            }
            catch (NullReferenceException)
            {
                Console.WriteLine("Team No.{0} nonexistent", team_to_update.ID);
            }

            Console.WriteLine("\n______________________________\n");
            try
            { TeamOperations.AddPlayer(team_to_update, player_to_update); }
            catch (SqlException sqlex)
            {
                Console.WriteLine("Team Adding player sqlex No.{0}\nMessage: {1}", sqlex.Number, sqlex.Message);
            }
            catch (NullReferenceException)
            {
                Console.WriteLine("Team No.{0} nonexistent or player No.{1}", team_to_update.ID,player_to_update.ID);
            }

            Console.WriteLine("\n______________________________\n");
            Club club_to_update = ClubOperations.Select(6);
            
            
            try
            {
                club_to_update.Address = " Nová " + (new Random(DateTime.Now.Millisecond).Next(20)).ToString();
                ClubOperations.Update(club_to_update);
            }
            catch (SqlException sqlex)
            {
                Console.WriteLine("Club sqlex No.{0}\nMessage: {1}", sqlex.Number, sqlex.Message);
            }
            catch (NullReferenceException)
            {
                Console.WriteLine("Club No.{0} nonexistent ", club_to_update.ID);
            }


            Console.WriteLine("\n______________________________\n");
            int index = 0;
            Match match_to_update = null;
            try
            {
                if (one_player_matches.Count > index)
                {
                    match_to_update = one_player_matches[index];
                }
                match_to_update.HomePlayerScore = match_to_update.HomePlayerScore == 3?1:3;
                match_to_update.HostPlayerScore = match_to_update.HostPlayerScore == 3 ? 1 : 3;
                MatchOperations.Update(match_to_update);
            }
            catch (SqlException sqlex)
            {
                Console.WriteLine("Match sqlex No.{0}\nMessage: {1}", sqlex.Number, sqlex.Message);
            }
            catch (NullReferenceException)
            {
                Console.WriteLine("Match nonexistent ");
            }


            Console.WriteLine("\n______________________________\n");

            Console.WriteLine("State after updating:");
            Console.WriteLine("Players count:\t{0}", PlayerOperations.Select().Count);
            Console.WriteLine("Team count:\t{0}", TeamOperations.Select().Count);
            Console.WriteLine("Club count:\t{0}", ClubOperations.Select().Count);
            Console.WriteLine("Match count:\t{0}", MatchOperations.Select().Count);

            Console.WriteLine("\n______________________________\n");
            Match match_to_delete = MatchOperations.Select().Last();
            MatchOperations.Delete(match_to_delete);


            Console.WriteLine("\n______________________________\n");
            TeamOperations.RemovePlayer(TeamOperations.Select().Last(), PlayerOperations.Select().Last());

            Console.WriteLine("\n______________________________\n");
            Team team_to_delete = TeamOperations.Select().Last();
            TeamOperations.Delete(team_to_delete);

            Console.WriteLine("\n______________________________\n");
            Player player_to_delete = PlayerOperations.Select().Last();
            PlayerOperations.Delete(player_to_delete);

            Console.WriteLine("\n______________________________\n");
            Club club_to_delete = ClubOperations.Select().Last();
            ClubOperations.Delete(club_to_delete);

            Console.WriteLine("\n______________________________\n");






            Console.WriteLine("State after deletion:");
            Console.WriteLine("Players count:\t{0}", PlayerOperations.Select().Count);
            Console.WriteLine("Team count:\t{0}", TeamOperations.Select().Count);
            Console.WriteLine("Club count:\t{0}", ClubOperations.Select().Count);
            Console.WriteLine("Match count:\t{0}", MatchOperations.Select().Count);

            Player bilanceplayer = PlayerOperations.Select(10);
            Team pointteam = TeamOperations.Select(63);
            Console.WriteLine("\n______________________________\n");
            PlayerOperations.Bilance(bilanceplayer, "2018/2019", "OS5");
            Console.WriteLine("Bilance of player ID {0} is {1}%",bilanceplayer.ID,bilanceplayer.Bilance);
            TeamOperations.Points(pointteam);
            Console.WriteLine("Points of team ID {0} = {1}", pointteam.ID, pointteam.Points);

            Console.WriteLine("END");
        }
    }
}
