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
using RegisterProjectLibrary.DAO;
using System.Collections.ObjectModel;

namespace RegisterProjectWinForm
{
    public partial class PlayerDetail : Detail
    {
        public PlayerDetail()
        {
            InitializeComponent();
            info = new TableLayoutPanel(); 
            PlayerToBeDisplayed = new Player();
            teams_bilances = new DataGridView();

            updatebutton.Click += Updatebutton_Click;
            deletebutton.Click += Deletebutton_Click;
            teams_bilances.Parent = this;
            teams_bilances.ReadOnly = true;
            teams_bilances.Columns.Add("Tým", "Tým");
            teams_bilances.Columns.Add("Bilance", "Bilance");
            teams_bilances.CellBorderStyle= DataGridViewCellBorderStyle.None;

            teams_bilances.DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter;
            teams_bilances.DefaultCellStyle.BackColor = teams_bilances.Parent.BackColor;
            teams_bilances.RowHeadersVisible = false;
            teams_bilances.BorderStyle = BorderStyle.None;
            teams_bilances.BackgroundColor = teams_bilances.Parent.BackColor;
            teams_bilances.ColumnHeadersVisible = false;
            teams_bilances.AutoGenerateColumns = false;
            teams_bilances.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.DisplayedCells;
            teams_bilances.CellContentDoubleClick += Teams_bilances_CellContentDoubleClick;
            teams_bilances.ScrollBars = ScrollBars.Vertical;

            info.Parent = this;
            info.Visible = true;
            info.RowCount = 5;
            info.ColumnCount = 2;
            info.Controls.Add(new Label(), 1, 0);
            info.Width = 400;
            info.Height = 200;
            info.ColumnStyles.Add(new ColumnStyle(SizeType.AutoSize));
            for (int i = 1; i < info.RowCount; i++)
            {
                info.Controls.Add(new Label()  , 0, i);
                
            }
            addmatchbutton = new Button();
            removematchbutton = new Button();
            addmatchbutton.Visible = removematchbutton.Visible = true;
            addmatchbutton.Parent = removematchbutton.Parent = this;
            addmatchbutton.Size = removematchbutton.Size = new Size(100, 50);
            addmatchbutton.Text = "Přidat zápas";
            removematchbutton.Text = "Smazat zápas";
            addmatchbutton.Left = deletebutton.Right +20;
            removematchbutton.Left = addmatchbutton.Right + 20;
            addmatchbutton.Top = removematchbutton.Top = updatebutton.Top;
            addmatchbutton.Click += Addmatchbutton_Click;
            removematchbutton.Click += Removematchbutton_Click;

        }

        private void Removematchbutton_Click(object sender, EventArgs e)
        {
            removematchform = new Form()
            {

                Text = "Odebrat zápas",
                Width = 600,
                Height = 400

            };
            Label sign = new Label() {Top=20, Width = 150, Height = 40, Visible = true, Parent = removematchform, Text = String.Format("Vyberte sezonu a zápas:"), Left = 5 };

            ComboBox matchselector = new ComboBox() { Top = 120, Width = 200, Height = 40, Visible = true, Parent = removematchform, Left = 5 };

            ComboBox leaguetoremove_selector = new ComboBox() { Top = 60, Width = 200, Height = 40, Visible = true, Parent = removematchform, Left = 5 };
            for (int i = 0; i < PlayerToBeDisplayed.Teams.Count; i++)
            {
                leaguetoremove_selector.Items.Add(String.Format("{0}({1})", PlayerToBeDisplayed.Teams[i].CompetitionClass.ID, PlayerToBeDisplayed.Teams[i].CompetitionClass.Name));
            }
            leaguetoremove_selector.SelectedIndexChanged += (object send,EventArgs ea)=> 
            {
                matchselector.Items.Clear();
                Collection<Match> matchlist = MatchOperations.Select(PlayerToBeDisplayed.ID, seasonselected, leaguetoremove_selector.SelectedItem.ToString().Split('(')[0]);
                for (int i = 0; i < matchlist.Count; i++)
                {
                    matchselector.Items.Add(matchlist[i]);
                }
                
            };

            confirmremovematch = new Button()
            {
                Height = 30,
                Width = 100,
                Parent = removematchform,
                Visible = true,
                Left = 20,
                Top = matchselector.Bottom + 10,
                Text = "Smazat"
            };
            confirmremovematch.Click += (object send, EventArgs ea)=>
            {
                Match m = (Match)(matchselector.SelectedItem);
                try { MatchOperations.Delete(m); }
                catch (Exception ex) { MessageBox.Show(String.Format("Nepodařilo se smazat zápas {0}{1}", Environment.NewLine, ex.Message)); return; }
                removematchform.Dispose();


            };
            removematchform.Show();

            


        }

        

