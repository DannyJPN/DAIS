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
using System.Text.RegularExpressions;

namespace RegisterProjectWinForm
{
    public partial class TeamDetail : Detail
    {
        public TeamDetail()
        {
            InitializeComponent();
            info = new TableLayoutPanel();
     
           
            
            playerlist = new DataGridView();
            TeamToBeDisplayed = new Team();
            updatebutton.Click += Updatebutton_Click;
            deletebutton.Click += Deletebutton_Click;
            playerlist.Parent = this;
            playerlist.ReadOnly = true;
            playerlist.Columns.Add("Hráč", "Hráč");
            playerlist.Columns.Add("Bilance", "Bilance");
            playerlist.CellBorderStyle = DataGridViewCellBorderStyle.None;

            playerlist.DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter;
            playerlist.DefaultCellStyle.BackColor = playerlist.Parent.BackColor;
            playerlist.RowHeadersVisible = false;
            playerlist.BorderStyle = BorderStyle.None;
            playerlist.BackgroundColor = playerlist.Parent.BackColor;
            playerlist.ColumnHeadersVisible = false;
            playerlist.AutoGenerateColumns = false;
            playerlist.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.DisplayedCells;
            playerlist.CellContentDoubleClick += Playerlist_CellContentDoubleClick;
            playerlist.ScrollBars = ScrollBars.Vertical;
            info.Parent = this;
            info.Visible = true;
            info.RowCount = 4;
            info.ColumnCount = 2;
            info.Controls.Add(new Label(), 1, 0);
            info.Width = 400;
            info.Height = 200;
            info.ColumnStyles.Add(new ColumnStyle(SizeType.AutoSize));
            for (int i = 1; i < info.RowCount; i++)
            {
                info.Controls.Add(new Label(), 0, i);

            }
            addplayerbutton = new Button();
            removeplayerbutton = new Button();
            addplayerbutton.Visible = removeplayerbutton.Visible = true;
            addplayerbutton.Parent = removeplayerbutton.Parent = this;
            addplayerbutton.Size = removeplayerbutton.Size = new Size(100,50);
            addplayerbutton.Text = "Přidat hráče";
            removeplayerbutton.Text = "Odstranit hráče";
            addplayerbutton.Left = deletebutton.Right+20;
            removeplayerbutton.Left = addplayerbutton.Right + 20;
            addplayerbutton.Top = removeplayerbutton.Top = updatebutton.Top;
            addplayerbutton.Click += Addplayerbutton_Click;
            removeplayerbutton.Click += Removeplayerbutton_Click;


        }

        private void Removeplayerbutton_Click(object sender, EventArgs e)
        {
            removeplayerform = new Form()
            {

                Text = "Odebrat hráče",
                Width = 600,
                Height = 400

            };
            Label sign = new Label() { Top = 20, Width = 150, Height = 40, Visible = true, Parent = removeplayerform, Text = String.Format("Vyberte hráče:"), Left = 5 };

            ComboBox playerselector = new ComboBox() { Top = 70, Width = 200, Height = 40, Visible = true, Parent = removeplayerform, Left = 5 };
            

            for (int i = 0; i < TeamToBeDisplayed.Members.Count; i++)
            {

                  playerselector.Items.Add(String.Format("{0}({1} {2})", TeamToBeDisplayed.Members[i].ID, TeamToBeDisplayed.Members[i].Surname, TeamToBeDisplayed.Members[i].Name));
              

            }
            playerselector.SelectedIndexChanged += (object o, EventArgs ea) =>
            {
                playerselector.Tag = PlayerOperations.Select(Convert.ToInt32(playerselector.SelectedItem.ToString().Split('(')[0]));
            };



            confirmremoveplayer = new Button()
            {
                Height = 30,
                Width = 100,
                Parent = removeplayerform,
                Visible = true,
                Left = 20,
                Top = playerselector.Bottom + 10,
                Text = "Smazat"
            };
            confirmremoveplayer.Click += (object o, EventArgs ea) =>
            {
                Player p = (Player)(playerselector.Tag);
                try
                {
                    TeamOperations.RemovePlayer(TeamToBeDisplayed, p);
                }
                catch (Exception ex) { MessageBox.Show(String.Format("Nepodařilo se smazat hráče {0}{1}", Environment.NewLine, ex.Message)); return; }
                removeplayerform.Dispose();
            };
            removeplayerform.Show();

        }

