using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace UserControlTest
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();

            p_detail.Navigate += P_detail_Navigate;
        }

        private void P_detail_Navigate(object sender, NavigateEventArgs e)
        {
            SetActiveDetail(t_detail);
        }

        private PlayerDetailControl p_detail = new PlayerDetailControl();
        private TeamDetailControl t_detail = new TeamDetailControl();
        private DetailControl detail_active=null;


        private void Form1_Load(object sender, EventArgs e)
        {

        }

        private void SetActiveDetail(DetailControl det)
        {
            DetailBox.Controls.Clear();
            DetailBox.Controls.Add(det);
            det.Dock = DockStyle.Fill;
            detail_active = det;

        }

        private void button1_Click(object sender, EventArgs e)
        {
            SetActiveDetail(p_detail);
        }

        private void button2_Click(object sender, EventArgs e)
        {
            SetActiveDetail(t_detail);
        }
    }
}
