using System;
using System.Collections.ObjectModel;
using System.Data.SqlClient;
using RegisterProjectLibrary.DTO;

namespace RegisterProjectLibrary.DAO
{
    public class DistrictOperations
    {
        private static string fullselectstring = "select ok.zkratka as okres_zkratka,ok.nazev as okres_nazev,k.zkratka as kraj_zkratka,k.nazev as kraj_nazev from Okres ok join Kraj k on k.zkratka = ok.kraj_zkratka";
        private static string singleselectstring = "select ok.zkratka as okres_zkratka,ok.nazev as okres_nazev,k.zkratka as kraj_zkratka,k.nazev as kraj_nazev from Okres ok join Kraj k on k.zkratka = ok.kraj_zkratka " +
        "where ok.zkratka = @districtID ";
        public static District Select(string district_code)
        {
            Database db = new Database();
            db.Connect();
            SqlCommand command = db.CreateCommand(singleselectstring);

            command.Parameters.AddWithValue("@districtID", district_code);
            SqlDataReader reader = db.Select(command);

            Collection<District> districts = LoadData(reader);
            District district = null;
            
            if (districts.Count == 1)
            {
                district = districts[0];
            }
            reader.Close();
            db.Close();
            
            return district;
        }
 
        public static Collection<District> Select()
        {
            Database db = new Database();
            db.Connect();
            SqlCommand command = db.CreateCommand(fullselectstring);

      
            SqlDataReader reader = db.Select(command);

            Collection<District> districts = LoadData(reader);
            
            db.Close();
            return districts;
        }
        public static Collection<District> LoadData(SqlDataReader reader)
        {
            Collection<District> districts = new Collection<District>();

            while (reader.Read())
            {
                District d = new District();
                d.Code = Convert.ToString(reader["okres_zkratka"]);
                d.Name = Convert.ToString(reader["okres_nazev"]);
                Region r = new Region();
                r.Code = Convert.ToString(reader["kraj_zkratka"]);
                r.Name = Convert.ToString(reader["kraj_nazev"]);
                d.HomeRegion = r;

                districts.Add(d);




            }
            return districts;
        }

        
    }
}
