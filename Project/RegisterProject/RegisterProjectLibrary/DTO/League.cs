using System;

namespace RegisterProjectLibrary.DTO
{
    public class League
    {

        public League(string id, string name)
        {
            ID = id;
            Name = name;
        }

        public League() : this("", "") { }

        public string ID { get; set; }
        public string Name { get; set; }

        public override string ToString()
        {
            return String.Format("{0} ({1})", Name, ID);
        }
    }
}
