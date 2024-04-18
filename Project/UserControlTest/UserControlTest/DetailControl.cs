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
    public partial class DetailControl : UserControl
    {
        public DetailControl()
        {
            InitializeComponent();
        }

        private void DetailControl_Load(object sender, EventArgs e)
        {

        }

        public virtual void OpenRecord(int ID)
        {

        }
        public event EventHandler<NavigateEventArgs> Navigate;
        protected virtual void OnNavigate(DetailType d_type)
        {
            if (Navigate != null)
            {
                Navigate(this, new NavigateEventArgs(d_type));
            }
        }



    }
}