        private void Addplayerbutton_Click(object sender, EventArgs e)
        {
            addplayerform = new Form()
            {

                Text = "Přidat hráče",
                Width = 600,
                Height = 400

            };
            Label sign = new Label() { Top = 20, Width = 150, Height = 40, Visible = true, Parent = addplayerform, Text = String.Format("Vyberte hráče:"), Left = 5 };

            ComboBox playerselector = new ComboBox() {Top = 70, Width = 200, Height = 40, Visible = true, Parent = addplayerform, Left = 5};
            Collection<Player> playerlist = PlayerOperations.Select();
           

            for (int i = 0; i < playerlist.Count; i++)
            {

                PlayerOperations.FindClub(playerlist[i], seasonselected);
                if (playerlist[i].HomeClub == null)
                {
                    playerselector.Items.Add(String.Format("{0}({1} {2})", playerlist[i].ID, playerlist[i].Surname, playerlist[i].Name));
                    continue;
                }


                if ( (playerlist[i].HomeClub == TeamToBeDisplayed.HomeClub ) &&
                    !TeamToBeDisplayed.Members.Contains(playerlist[i]) )
                {

                    PlayerOperations.FindTeams(playerlist[i], seasonselected);
                    
                    if (playerlist[i].Teams.Count < 3 &&
                    !playerlist[i].Teams.Any(t => t.CompetitionClass == TeamToBeDisplayed.CompetitionClass))
                    {
                        playerselector.Items.Add(String.Format("{0}({1} {2})", playerlist[i].ID, playerlist[i].Surname, playerlist[i].Name));


                    }
                }
                
            }
            playerselector.SelectedIndexChanged += (object o, EventArgs ea) =>
              {
                  playerselector.Tag = PlayerOperations.Select(Convert.ToInt32(playerselector.SelectedItem.ToString().Split('(')[0]));
              };



            confirmaddplayer = new Button()
            {
                Height = 30,
                Width = 100,
                Parent = addplayerform,
                Visible = true,
                Left = 20,
                Top = playerselector.Bottom + 10,
                Text = "Uložit"
            };
            confirmaddplayer.Click += (object o,EventArgs ea)=> 
            {
                Player p = (Player)(playerselector.Tag);
                try
                {
                    TeamOperations.AddPlayer(TeamToBeDisplayed, p);
                }
                catch (Exception ex) { MessageBox.Show(String.Format("Nepodařilo se přidat hráče {0}{1}", Environment.NewLine, ex.Message)); return; }
                addplayerform.Dispose();
            };
            addplayerform.Show();

        }

        public Team TeamToBeDisplayed { get; set; }



        private DataGridView playerlist;
        private Form addplayerform, removeplayerform;
        private Button confirmaddplayer, confirmremoveplayer, addplayerbutton, removeplayerbutton;

        private void Playerlist_CellContentDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            DataGridView s = (DataGridView)sender;
            if (e.ColumnIndex == 0)
            {
                ControlClicked(((Player)(s.Rows[e.RowIndex].Tag)).ID);
            }
            else if (e.ColumnIndex == 1)
            {
                ControlClicked(((Player)(s.Rows[e.RowIndex].Tag)).ID,TeamToBeDisplayed.CompetitionClass.ID);
            }
            
       
        }

        private void Deletebutton_Click(object sender, EventArgs e)
        {
            try
            {
                TeamOperations.Delete(TeamToBeDisplayed);
            }
            catch (Exception ex)
            {

                MessageBox.Show(String.Format("Smazání se nezdařilo {0}{1}", Environment.NewLine, ex.Message));
            }
        }

        private void TeamDetail_Load(object sender, EventArgs e)
        {

            playerlist.Left = Parent.Width / 2;
            playerlist.Top = 40;
            playerlist.Height = Parent.Height / 2;





             
        }

        public void Set(Team t)
        {
            TeamToBeDisplayed = t;

            info.Controls[0].Text = String.Format("{0}",TeamToBeDisplayed.Name);
            info.Controls[1].Text = String.Format("Oddíl: {0} ", TeamToBeDisplayed.HomeClub.Name);
            info.Controls[2].Text = String.Format("Soutěž: {0} ", TeamToBeDisplayed.CompetitionClass.Name);
            info.Controls[3].Text = String.Format("Body: {0} ", TeamToBeDisplayed.Points);
            for (int i = 0; i < info.RowCount; i++)
            {
                info.Controls[i].Width = info.Controls[i].Text.Length * (int)(info.Controls[i].Font.Size);

            }

            playerlist.Rows.Clear();
            for (int i = 0; i < TeamToBeDisplayed.Members.Count; i++)

            {

                string playername = String.Format("{0} {1} ", TeamToBeDisplayed.Members[i].Surname, TeamToBeDisplayed.Members[i].Name);
                PlayerOperations.Bilance(TeamToBeDisplayed.Members[i], TeamToBeDisplayed.SeasonOfExistence, TeamToBeDisplayed.CompetitionClass.ID);
                string bil = String.Format("{0}%", TeamToBeDisplayed.Members[i].Bilance);
                playerlist.Rows.Add(playername, bil);
                playerlist.Rows[i].Tag = TeamToBeDisplayed.Members[i];

            }

        }

