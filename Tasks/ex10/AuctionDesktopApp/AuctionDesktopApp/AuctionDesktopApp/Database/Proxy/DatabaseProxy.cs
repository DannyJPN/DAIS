using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AuctionDesktopApp.Database.Proxy
{
    public abstract class DatabaseProxy
    {
        public abstract bool Connect();
        public abstract bool Connect(String conString);
        public abstract void Close();
        public abstract void BeginTransaction();
        public abstract void EndTransaction();
        public abstract void Rollback();
    }
}