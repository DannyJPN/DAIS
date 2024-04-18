using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using RegisterProjectLibrary.DTO;
using System.Collections.ObjectModel;
using RegisterProjectLibrary.DAO;

namespace RegisterProjectWinForm
{
    public partial class ClubDetail : Detail
    {
        public ClubDetail()
        {
            InitializeComponent();
            info = new TableLayoutPanel();
            teamlist = new DataGridView();
            playerlist = new DataGridView();
            updatebutton.Click += Updatebutton_Click;
            deletebutton.Click += Deletebutton_Click;

            teamlist.Parent = this;
            teamlist.ReadOnly = true;
            teamlist.Columns.Add("Tým", "Tým");
            teamlist.Columns.Add("Soutěž", "Soutěž");
            teamlist.CellBorderStyle = DataGridViewCellBorderStyle.None;

            teamlist.DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter;
            teamlist.DefaultCellStyle.BackColor = teamlist.Parent.BackColor;
            teamlist.RowHeadersVisible = false;
            teamlist.BorderStyle = BorderStyle.None;
            teamlist.BackgroundColor = teamlist.Parent.BackColor;
            teamlist.ColumnHeadersVisible = false;
            teamlist.AutoGenerateColumns = false;
            teamlist.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.DisplayedCells;
            teamlist.ScrollBars = ScrollBars.Vertical;
            teamlist.CellContentDoubleClick += Teamlist_CellContentDoubleClick;
            playerlist.Parent = this;
            playerlist.ReadOnly = true;
            playerlist.Columns.Add("Tým", "Tým");
            playerlist.Columns.Add("Soutěž", "Soutěž");
            playerlist.CellBorderStyle = DataGridViewCellBorderStyle.None;
            playerlist.ScrollBars = ScrollBars.None;
            playerlist.DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter;
            playerlist.DefaultCellStyle.BackColor = playerlist.Parent.BackColor;
            playerlist.RowHeadersVisible = false;
            playerlist.BorderStyle = BorderStyle.None;
            playerlist.BackgroundColor = playerlist.Parent.BackColor;
            playerlist.ColumnHeadersVisible = false;
            playerlist.AutoGenerateColumns = false;
            playerlist.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.DisplayedCells;
            playerlist.ScrollBars = ScrollBars.Vertical;
            playerlist.CellContentDoubleClick += Playerlist_CellContentDoubleClick;
            ClubToBeDisplayed = new Club();


            info.Parent = this;
            info.Visible = true;
            info.RowCount = 7;
            info.ColumnCount = 2;
            info.Controls.Add(new Label(), 1, 0);
            info.Width = 500;
            info.Height = 200;
            info.ColumnStyles.Add(new ColumnStyle(SizeType.AutoSize));
            for (int i = 1; i < info.RowCount; i++)
            {
                info.Controls.Add(new Label(), 0, i);

            }
        }

        private void Deletebutton_Click(object sender, EventArgs e)
        {
            try
            {
                ClubOperations.Delete(ClubToBeDisplayed);
            }
            catch (Exception ex)
            {

                MessageBox.Show(String.Format("Smazání se nezdařilo {0}{1}", Environment.NewLine, ex.Message));
            }
        }

        private DataGridView teamlist;
        private DataGridView playerlist;
        

