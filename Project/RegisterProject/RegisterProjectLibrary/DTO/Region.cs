using System;


namespace RegisterProjectLibrary.DTO
{
    public class Region
    {
        public Region(string code, string name)
        {
            Code = code;
            Name = name;
        }

        public Region() : this("", "") { }

        public string Code { get; set; }
        public string Name { get; set; }

        public override string ToString()
        {
            return String.Format("{0} ({1})",Name,Code);
        }
    }
}