        private DataGridView teams_bilances;
        private Button addmatchbutton, removematchbutton;
        private Form addmatchform;
        private Form removematchform;

        private TableLayoutPanel matchinfo;
        private Button confirmaddmatch;
        private Button confirmremovematch;

        public Player PlayerToBeDisplayed { get; set; }

        private void Addmatchbutton_Click(object sender, EventArgs e)
        {
            addmatchform = new Form()
            {

                Text = "Přidat zápas",
                Width = 600,
                Height = 400

            };
            matchinfo = new TableLayoutPanel();
            matchinfo.Parent = addmatchform;
            matchinfo.RowCount = 6;
            matchinfo.ColumnCount = 2;
            matchinfo.Visible = true;
            matchinfo.Width = addmatchform.Width;
            matchinfo.Height = 2 * addmatchform.Height / 3;
            matchinfo.ColumnStyles.Add(new ColumnStyle(SizeType.AutoSize));
            matchinfo.Controls.Add(new Label() { Width = 150, Height = 40, Visible = true, Parent = addmatchform, Text = String.Format("Oponent:"), Left = 5 }, 0, 0);

            matchinfo.Controls.Add(new Label() { Width = 150, Height = 40, Visible = true, Parent = addmatchform, Text = String.Format("Skóre hráče:"), Left = 5 }, 0, 1);
            matchinfo.Controls.Add(new Label() { Width = 150, Height = 40, Visible = true, Parent = addmatchform, Text = String.Format("Skóre oponenta:"), Left = 5 }, 0, 2);
            matchinfo.Controls.Add(new Label() { Width = 150, Height = 40, Visible = true, Parent = addmatchform, Text = String.Format("Datum:"), Left = 5 }, 0, 3);
            matchinfo.Controls.Add(new Label() { Width = 150, Height = 40, Visible = true, Parent = addmatchform, Text = String.Format("Soutěž:"), Left = 5 }, 0, 4);
            matchinfo.Controls.Add(new Label() { Width = 150, Height = 40, Visible = true, Parent = addmatchform, Text = String.Format("Místo:"), Left = 5 }, 0, 5);

            DateTimePicker date = new DateTimePicker();
            date.MaxDate = DateTime.Now;
            date.MinDate = new DateTime(1900, 1, 1);

            ComboBox oponentselector = new ComboBox() { Width = 170, Height = 40, Visible = true, Parent = updateform, Left = 60 };
            oponentselector.SelectedIndexChanged += Oponentselector_SelectedIndexChanged;

            ComboBox scorethisplayer_selector=new ComboBox() { Width = 170, Height = 40, Visible = true, Parent = updateform, Left = 60 };
            for (int i = 0; i <=3; i++)
            {
                scorethisplayer_selector.Items.Add(i);

            }
            scorethisplayer_selector.SelectedIndex = 0;
            scorethisplayer_selector.SelectedIndexChanged += Scorethisplayer_selector_SelectedIndexChanged;

            ComboBox scoreopponent_selector = new ComboBox() { Width = 170, Height = 40, Visible = true, Parent = updateform, Left = 60 };
            for (int i = 0; i <= 3; i++)
            {
                scoreopponent_selector.Items.Add(i);

            }
            scoreopponent_selector.SelectedIndex = 0;
            scoreopponent_selector.SelectedIndexChanged += Scoreopponent_selector_SelectedIndexChanged;

            ComboBox homeoutselector = new ComboBox() { Width = 170, Height = 40, Visible = true, Parent = updateform, Left = 60 };

            homeoutselector.Items.Add("Doma");
            homeoutselector.Items.Add("Venku");
            homeoutselector.SelectedIndex = 0;




            ComboBox leagueselector = new ComboBox() { Width = 170, Height = 40, Visible = true, Parent = updateform, Left = 60 };
            for (int i = 0; i < PlayerToBeDisplayed.Teams.Count; i++)
            {
                leagueselector.Items.Add(String.Format("{0}({1})", PlayerToBeDisplayed.Teams[i].CompetitionClass.ID, PlayerToBeDisplayed.Teams[i].CompetitionClass.Name));
            }
            leagueselector.SelectedIndexChanged += Leagueselector_SelectedIndexChanged;



            matchinfo.Controls.Add(oponentselector,1, 0);

            matchinfo.Controls.Add(scorethisplayer_selector, 1, 1);
            matchinfo.Controls.Add(scoreopponent_selector, 1, 2);
            matchinfo.Controls.Add(date, 1, 3);
            matchinfo.Controls.Add(leagueselector, 1, 4);
            matchinfo.Controls.Add(homeoutselector, 1, 5);







            confirmaddmatch = new Button()
            {
                Height = 30,
                Width = 100,
                Parent = addmatchform,
                Visible = true,
                Left = 20,
                Top = matchinfo.Bottom + 10,
                Text = "Uložit"
            };
            confirmaddmatch.Click += Confirmaddmatch_Click;
            addmatchform.Show();






        }

