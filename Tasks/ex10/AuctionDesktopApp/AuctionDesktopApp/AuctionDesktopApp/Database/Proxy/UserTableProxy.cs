using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AuctionDesktopApp.Database.Proxy
{
    /// <summary>
    /// Proxy třída zastupující DAO UserTable.
    /// Podle zvoleného nastavení použije intační třídu pro Oracle nebo MS SQL
    /// </summary>
    public abstract class UserTableProxy
    {

        //staticka instance je vhodnejsi, pokud se nebude menit proměnna, která určuje zda se použije oracle nebo mssql. Avšak pro projevení změny, musí být zastavena či "recyklována" webová aplikace
        //Pro účely cvičení však použijeme metodu, která vždy vrátí novou instanci. Tento přístup je neefiktivní, ale nebude potřeba zastavovat a resetovat webovou aplikaci, aby reagovala na změnu.
        /// <summary>
        /// Obsahuje referenci na konkrétní třídu pro MS SQL nebo Oracle.
        /// </summary>
        private static UserTableProxy instance
        {
            get
            {
                if (Properties.Settings.Default.DBMS == "oracle")
                {
                    return new Oracle.UserTable();
                }
                else
                {
                    return new MsSql.UserTable();

                }
            }
        }

        #region Abstraktní metody
        //abstraktni metody - konkrétní implementace pro Oracle nebo MS SQL musí implementovat tyto metody
        /// <summary>
        /// Insert
        /// </summary>
        protected abstract int insert(User user, DatabaseProxy pDb = null);

        /// <summary>
        /// Update
        /// </summary>
        protected abstract int update(User user, DatabaseProxy pDb = null);

        /// <summary>
        /// Select records
        /// </summary>
        protected abstract Collection<User> select(DatabaseProxy pDb = null);
        /// <summary>
        /// Select records for user
        /// </summary>
        protected abstract User select(int idUser, DatabaseProxy pDb = null);

        /// <summary>
        /// Delete the record.
        /// </summary>
        protected abstract int delete(int idUser, DatabaseProxy pDb = null);
        #endregion

        #region Statické metody
        //statické metody volají metody konkrétní implementace pro Oracle nebo MS SQL.

        /// <summary>
        /// Insert
        /// </summary>
        public static int Insert(User user, DatabaseProxy pDb = null)
        {
            return instance.insert(user, pDb);
        }

        public static int Insert(User user)
        {
            return instance.insert(user);
        }

        /// <summary>
        /// Update
        /// </summary>
        public static int Update(User user, DatabaseProxy pDb = null)
        {
            return instance.update(user, pDb);
        }

        public static int Update(User user)
        {
            return instance.update(user);
        }

        /// <summary>
        /// Select records for user
        /// </summary>
        public static Collection<User> Select(DatabaseProxy pDb = null)
        {
            return instance.select(pDb);
        }

        public static Collection<User> Select()
        {
            return instance.select();
        }

        /// <summary>
        /// Select records for user.
        /// </summary>
        /// <param name="idUser">Owner of transactions</param>
        public static User Select(int id, DatabaseProxy pDb = null)
        {
            return instance.select(id, pDb);
        }

        public static User Select(int id)
        {
            return instance.select(id);
        }

        /// <summary>
        /// Delete the record.
        /// </summary>
        //note: name of the parameter must be same as name of the delete parameter in ObjectDataSource definition (in <DeleteParameters> of data source)
        public static int Delete(int idAuction, DatabaseProxy pDb = null)
        {
            return instance.delete(idAuction, pDb);
        }

        public static int Delete(int idAuction)
        {
            return instance.delete(idAuction);
        }
        #endregion
    }
}