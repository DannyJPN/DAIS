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
    public partial class FormAuctionDetail : Templates.FormDetail
    {
        private Database.Auction auction;
        private bool newRecord;

        public FormAuctionDetail()
        {
            InitializeComponent();
        }

        public override bool OpenRecord(object primaryKey)
        {
            if (primaryKey != null)
            {
                int idAuction = (int)primaryKey;
                auction = Database.Proxy.AuctionTableProxy.SelectOne(idAuction);
                newRecord = false;
            }
            else
            {
                auction = new Database.Auction();
                auction.IdOwner = Classes.Session.LoggedUserId;
                auction.Creation = DateTime.Now;
                auction.End = DateTime.Now;
                newRecord = true;
            }
            BindData();
            return true;
        }

        private void BindData()
        {
            Collection<Database.Category> categories = Database.Proxy.CategoryTableProxy.Select();
            comboCategory.DisplayMember = "Name";
            comboCategory.ValueMember = "idCategory";
            comboCategory.DataSource = categories;

            if (auction.Owner != null)
            {
                txtOwner.Text = auction.Owner.Login;
            }
            else
            {
                txtOwner.Text = string.Empty;
            }

            txtName.Text = auction.Name;
            txtDescription.Text = auction.Description;
            txtDescriptionDetail.Text = auction.DescriptionDetail;
            txtCreation.Text = auction.Creation.ToString();
            txtEnd.Text = auction.End.ToString();
            comboCategory.SelectedValue = auction.IdCategory;
            txtMinimalBid.Text = auction.MinBidValue.HasValue ? auction.MinBidValue.Value.ToString() : string.Empty;
            txtMaximalBid.Text = auction.MaxBidValue.HasValue ? auction.MaxBidValue.Value.ToString() : string.Empty;
            txtUserWithMaxBid.Text = auction.MaxBidderFullName;
        }

        private bool GetData()
        {
            bool ret = true;
            DateTime dateTime;
            int i;

            errorProvider.Clear();

            auction.Name = txtName.Text;
            auction.Description = txtDescription.Text;
            auction.DescriptionDetail = txtDescriptionDetail.Text;

            if (DateTime.TryParse(txtCreation.Text, out dateTime))
            {
                auction.Creation = dateTime;
            }
            else
            {
                errorProvider.SetError(txtCreation, "Invalid creation date format.");
                ret = false;
            }
            
            if (DateTime.TryParse(txtEnd.Text, out dateTime))
            {
                auction.End = dateTime;
            }
            else
            {
                errorProvider.SetError(txtEnd, "Invalid end date format.");
                ret = false;
            }
            
            auction.IdCategory = (int)comboCategory.SelectedValue;
            
            if (string.IsNullOrWhiteSpace(txtMinimalBid.Text))
            {
                auction.MinBidValue = null;
            }
            else
            {
                if (int.TryParse(txtMinimalBid.Text, out i))
                {
                    auction.MinBidValue = i;
                }
                else
                {
                    errorProvider.SetError(txtMinimalBid, "Invalid minimal bid number format.");
                    ret = false;
                }
            }

            if (string.IsNullOrWhiteSpace(txtMaximalBid.Text))
            {
                auction.MaxBidValue = null;
            }
            else
            {
                if (int.TryParse(txtMaximalBid.Text, out i))
                {
                    auction.MaxBidValue = null;
                }
                else
                {
                    errorProvider.SetError(txtMaximalBid, "Invalid maximal bid number format");
                    ret = false;
                }
            }

            return ret;
        }

        protected override bool SaveRecord()
        {
            if (GetData())
            {
                if (newRecord)
                {
                    Database.Proxy.AuctionTableProxy.Insert(auction);
                }
                else
                {
                    Database.Proxy.AuctionTableProxy.Update(auction);
                }
                return true;
            }
            else
            {
                return false;
            }
        }

        protected override bool DeleteRecord()
        {
            Database.Proxy.AuctionTableProxy.Delete(auction.IdAuction);
            return true;
        }
    }
}
