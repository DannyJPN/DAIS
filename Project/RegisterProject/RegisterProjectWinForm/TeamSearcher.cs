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
    public partial class TeamSearcher : Searcher
    {
        public TeamSearcher()
        {
            InitializeComponent();
            indicator.Text = "Vyhledat družstvo";

            searchbutton.Click += Searchbutton_Click;



            result.Columns.Add("Družstvo", "Družstvo");
            result.Columns.Add("Oddíl", "Oddíl");
            result.Columns.Add("Soutěž", "Soutěž");
            result.Columns.Add("Sezona", "Sezona");

            result.CellContentDoubleClick += Result_CellContentDoubleClick;
            insertbutton.Text = "Přidat družstvo";
            insertbutton.Click += Insertbutton_Click;

        }

        private void Insertbutton_Click(object sender, EventArgs e)
        {
            insertform = new Form()
            {

                Text = "Upravit družstvo",
                Width = 600,
                Height = 400

            };

            ComboBox leagueselector = new ComboBox() { Width = 170, Height = 40, Visible = true, Parent = insertform, Left = 60 };
            Collection<League> items = LeagueOperations.Select();

            for (int i = 0; i < items.Count; i++)
            {
                leagueselector.Items.Add(String.Format("{0}({1})", items[i].ID, items[i].Name));
            }
            leagueselector.SelectedIndexChanged += Leagueselector_SelectedIndexChanged;

            ComboBox clubselector = new ComboBox() { Width = 170, Height = 40, Visible = true, Parent = insertform, Left = 60 };
            Collection<Club> clubs = ClubOperations.Select();

            for (int i = 0; i < clubs.Count; i++)
            {
                clubselector.Items.Add(String.Format("{0}({1})", clubs[i].ID, clubs[i].Name));
            }
            clubselector.SelectedIndexChanged += Clubselector_SelectedIndexChanged;

            ComboBox teamseasonselector = new ComboBox() { Width = 170, Height = 40, Visible = true, Parent = insertform, Left = 60 };
            for (int i = DateTime.Now.Year; i > 2010; i--)
            {
                string season = String.Format("{0}/{1}", i, i + 1);
                if (!teamseasonselector.Items.Contains(season))
                {
                    teamseasonselector.Items.Add(season);
                }

            }

            teamseasonselector.SelectedItem = DateTime.Now.Month < 7 ? teamseasonselector.Items[1] : teamseasonselector.Items[0];






            insertinfo = new TableLayoutPanel();
            insertinfo.Parent = insertform;
            insertinfo.RowCount = 5;
            insertinfo.ColumnCount = 2;
            insertinfo.Visible = true;
            insertinfo.Width = insertform.Width;
            insertinfo.Height = 2 * insertform.Height / 3;
            insertinfo.ColumnStyles.Add(new ColumnStyle(SizeType.AutoSize));

            insertinfo.Controls.Add(new Label() { Width = 150, Height = 40, Visible = true, Parent = insertform, Text = String.Format("Název:"), Left = 5 }, 0, 0);
            insertinfo.Controls.Add(new Label() { Width = 150, Height = 40, Visible = true, Parent = insertform, Text = String.Format("Soutěž:"), Left = 5 }, 0, 1);
            insertinfo.Controls.Add(new Label() { Width = 150, Height = 40, Visible = true, Parent = insertform, Text = String.Format("Oddíl:"), Left = 5 }, 0, 2);
            insertinfo.Controls.Add(new Label() { Width = 150, Height = 40, Visible = true, Parent = insertform, Text = String.Format("Sezona:"), Left = 5 }, 0, 3);



            insertinfo.Controls.Add(new TextBox() { Width = 170, Height = 40, Visible = true, Parent = insertform, Left = 160 }, 1, 0);
            insertinfo.Controls.Add(leagueselector, 1, 1);
            insertinfo.Controls.Add(clubselector, 1, 2);
            insertinfo.Controls.Add(teamseasonselector, 1, 3);



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
            Team t = new Team();

            t.Name = insertinfo.GetControlFromPosition(1, 0).Text;
            if (t.Name == "") { MessageBox.Show("Zadejte název"); return; }

            try { t.CompetitionClass = (League)(insertinfo.GetControlFromPosition(1, 1).Tag); } catch { MessageBox.Show("Chyba na vstupu argumentu soutěž"); return; }
            try { t.HomeClub = (Club)(insertinfo.GetControlFromPosition(1, 2).Tag); } catch { MessageBox.Show("Chyba na vstupu argumentu soutěž"); return; }
            try { t.SeasonOfExistence = ((ComboBox)(insertinfo.GetControlFromPosition(1, 3))).SelectedItem.ToString(); }
            catch { MessageBox.Show("Chyba na vstupu argumentu sezona"); return; }



            try { TeamOperations.Insert(t); }
            catch (Exception ex) { MessageBox.Show(String.Format("Nepodařilo se vložit družstvo {0}{1}", Environment.NewLine, ex.Message)); return; }
            ((Control)sender).Parent.Dispose();
        }

        private void TeamSearcher_Load(object sender, EventArgs e)
        {

        }

        private void Result_CellContentDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            DataGridView s = (DataGridView)sender;
            ControlClicked(((Team)(s.Rows[e.RowIndex].Tag)).ID);
        }

        private void Searchbutton_Click(object sender, EventArgs e)
        {
            if (searchbox.Text == "")
            { return; }
            Collection<Team> teamlist = TeamOperations.Select(searchbox.Text);

            Collection<Team> filtered_teamlist = new Collection<Team>();

            for (int i = 0; i < teamlist.Count; i++)
            {
                if (teamlist[i].SeasonOfExistence == seasonselected)
                {
                    filtered_teamlist.Add(teamlist[i]);

                }
            }
            result.Rows.Clear();
            for (int i = 0; i < filtered_teamlist.Count; i++)
            {


                result.Rows.Add(filtered_teamlist[i].Name, filtered_teamlist[i].HomeClub.Name, filtered_teamlist[i].CompetitionClass.Name, filtered_teamlist[i].SeasonOfExistence);
                result.Rows[i].Tag = filtered_teamlist[i];

            }
        }

        private void Clubselector_SelectedIndexChanged(object sender, EventArgs e)
        {
            ((ComboBox)sender).Tag = ClubOperations.Select(Convert.ToInt32(((ComboBox)sender).SelectedItem.ToString().Split('(')[0]));

        }

        private void Leagueselector_SelectedIndexChanged(object sender, EventArgs e)
        {
            ((ComboBox)sender).Tag = LeagueOperations.Select(((ComboBox)sender).SelectedItem.ToString().Split('(')[0]);

        }

    }
}
