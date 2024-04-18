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
    public partial class PlayerDetailControl : DetailControl
    {
        public PlayerDetailControl()
        {
            InitializeComponent();
        }

        private void PlayerDetailControl_Load(object sender, EventArgs e)
        {

        }



        private void button1_Click(object sender, EventArgs e)
        {
            OnNavigate(DetailType.Player);
        }
    }
}
