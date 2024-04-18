using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Text;
using System.Data;
using System.Web.Configuration;
using Oracle.ManagedDataAccess.Client;
using AuctionWebApp.Database.Proxy;

namespace AuctionWebApp.Database.Oracle
{
    /// <summary>
    /// Represents a Oracle Database
    /// </summary>
    public class Database:DatabaseProxy
    {
        private OracleConnection Connection { get; set; }
        private OracleTransaction SqlTransaction { get; set; }
        public string Language { get; set; }
        // private static String CONNECTION_STRING = "server=dbsys.cs.vsb.cz\\STUDENT;database=kra28;user=kra28;password=abc;";

        public Database() 
        {
            Connection = new OracleConnection();
            
            Language = "en";
        }

        /// <summary>
        /// Connect
        /// </summary>
        public override bool Connect(String conString)
        {
            if (Connection.State != System.Data.ConnectionState.Open)
            {
                Connection.ConnectionString = conString;
                Connection.Open();
            }
            return true;
        }

        /// <summary>
        /// Connect
        /// </summary>
        public override bool Connect()
        {
            bool ret = true;

            if (Connection.State != System.Data.ConnectionState.Open)
            {
                ret = Connect(WebConfigurationManager.ConnectionStrings["ConnectionStringOracle"].ConnectionString);
            }

            return ret;
        }

        /// <summary>
        /// Close.
        /// </summary>
        public override void Close()
        {
            Connection.Close();
        }

        /// <summary>
        /// Begin a transaction.
        /// </summary>
        public override void BeginTransaction()
        {
           SqlTransaction = Connection.BeginTransaction(IsolationLevel.Serializable);
        }

        /// <summary>
        /// End a transaction.
        /// </summary>
        public override void EndTransaction()
        {
            // command.Dispose()
            SqlTransaction.Commit();
            Close();
        }

        /// <summary>
        /// If a transaction is failed call it.
        /// </summary>
        public override void Rollback()
        {
            SqlTransaction.Rollback();
        }

        /// <summary>
        /// Insert a record encapulated in the command.
        /// </summary>
        public int ExecuteNonQuery(OracleCommand command)
        {
            int rowNumber = 0;
            try
            {
                rowNumber = command.ExecuteNonQuery();
            }
            catch (Exception e)
            {
                throw e;
            }
            finally
            {
                Close();
            }
            return rowNumber;
        }

        /// <summary>
        /// Create command.
        /// </summary>
        public OracleCommand CreateCommand(string strCommand)
        {
            OracleCommand command = new OracleCommand(strCommand, Connection);

            if (SqlTransaction != null)
            {
                command.Transaction = SqlTransaction;
            }
            return command;
        }
        /// <summary>
        /// Select encapulated in the command.
        /// </summary>
        public OracleDataReader Select(OracleCommand command)
        {
            //command.Prepare();
            OracleDataReader sqlReader = command.ExecuteReader();
            return sqlReader;
        }
    }
}

