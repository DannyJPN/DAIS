using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AuctionWebApp.Form
{
    public partial class Category : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void DetailsViewCategory_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            GridViewCategory.DataBind(); //refresh data
        }

        protected void DetailsViewCategory_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {
            GridViewCategory.DataBind(); //refresh data
        }

        protected void Delete_Click(object sender, EventArgs e)
        {
            int categoryId;
            LinkButton btn = (LinkButton)sender;
            if (int.TryParse(btn.CommandArgument,out categoryId))
            {
                //in case of oracle change namespace to 'AuctionWebApp.Database.Oracle.CategoryTable'
                AuctionWebApp.Database.Mssql.CategoryTable.Delete(categoryId);
                GridViewCategory.DataBind(); //refresh data
            }
            else
            {
                //error parsing category id.
            }
        }
    }
}