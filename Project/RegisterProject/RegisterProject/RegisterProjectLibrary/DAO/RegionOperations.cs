using System;
using System.Collections.ObjectModel;
using System.Data.SqlClient;
using RegisterProjectLibrary.DTO;

namespace RegisterProjectLibrary.DAO
{
    public class RegionOperations
    {

        private static string fullselectstring = "select k.zkratka,k.nazev from Kraj k";
        private static string singleselectstring = "select k.zkratka,k.nazev from Kraj k " +
        "where k.zkratka = @regionID ";
        public static Region Select(string region_code)
        {
            Database db = new Database();
            db.Connect();
            SqlCommand command = db.CreateCommand(singleselectstring);

            command.Parameters.AddWithValue("@regionID", region_code);
            SqlDataReader reader = db.Select(command);

            Collection<Region> regions = LoadData(reader);
            Region region = null;
            if (regions.Count == 1)
            {
                region = regions[0];
            }
            reader.Close();
            db.Close();
            return region;
        }
        public static Collection<Region> Select()
        {
            Database db = new Database();
            db.Connect();
            SqlCommand command = db.CreateCommand(fullselectstring);

          
            SqlDataReader reader = db.Select(command);

            Collection<Region> regions = LoadData(reader);
            db.Close();
            return regions;
           
           
        }

        private static Collection<Region> LoadData(SqlDataReader reader)
        {
            Collection<Region> regions = new Collection<Region>();

            while (reader.Read())
            {
                Region r = new Region();
                r.Code = Convert.ToString(reader["zkratka"]);
                r.Name = Convert.ToString(reader["nazev"]);
                

                regions.Add(r);




            }
            return regions;
        }
    }
}
