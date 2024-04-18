using System;
using System.Collections.ObjectModel;

namespace RegisterProjectLibrary.DTO
{
    public class Player
    {
        public Player(int id, string name, string surname)
        {
            ID = id;
            Name = name;
            Surname = surname;
            Birthdate = new DateTime();
            Phonenumber = null;
            Email = "";
            Teams = new Collection<Team>();
            HomeClub = new Club();
            Bilance = 0;
        }

        public Player() : this(0, "", "") { }

        public int ID { get; set; }
        public string Name { get; set; }
        public string Surname { get; set; }
        public DateTime Birthdate { get; set; }
        public int? Phonenumber { get; set; }
        public string Email { get; set; }
        public Collection<Team> Teams { get; set; }
        public Club HomeClub { get; set; }
        public double Bilance { get; set; }
        public override string ToString()
        {
            return String.Format("{0} {1} ({2})\nTelefon: {3}\nEmail: {4}\nID: {5}\n", Surname,Name,Birthdate.ToShortDateString(),Phonenumber,Email,ID);
            
           

        }

    }
}
