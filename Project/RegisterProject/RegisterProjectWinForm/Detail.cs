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
    public partial class Detail : AbstractControl
    {
        public Detail()
        {
            InitializeComponent();
            updatebutton = new Button();
            deletebutton = new Button();
            updatebutton.Visible = deletebutton.Visible = true;
            updatebutton.Parent = deletebutton.Parent = this;
            updatebutton.Size = deletebutton.Size = new Size(100, 50);
            updatebutton.Text = "Upravit";
            deletebutton.Text = "Smazat";
            updatebutton.Left = 20;
            deletebutton.Left = updatebutton.Right + 20;
            updatebutton.Top = deletebutton.Top = this.Height -  updatebutton.Height;

        }
        protected Button updatebutton;
        protected Button deletebutton;
        protected Button confirmupdate;
        protected Form updateform;
        protected TableLayoutPanel editinfo;
        protected TableLayoutPanel info;
        private void Detail_Load(object sender, EventArgs e)
        {
            this.Size = this.Parent.Size;
 

        }

        
    }
}