        public Club ClubToBeDisplayed { get; set; }
        private void ClubDetail_Load(object sender, EventArgs e)
        {
            teamlist.Left = info.Left;
            teamlist.Top = info.Bottom;
            playerlist.Left = Parent.Width / 2;
            playerlist.Top = 40;
            playerlist.Height = Parent.Height / 2;

           



        }
        public void Set(Club c)
        {
            ClubToBeDisplayed = c;

            info.Controls[0].Text = String.Format("{0}", ClubToBeDisplayed.Name);
            info.Controls[1].Text = String.Format("Telefon jednatele: {0} ", ClubToBeDisplayed.ManagerPhoneNumber);
            info.Controls[2].Text = String.Format("Email jednatele: {0} ", ClubToBeDisplayed.ManagerEmail);
            info.Controls[3].Text = String.Format("Web: {0} ", ClubToBeDisplayed.Web);
            info.Controls[4].Text = String.Format("Kraj: {0} ", ClubToBeDisplayed.HomeDistrict.HomeRegion.Name);
            info.Controls[5].Text = String.Format("Okres: {0} ", ClubToBeDisplayed.HomeDistrict.Name);
            info.Controls[6].Text = String.Format("Adresa: {0} ,{1}", ClubToBeDisplayed.Address, ClubToBeDisplayed.City);
            for (int i = 0; i < info.RowCount; i++)
            {
                info.Controls[i].Width = info.Controls[i].Text.Length * (int)(info.Controls[i].Font.Size);

            }
            teamlist.Rows.Clear();
            playerlist.Rows.Clear();
            for (int i = 0; i < ClubToBeDisplayed.Teams.Count; i++)

            {

                string teamname = String.Format("{0}", ClubToBeDisplayed.Teams[i].Name);
                string league = String.Format("{0}", ClubToBeDisplayed.Teams[i].CompetitionClass.ID);
                teamlist.Rows.Add(teamname, league);
                teamlist.Rows[i].Tag = ClubToBeDisplayed.Teams[i];

            }
            for (int i = 0; i < ClubToBeDisplayed.Members.Count; i++)

            {

                string playername = String.Format("{0} {1}", ClubToBeDisplayed.Members[i].Name, ClubToBeDisplayed.Members[i].Surname);
                string year = String.Format("{0}", ClubToBeDisplayed.Members[i].Birthdate.Year);
                playerlist.Rows.Add(playername, year);
                playerlist.Rows[i].Tag = ClubToBeDisplayed.Members[i];

            }
            //MessageBox.Show(String.Format("{0}and{1}", ClubToBeDisplayed.Members.Count, ClubToBeDisplayed.Teams.Count));

        }
        private void Updatebutton_Click(object sender, EventArgs e)
        {
            updateform = new Form()
            {
                
                Text = "Upravit klub",
                Width = 350,
                Height = 400

            };

            ComboBox districtselector = new ComboBox() { Width = 170, Height = 40, Visible = true, Parent = updateform, Left = 60 };
            Collection<District> items = DistrictOperations.Select();
            
            for (int i = 0; i < items.Count; i++)
            {
               districtselector.Items.Add(String.Format("{0}({1})",items[i].Code,items[i].Name));  
            }
            districtselector.SelectedIndexChanged += Districtselector_SelectedIndexChanged;
            districtselector.SelectedItem = String.Format("{0}({1})", ClubToBeDisplayed.HomeDistrict.Code, ClubToBeDisplayed.HomeDistrict.Name) ;
            
            editinfo = new TableLayoutPanel();
            editinfo.Parent = updateform;
            editinfo.RowCount = 5;
            editinfo.ColumnCount = 2;
            editinfo.Visible = true;
            editinfo.Width = updateform.Width;
            editinfo.Height = 2 * updateform.Height / 3;
            editinfo.ColumnStyles.Add(new ColumnStyle(SizeType.AutoSize));
            
            
              
            editinfo.Controls.Add(new Label(){  Width = 50,Height = 40,Visible=true,Parent=updateform,      Text=String.Format("Název:"),  Left = 5}, 0, 0);
            editinfo.Controls.Add(new Label() { Width = 50,Height = 40,Visible = true, Parent = updateform, Text = String.Format("Telefon jednatele:"), Left = 5 }, 0, 1);
            editinfo.Controls.Add(new Label() { Width = 50,Height = 40,Visible = true, Parent = updateform, Text = String.Format("Email jednatele:"), Left = 5 }, 0, 2);
            editinfo.Controls.Add(new Label() { Width = 50,Height = 40,Visible = true, Parent = updateform, Text = String.Format("Web:"), Left = 5 }, 0, 3);
            editinfo.Controls.Add(new Label() { Width = 50,Height = 40,Visible = true, Parent = updateform, Text = String.Format("Okres:"), Left = 5 }, 0, 4);
            editinfo.Controls.Add(new Label() { Width = 50,Height = 40,Visible = true, Parent = updateform, Text = String.Format("Adresa:"), Left = 5 }, 0, 5);
            editinfo.Controls.Add(new Label() { Width = 50,Height = 40,Visible = true, Parent = updateform, Text = String.Format("Město" ), Left = 5 }, 0, 6);



            editinfo.Controls.Add(new TextBox(){ Width = 170,Height = 40, Visible=true,Parent=updateform,Text=ClubToBeDisplayed.Name,Left = 60},1, 0);
            editinfo.Controls.Add(new TextBox() {Width = 170,Height = 40, Visible = true, Parent = updateform, Text = ClubToBeDisplayed.ManagerPhoneNumber.ToString(), Left = 60 },1, 1);
            editinfo.Controls.Add(new TextBox() {Width = 170,Height = 40, Visible = true, Parent = updateform, Text = ClubToBeDisplayed.ManagerEmail, Left = 60 },1, 2);
            editinfo.Controls.Add(new TextBox() {Width = 170,Height = 40, Visible = true, Parent = updateform, Text = ClubToBeDisplayed.Web, Left = 60 },1, 3);
            editinfo.Controls.Add(districtselector,1, 4);
            editinfo.Controls.Add(new TextBox() {Width = 170,Height = 40, Visible = true, Parent = updateform, Text = ClubToBeDisplayed.Address, Left = 60 },1, 5);
            editinfo.Controls.Add(new TextBox() {Width = 170,Height = 40, Visible = true, Parent = updateform, Text = ClubToBeDisplayed.City, Left = 60 },1, 6);


             confirmupdate = new Button()
            {
                Height = 30,
                Width = 100,
                Parent = updateform,
                Visible = true,
                Left = 20,
                Top = editinfo.Bottom + 10,
                Text = "Uložit"
            };
              confirmupdate.Click += Confirmupdate_Click;
              updateform.Show();



        }

