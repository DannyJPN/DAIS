namespace AuctionDesktopApp.Forms
{
    partial class FormUserGrid
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
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle8 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle9 = new System.Windows.Forms.DataGridViewCellStyle();
            this.gridUsers = new System.Windows.Forms.DataGridView();
            this.colLogin = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.colName = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.colSurname = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.colAddress = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.colTelephone = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.colMaxUnfinishedAuctions = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.colLastVisit = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.colType = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.colFullName = new System.Windows.Forms.DataGridViewTextBoxColumn();
            ((System.ComponentModel.ISupportInitialize)(this.gridUsers)).BeginInit();
            this.SuspendLayout();
            // 
            // gridUsers
            // 
            this.gridUsers.AllowUserToAddRows = false;
            this.gridUsers.AllowUserToDeleteRows = false;
            this.gridUsers.BorderStyle = System.Windows.Forms.BorderStyle.None;
            this.gridUsers.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.gridUsers.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.colLogin,
            this.colName,
            this.colSurname,
            this.colAddress,
            this.colTelephone,
            this.colMaxUnfinishedAuctions,
            this.colLastVisit,
            this.colType,
            this.colFullName});
            this.gridUsers.Dock = System.Windows.Forms.DockStyle.Fill;
            this.gridUsers.Location = new System.Drawing.Point(0, 25);
            this.gridUsers.Name = "gridUsers";
            this.gridUsers.ReadOnly = true;
            this.gridUsers.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.gridUsers.Size = new System.Drawing.Size(591, 328);
            this.gridUsers.TabIndex = 3;
            this.gridUsers.CellDoubleClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.gridUsers_CellDoubleClick);
            // 
            // colLogin
            // 
            this.colLogin.DataPropertyName = "Login";
            dataGridViewCellStyle1.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            this.colLogin.DefaultCellStyle = dataGridViewCellStyle1;
            this.colLogin.HeaderText = "Login";
            this.colLogin.Name = "colLogin";
            this.colLogin.ReadOnly = true;
            this.colLogin.Width = 80;
            // 
            // colName
            // 
            this.colName.DataPropertyName = "Name";
            dataGridViewCellStyle2.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            this.colName.DefaultCellStyle = dataGridViewCellStyle2;
            this.colName.HeaderText = "Name";
            this.colName.Name = "colName";
            this.colName.ReadOnly = true;
            this.colName.Width = 80;
            // 
            // colSurname
            // 
            this.colSurname.DataPropertyName = "Surname";
            dataGridViewCellStyle3.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            this.colSurname.DefaultCellStyle = dataGridViewCellStyle3;
            this.colSurname.HeaderText = "Surname";
            this.colSurname.Name = "colSurname";
            this.colSurname.ReadOnly = true;
            this.colSurname.Width = 80;
            // 
            // colAddress
            // 
            this.colAddress.DataPropertyName = "Address";
            dataGridViewCellStyle4.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            this.colAddress.DefaultCellStyle = dataGridViewCellStyle4;
            this.colAddress.HeaderText = "Address";
            this.colAddress.Name = "colAddress";
            this.colAddress.ReadOnly = true;
            // 
            // colTelephone
            // 
            this.colTelephone.DataPropertyName = "Telephone";
            dataGridViewCellStyle5.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            this.colTelephone.DefaultCellStyle = dataGridViewCellStyle5;
            this.colTelephone.HeaderText = "Telephone";
            this.colTelephone.Name = "colTelephone";
            this.colTelephone.ReadOnly = true;
            // 
            // colMaxUnfinishedAuctions
            // 
            this.colMaxUnfinishedAuctions.DataPropertyName = "MaximumUnfinisfedAuctions";
            dataGridViewCellStyle6.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            this.colMaxUnfinishedAuctions.DefaultCellStyle = dataGridViewCellStyle6;
            this.colMaxUnfinishedAuctions.HeaderText = "Max. Unf. Auctios";
            this.colMaxUnfinishedAuctions.Name = "colMaxUnfinishedAuctions";
            this.colMaxUnfinishedAuctions.ReadOnly = true;
            this.colMaxUnfinishedAuctions.Width = 120;
            // 
            // colLastVisit
            // 
            this.colLastVisit.DataPropertyName = "LastVisit";
            dataGridViewCellStyle7.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            this.colLastVisit.DefaultCellStyle = dataGridViewCellStyle7;
            this.colLastVisit.HeaderText = "Last Visit";
            this.colLastVisit.Name = "colLastVisit";
            this.colLastVisit.ReadOnly = true;
            // 
            // colType
            // 
            this.colType.DataPropertyName = "Type";
            dataGridViewCellStyle8.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            this.colType.DefaultCellStyle = dataGridViewCellStyle8;
            this.colType.HeaderText = "Type";
            this.colType.Name = "colType";
            this.colType.ReadOnly = true;
            this.colType.Width = 70;
            // 
            // colFullName
            // 
            this.colFullName.DataPropertyName = "FullName";
            dataGridViewCellStyle9.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            this.colFullName.DefaultCellStyle = dataGridViewCellStyle9;
            this.colFullName.HeaderText = "Full Name";
            this.colFullName.Name = "colFullName";
            this.colFullName.ReadOnly = true;
            // 
            // FormUserGrid
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(591, 353);
            this.Controls.Add(this.gridUsers);
            this.Name = "FormUserGrid";
            this.Text = "Users";
            this.Controls.SetChildIndex(this.gridUsers, 0);
            ((System.ComponentModel.ISupportInitialize)(this.gridUsers)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DataGridView gridUsers;
        private System.Windows.Forms.DataGridViewTextBoxColumn colLogin;
        private System.Windows.Forms.DataGridViewTextBoxColumn colName;
        private System.Windows.Forms.DataGridViewTextBoxColumn colSurname;
        private System.Windows.Forms.DataGridViewTextBoxColumn colAddress;
        private System.Windows.Forms.DataGridViewTextBoxColumn colTelephone;
        private System.Windows.Forms.DataGridViewTextBoxColumn colMaxUnfinishedAuctions;
        private System.Windows.Forms.DataGridViewTextBoxColumn colLastVisit;
        private System.Windows.Forms.DataGridViewTextBoxColumn colType;
        private System.Windows.Forms.DataGridViewTextBoxColumn colFullName;
    }
}