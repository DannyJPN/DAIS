using System;

namespace RegisterProjectLibrary.DTO
{
    public class District
    {
        public District(string code,string name)
        {
            Code = code;
            Name = name;
            HomeRegion = new Region();

        }

        public District() : this("", "") { }

        public string Code { get; set; }
        public string Name { get; set; }
        public Region HomeRegion { get; set; }

        public override string ToString()
        {
            return String.Format("{0} ({1}),kraj {2}", Name, Code,HomeRegion.Name);
        }
    }
}
