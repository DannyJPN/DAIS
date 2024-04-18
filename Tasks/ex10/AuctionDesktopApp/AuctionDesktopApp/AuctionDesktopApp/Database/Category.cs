using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AuctionDesktopApp.Database
{
    public class Category
    {
        public int IdCategory { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }

        //artificial columns
        public int ItemsCount { get; set; }
        public bool CanBeDeleted { get { return this.ItemsCount == 0; } }
    }
}