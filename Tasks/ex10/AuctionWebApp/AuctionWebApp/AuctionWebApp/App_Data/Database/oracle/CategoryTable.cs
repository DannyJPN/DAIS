using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Text;
using System.Data;
using AuctionWebApp.Database.Proxy;
using Oracle.ManagedDataAccess.Client;

namespace AuctionWebApp.Database.Oracle
{
    public class CategoryTable : CategoryTableProxy
    {
        public static String TABLE_NAME = "Category";

        public static String SQL_SELECT = "SELECT c.*, (SELECT count(*) FROM Auction WHERE category=c.idCategory) FROM Category c";
        public static String SQL_SELECT_ID = "SELECT * FROM Category WHERE idCategory=:idCategory";
        public static String SQL_SELECT_NAME = "SELECT * FROM Category WHERE name=:name";
        public static String SQL_INSERT = "INSERT INTO Category (name,description) VALUES (:name, :description)";
        public static String SQL_DELETE_ID = "DELETE FROM Category WHERE idCategory=:idCategory";
        public static String SQL_UPDATE = "UPDATE Category SET name=:name, description=:description WHERE idCategory=:idCategory";


        #region Abstraktní metody
        /// <summary>
        /// Insert the record.
        /// </summary>
        protected override int insert(Category category, DatabaseProxy pDb = null)
        {
            Database db = new Database();
            db.Connect();
            OracleCommand command = db.CreateCommand(SQL_INSERT);
            PrepareCommand(command, category, false);
            int ret = db.ExecuteNonQuery(command);
            db.Close();
            return ret;
        }

        /// <summary>
        /// Update the record.
        /// </summary>
        /// <param name="Category"></param>
        /// <returns></returns>
        protected override int update(Category category, DatabaseProxy pDb = null)
        {
            Database db = new Database();
            db.Connect();
            OracleCommand command = db.CreateCommand(SQL_UPDATE);
            PrepareCommand(command, category);
            int ret = db.ExecuteNonQuery(command);
            db.Close();
            return ret;
        }


        /// <summary>
        /// Select records.
        /// </summary>
        protected override Collection<Category> select(DatabaseProxy pDb = null)
        {
            Database db = new Database();
            db.Connect();

            OracleCommand command = db.CreateCommand(SQL_SELECT);
            OracleDataReader reader = db.Select(command);

            Collection<Category> Categorys = Read(reader, true);
            reader.Close();
            db.Close();
            return Categorys;
        }

        /// <summary>
        /// Select records for category.
        /// </summary>
        protected override Category select(int idCategory, DatabaseProxy pDb = null)
        {
            Database db = new Database();
            db.Connect();
            OracleCommand command = db.CreateCommand(SQL_SELECT_ID);

            command.Parameters.AddWithValue(":idCategory", idCategory);
            OracleDataReader reader = db.Select(command);

            Collection<Category> categories = Read(reader);
            Category category = null;
            if (categories.Count == 1)
            {
                category = categories[0];
            }
            reader.Close();
            db.Close();
            return category;
        }
        /// <summary>
        /// Delete the record.
        /// </summary>
        protected override int delete(int id, DatabaseProxy pDb = null)
        {
            Database db = new Database();
            db.Connect();
            OracleCommand command = db.CreateCommand(SQL_DELETE_ID);

            command.Parameters.AddWithValue(":idCategory", id);
            int ret = db.ExecuteNonQuery(command);

            db.Close();
            return ret;
        }
        #endregion

        /// <summary>
        /// Select the record for a name.
        /// </summary>
        public static Category SelectForName(string pName, Database pDb = null)
        {
            Database db;
            if (pDb == null)
            {
                db = new Database();
                db.Connect();
            }
            else
            {
                db = pDb;
            }

            OracleCommand command = db.CreateCommand(SQL_SELECT_NAME);

            command.Parameters.AddWithValue(":name", pName);
            OracleDataReader reader = db.Select(command);

            Collection<Category> categories = Read(reader);
            Category category = null;
            if (categories.Count == 1)
            {
                category = categories[0];
            }
            reader.Close();

            if (pDb == null)
            {
                db.Close();
            }

            return category;
        }

        /// <summary>
        /// Prepare a command.
        /// </summary>
        private static void PrepareCommand(OracleCommand command, Category Category, bool withId = true)
        {
            command.BindByName = true;
           if (withId) //for some reason oracle command cannot handle unused parameters.
                command.Parameters.AddWithValue(":idCategory", Category.IdCategory);
            command.Parameters.AddWithValue(":name", Category.Name);
            command.Parameters.AddWithValue(":description", Category.Description == null ? DBNull.Value : (object)Category.Description);
        }

        private static Collection<Category> Read(OracleDataReader reader, bool withItemsCount = false)
        {
            Collection<Category> categories = new Collection<Category>();

            while (reader.Read())
            {
                Category category = new Category();
                int i = -1;
                category.IdCategory = reader.GetInt32(++i);
                category.Name = reader.GetString(++i);
                if (!reader.IsDBNull(++i))
                {
                    category.Description = reader.GetString(i);
                }
                if (withItemsCount)
                    category.ItemsCount = reader.GetInt32(++i);
                categories.Add(category);
            }
            return categories;
        }

    }
}