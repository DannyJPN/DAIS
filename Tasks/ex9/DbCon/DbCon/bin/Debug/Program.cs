using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DbCon
{
    class Program
    {
       
        static void Main(string[] args)
        {



            SqlConnection con = new SqlConnection();
            con.ConnectionString = @"Server=dbsys.cs.vsb.cz\STUDENT;Database=kru0142;User Id=kru0142;
Password = BEC3Q9uGP3; ";
            con.Open();

            /*  SqlCommand com1 = con.CreateCommand();
              com1.CommandText = "INSERT into Student (login,fname,lname,email,tallness) values ('jan006','Zuzana','Jandová','janz@vsb.cz','206')";


              com1.ExecuteNonQuery();*/
            try
            {
                SqlCommand com2 = con.CreateCommand();
                com2.CommandText = "INSERT into Student (login,fname,lname,email,tallness) values (@login,@fname,@lname,@email,@tallness)";
                com2.Parameters.AddWithValue("login", "TAN457");
                com2.Parameters.AddWithValue("fname", "Tomáš");
                com2.Parameters.AddWithValue("lname", "Tanský");
                com2.Parameters.AddWithValue("email", "tomtan@email.cz");
                com2.Parameters.AddWithValue("tallness", "157");

             
                com2.ExecuteNonQuery();
            }
            catch(Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
           
            
            SqlCommand com3 = con.CreateCommand();
            com3.CommandText = "select fname,lname from student";
            SqlDataReader dataread = com3.ExecuteReader();

            while (dataread.Read())
            {
                Console.WriteLine("{0}\t{1}",dataread["fname"], dataread["lname"]);
               

            }


            con.Close();
        }
    }
}
