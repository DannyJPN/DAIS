using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace RegisterProjectWinForm
{
    public partial class AbstractControl : UserControl
    {
        public AbstractControl()
        {
            InitializeComponent();




        }
        public static string seasonselected="";


        private void AbstractControl_Load(object sender, EventArgs e)
        {
            this.Size = this.Parent.Size;

        }

        protected virtual void ControlClicked(int ID)
        {
            if (DetailClicked != null)
            {
                DetailClicked(this, new DetailEventArgs(ID));

            }

        }

        protected virtual void ControlClicked(int ID,string leagueCode)
        {
            if (DetailClicked != null)
            {
                DetailClicked(this, new DetailEventArgs(ID,leagueCode));

            }

        }



        public event EventHandler<DetailEventArgs> DetailClicked;
    }

    public class DetailEventArgs : EventArgs
    {


        public int ID { get; set; }
        public string LeagueCode { get; set; }


        public DetailEventArgs(int searchedID)
        {
            ID = searchedID;
            LeagueCode = "";
        }
        public DetailEventArgs(int searchedID,string leagueCode)
        {
            ID = searchedID;
            LeagueCode = leagueCode;
        }


    }

}
