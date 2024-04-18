using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace AuctionDesktopApp.Forms
{
    public partial class FormUserDetail : Templates.FormDetail
    {
        private Database.User user;
        private bool newRecord;

        public FormUserDetail()
        {
            InitializeComponent();
        }

        public override bool OpenRecord(object primaryKey)
        {
            if (primaryKey != null)
            {
                int idUser = (int)primaryKey;
                user = Database.Proxy.UserTableProxy.Select(idUser);
                newRecord = false;
            }
            else
            {
                user = new Database.User();
                newRecord = true;
            }
            BindData();
            return true;
        }

        private void BindData()
        {
            txtLogin.Text = user.Login;
            txtName.Text = user.Name;
            txtSurname.Text = user.Surname;
            txtFullName.Text = user.FullName;
            txtAddress.Text = user.Address;
            txtTelephone.Text = user.Telephone;
            txtMaximumUnfinishedAuctions.Text = user.MaximumUnfinisfedAuctions.ToString();

            if (user.Type == "U")
            {
                comboType.SelectedItem = "User";
            }
            else if (user.Type == "A")
            {
                comboType.SelectedItem = "Admin";
            }
        }

        private bool GetData()
        {
            bool ret = true;
            int i;

            errorProvider.Clear();

            user.Login = txtLogin.Text;
            user.Name = txtName.Text;
            user.Surname = txtSurname.Text;
            user.Address = txtAddress.Text;
            user.Telephone = txtTelephone.Text;
            
            if (int.TryParse(txtMaximumUnfinishedAuctions.Text, out i))
            {
                user.MaximumUnfinisfedAuctions = i;
            }
            else
            {
                errorProvider.SetError(txtMaximumUnfinishedAuctions, "Invalid number format.");
                ret = false;
            }

            if (comboType.SelectedItem == null)
            {
                errorProvider.SetError(comboType, "User type must be specified.");
                ret = false;
            }
            else
            {
                if (comboType.SelectedItem.ToString() == "User")
                {
                    user.Type = "U";
                }
                else if (comboType.SelectedItem.ToString() == "Admin")
                {
                    user.Type = "A";
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
                    Database.Proxy.UserTableProxy.Insert(user);
                }
                else
                {
                    Database.Proxy.UserTableProxy.Update(user);
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
            Database.Proxy.UserTableProxy.Delete(user.Id);
            return true;
        }
    }
}
