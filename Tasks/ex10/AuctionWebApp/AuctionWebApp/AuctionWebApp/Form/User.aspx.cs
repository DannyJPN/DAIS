using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AuctionWebApp.Form
{
    public partial class User : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void DetailsViewUser_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {
            GridViewUser.DataBind(); //refresh data
        }

        protected void DetailsViewUser_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            GridViewUser.DataBind(); //refresh data
        }
    }
}