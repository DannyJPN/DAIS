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
    public partial class FormCategoryDetail : Templates.FormDetail
    {
        private Database.Category category;
        private bool newRecord;

        public FormCategoryDetail()
        {
            InitializeComponent();
        }

        public override bool OpenRecord(object primaryKey)
        {
            if (primaryKey != null)
            {
                int idCategory = (int)primaryKey;
                category = Database.Proxy.CategoryTableProxy.Select(idCategory);
                newRecord = false;
            }
            else
            {
                category = new Database.Category();
                newRecord = true;
            }
            BindData();
            return true;
        }

        private void BindData()
        {
            txtName.Text = category.Name;
            txtDescription.Text = category.Description;
        }

        private bool GetData()
        {
            category.Name = txtName.Text;
            category.Description = txtDescription.Text;
            return true;
        }

        protected override bool SaveRecord()
        {
            if (GetData())
            {
                if (newRecord)
                {
                    Database.Proxy.CategoryTableProxy.Insert(category);
                }
                else
                {
                    Database.Proxy.CategoryTableProxy.Update(category);
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
            if (category.CanBeDeleted)
            {
                Database.Proxy.CategoryTableProxy.Delete(category.IdCategory);
                return true;
            }
            else
            {
                MessageBox.Show("This category cannot be deleted.", "Auction App",
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return false;
            }
        }
    }
}
