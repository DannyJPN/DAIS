using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RegisterProjectLibrary.DTO
{
    public class Team
    {

        public Team(int id,string name,string season)
        {
            ID = id;
            Name = name;
            SeasonOfExistence = season;
            HomeClub = new Club();
            CompetitionClass = new League();
            Members = new Collection<Player>();
            Points = 0;
        }
        public Team():this(0,"","")
        {
            
        }

        public int ID { get; set; }
        public string Name { get; set; }
        public string SeasonOfExistence { get; set; }
        public Club HomeClub { get; set; }
        public League CompetitionClass { get; set; }
        public Collection<Player> Members { get; set; }
        public int Points { get; set; }
        public override string ToString()
        {
             return String.Format("{0} ({1})\nSezona: {2}\nOddil: {3}\nID: {4}",Name,CompetitionClass.Name,SeasonOfExistence,HomeClub.Name,ID);
           
            

        }


    }
}
