using System;
using System.Collections.ObjectModel;

namespace RegisterProjectLibrary.DTO
{
    public class Club
    {
        public Club(int id, string name, string city)
        {
            ID = id;
            Name = name;
            City = city;
            Address = "";
            ManagerPhoneNumber = null;
            ManagerEmail = "";
            HomeDistrict = new District();
            Web = "";
            Teams = new Collection<Team>();
            Members = new Collection<Player>();
        }

        public Club() : this(0, "", "") { }

        public int ID { get; set; }
        public string Name { get; set; }
        public string City { get; set; }
        public string Address { get; set; }
        public int? ManagerPhoneNumber { get; set; }
        public string ManagerEmail { get; set; }
        public District HomeDistrict { get; set; }
        public string Web { get; set; }
        public Collection<Team> Teams { get; set; }
        public Collection<Player> Members { get; set; }
        public override string ToString()
        {
            return String.Format("{0}\nMěsto: {1}\nAdresa: {2}\nTelefon jednatele oddílu: {3}\nEmail jednatele oddílu: {4}\nOkres:{5}\nWebová stránka: {6}", 
                Name,City,Address,ManagerPhoneNumber,ManagerEmail,HomeDistrict.Name,Web);
            
        }
    }
}
