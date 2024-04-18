using System;
using AuctionSystem.ORM;
using AuctionSystem.ORM.Proxy;
using AuctionSystem.ORM.Mssql;

namespace AuctionSystem
{
    class Program
    {
        static void Main(string[] args)
        {
            DatabaseProxy db = new Database();
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

            UserTableProxy.Insert(u, db);

            int count = UserTableProxy.Select(db).Count;

            Console.WriteLine("#C: " + count);

            UserTableProxy.Delete(5, db);

            count = UserTableProxy.Select(db).Count;

            Console.WriteLine("#C: " + count);

            db.Close();
        }
    }
}
