using System;

namespace RegisterProjectLibrary.DTO
{
    public class Match
    {
        public Match(string season, int homescore, int hostscore)
        {
            HomePlayer = new Player();
            HostPlayer = new Player();
            Season = season;
            DateOfOccurrence = new DateTime();
            HomePlayerScore = homescore;
            HostPlayerScore = hostscore;
            CompetitionClass = new League();
        }

        public Match() : this("", 0, 0) { }

        public Player HomePlayer { get; set; }
        public Player HostPlayer { get; set; }
        public string Season { get; set; }
        public DateTime DateOfOccurrence { get; set; }
        public int HomePlayerScore { get; set; }
        public int HostPlayerScore { get; set; }
        public League CompetitionClass { get; set; }
        public override string ToString()
        {
            return String.Format("{0} - {1} \t {2}:{3} \t {4} \t {5}",
                String.Format("{0} {1}",HomePlayer.Surname,HomePlayer.Name),
                String.Format("{0} {1}", HostPlayer.Surname, HostPlayer.Name),
                HomePlayerScore,
                HostPlayerScore,
                DateOfOccurrence.ToShortDateString(),
                CompetitionClass.ID
                );

        }

    }
}