        private void Updatebutton_Click(object sender, EventArgs e)
        {
            updateform = new Form()
            {

                Text = "Upravit družstvo",
                Width = 600,
                Height = 400

            };

            ComboBox leagueselector = new ComboBox() { Width = 170, Height = 40, Visible = true, Parent = updateform, Left = 60 };
            Collection<League> items = LeagueOperations.Select();

            for (int i = 0; i < items.Count; i++)
            {
                leagueselector.Items.Add(String.Format("{0}({1})", items[i].ID, items[i].Name));
            }
            leagueselector.SelectedIndexChanged += Leagueselector_SelectedIndexChanged;
            leagueselector.SelectedItem = String.Format("{0}({1})", TeamToBeDisplayed.CompetitionClass.ID, TeamToBeDisplayed.CompetitionClass.Name);

            ComboBox clubselector = new ComboBox() { Width = 170, Height = 40, Visible = true, Parent = updateform, Left = 60 };
            Collection<Club> clubs = ClubOperations.Select();

            for (int i = 0; i < clubs.Count; i++)
            {
                clubselector.Items.Add(String.Format("{0}({1})", clubs[i].ID, clubs[i].Name));
            }
            clubselector.SelectedIndexChanged += Clubselector_SelectedIndexChanged; 
            clubselector.SelectedItem = String.Format("{0}({1})", TeamToBeDisplayed.HomeClub.ID, TeamToBeDisplayed.HomeClub.Name);
            ComboBox teamseasonselector = new ComboBox() { Width = 170, Height = 40, Visible = true, Parent = updateform, Left = 60 };
            for (int i = DateTime.Now.Year; i > 2010; i--)
            {
                string season = String.Format("{0}/{1}", i, i + 1);
                if (!teamseasonselector.Items.Contains(season))
                {
                    teamseasonselector.Items.Add(season);
                }

            }

            teamseasonselector.SelectedItem = DateTime.Now.Month < 7 ? teamseasonselector.Items[1] : teamseasonselector.Items[0];


           



            editinfo = new TableLayoutPanel();
            editinfo.Parent = updateform;
            editinfo.RowCount = 5;
            editinfo.ColumnCount = 2;
            editinfo.Visible = true;
            editinfo.Width = updateform.Width;
            editinfo.Height = 2 * updateform.Height / 3;
            editinfo.ColumnStyles.Add(new ColumnStyle(SizeType.AutoSize));

            editinfo.Controls.Add(new Label() { Width = 150, Height = 40, Visible = true, Parent = updateform, Text = String.Format("Název:"), Left = 5 }, 0, 0);
            editinfo.Controls.Add(new Label() { Width = 150, Height = 40, Visible = true, Parent = updateform, Text = String.Format("Soutěž:"), Left = 5 }, 0, 1);
            editinfo.Controls.Add(new Label() { Width = 150, Height = 40, Visible = true, Parent = updateform, Text = String.Format("Oddíl:"), Left = 5 }, 0, 2);
            editinfo.Controls.Add(new Label() { Width = 150, Height = 40, Visible = true, Parent = updateform, Text = String.Format("Sezona:"), Left = 5 }, 0, 3);



            editinfo.Controls.Add(new TextBox() { Width = 170, Height = 40, Visible = true, Parent = updateform, Text = TeamToBeDisplayed.Name, Left = 160 }, 1, 0);
            editinfo.Controls.Add(leagueselector, 1, 1);
            editinfo.Controls.Add(clubselector, 1, 2);
            editinfo.Controls.Add(teamseasonselector, 1, 3);



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

        private void Clubselector_SelectedIndexChanged(object sender, EventArgs e)
        {
            ((ComboBox)sender).Tag = ClubOperations.Select( Convert.ToInt32(((ComboBox)sender).SelectedItem.ToString().Split('(')[0]));

        }

        private void Leagueselector_SelectedIndexChanged(object sender, EventArgs e)
        {
            ((ComboBox)sender).Tag = LeagueOperations.Select(((ComboBox)sender).SelectedItem.ToString().Split('(')[0]);

        }

        
        private void Confirmupdate_Click(object sender, EventArgs e)
        {
            Team t = new Team();
            t.ID = TeamToBeDisplayed.ID;
            t.Name = editinfo.GetControlFromPosition(1, 0).Text;
            if (t.Name == "") { MessageBox.Show("Zadejte název"); return; }

            try { t.CompetitionClass = (League)(editinfo.GetControlFromPosition(1, 1).Tag); } catch { MessageBox.Show("Chyba na vstupu argumentu soutěž"); return; }
            try { t.HomeClub = (Club)(editinfo.GetControlFromPosition(1, 2).Tag); } catch { MessageBox.Show("Chyba na vstupu argumentu soutěž"); return; }
            try { t.SeasonOfExistence = ((ComboBox)(editinfo.GetControlFromPosition(1, 3))).SelectedItem.ToString(); }
            catch { MessageBox.Show("Chyba na vstupu argumentu sezona"); return; }



            try { TeamOperations.Update(t); }
            catch (Exception ex) { MessageBox.Show(String.Format("Nepodařilo se aktualizovat družstvo {0}{1}",Environment.NewLine,ex.Message)); return; }
            ((Control)sender).Parent.Dispose();
        }


    }
}
