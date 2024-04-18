using RegisterProjectLibrary;
using RegisterProjectLibrary.DAO;
using RegisterProjectLibrary.DTO;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Data;

using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;


namespace RegisterProjectWinForm
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            
            p_search.DetailClicked += P_search_DetailClicked;
            t_search.DetailClicked += T_search_DetailClicked;
            c_search.DetailClicked += C_search_DetailClicked;
            p_detail.DetailClicked += P_detail_DetailClicked;
            c_detail.DetailClicked += C_detail_DetailClicked;
            t_detail.DetailClicked += T_detail_DetailClicked;
            Width = 1200;
            Height = 600;
        }

        private void T_detail_DetailClicked(object sender, DetailEventArgs e)
        {
            if (e.LeagueCode == "")
            {


                P_search_DetailClicked(sender, e);
            }
            else
            {

                P_detail_DetailClicked(sender, e);
            }
        }

        private void C_detail_DetailClicked(object sender, DetailEventArgs e)
        {
            
            if (e.LeagueCode == "")
            {

                //  Player p = PlayerOperations.Select(e.ID);
                //MessageBox.Show(String.Format("Player {0}{1}",p.Name,p.Surname));
                P_search_DetailClicked(sender, e);
            }
            else
            {
                //Team t = TeamOperations.Select(e.ID);
                //MessageBox.Show(String.Format("Team {0}", t.Name));
                T_search_DetailClicked(sender, e);
            }
        }

        private void P_detail_DetailClicked(object sender, DetailEventArgs e)
        {

            //MessageBox.Show(e.ID.ToString());
            if (e.LeagueCode == "")
            {
                T_search_DetailClicked(sender, e);
            }
            else
            {
                Collection<Match> Matchlist = MatchOperations.Select(e.ID, MatchList.seasonselected, e.LeagueCode);
                m_list.Set(e.ID, Matchlist);
                SetActiveControl(m_list);
            }

        }

        private void C_search_DetailClicked(object sender, DetailEventArgs e)
        {
            Club c = ClubOperations.Select(e.ID);
            ClubOperations.FindMembers(c, ClubDetail.seasonselected);
            
            c_detail.Set(c);
            SetActiveControl(c_detail);
        }

        private void T_search_DetailClicked(object sender, DetailEventArgs e)
        {

            //MessageBox.Show(e.ID.ToString());
            Team t = TeamOperations.Select(e.ID);
            TeamOperations.FindMembers(t);
            TeamOperations.Points(t);



            t_detail.Set(t);
            SetActiveControl(t_detail);
        }

        private void P_search_DetailClicked(object sender, DetailEventArgs e)
        {
            //MessageBox.Show(e.ID.ToString());
            Player p = PlayerOperations.Select(e.ID);
            PlayerOperations.FindTeams(p, PlayerDetail.seasonselected);
            PlayerOperations.FindClub(p, PlayerDetail.seasonselected);
           

            
            
            p_detail.Set(p);
            SetActiveControl(p_detail);
        }

        public List<Button> mainbuttons = new List<Button>();
        public Panel displayer = new Panel();
        private AbstractControl act_control = null;
        private PlayerSearcher p_search = new PlayerSearcher();
        private TeamSearcher t_search = new TeamSearcher();
        private ClubSearcher c_search = new ClubSearcher();
        private MatchList m_list = new MatchList();
        private PlayerDetail p_detail= new PlayerDetail();
        private TeamDetail t_detail = new TeamDetail();
        private ClubDetail c_detail = new ClubDetail();
        private  ComboBox seasonselector=new ComboBox();


        private void Form1_Load(object sender, EventArgs e)
        {
            
            Button b_player = new Button();b_player.Name = "b_player";
            Button b_team = new Button(); b_team.Name = "b_team";
            Button b_club = new Button(); b_club.Name = "b_club";
            b_player.Text = "Hráči";
            b_team.Text = "Družstva";
            b_club.Text = "Oddíly";

            b_player.Click += B_player_Click;
            b_team.Click += B_team_Click;
            b_club.Click += B_club_Click;


            mainbuttons.Add(b_player);
            mainbuttons.Add(b_team);
            mainbuttons.Add(b_club);



            for(int i = 0;i<mainbuttons.Count;i++)
            {
                mainbuttons[i].Left = 50;
                mainbuttons[i].Parent = this;
                mainbuttons[i].Height = 30;
                mainbuttons[i].Width = 120;
                mainbuttons[i].Visible = true;
                mainbuttons[i].Top = (i + 1) * 100;
                mainbuttons[i].TabIndex = i;
            }


            
            displayer.Name = "displayer";
            displayer.Parent = this;
            displayer.Top = 30;
            displayer.Left = mainbuttons[0].Right + 30;
            displayer.Width = ClientSize.Width - displayer.Left - 20;
            displayer.Height = ClientSize.Height - displayer.Top - 20;
            displayer.Visible = true;
            displayer.BorderStyle = BorderStyle.FixedSingle;

            
            seasonselector.Visible = true;
            seasonselector.Width = 100;
            seasonselector.Height = 35;
            seasonselector.Parent = this;
            seasonselector.Left = 50;
            seasonselector.Top = 0;
            for (int i = DateTime.Now.Year; i > 2010; i--)
            {
                string season = String.Format("{0}/{1}", i , i+1);
                if (!seasonselector.Items.Contains(season))
                {
                    seasonselector.Items.Add(season);
                }

            }
            seasonselector.SelectedIndexChanged += Seasonselector_SelectedIndexChanged;
            seasonselector.SelectedItem = DateTime.Now.Month < 7?seasonselector.Items[1]:seasonselector.Items[0];
            
            


        }

        private void Seasonselector_SelectedIndexChanged(object sender, EventArgs e)
        {
            AbstractControl.seasonselected = seasonselector.SelectedItem.ToString();
            try
            {
                p_detail.Matchseasonselector_SelectedIndexChanged();
            }
            catch (NullReferenceException nex)
            { Console.WriteLine("NULL  "+nex.Message); }
            catch (Exception ex)
            { Console.WriteLine(ex.Message); }
                

        }

        private void SetActiveControl(AbstractControl control)
        {
            displayer.Controls.Clear();
            displayer.Controls.Add(control);
            control.Dock = DockStyle.Fill;
            act_control = control;
        }

       
        private void B_team_Click(object sender, EventArgs e)
        {

            SetActiveControl(t_search);
        }

        

        private void B_club_Click(object sender, EventArgs e)
        {
            SetActiveControl(c_search);
        }

        private void B_player_Click(object sender, EventArgs e)
        {
            SetActiveControl(p_search);
        }
    }
}
