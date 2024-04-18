using System;
using AuctionSystem.ORM;
using AuctionSystem.ORM.DAO.Sqls;

namespace AuctionSystem
{
    class Program
    {
        static void Main(string[] args)
        {
            Database db = new Database();
            db.Connect();

            User u = new User();
            u.Login = "son28";
            u.Name = "Tonda";
            u.Surname = "Sobota";
            u.Address = "Fialová 8, Ostrava, 70833";
            u.Telephone = "420596784213";
            u.MaximumUnfinisfedAuctions = 0;
            u.LastVisit = null;
            u.Type = "U";

            UserTable.Insert(u, db);

            int count1 = UserTable.Select(db).Count;
            int dltCount = UserTable.Delete(7, db);
            int count2 = UserTable.Select(db).Count;

            Console.WriteLine("#C: " + count1);
            Console.WriteLine("#D: " + dltCount);
            Console.WriteLine("#C: " + count2);

            db.Close();
        }
    }
}
