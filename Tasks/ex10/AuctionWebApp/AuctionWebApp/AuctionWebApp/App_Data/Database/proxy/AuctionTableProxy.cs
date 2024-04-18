using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Text;
using System.Data;
using System.Diagnostics;
using System.Configuration;

namespace AuctionWebApp.Database.Proxy
{
    /// <summary>
    /// Proxy třída zastupující DAO AuctionTable.
    /// Podle zvoleného nastavení použije intační třídu pro Oracle nebo MS SQL
    /// </summary>
    public abstract class AuctionTableProxy
    {

        //staticka instance je vhodnejsi, pokud se nebude menit proměnna, která určuje zda se použije oracle nebo mssql. Avšak pro projevení změny, musí být zastavena či "recyklována" webová aplikace
        //Pro účely cvičení však použijeme metodu, která vždy vrátí novou instanci. Tento přístup je neefiktivní, ale nebude potřeba zastavovat a resetovat webovou aplikaci, aby reagovala na změnu.
        /// <summary>
        /// Obsahuje referenci na konkrétní třídu pro MS SQL nebo Oracle.
        /// </summary>
        private static AuctionTableProxy instance
        {
            get
            {
                if (ConfigurationManager.AppSettings["DBMS"].ToLower() == "oracle")
                {
                    return new Oracle.AuctionTable();
                }
                else
                {
                    return new Mssql.AuctionTable();

                }
            }
        }
        
        #region Abstraktní metody
        //abstraktni metody - konkrétní implementace pro Oracle nebo MS SQL musí implementovat tyto metody
        /// <summary>
        /// Insert
        /// </summary>
        protected abstract int insert(Auction auction, DatabaseProxy pDb = null);
        
        /// <summary>
        /// Update
        /// </summary>
        protected abstract int update(Auction auction, DatabaseProxy pDb = null);
        
        /// <summary>
        /// Select records
        /// </summary>
        /// <param name="iduser">Owner of transactions</param>
        protected abstract Collection<Auction> select(int iduser, DatabaseProxy pDb = null);

        /// <summary>
        /// Select the record.
        /// </summary>
        protected abstract Auction selectOne(int idAuction, DatabaseProxy pDb = null);

        /// <summary>
        /// Delete the record.
        /// </summary>
        protected abstract int delete(int idAuction, DatabaseProxy pDb = null);
        #endregion

        #region Statické metody
        //statické metody volají metody konkrétní implementace pro Oracle nebo MS SQL.

        /// <summary>
        /// Insert
        /// </summary>
        public static int Insert(Auction auction, DatabaseProxy pDb = null)
        {
            return instance.insert(auction, pDb);
        }

        public static int Insert(Auction auction)
        {
            return instance.insert(auction);
        }

        /// <summary>
        /// Update
        /// </summary>
        public static int Update(Auction auction, DatabaseProxy pDb = null)
        {
            return instance.update(auction, pDb);
        }

        public static int Update(Auction auction)
        {
            return instance.update(auction);
        }

        /// <summary>
        /// Select records
        /// </summary>
        /// <param name="iduser">Owner of transactions</param>
        public static Collection<Auction> Select(int iduser, DatabaseProxy pDb = null)
        {
            return instance.select(iduser, pDb);
        }

        public static Collection<Auction> Select(int iduser)
        {
            return instance.select(iduser);
        }

        /// <summary>
        /// Select the record.
        /// </summary>
        public static Auction SelectOne(int idAuction, DatabaseProxy pDb = null)
        {
            return instance.selectOne(idAuction, pDb);
        }

        public static Auction SelectOne(int idAuction)
        {
            return instance.selectOne(idAuction);
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