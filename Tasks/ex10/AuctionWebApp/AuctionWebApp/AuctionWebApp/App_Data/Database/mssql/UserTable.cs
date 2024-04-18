using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using AuctionWebApp.Database.Proxy;

namespace AuctionWebApp.Database.Mssql
{
    public class UserTable : UserTableProxy
    {
        public static String SQL_SELECT = "SELECT * FROM \"User\"";
        public static String SQL_SELECT_ID = "SELECT * FROM \"User\" WHERE idUser=@id";
        public static String SQL_INSERT = "INSERT INTO \"User\" VALUES (@login, @name, @surname, @address, @telephone," +
            "@maximum_unfinisfed_auctions, @last_visit, @type)";
        public static String SQL_DELETE_ID = "DELETE FROM \"User\" WHERE idUser=@id";
        public static String SQL_UPDATE = "UPDATE \"User\" SET login=@login, name=@name, surname=@surname," +
            "address=@address, telephone=@telephone, maximum_unfinisfed_auctions=@maximum_unfinisfed_auctions," +
            "last_visit=@last_visit, type=@type WHERE idUser=@id";

        /// <summary>
        /// Insert the record.
        /// </summary>
        protected override int insert(User user, DatabaseProxy pDb = null)
        {
            Database db = Database.Open(pDb);

            SqlCommand command = db.CreateCommand(SQL_INSERT);
            PrepareCommand(command, user);
            int ret = db.ExecuteNonQuery(command);

            Database.Close(db);

            return ret;
        }

        /// <summary>
        /// Update the record.
        /// </summary>
        protected override int update(User user, DatabaseProxy pDb = null)
        {
            Database db = Database.Open(pDb);

            SqlCommand command = db.CreateCommand(SQL_UPDATE);
            PrepareCommand(command, user);
            int ret = db.ExecuteNonQuery(command);

            Database.Close(db);

            return ret;
        }


        /// <summary>
        /// Select the records.
        /// </summary>
        protected override Collection<User> select(DatabaseProxy pDb = null)
        {
            Database db = Database.Open(pDb);

            SqlCommand command = db.CreateCommand(SQL_SELECT);
            SqlDataReader reader = db.Select(command);

            Collection<User> users = Read(reader);
            reader.Close();

            Database.Close(db);

            return users;
        }

        /// <summary>
        /// Select the record.
        /// </summary>
        /// <param name="id">user id</param>
        protected override User select(int id, DatabaseProxy pDb = null)
        {
            Database db = Database.Open(pDb);

            SqlCommand command = db.CreateCommand(SQL_SELECT_ID);

            command.Parameters.AddWithValue("@id", id);
            SqlDataReader reader = db.Select(command);

            Collection<User> Users = Read(reader);
            User User = null;
            if (Users.Count == 1)
            {
                User = Users[0];
            }
            reader.Close();

            Database.Close(db);

            return User;
        }

        /// <summary>
        /// Delete the record.
        /// </summary>
        /// <param name="idUser">user id</param>
        /// <returns></returns>
        protected override int delete(int idUser, DatabaseProxy pDb = null)
        {
            Database db = Database.Open(pDb);

            SqlCommand command = db.CreateCommand(SQL_DELETE_ID);
            command.Parameters.AddWithValue("@id", idUser);
            int ret = db.ExecuteNonQuery(command);

            Database.Close(db);

            return ret;
        }

        /// <summary>
        ///  Prepare a command.
        /// </summary>
        private static void PrepareCommand(SqlCommand command, User User)
        {
            command.Parameters.AddWithValue("@id", User.Id);
            command.Parameters.AddWithValue("@login", User.Login);
            command.Parameters.AddWithValue("@name", User.Name);
            command.Parameters.AddWithValue("@surname", User.Surname);
            command.Parameters.AddWithValue("@address", User.Address == null ? DBNull.Value : (object)User.Address);
            command.Parameters.AddWithValue("@telephone", User.Telephone == null ? DBNull.Value : (object)User.Telephone);
            command.Parameters.AddWithValue("@maximum_unfinisfed_auctions", User.MaximumUnfinisfedAuctions);
            command.Parameters.AddWithValue("@last_visit", User.LastVisit == null ? DBNull.Value : (object)User.LastVisit);
            command.Parameters.AddWithValue("@type", User.Type);
        }

        private static Collection<User> Read(SqlDataReader reader)
        {
            Collection<User> users = new Collection<User>();

            while (reader.Read())
            {
                int i = -1;
                User user = new User();
                user.Id = reader.GetInt32(++i);
                user.Login = reader.GetString(++i);
                user.Name = reader.GetString(++i);
                user.Surname = reader.GetString(++i);
                user.Address = reader.GetString(++i);
                user.Telephone = reader.GetString(++i);
                user.MaximumUnfinisfedAuctions = reader.GetInt32(++i);
                if (!reader.IsDBNull(++i))
                {
                    user.LastVisit = reader.GetDateTime(i);
                }
                user.Type = reader.GetString(++i);

                users.Add(user);
            }
            return users;
        }

        // It is not a function from the functional analysis
        // it is an example how to work with stored procedures
        public static string CheckUser(int idUser, DatabaseProxy pDb)
        {
            Database db = Database.Open(pDb);

            // 1.  create a command object identifying the stored procedure
            SqlCommand command = db.CreateCommand("CheckUser");

            // 2. set the command object so it knows to execute a stored procedure
            command.CommandType = CommandType.StoredProcedure;

            // 3. create input parameters
            SqlParameter input = new SqlParameter();
            input.ParameterName = "@idUser";
            input.DbType = DbType.Int32;
            input.Value = idUser;
            input.Direction = ParameterDirection.Input;
            command.Parameters.Add(input);

            // 3. create output parameters
            SqlParameter output = new SqlParameter();
            output.ParameterName = "@result";
            output.DbType = DbType.String;
            output.Direction = ParameterDirection.Output;
            command.Parameters.Add(output);

            // 4. execute procedure
            int ret = db.ExecuteNonQuery(command);

            // 5. get values of the output parameters
            string result = command.Parameters["@result"].Value.ToString();

            Database.Close(db);

            return result;
        }
    }
}