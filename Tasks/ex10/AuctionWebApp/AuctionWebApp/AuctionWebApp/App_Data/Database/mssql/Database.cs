using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using AuctionWebApp.Database.Proxy;

namespace AuctionWebApp.Database.Mssql
{
    /// <summary>
    /// Represents a MS SQL Database
    /// </summary>
    public class Database : DatabaseProxy
    {
        private SqlConnection Connection { get; set; }
        private SqlTransaction SqlTransaction { get; set; }
        public string Language { get; set; }

        public Database()
        {
            Connection = new SqlConnection();
            Language = "en";
        }
        
        /// <summary>
        /// Connect
        /// </summary>
        public override bool Connect(string conString)
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
                //connection string is stored in file 'web.config'
                ret = Connect(WebConfigurationManager.ConnectionStrings["ConnectionStringMsSql"].ConnectionString);
            }
            return ret;
        }

        public static Database Open(DatabaseProxy pDb)
        {
            Database db;
            if (pDb == null)
            {
                db = new Database();
                db.Connect();
            }
            else
            {
                db = (Database)pDb;
            }
            return db;
        }

/// <summary>
/// Close
/// </summary>
        public override void Close()
        {
            Connection.Close();
        }

        public static void Close(Database pDb)
        {
            if (pDb == null)
            {
                pDb.Close();
            }
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
        public int ExecuteNonQuery(SqlCommand command)
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
        /// Create command
        /// </summary>
        public SqlCommand CreateCommand(string strCommand)
        {
            SqlCommand command = new SqlCommand(strCommand, Connection);

            if (SqlTransaction != null)
            {
                command.Transaction = SqlTransaction;
            }
            return command;
        }

        /// <summary>
        /// Select encapulated in the command.
        /// </summary>
        public SqlDataReader Select(SqlCommand command)
        {
            SqlDataReader sqlReader = command.ExecuteReader();
            return sqlReader;
        }
       
    }
}

