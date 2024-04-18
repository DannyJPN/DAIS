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
    public partial class Searcher : AbstractControl
    {
        public Searcher()
        {
            InitializeComponent();
            indicator = new Label() { Height = 40, Width = 200, Visible = true, Parent = this, Left = 10, Top = 5, TextAlign = ContentAlignment.MiddleCenter };
            searchbox = new TextBox() { Visible = true, Parent = this };
            result = new DataGridView();
            searchbutton = new Button() { Height = 40, Width = 200, Text = "Vyhledat", Visible = true, Parent = this, Left = 10, Top = 5 };
            insertbutton = new Button() { Height = 40, Width = 200, Text = "Vložit", Visible = true, Parent = this, Left = 10, Top = 5 };
            topboard = new TableLayoutPanel();
            topboard.Parent = this;
            topboard.Visible = true;
            topboard.RowCount = 1;
            topboard.ColumnCount = 3;

            topboard.Width = ClientSize.Width;
            topboard.Height = 60;
            topboard.ColumnStyles.Add(new ColumnStyle(SizeType.AutoSize));

            topboard.Controls.Add(indicator, 0, 0);
            topboard.Controls.Add(searchbutton, 1, 0);
            topboard.Controls.Add(insertbutton, 2, 0);





            result.CellBorderStyle = DataGridViewCellBorderStyle.Single;
            result.DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter;
            result.RowHeadersVisible = false;
            result.BorderStyle = BorderStyle.None;
            result.ColumnHeadersVisible = true;
            result.AutoGenerateColumns = false;
            result.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.DisplayedCells;
            result.ScrollBars = ScrollBars.Vertical;




        }

        protected Label indicator;
        protected TextBox searchbox;
        protected DataGridView result;
        protected Button searchbutton;
        protected Button insertbutton;
        protected TableLayoutPanel insertinfo;
        protected Button confirminsert;
        protected Form insertform;
        protected TableLayoutPanel topboard;
        private void Searcher_Load(object sender, EventArgs e)
        {
            this.Size = this.Parent.Size;
            topboard.Width = this.Width;
            searchbox.Left = 5;
            searchbox.Top = topboard.Bottom;
            searchbox.Size = new Size(this.Width - searchbox.Left * 2, 50);


            result.Parent = this;
            result.Visible = true;

            result.Top = searchbox.Bottom + 5;
            result.Left = searchbox.Left;
            result.Width = searchbox.Width;
            result.Height = this.Height - result.Top;
            result.DefaultCellStyle.BackColor = result.Parent.BackColor;
            result.BackgroundColor = result.Parent.BackColor;
            result.ReadOnly = true;
        }





    }






}
