<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="User.aspx.cs" Inherits="AuctionWebApp.Form.User" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <p>
        <asp:GridView ID="GridViewUser" runat="server" DataKeyNames="id"
            AllowPaging="True" DataSourceID="odsUser">
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
            </Columns>
        </asp:GridView>
    </p>

    <p>
        <asp:DetailsView ID="DetailsViewUser" runat="server" OnItemUpdated="DetailsViewUser_ItemUpdated" OnItemInserted="DetailsViewUser_ItemInserted"
            AutoGenerateRows="False" DataSourceID="odsUserDetail"
            DataKeyNames="id">
            <Fields>
                <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="true" InsertVisible="false"  />
                <asp:TemplateField HeaderText="Login" SortExpression="Login">
                    <ItemTemplate>
                        <asp:Label runat="server" Text='<%# Eval("Login") %>' />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="TextLogin" runat="server" Text='<%# Bind("Login") %>' />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="TextLogin" CssClass="error">*</asp:RequiredFieldValidator>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Name" SortExpression="Name">
                    <ItemTemplate>
                        <asp:Label runat="server" Text='<%# Eval("Name") %>' />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="TextName" runat="server" Text='<%# Bind("Name") %>' />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="TextName" CssClass="error">*</asp:RequiredFieldValidator>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Surname" SortExpression="Surname">
                    <ItemTemplate>
                        <asp:Label runat="server" Text='<%# Eval("Surname") %>' />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="TextSurname" runat="server" Text='<%# Bind("Surname") %>' />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="TextSurname" CssClass="error">*</asp:RequiredFieldValidator>
                    </EditItemTemplate>
                </asp:TemplateField>
                 <asp:TemplateField HeaderText="FullName" SortExpression="FullName" InsertVisible="false" >
                    <ItemTemplate>
                        <asp:Label runat="server" Text='<%# Eval("FullName") %>' />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:Label ID="LabelFullName2"  runat="server" Text='<%# Eval("FullName") %>' />
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Address" HeaderText="Address" />
                <asp:BoundField DataField="Telephone" HeaderText="Telephone" />
                <asp:TemplateField HeaderText="Maximum Unfinisfed Auctions">
                    <ItemTemplate>
                        <asp:Label runat="server" Text='<%# Eval("MaximumUnfinisfedAuctions") %>' />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="TextMaximumUnfinisfedAuctions" runat="server" Text='<%# Bind("MaximumUnfinisfedAuctions") %>' />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="TextMaximumUnfinisfedAuctions" CssClass="error">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator runat="server" ValidationExpression="\d*" ControlToValidate="TextMaximumUnfinisfedAuctions" ErrorMessage="Must be a number." CssClass="error">!</asp:RegularExpressionValidator>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Type" SortExpression="Type">
                    <ItemTemplate>
                        <asp:Label runat="server" Text='<%# Eval("Type") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList ID="ListCategory" runat="server" SelectedValue='<%# Bind("Type") %>'>
                            <asp:ListItem Text="User" Value="U"  />
                            <asp:ListItem Text="Admin" Value="A" Selected="True" />
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="ValidatorCategory" runat="server" ControlToValidate="ListCategory"
                            ErrorMessage="Category is required" Display="None">
                        </asp:RequiredFieldValidator>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="LastVisit" HeaderText="LastVisit" ReadOnly="true" />
                <asp:CommandField ShowEditButton="True" ShowInsertButton="True" />
            </Fields>
        </asp:DetailsView>
    </p>

    <asp:ObjectDataSource ID="odsUser" runat="server"
        TypeName="AuctionWebApp.Database.Proxy.UserTableProxy"
        SelectMethod="Select" DeleteMethod="Delete">
        <DeleteParameters>
            <asp:ControlParameter Type="Int32" Name="id" ControlID="GridViewUser"></asp:ControlParameter>
        </DeleteParameters>
    </asp:ObjectDataSource>

    <asp:ObjectDataSource ID="odsUserDetail" runat="server"
        TypeName="AuctionWebApp.Database.Proxy.UserTableProxy"
        DataObjectTypeName="AuctionWebApp.Database.User"
        SelectMethod="Select" InsertMethod="Insert" UpdateMethod="Update">
        <SelectParameters>
            <asp:ControlParameter PropertyName="SelectedValue" Type="Int32" Name="id"
                ControlID="GridViewUser" DefaultValue="1"></asp:ControlParameter>
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
