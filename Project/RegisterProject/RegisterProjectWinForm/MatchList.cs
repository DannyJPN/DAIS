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
    public partial class MatchList : AbstractControl
    {
        public MatchList()
        {
            InitializeComponent();
            PlayerID = 0;
            MatchesToBeDisplayed = new Collection<Match>();
             matchgrid= new DataGridView();
            matchgrid.Parent = this;
            matchgrid.Visible = true;
            matchgrid.Size = this.Size;
            matchgrid.Dock = DockStyle.Fill;
            matchgrid.Columns.Add("Datum", "Datum");
            matchgrid.Columns.Add("Hráč", "Hráč");
            matchgrid.Columns.Add("Soupeř", "Soupeř");
            matchgrid.Columns.Add("Soutěž", "Soutěž");
            matchgrid.Columns.Add("Skóre hráče", "Skóre hráče");
            matchgrid.Columns.Add("Skóre soupeře", "Skóre soupeře");
            matchgrid.Columns.Add("Sezona", "Sezona");
            matchgrid.Parent = this;
            matchgrid.ReadOnly = true;
            matchgrid.CellBorderStyle = DataGridViewCellBorderStyle.Single;
            matchgrid.ScrollBars = ScrollBars.None;
            matchgrid.DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter;
            matchgrid.DefaultCellStyle.BackColor = matchgrid.Parent.BackColor;
            matchgrid.RowHeadersVisible = false;
            matchgrid.BorderStyle = BorderStyle.None;
            matchgrid.BackgroundColor = matchgrid.Parent.BackColor;
            matchgrid.ColumnHeadersVisible = true;
            matchgrid.AutoGenerateColumns = false;
            matchgrid.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.DisplayedCells;

        }
        public Collection<Match> MatchesToBeDisplayed { get; set; }
        public int PlayerID { get; set; }
        private DataGridView matchgrid;
        private void MatchList_Load(object sender, EventArgs e)
        {
            

            
            

            
        }
        public void Set(int playerID,Collection<Match> matches)
        {
            PlayerID = playerID;
            MatchesToBeDisplayed = matches;
            matchgrid.Rows.Clear();
            List<string[]> adaptedoutput =MatchOperations.AdaptedOutput(PlayerID, MatchesToBeDisplayed);
            for(int i = 0;i<adaptedoutput.Count;i++)
            {

                matchgrid.Rows.Add(adaptedoutput[i]);

            }



        }
    }
}
