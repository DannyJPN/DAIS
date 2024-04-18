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
    public partial class FormUserGrid : Templates.FormGrid
    {
        public FormUserGrid()
        {
            InitializeComponent();
        }

        protected override void RefreshData()
        {
            Collection<Database.User> users = Database.Proxy.UserTableProxy.Select();
            BindingList<Database.User> bindingList = new BindingList<Database.User>(users);
            gridUsers.AutoGenerateColumns = false;
            gridUsers.DataSource = bindingList;
        }

        private Database.User GetSelectedUser()
        {
            // The "SelectionMode" property of the data grid view must be set to "FullRowSelect".
            if (gridUsers.SelectedRows.Count == 1)
            {
                Database.User user = gridUsers.SelectedRows[0].DataBoundItem as Database.User;
                return user;
            }
            else
            {
                return null;
            }
        }

        protected override void NewRecord()
        {
            FormUserDetail form = new FormUserDetail();
            if (form.OpenRecord(null))
            {
                form.ShowDialog();
                RefreshData();
            }
        }

        protected override void EditRecord()
        {
            Database.User selectedUser = GetSelectedUser();
            if (selectedUser != null)
            {
                FormUserDetail form = new FormUserDetail();
                if (form.OpenRecord(selectedUser.Id))
                {
                    form.ShowDialog();
                    RefreshData();
                }                
            }
        }

        private void gridUsers_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            EditRecord();
        }
    }
}
