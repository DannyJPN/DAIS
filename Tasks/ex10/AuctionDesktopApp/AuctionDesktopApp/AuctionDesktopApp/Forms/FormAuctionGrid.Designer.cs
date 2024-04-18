namespace AuctionDesktopApp.Forms
{
    partial class FormAuctionGrid
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle1 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle2 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle3 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle4 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle5 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle6 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle7 = new System.Windows.Forms.DataGridViewCellStyle();
            this.gridAuctions = new System.Windows.Forms.DataGridView();
            this.colName = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.colDescription = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.colCreation = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.colEnd = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.colCategory = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.colMinimalBid = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.colMaximalBid = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.colUserMaxBid = new System.Windows.Forms.DataGridViewTextBoxColumn();
            ((System.ComponentModel.ISupportInitialize)(this.gridAuctions)).BeginInit();
            this.SuspendLayout();
            // 
            // gridAuctions
            // 
            this.gridAuctions.AllowUserToAddRows = false;
            this.gridAuctions.AllowUserToDeleteRows = false;
            this.gridAuctions.BorderStyle = System.Windows.Forms.BorderStyle.None;
            this.gridAuctions.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.gridAuctions.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.colName,
            this.colDescription,
            this.colCreation,
            this.colEnd,
            this.colCategory,
            this.colMinimalBid,
            this.colMaximalBid,
            this.colUserMaxBid});
            this.gridAuctions.Dock = System.Windows.Forms.DockStyle.Fill;
            this.gridAuctions.Location = new System.Drawing.Point(0, 25);
            this.gridAuctions.Name = "gridAuctions";
            this.gridAuctions.ReadOnly = true;
            this.gridAuctions.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.gridAuctions.Size = new System.Drawing.Size(822, 328);
            this.gridAuctions.TabIndex = 1;
            this.gridAuctions.CellDoubleClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.gridAuctions_CellDoubleClick);
            // 
            // colName
            // 
            this.colName.DataPropertyName = "Name";
            dataGridViewCellStyle1.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            this.colName.DefaultCellStyle = dataGridViewCellStyle1;
            this.colName.HeaderText = "Name";
            this.colName.Name = "colName";
            this.colName.ReadOnly = true;
            // 
            // colDescription
            // 
            this.colDescription.DataPropertyName = "Description";
            this.colDescription.HeaderText = "Description";
            this.colDescription.Name = "colDescription";
            this.colDescription.ReadOnly = true;
            this.colDescription.Width = 200;
            // 
            // colCreation
            // 
            this.colCreation.DataPropertyName = "Creation";
            dataGridViewCellStyle2.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            this.colCreation.DefaultCellStyle = dataGridViewCellStyle2;
            this.colCreation.HeaderText = "Creation";
            this.colCreation.Name = "colCreation";
            this.colCreation.ReadOnly = true;
            this.colCreation.Width = 70;
            // 
            // colEnd
            // 
            this.colEnd.DataPropertyName = "End";
            dataGridViewCellStyle3.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            this.colEnd.DefaultCellStyle = dataGridViewCellStyle3;
            this.colEnd.HeaderText = "End";
            this.colEnd.Name = "colEnd";
            this.colEnd.ReadOnly = true;
            this.colEnd.Width = 70;
            // 
            // colCategory
            // 
            this.colCategory.DataPropertyName = "CategoryName";
            dataGridViewCellStyle4.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            this.colCategory.DefaultCellStyle = dataGridViewCellStyle4;
            this.colCategory.HeaderText = "Category";
            this.colCategory.Name = "colCategory";
            this.colCategory.ReadOnly = true;
            this.colCategory.Width = 80;
            // 
            // colMinimalBid
            // 
            this.colMinimalBid.DataPropertyName = "MinBidValue";
            dataGridViewCellStyle5.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            this.colMinimalBid.DefaultCellStyle = dataGridViewCellStyle5;
            this.colMinimalBid.HeaderText = "Minimal Bid";
            this.colMinimalBid.Name = "colMinimalBid";
            this.colMinimalBid.ReadOnly = true;
            this.colMinimalBid.Width = 85;
            // 
            // colMaximalBid
            // 
            this.colMaximalBid.DataPropertyName = "MaxBidValue";
            dataGridViewCellStyle6.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            this.colMaximalBid.DefaultCellStyle = dataGridViewCellStyle6;
            this.colMaximalBid.HeaderText = "Maximal Bid";
            this.colMaximalBid.Name = "colMaximalBid";
            this.colMaximalBid.ReadOnly = true;
            this.colMaximalBid.Width = 85;
            // 
            // colUserMaxBid
            // 
            this.colUserMaxBid.DataPropertyName = "MaxBidderFullName";
            dataGridViewCellStyle7.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            this.colUserMaxBid.DefaultCellStyle = dataGridViewCellStyle7;
            this.colUserMaxBid.HeaderText = "User with Max. Bid";
            this.colUserMaxBid.Name = "colUserMaxBid";
            this.colUserMaxBid.ReadOnly = true;
            this.colUserMaxBid.Width = 130;
            // 
            // FormAuctionGrid
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(822, 353);
            this.Controls.Add(this.gridAuctions);
            this.Name = "FormAuctionGrid";
            this.Text = "Auctions";
            this.Controls.SetChildIndex(this.gridAuctions, 0);
            ((System.ComponentModel.ISupportInitialize)(this.gridAuctions)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DataGridView gridAuctions;
        private System.Windows.Forms.DataGridViewTextBoxColumn colName;
        private System.Windows.Forms.DataGridViewTextBoxColumn colDescription;
        private System.Windows.Forms.DataGridViewTextBoxColumn colCreation;
        private System.Windows.Forms.DataGridViewTextBoxColumn colEnd;
        private System.Windows.Forms.DataGridViewTextBoxColumn colCategory;
        private System.Windows.Forms.DataGridViewTextBoxColumn colMinimalBid;
        private System.Windows.Forms.DataGridViewTextBoxColumn colMaximalBid;
        private System.Windows.Forms.DataGridViewTextBoxColumn colUserMaxBid;
    }
}