        private void Districtselector_SelectedIndexChanged(object sender, EventArgs e)
        {
           
            ((ComboBox)sender).Tag = DistrictOperations.Select(((ComboBox)sender).SelectedItem.ToString().Split('(')[0]);
            
        }

        private void Confirmupdate_Click(object sender, EventArgs e)
        {
            Club c = new Club();
            c.ID = ClubToBeDisplayed.ID;
            c.Name = editinfo.GetControlFromPosition(1,0).Text;
            if (editinfo.GetControlFromPosition(1,0).Text == "") { MessageBox.Show("Zadejte název");return; }

           
            string num = editinfo.GetControlFromPosition(1, 1).Text;
            if (num.Length != 9 && num.Length != 0)
            {

                MessageBox.Show("Chyba vstupu atributu telefonní číslo"); return;
            }
            try
            {

                c.ManagerPhoneNumber = num == "" ? null : (int?)Convert.ToInt32(num);

            }
            catch { MessageBox.Show("Chyba vstupu atributu telefonní číslo"); return; }




            c.ManagerEmail=editinfo.GetControlFromPosition(1, 2).Text;
            if (!c.ManagerEmail.Contains("@") && c.ManagerEmail != "")
            {

                MessageBox.Show("Chyba vstupu atributu email"); return;
            }
            c.Web=editinfo.GetControlFromPosition(1, 3).Text;
            try { c.HomeDistrict = (District)(editinfo.GetControlFromPosition(1, 4).Tag); } catch { MessageBox.Show("Chyba na vstupu argumentu okres");return; }
            c.Address=editinfo.GetControlFromPosition(1, 5).Text;
            c.City=editinfo.GetControlFromPosition(1, 6).Text;
            if (c.City== "") { MessageBox.Show("Zadejte město"); return; }

            try { ClubOperations.Update(c); } catch { MessageBox.Show("Nepodařilo se aktualizovat klub"); return; }
            ((Control)sender).Parent.Dispose();

        }

        private void Teamlist_CellContentDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            DataGridView s = (DataGridView)sender;

            ControlClicked(((Team)(s.Rows[e.RowIndex].Tag)).ID, ((Team)(s.Rows[e.RowIndex].Tag)).CompetitionClass.ID);
        }
        private void Playerlist_CellContentDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            DataGridView s = (DataGridView)sender;
            ControlClicked(((Player)(s.Rows[e.RowIndex].Tag)).ID);
        }
    }
}
