using System;
using System.Collections.Generic;
using System.ComponentModel;

using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using RegisterProjectLibrary.DAO;
using System.Collections.ObjectModel;
using RegisterProjectLibrary.DTO;

namespace RegisterProjectWinForm
{
    public partial class ClubSearcher : Searcher
    {
        public ClubSearcher()
        {
            InitializeComponent();
            indicator.Text = "Vyhledat klub";

            searchbutton.Click += Searchbutton_Click;

            result.Columns.Add("Oddíl", "Oddíl");
            result.Columns.Add("Okres", "Okres");
            result.Columns.Add("Kraj", "Kraj");
            result.Columns.Add("Město", "Město");

            result.CellContentDoubleClick += Result_CellContentDoubleClick;
            insertbutton.Text = "Přidat oddíl";
            insertbutton.Click += Insertbutton_Click;


        }

        private void Insertbutton_Click(object sender, EventArgs e)
        {
            insertform = new Form()
            {

                Text = "Vložit oddíl",
                Width = 350,
                Height = 400

            };

            ComboBox districtselector = new ComboBox() { Width = 170, Height = 40, Visible = true, Parent = insertform, Left = 60 };
            Collection<District> items = DistrictOperations.Select();

            for (int i = 0; i < items.Count; i++)
            {
                districtselector.Items.Add(String.Format("{0}({1})", items[i].Code, items[i].Name));
            }
            districtselector.SelectedIndexChanged += Districtselector_SelectedIndexChanged;

            insertinfo = new TableLayoutPanel();
            insertinfo.Parent = insertform;
            insertinfo.RowCount = 5;
            insertinfo.ColumnCount = 2;
            insertinfo.Visible = true;
            insertinfo.Width = insertform.Width;
            insertinfo.Height = 2 * insertform.Height / 3;
            insertinfo.ColumnStyles.Add(new ColumnStyle(SizeType.AutoSize));



            insertinfo.Controls.Add(new Label() { Width = 50, Height = 40, Visible = true, Parent = insertform, Text = String.Format("Název:"), Left = 5 }, 0, 0);
            insertinfo.Controls.Add(new Label() { Width = 50, Height = 40, Visible = true, Parent = insertform, Text = String.Format("Telefon jednatele:"), Left = 5 }, 0, 1);
            insertinfo.Controls.Add(new Label() { Width = 50, Height = 40, Visible = true, Parent = insertform, Text = String.Format("Email jednatele:"), Left = 5 }, 0, 2);
            insertinfo.Controls.Add(new Label() { Width = 50, Height = 40, Visible = true, Parent = insertform, Text = String.Format("Web:"), Left = 5 }, 0, 3);
            insertinfo.Controls.Add(new Label() { Width = 50, Height = 40, Visible = true, Parent = insertform, Text = String.Format("Okres:"), Left = 5 }, 0, 4);
            insertinfo.Controls.Add(new Label() { Width = 50, Height = 40, Visible = true, Parent = insertform, Text = String.Format("Adresa:"), Left = 5 }, 0, 5);
            insertinfo.Controls.Add(new Label() { Width = 50, Height = 40, Visible = true, Parent = insertform, Text = String.Format("Město"), Left = 5 }, 0, 6);



            insertinfo.Controls.Add(new TextBox() { Width = 170, Height = 40, Visible = true, Parent = insertform, Left = 60 }, 1, 0);
            insertinfo.Controls.Add(new TextBox() { Width = 170, Height = 40, Visible = true, Parent = insertform, Left = 60 }, 1, 1);
            insertinfo.Controls.Add(new TextBox() { Width = 170, Height = 40, Visible = true, Parent = insertform, Left = 60 }, 1, 2);
            insertinfo.Controls.Add(new TextBox() { Width = 170, Height = 40, Visible = true, Parent = insertform, Left = 60 }, 1, 3);
            insertinfo.Controls.Add(districtselector, 1, 4);
            insertinfo.Controls.Add(new TextBox() { Width = 170, Height = 40, Visible = true, Parent = insertform, Left = 60 }, 1, 5);
            insertinfo.Controls.Add(new TextBox() { Width = 170, Height = 40, Visible = true, Parent = insertform, Left = 60 }, 1, 6);


            confirminsert = new Button()
            {
                Height = 30,
                Width = 100,
                Parent = insertform,
                Visible = true,
                Left = 20,
                Top = insertinfo.Bottom + 10,
                Text = "Uložit"
            };
            confirminsert.Click += Confirminsert_Click;
            insertform.Show();


        }

        private void Confirminsert_Click(object sender, EventArgs e)
        {
            Club c = new Club();

            c.Name = insertinfo.GetControlFromPosition(1, 0).Text;
            if (insertinfo.GetControlFromPosition(1, 0).Text == "") { MessageBox.Show("Zadejte název"); return; }
            string num = insertinfo.GetControlFromPosition(1, 1).Text;
            if (num.Length != 9 && num.Length != 0)
            {

                MessageBox.Show("Chyba vstupu atributu telefonní číslo"); return;
            }
            try
            {

                c.ManagerPhoneNumber = num == "" ? null : (int?)Convert.ToInt32(num);

            }
            catch { MessageBox.Show("Chyba vstupu atributu telefonní číslo"); return; }


            c.ManagerEmail = insertinfo.GetControlFromPosition(1, 2).Text;
            if (!c.ManagerEmail.Contains("@") && c.ManagerEmail != "")
            {

                MessageBox.Show("Chyba vstupu atributu email"); return;
            }
            c.Web = insertinfo.GetControlFromPosition(1, 3).Text;
            try { c.HomeDistrict = (District)(insertinfo.GetControlFromPosition(1, 4).Tag); } catch { MessageBox.Show("Chyba na vstupu argumentu okres"); return; }
            c.Address = insertinfo.GetControlFromPosition(1, 5).Text;
            c.City = insertinfo.GetControlFromPosition(1, 6).Text;
            if (c.City == "") { MessageBox.Show("Zadejte město"); return; }

            try { ClubOperations.Insert(c); } catch (Exception ex) { MessageBox.Show(String.Format("Nepodařilo se vložit oddíl {0}{1}", Environment.NewLine, ex.Message)); return; }
            ((Control)sender).Parent.Dispose();
        }

        private void Districtselector_SelectedIndexChanged(object sender, EventArgs e)
        {
            ((ComboBox)sender).Tag = DistrictOperations.Select(((ComboBox)sender).SelectedItem.ToString().Split('(')[0]);

        }

        private void Result_CellContentDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            DataGridView s = (DataGridView)sender;
            ControlClicked(((Club)(s.Rows[e.RowIndex].Tag)).ID);
        }

        private void ClubSearcher_Load(object sender, EventArgs e)
        {

        }

        private void Searchbutton_Click(object sender, EventArgs e)
        {
            if (searchbox.Text == "")
            { return; }
            Collection<Club> clublist = ClubOperations.Select(searchbox.Text);


            result.Rows.Clear();
            for (int i = 0; i < clublist.Count; i++)
            {
                result.Rows.Add(clublist[i].Name, clublist[i].HomeDistrict.Name, clublist[i].HomeDistrict.HomeRegion.Name, clublist[i].City);
                result.Rows[i].Tag = clublist[i];


            }


        }





    }
}
