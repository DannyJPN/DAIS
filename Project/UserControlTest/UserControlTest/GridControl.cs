using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace UserControlTest
{
    public partial class GridControl : UserControl
    {
        public GridControl()
        {
            InitializeComponent();
        }

        private void GridControl_Load(object sender, EventArgs e)
        {

        }
        public virtual void RefreshContent()
        {

        }

        public event EventHandler<NavigateEventArgs> Navigate;
        protected virtual void OnNavigate(DetailType d_type)
        {
            if (Navigate != null)
            {
                Navigate(this,new NavigateEventArgs(d_type));
            }
        }
    
    }

    public class NavigateEventArgs : EventArgs
    {
        public DetailType DetType { get; set; }
        public NavigateEventArgs(DetailType d_type)
        {
            DetType = d_type;

        }
         
    }


    public enum DetailType
    {
        Player,Team,Club
    }
}
