using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Text;
using System.Data;
using System.Diagnostics;
using System.Configuration;

namespace AuctionSystem.ORM.Proxy
{
    /// <summary>
    /// Proxy třída zastupující DAO CategoryTable.
    /// Podle zvoleného nastavení použije intační třídu pro Oracle nebo MS SQL
    /// </summary>
    public abstract class CategoryTableProxy
    {

        //staticka instance je vhodnejsi, pokud se nebude menit proměnna, která určuje zda se použije oracle nebo mssql. Avšak pro projevení změny, musí být zastavena či "recyklována" webová aplikace
        //Pro účely cvičení však použijeme metodu, která vždy vrátí novou instanci. Tento přístup je neefiktivní, ale nebude potřeba zastavovat a resetovat webovou aplikaci, aby reagovala na změnu.
        /// <summary>
        /// Obsahuje referenci na konkrétní třídu pro MS SQL nebo Oracle.
        /// </summary>
        private static CategoryTableProxy instance
        {
            get
            {
                if (ConfigurationManager.AppSettings["DBMS"].ToLower() == "oracle")
                {
                    return new Oracle.CategoryTable();
                }
                else
                {
                    return new Mssql.CategoryTable();

                }
            }
        }

        #region Abstraktní metody
        //abstraktni metody - konkrétní implementace pro Oracle nebo MS SQL musí implementovat tyto metody
        /// <summary>
        /// Insert
        /// </summary>
        protected abstract int insert(Category category);

        /// <summary>
        /// Update
        /// </summary>
        protected abstract int update(Category category);

        /// <summary>
        /// Select records
        /// </summary>
        protected abstract Collection<Category> select();
        /// <summary>
        /// Select records for category
        /// </summary>
        protected abstract Category select(int idCategory);

        /// <summary>
        /// Delete the record.
        /// </summary>
        protected abstract int delete(int idAuction);
        #endregion

        #region Statické metody
        //statické metody volají metody konkrétní implementace pro Oracle nebo MS SQL.

        /// <summary>
        /// Insert
        /// </summary>
        public static int Insert(Category category)
        {
            return instance.insert(category);
        }
        /// <summary>
        /// Update
        /// </summary>
        public static int Update(Category category)
        {
            return instance.update(category);
        }

        /// <summary>
        /// Select records for category
        /// </summary>
        public static Collection<Category> Select()
        {
            return instance.select();
        }

        /// <summary>
        /// Select records for category.
        /// </summary>
        /// <param name="idCategory">Owner of transactions</param>
        public static Category Select(int idCategory)
        {
            return instance.select(idCategory);
        }

        /// <summary>
        /// Delete the record.
        /// </summary>
        //note: name of the parameter must be same as name of the delete parameter in ObjectDataSource definition (in <DeleteParameters> of data source)
        public static int Delete(int IdAuction)
        {
            return instance.delete(IdAuction);
        }
        #endregion
    }
}