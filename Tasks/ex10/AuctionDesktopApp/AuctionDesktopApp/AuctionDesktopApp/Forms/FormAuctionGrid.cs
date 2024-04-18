using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace AuctionDesktopApp.Forms
{
    public partial class FormAuctionGrid : Templates.FormGrid
    {
        public FormAuctionGrid()
        {
            InitializeComponent();
        }
        
        protected override void RefreshData()
        {
            int userId = Classes.Session.LoggedUserId;
            Collection<Database.Auction> auctions = Database.Proxy.AuctionTableProxy.Select(userId);
            BindingList<Database.Auction> bindingList = new BindingList<Database.Auction>(auctions);
            gridAuctions.AutoGenerateColumns = false;
            gridAuctions.DataSource = bindingList;
        }

        private Database.Auction GetSelectedAuction()
        {
            // The "SelectionMode" property of the data grid view must be set to "FullRowSelect".
            if (gridAuctions.SelectedRows.Count == 1)
            {
                Database.Auction auction = gridAuctions.SelectedRows[0].DataBoundItem as Database.Auction;
                return auction;
            }
            else
            {
                return null;
            }
        }

        protected override void NewRecord()
        {
            FormAuctionDetail form = new FormAuctionDetail();
            if (form.OpenRecord(null))
            {
                form.ShowDialog();
                RefreshData();
            }
        }

        protected override void EditRecord()
        {
            Database.Auction selectedAuction = GetSelectedAuction();
            if (selectedAuction != null)
            {
                FormAuctionDetail form = new FormAuctionDetail();
                if (form.OpenRecord(selectedAuction.IdAuction))
                {
                    form.ShowDialog();
                    RefreshData();
                }
            }
        }

        private void gridAuctions_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            EditRecord();
        }
    }
}