        private void Confirmaddmatch_Click(object sender, EventArgs e)
        {
            Match m = new Match();
            string homeout = ((ComboBox)(matchinfo.GetControlFromPosition(1, 5))).SelectedItem.ToString();
            if (homeout == "Doma")
            {
                m.HomePlayer = PlayerToBeDisplayed;
                try { m.HostPlayer = (Player)(matchinfo.GetControlFromPosition(1, 0).Tag); } catch { MessageBox.Show("Chyba na vstupu argumentu oponent"); return; }
                try { m.HomePlayerScore = Convert.ToInt32(((ComboBox)matchinfo.GetControlFromPosition(1, 1)).SelectedItem.ToString()); } catch { MessageBox.Show("Chyba na vstupu argumentu skóre hráče"); return; }
                try { m.HostPlayerScore = Convert.ToInt32(((ComboBox)matchinfo.GetControlFromPosition(1, 2)).SelectedItem.ToString()); } catch { MessageBox.Show("Chyba na vstupu argumentu skóre oponenta"); return; }
                
            }
            else if (homeout == "Venku")
            {
                m.HostPlayer = PlayerToBeDisplayed;
                try { m.HomePlayer = (Player)(matchinfo.GetControlFromPosition(1, 0).Tag); } catch { MessageBox.Show("Chyba na vstupu argumentu oponent"); return; }
                try { m.HomePlayerScore = Convert.ToInt32(((ComboBox)matchinfo.GetControlFromPosition(1, 2)).SelectedItem.ToString()); } catch { MessageBox.Show("Chyba na vstupu argumentu skóre hráče"); return; }
                try { m.HostPlayerScore = Convert.ToInt32(((ComboBox)matchinfo.GetControlFromPosition(1, 1)).SelectedItem.ToString()); } catch { MessageBox.Show("Chyba na vstupu argumentu skóre oponenta"); return; }

            }
            m.Season = seasonselected;
            try { m.CompetitionClass = (League)(matchinfo.GetControlFromPosition(1, 4).Tag); }
            catch { MessageBox.Show(String.Format("Chyba na vstupu argumentu soutěž")); return; }
            try { m.DateOfOccurrence = ((DateTimePicker)matchinfo.GetControlFromPosition(1, 3)).Value; }
            catch { MessageBox.Show("Chyba vstupu atributu datum"); return; }

            try { MatchOperations.Insert(m); }
            catch (Exception ex) { MessageBox.Show(String.Format("Nepodařilo se přidat zápas {0}{1}", Environment.NewLine, ex.Message)); return; }
            ((Control)sender).Parent.Dispose();


        }

        public void Matchseasonselector_SelectedIndexChanged()
        {
        
            string leagueID = ((ComboBox)matchinfo.GetControlFromPosition(1, 4)).SelectedItem.ToString();

            Oponentselector_ItemUpdate(seasonselected, leagueID);
        }

        private void Oponentselector_SelectedIndexChanged(object sender, EventArgs e)
        {
            ((ComboBox)sender).Tag = PlayerOperations.Select(Convert.ToInt32(((ComboBox)sender).SelectedItem.ToString().Split('(')[0]));
        }

        private void Scoreopponent_selector_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (Convert.ToInt32(((ComboBox)sender).SelectedItem.ToString()) != 3)
            {
                ((ComboBox)matchinfo.GetControlFromPosition(1, 1)).SelectedItem = 3;
            }
       
                
                 
        }

