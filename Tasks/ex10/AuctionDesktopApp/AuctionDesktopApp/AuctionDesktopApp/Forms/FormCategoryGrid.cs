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
    public partial class FormCategoryGrid : Templates.FormGrid
    {
        public FormCategoryGrid()
        {
            InitializeComponent();
        }

        protected override void RefreshData()
        {
            Collection<Database.Category> categories = Database.Proxy.CategoryTableProxy.Select();
            BindingList<Database.Category> bindingList = new BindingList<Database.Category>(categories);
            gridCategories.AutoGenerateColumns = false;
            gridCategories.DataSource = bindingList;
        }

        private Database.Category GetSelectedCategory()
        {
            // The "SelectionMode" property of the data grid view must be set to "FullRowSelect".
            if (gridCategories.SelectedRows.Count == 1)
            {
                Database.Category category = gridCategories.SelectedRows[0].DataBoundItem as Database.Category;
                return category;
            }
            else
            {
                return null;
            }
        }

        protected override void NewRecord()
        {
            FormCategoryDetail form = new FormCategoryDetail();
            if (form.OpenRecord(null))
            {
                form.ShowDialog();
                RefreshData();
            }
        }

        protected override void EditRecord()
        {
            Database.Category selectedCategory = GetSelectedCategory();
            if (selectedCategory != null)
            {
                FormCategoryDetail form = new FormCategoryDetail();
                if (form.OpenRecord(selectedCategory.IdCategory))
                {
                    form.ShowDialog();
                    RefreshData();
                }
            }
        }

        private void gridCategories_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            EditRecord();
        }

        private void gridCategories_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
    }
}
