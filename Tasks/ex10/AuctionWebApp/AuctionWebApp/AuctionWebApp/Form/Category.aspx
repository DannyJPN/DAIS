<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Category.aspx.cs" Inherits="AuctionWebApp.Form.Category" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
  <p><asp:GridView ID="GridViewCategory" runat="server" DataKeyNames="idCategory" 
    AllowPaging="True" DataSourceID="odsCategory">
    <Columns>
      <asp:CommandField ShowSelectButton="True" ShowDeleteButton="False"/>
       <asp:TemplateField >
           <ItemTemplate>
               <asp:LinkButton runat="server" Enabled='<%# Eval("CanBeDeleted") %>' CommandArgument='<%# Eval("IdCategory") %>' OnClick="Delete_Click">Delete</asp:LinkButton>
           </ItemTemplate>
           
       </asp:TemplateField>
    </Columns>
  </asp:GridView></p>

  <p><asp:DetailsView ID="DetailsViewCategory" runat="server"
    AutoGenerateRows="false" DataSourceID="odsCategoryDetail" 
    DataKeyNames="idCategory" OnItemInserted="DetailsViewCategory_ItemInserted" OnItemUpdated="DetailsViewCategory_ItemUpdated"
    Width="50%" FieldHeaderStyle-Width="10%">
    
    <Fields>
        <asp:BoundField DataField="IdCategory" HeaderText="IdCategory" ReadOnly="true" InsertVisible="false"/>
        <asp:TemplateField HeaderText="Name" SortExpression="Name">
                    <ItemTemplate>
                        <asp:Label runat="server" Text='<%# Eval("Name") %>' />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="TextName" runat="server" Text='<%# Bind("Name") %>' />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="TextName" CssClass="error" >*</asp:RequiredFieldValidator>
                    </EditItemTemplate>
        </asp:TemplateField>
         <asp:TemplateField HeaderText="Description" SortExpression="Description">
                    <ItemTemplate>
                        <asp:Label ID="LabelOwner" runat="server" Text='<%# Eval("Description") %>' />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="TextDescription" runat="server" Text='<%# Bind("Description") %>' />
                    </EditItemTemplate>
                </asp:TemplateField>
      <asp:CommandField ShowEditButton="True" ShowInsertButton="true" />
    </Fields>
  </asp:DetailsView></p>

  <asp:ObjectDataSource ID="odsCategory" runat="server" 
     TypeName="AuctionWebApp.Database.Proxy.CategoryTableProxy" 
    SelectMethod="Select"  DeleteMethod="Delete">
    <DeleteParameters>
      <asp:ControlParameter Type="Int32" Name="idCategory" ControlID="GridViewCategory"></asp:ControlParameter>
    </DeleteParameters>
  </asp:ObjectDataSource> 

  <asp:ObjectDataSource ID="odsCategoryDetail" runat="server" 
    TypeName="AuctionWebApp.Database.Proxy.CategoryTableProxy" 
    DataObjectTypeName="AuctionWebApp.Database.Category"
    SelectMethod="Select" InsertMethod="Insert" UpdateMethod="Update">
    <SelectParameters>
      <asp:ControlParameter PropertyName="SelectedValue" Type="Int32" Name="idCategory" 
      ControlID="GridViewCategory" DefaultValue="1"></asp:ControlParameter>
    </SelectParameters>
  </asp:ObjectDataSource>
</asp:Content>
