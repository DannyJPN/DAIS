using Oracle.ManagedDataAccess.Client;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AuctionDesktopApp.Database.Oracle
{
    public static class Extensions
    {
        /// <summary>
        /// Wrapper for method AddWithValue
        /// </summary>
        /// <param name="cmd"></param>
        /// <param name="parameterName"></param>
        /// <param name="value"></param>
        public static void AddWithValue(this OracleParameterCollection cmd, string parameterName, object value)
        {
            cmd.Add(parameterName, value);
        }
    }
}
