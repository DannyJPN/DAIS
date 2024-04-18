namespace AuctionDesktopApp.Forms
{
    partial class FormCategoryGrid
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
            this.gridCategories = new System.Windows.Forms.DataGridView();
            this.colName = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.colDescription = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.colItemsCount = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.colCanBeDeleted = new System.Windows.Forms.DataGridViewCheckBoxColumn();
            ((System.ComponentModel.ISupportInitialize)(this.gridCategories)).BeginInit();
            this.SuspendLayout();
            // 
            // gridCategories
            // 
            this.gridCategories.AllowUserToAddRows = false;
            this.gridCategories.AllowUserToDeleteRows = false;
            this.gridCategories.BorderStyle = System.Windows.Forms.BorderStyle.None;
            this.gridCategories.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.gridCategories.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.colName,
            this.colDescription,
            this.colItemsCount,
            this.colCanBeDeleted});
            this.gridCategories.Dock = System.Windows.Forms.DockStyle.Fill;
            this.gridCategories.Location = new System.Drawing.Point(0, 27);
            this.gridCategories.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
            this.gridCategories.Name = "gridCategories";
            this.gridCategories.ReadOnly = true;
            this.gridCategories.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.gridCategories.Size = new System.Drawing.Size(788, 435);
            this.gridCategories.TabIndex = 2;
            this.gridCategories.CellContentClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.gridCategories_CellContentClick);
            this.gridCategories.CellDoubleClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.gridCategories_CellDoubleClick);
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
            // colItemsCount
            // 
            this.colItemsCount.DataPropertyName = "ItemsCount";
            dataGridViewCellStyle2.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            this.colItemsCount.DefaultCellStyle = dataGridViewCellStyle2;
            this.colItemsCount.HeaderText = "Items Count";
            this.colItemsCount.Name = "colItemsCount";
            this.colItemsCount.ReadOnly = true;
            // 
            // colCanBeDeleted
            // 
            this.colCanBeDeleted.DataPropertyName = "CanBeDeleted";
            this.colCanBeDeleted.HeaderText = "Can Be Deleted";
            this.colCanBeDeleted.Name = "colCanBeDeleted";
            this.colCanBeDeleted.ReadOnly = true;
            // 
            // FormCategoryGrid
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 17F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(788, 462);
            this.Controls.Add(this.gridCategories);
            this.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
            this.Name = "FormCategoryGrid";
            this.Text = "Categories";
            this.Controls.SetChildIndex(this.gridCategories, 0);
            ((System.ComponentModel.ISupportInitialize)(this.gridCategories)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DataGridView gridCategories;
        private System.Windows.Forms.DataGridViewTextBoxColumn colName;
        private System.Windows.Forms.DataGridViewTextBoxColumn colDescription;
        private System.Windows.Forms.DataGridViewTextBoxColumn colItemsCount;
        private System.Windows.Forms.DataGridViewCheckBoxColumn colCanBeDeleted;
    }
}