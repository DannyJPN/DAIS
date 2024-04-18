using AuctionDesktopApp.Database.Proxy;
using Oracle.ManagedDataAccess.Client;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AuctionDesktopApp.Database.Oracle
{
    public class UserTable : UserTableProxy
    {
        public static String SQL_SELECT = "SELECT * FROM \"User\"";
        public static String SQL_SELECT_ID = "SELECT * FROM \"User\" WHERE idUser=:id";
        public static String SQL_INSERT = "INSERT INTO \"User\" (login,name,surname,address,telephone,maximum_unfinisfed_auctions,last_visit,type) "
            + " VALUES (:login, :name, :surname, :address, :telephone,:maximum_unfinisfed_auctions, :last_visit, :type)";
        public static String SQL_DELETE_ID = "DELETE FROM \"User\" WHERE idUser=:id";
        public static String SQL_UPDATE = "UPDATE \"User\" SET login=:login, name=:name, surname=:surname," +
            "address=:address, telephone=:telephone, maximum_unfinisfed_auctions=:maximum_unfinisfed_auctions," +
            "last_visit=:last_visit, type=:type WHERE idUser=:id";

        #region Abstraktní metody
        /// <summary>
        /// Insert the record.
        /// </summary>
        protected override int insert(User user, DatabaseProxy pDb = null)
        {
            Database db = new Database();
            db.Connect();
            OracleCommand command = db.CreateCommand(SQL_INSERT);
            PrepareCommand(command, user);
            int ret = db.ExecuteNonQuery(command);
            db.Close();
            return ret;
        }

        /// <summary>
        /// Update the record.
        /// </summary>
        protected override int update(User user, DatabaseProxy pDb = null)
        {
            Database db = new Database();
            db.Connect();
            OracleCommand command = db.CreateCommand(SQL_UPDATE);
            PrepareCommand(command, user);
            int ret = db.ExecuteNonQuery(command);
            db.Close();
            return ret;
        }


        /// <summary>
        /// Select the records.
        /// </summary>
        protected override Collection<User> select(DatabaseProxy pDb = null)
        {
            Database db = new Database();
            db.Connect();

            OracleCommand command = db.CreateCommand(SQL_SELECT);
            OracleDataReader reader = db.Select(command);

            Collection<User> Users = Read(reader);
            reader.Close();
            db.Close();
            return Users;
        }

        /// <summary>
        /// Select the record.
        /// </summary>
        /// <param name="id">user id</param>
        protected override User select(int id, DatabaseProxy pDb = null)
        {
            Database db = new Database();
            db.Connect();
            OracleCommand command = db.CreateCommand(SQL_SELECT_ID);

            command.Parameters.AddWithValue(":id", id);
            OracleDataReader reader = db.Select(command);

            Collection<User> Users = Read(reader);
            User User = null;
            if (Users.Count == 1)
            {
                User = Users[0];
            }
            reader.Close();
            db.Close();
            return User;
        }

        /// <summary>
        /// Delete the record.
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        protected override int delete(int id, DatabaseProxy pDb = null)
        {
            Database db = new Database();
            db.Connect();
            OracleCommand command = db.CreateCommand(SQL_DELETE_ID);

            command.Parameters.AddWithValue(":id", id);
            int ret = db.ExecuteNonQuery(command);

            db.Close();
            return ret;
        }

        #endregion

        /// <summary>
        /// Prepare a command.
        /// </summary>
        private static void PrepareCommand(OracleCommand command, User User)
        {
            command.BindByName = true;
            command.Parameters.AddWithValue(":id", User.Id);
            command.Parameters.AddWithValue(":login", User.Login);
            command.Parameters.AddWithValue(":name", User.Name);
            command.Parameters.AddWithValue(":surname", User.Surname);
            command.Parameters.AddWithValue(":address", User.Address == null ? DBNull.Value : (object)User.Address);
            command.Parameters.AddWithValue(":telephone", User.Telephone == null ? DBNull.Value : (object)User.Telephone);
            command.Parameters.AddWithValue(":maximum_unfinisfed_auctions", User.MaximumUnfinisfedAuctions);
            command.Parameters.AddWithValue(":last_visit", User.LastVisit == null ? DBNull.Value : (object)User.LastVisit);
            command.Parameters.AddWithValue(":type", User.Type);
        }

        private static Collection<User> Read(OracleDataReader reader)
        {
            Collection<User> Users = new Collection<User>();

            while (reader.Read())
            {
                int i = -1;
                User User = new User();
                User.Id = reader.GetInt32(++i);
                User.Login = reader.GetString(++i);
                User.Name = reader.GetString(++i);
                User.Surname = reader.GetString(++i);
                User.Address = reader.GetString(++i);
                User.Telephone = reader.GetString(++i);
                User.MaximumUnfinisfedAuctions = reader.GetInt32(++i);
                if (!reader.IsDBNull(++i))
                {
                    User.LastVisit = reader.GetDateTime(i);
                }
                User.Type = reader.GetString(++i);

                Users.Add(User);
            }
            return Users;
        }
    }
}