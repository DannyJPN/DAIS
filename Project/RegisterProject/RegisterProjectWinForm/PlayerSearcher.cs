using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Collections.ObjectModel;
using RegisterProjectLibrary.DTO;
using RegisterProjectLibrary.DAO;

namespace RegisterProjectWinForm
{
    public partial class PlayerSearcher : Searcher
    {
        public PlayerSearcher()
        {
            InitializeComponent();
            indicator.Text = "Vyhledat hráče";

            searchbutton.Click += Searchbutton_Click;



            result.Columns.Add("Hráč", "Hráč");
            result.Columns.Add("Ročník", "Ročník");
            result.Columns.Add("Telefon", "Telefon");
            result.Columns.Add("Email", "Email");

            result.CellContentDoubleClick += Result_CellContentDoubleClick;
            insertbutton.Text = "Přidat hráče";
            insertbutton.Click += Insertbutton_Click;

        }

        private void Insertbutton_Click(object sender, EventArgs e)
        {
            insertform = new Form()
            {

                Text = "Vložit hráče",
                Width = 600,
                Height = 400

            };
            insertinfo = new TableLayoutPanel();
            insertinfo.Parent = insertform;
            insertinfo.RowCount = 5;
            insertinfo.ColumnCount = 2;
            insertinfo.Visible = true;
            insertinfo.Width = insertform.Width;
            insertinfo.Height = 2 * insertform.Height / 3;
            insertinfo.ColumnStyles.Add(new ColumnStyle(SizeType.AutoSize));
            insertinfo.Controls.Add(new Label() { Width = 150, Height = 40, Visible = true, Parent = insertform, Text = String.Format("Jméno:"), Left = 5 }, 0, 0);
            insertinfo.Controls.Add(new Label() { Width = 150, Height = 40, Visible = true, Parent = insertform, Text = String.Format("Příjmení:"), Left = 5 }, 0, 1);
            insertinfo.Controls.Add(new Label() { Width = 150, Height = 40, Visible = true, Parent = insertform, Text = String.Format("Email:"), Left = 5 }, 0, 2);
            insertinfo.Controls.Add(new Label() { Width = 150, Height = 40, Visible = true, Parent = insertform, Text = String.Format("Telefon:"), Left = 5 }, 0, 3);
            insertinfo.Controls.Add(new Label() { Width = 150, Height = 40, Visible = true, Parent = insertform, Text = String.Format("Datum narození:"), Left = 5 }, 0, 4);

            DateTimePicker date = new DateTimePicker();
            date.MaxDate = DateTime.Now;
            date.MinDate = new DateTime(1900, 1, 1);


            insertinfo.Controls.Add(new TextBox() { Width = 170, Height = 40, Visible = true, Parent = insertform, Left = 160 }, 1, 0);
            insertinfo.Controls.Add(new TextBox() { Width = 170, Height = 40, Visible = true, Parent = insertform, Left = 160 }, 1, 1);
            insertinfo.Controls.Add(new TextBox() { Width = 170, Height = 40, Visible = true, Parent = insertform, Left = 160 }, 1, 2);
            insertinfo.Controls.Add(new TextBox() { Width = 170, Height = 40, Visible = true, Parent = insertform, Left = 160 }, 1, 3);
            insertinfo.Controls.Add(date, 1, 4);






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
            Player p = new Player();

            p.Name = insertinfo.GetControlFromPosition(1, 0).Text;
            if (p.Name == "") { MessageBox.Show("Zadejte jméno"); return; }
            p.Surname = insertinfo.GetControlFromPosition(1, 1).Text;
            if (p.Surname == "") { MessageBox.Show("Zadejte příjmení"); return; }
            p.Email = insertinfo.GetControlFromPosition(1, 2).Text;
            if (!p.Email.Contains("@") && p.Email != "")
            {

                MessageBox.Show("Chyba vstupu atributu email"); return;
            }
            string num = insertinfo.GetControlFromPosition(1, 3).Text;
            if (num.Length != 9 && num.Length != 0)
            {

                MessageBox.Show("Chyba vstupu atributu telefonní číslo"); return;
            }
            try
            {

                p.Phonenumber = num == "" ? null : (int?)Convert.ToInt32(num);

            }
            catch
            { MessageBox.Show("Chyba vstupu atributu telefonní číslo"); return; }
            try { p.Birthdate = ((DateTimePicker)insertinfo.GetControlFromPosition(1, 4)).Value; }
            catch { MessageBox.Show("Chyba vstupu atributu datum narození"); return; }


            try { PlayerOperations.Insert(p); } catch (Exception ex) { MessageBox.Show(String.Format("Nepodařilo se vložit hráče {0}{1}", Environment.NewLine, ex.Message)); return; }
            ((Control)sender).Parent.Dispose();
        }

        private void Result_CellContentDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            DataGridView s = (DataGridView)sender;
            ControlClicked(((Player)(s.Rows[e.RowIndex].Tag)).ID);
        }

        private void PlayerSearcher_Load(object sender, EventArgs e)
        {

        }

        private void Searchbutton_Click(object sender, EventArgs e)
        {
            if (searchbox.Text == "")
            { return; }
            List<Player> playerlist = new List<Player>();
            string[] fullname = searchbox.Text.Split(' ', '\t');
            if (fullname.Length < 2)
            {
                playerlist.AddRange(PlayerOperations.Select(fullname[0], ""));
                playerlist.AddRange(PlayerOperations.Select("", fullname[0]));


            }
            else
            {
                playerlist.AddRange(PlayerOperations.Select(fullname[0], fullname[1]));
                playerlist.AddRange(PlayerOperations.Select(fullname[1], fullname[0]));

            }

            result.Rows.Clear();
            for (int i = 0; i < playerlist.Count; i++)
            {


                result.Rows.Add(playerlist[i].Surname + " " + playerlist[i].Name, playerlist[i].Birthdate.Year, playerlist[i].Phonenumber, playerlist[i].Email);
                result.Rows[i].Tag = playerlist[i];

            }
        }


    }
}