        private void Scorethisplayer_selector_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (Convert.ToInt32(((ComboBox)sender).SelectedItem.ToString()) != 3)
            {
                ((ComboBox)matchinfo.GetControlFromPosition(1, 2)).SelectedItem = 3;
            }
        }

        private void Leagueselector_SelectedIndexChanged(object sender, EventArgs e)
        {
            ((ComboBox)sender).Tag = LeagueOperations.Select(((ComboBox)sender).SelectedItem.ToString().Split('(')[0]);
            
            string leagueID = ((League)((ComboBox)matchinfo.GetControlFromPosition(1, 4)).Tag).ID;
            //MessageBox.Show(String.Format("Tag = {0}, leagueID = ({1})", ((ComboBox)sender).Tag==null?"null":((ComboBox)sender).Tag.ToString(),leagueID));
            Oponentselector_ItemUpdate(seasonselected, leagueID);
        }

        private void Oponentselector_ItemUpdate(string season,string leagueID)
        {
  
            Collection<Team> potential_teams = TeamOperations.Select();
            ((ComboBox)matchinfo.GetControlFromPosition(1, 0)).Items.Clear();
           
            for (int i = 0; i < potential_teams.Count; i++)
            {
                
                if (potential_teams[i].CompetitionClass.ID == leagueID && potential_teams[i].SeasonOfExistence == season)
                {
                    TeamOperations.FindMembers(potential_teams[i]);
                    

                    if (!potential_teams[i].Members.Any(p => p.ID == PlayerToBeDisplayed.ID))
                    {
                        for (int j = 0; j < potential_teams[i].Members.Count; j++)
                        {
                        
                            ((ComboBox)matchinfo.GetControlFromPosition(1, 0)).Items.Add(String.Format("{0}({1} {2})", potential_teams[i].Members[j].ID, potential_teams[i].Members[j].Surname, potential_teams[i].Members[j].Name));
                        }

                    }

                }
                    
            }
        }

        private void Deletebutton_Click(object sender, EventArgs e)
        {
            try
            {
                PlayerOperations.Delete(PlayerToBeDisplayed);
            }
            catch (Exception ex)
            {

                MessageBox.Show(String.Format("Smazání se nezdařilo {0}{1}",Environment.NewLine,ex.Message));
            }
        }

 
        private void PlayerDetail_Load(object sender, EventArgs e)
        {
            
            teams_bilances.Left = Parent.Width / 2;
            teams_bilances.Top = 40;
            teams_bilances.Height = Parent.Height / 2;
            
            


            

  
        }
        public void Set(Player p)

        {
            PlayerToBeDisplayed = p;
              

              info.Controls[0].Text = String.Format("{0} {1}", PlayerToBeDisplayed.Name, PlayerToBeDisplayed.Surname);
            
              info.Controls[1].Text = String.Format("Rok narození: {0} ", PlayerToBeDisplayed.Birthdate.Year);
              info.Controls[2].Text = String.Format("Oddíl: {0} ", PlayerToBeDisplayed.Teams != null && PlayerToBeDisplayed.Teams.Count >0 ? PlayerToBeDisplayed.Teams[0].HomeClub.Name : "žádný");
              info.Controls[3].Text = String.Format("Telefon: {0} ", PlayerToBeDisplayed.Phonenumber);
              info.Controls[4].Text = String.Format("Email: {0} ", PlayerToBeDisplayed.Email);
            for (int i = 0; i < info.RowCount; i++)
            {
                info.Controls[i].Width = info.Controls[i].Text.Length * (int)(info.Controls[i].Font.Size);
                
            }

            teams_bilances.Rows.Clear();
            for (int i = 0; i < PlayerToBeDisplayed.Teams.Count; i++)

            {

                string teamname = String.Format("{0}", PlayerToBeDisplayed.Teams[i].Name);
                PlayerOperations.Bilance(PlayerToBeDisplayed, PlayerToBeDisplayed.Teams[i].SeasonOfExistence, PlayerToBeDisplayed.Teams[i].CompetitionClass.ID);
                string bil = String.Format("{0}%", PlayerToBeDisplayed.Bilance);
                teams_bilances.Rows.Add(teamname, bil);
                teams_bilances.Rows[i].Tag = PlayerToBeDisplayed.Teams[i];
                
            }
            
            
        }
        private void Updatebutton_Click(object sender, EventArgs e)
        {
            updateform = new Form()
            {

                Text = "Upravit hráče",
                Width = 600,
                Height = 400

            };
            editinfo = new TableLayoutPanel();
            editinfo.Parent = updateform;
            editinfo.RowCount = 5;
            editinfo.ColumnCount = 2;
            editinfo.Visible = true;
            editinfo.Width = updateform.Width;
            editinfo.Height = 2 * updateform.Height / 3;
            editinfo.ColumnStyles.Add(new ColumnStyle(SizeType.AutoSize));
            editinfo.Controls.Add(new Label() { Width = 150, Height = 40, Visible = true, Parent = updateform, Text = String.Format("Jméno:"), Left = 5 }, 0, 0);
            editinfo.Controls.Add(new Label() { Width = 150, Height = 40, Visible = true, Parent = updateform, Text = String.Format("Příjmení:"), Left = 5 }, 0, 1);
            editinfo.Controls.Add(new Label() { Width = 150, Height = 40, Visible = true, Parent = updateform, Text = String.Format("Email:"), Left = 5 }, 0, 2);
            editinfo.Controls.Add(new Label() { Width = 150, Height = 40, Visible = true, Parent = updateform, Text = String.Format("Telefon:"), Left = 5 }, 0, 3);
            editinfo.Controls.Add(new Label() { Width = 150, Height = 40, Visible = true, Parent = updateform, Text = String.Format("Datum narození:"), Left = 5 }, 0, 4);
            
             DateTimePicker date = new DateTimePicker();
            date.MaxDate = DateTime.Now;
            date.MinDate = new DateTime(1900, 1, 1);
            date.Value = PlayerToBeDisplayed.Birthdate;



            editinfo.Controls.Add(new TextBox(){ Width = 170,Height = 40, Visible=true,Parent=updateform,Text=PlayerToBeDisplayed.Name,Left = 160}, 1, 0);
            editinfo.Controls.Add(new TextBox() {Width = 170,Height = 40, Visible = true, Parent = updateform, Text = PlayerToBeDisplayed.Surname, Left = 160 }, 1, 1);
            editinfo.Controls.Add(new TextBox() {Width = 170,Height = 40, Visible = true, Parent = updateform, Text = PlayerToBeDisplayed.Email, Left = 160 }, 1, 2);
            editinfo.Controls.Add(new TextBox() {Width = 170,Height = 40, Visible = true, Parent = updateform, Text = PlayerToBeDisplayed.Phonenumber.ToString(), Left = 160 }, 1, 3);
            editinfo.Controls.Add(date, 1, 4);


           
            


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

        private void Confirmupdate_Click(object sender, EventArgs e)
        {
            Player p = new Player();
            p.ID = PlayerToBeDisplayed.ID;
            p.Name = editinfo.GetControlFromPosition(1, 0).Text;
            if (p.Name == "") { MessageBox.Show("Zadejte jméno"); return; }
            p.Surname = editinfo.GetControlFromPosition(1, 1).Text;
            if (p.Surname == "") { MessageBox.Show("Zadejte příjmení"); return; }
            p.Email = editinfo.GetControlFromPosition(1, 2).Text;
            if (!p.Email.Contains("@") && p.Email != "")
            {

                MessageBox.Show("Chyba vstupu atributu email"); return;
            }

            string num = editinfo.GetControlFromPosition(1, 3).Text;
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
            try { p.Birthdate = ((DateTimePicker)editinfo.GetControlFromPosition(1, 4)).Value; }
            catch { MessageBox.Show("Chyba vstupu atributu datum narození"); return; }
         

            try { PlayerOperations.Update(p); } catch { MessageBox.Show("Nepodařilo se aktualizovat hráče"); return; }
            ((Control)sender).Parent.Dispose();
        }
        private void Teams_bilances_CellContentDoubleClick(object sender, DataGridViewCellEventArgs e)
        {

            //[((Label)(sender)).TabIndex].Name
            //((Player)(((Label)(sender)).Tag)).Teams[((Label)(sender)).TabIndex].Name
            //((Player)((Label)sender).Tag).ID)
            DataGridView s = (DataGridView)sender;
            //MessageBox.Show(String.Format("{0},{1}",s.Rows[e.RowIndex].Tag, ""));
            if (e.ColumnIndex == 1)
            {
                ControlClicked(PlayerToBeDisplayed.ID, ((Team)(s.Rows[e.RowIndex].Tag)).CompetitionClass.ID);
            }
            else if (e.ColumnIndex ==0)
            {
                ControlClicked(((Team)(s.Rows[e.RowIndex].Tag)).ID);
            }
        }
    }
}
