using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace RegexTest
{
    class Program
    {
        static void Main(string[] args)
        {
            List<string> season = new List<string>();
            season.Add("2018/2019");
            season.Add("2019/2019");
            season.Add("201/2019");
            season.Add("2018/201");
            season.Add("201/201");
            season.Add("2018/2019/");

            string pattern = @"^\d{4}/\d{4}$";
            string minorpattern = @"\d{4}";
            bool? truematch=null;
            for (int i = 0; i < season.Count; i++)
            {



                if (!(Regex.IsMatch(season[i], pattern) && Convert.ToInt32(Regex.Matches(season[i], minorpattern)[1].Value) - Convert.ToInt32(Regex.Matches(season[i], minorpattern)[0].Value) == 1))
                {
                    truematch = false;
                }
                else
                {
                    truematch = true;
                }
                Console.WriteLine("{0} = {1}", season[i], truematch);

                Console.WriteLine();
            }

            Console.ReadLine();
        }
    }
}
