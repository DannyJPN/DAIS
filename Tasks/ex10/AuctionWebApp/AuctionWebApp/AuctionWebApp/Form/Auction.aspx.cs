using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AuctionWebApp.Form
{
    public partial class Auction : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["IDUSER"] = 1; //should be determined from logged user.

            //set date compare validator for details view insert and edit mode.
        }

      
      

        protected void DetailsViewAuction_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {
            //add default values
            e.Values.Add("IdOwner", Session["IDUSER"]);
                
        }

        protected void DetailsViewAuction_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            //refresh gridview
            GridViewAuction.DataBind();
        }

        protected void GridViewAuction_RowDeleted(object sender, GridViewDeletedEventArgs e)
        {
            //refresh gridview
            GridViewAuction.DataBind();
        }

        protected void DetailsViewAuction_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {
            //refresh gridview
            GridViewAuction.DataBind();
        }
    }
}