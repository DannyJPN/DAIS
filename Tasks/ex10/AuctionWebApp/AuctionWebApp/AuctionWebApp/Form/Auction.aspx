<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Auction.aspx.cs" Inherits="AuctionWebApp.Form.Auction" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h3>My Auctions</h3>
    <p>
        <asp:GridView ID="GridViewAuction" runat="server" DataKeyNames="IdAuction"
            AutoGenerateColumns="False" OnRowDeleted="GridViewAuction_RowDeleted"
            AllowPaging="True" DataSourceID="odsAuction">
            <Columns>
                <asp:CommandField ShowSelectButton="True" ShowDeleteButton="True" />
                <asp:BoundField DataField="IdAuction" HeaderText="IdAuction" SortExpression="idAuction" />
                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="name" />
                <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="description" />
                <asp:BoundField DataField="Creation" HeaderText="Creation" SortExpression="creation" />
                <asp:BoundField DataField="End" HeaderText="End" SortExpression="end" />
                <asp:TemplateField HeaderText="Category" SortExpression="Category">
                    <ItemTemplate>
                        <asp:Label ID="LabelCategory" runat="server" Text='<%# Eval("Category.Name") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="MinBidValue" HeaderText="Minimal Bid" SortExpression="MinBidValue" />
                <asp:BoundField DataField="MaxBidValue" HeaderText="Maximal Bid" SortExpression="MaxBidValue" />
                <asp:BoundField DataField="MaxBidder.Login" HeaderText="User with Maximal Bid" SortExpression="IdMaxBidUser" />
            </Columns>
        </asp:GridView>
    </p>

    <h3>Auction Detail</h3>
    <p>
        <asp:DetailsView ID="DetailsViewAuction" runat="server"
            AutoGenerateRows="False" DataSourceID="odsAuctionDetail" DataKeyNames="idAuction"
            OnItemInserting="DetailsViewAuction_ItemInserting" OnItemInserted="DetailsViewAuction_ItemInserted" OnItemUpdated="DetailsViewAuction_ItemUpdated">
            <Fields>
                <asp:BoundField DataField="IdAuction" HeaderText="idAuction" ReadOnly="true" InsertVisible="false" />

                <asp:TemplateField HeaderText="IdOwner" SortExpression="IdOwner">
                    <ItemTemplate>
                        <asp:Label runat="server" Text='<%# Eval("Owner.Login") %>' />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:Label ID="LabelOwner" runat="server" Text='<%# Session["IDUSER"] %>' />
                    </EditItemTemplate>
                </asp:TemplateField>
                <%--   Difference beween Bind and Eval
                    Eval - one way. It evaluates and shows the value of property. Any later changes does not affect original value.
                    Bind - two way. Any changes in bound property affects original value. 

                    I.E. Eval is used for viewing. Bind is used in edit and insert mode. 
                    If we bind property 'Name' to Textbox's  Text property it means if user changes value of Textbox it also changes value of 'Name' property
                    in datasource (NOT IN DATABASE). To commit changes we must use Insert/Edit method of datasource.
                --%>
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
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="TextDescription" CssClass="error" >*</asp:RequiredFieldValidator>
                    </EditItemTemplate>
                </asp:TemplateField>
                <%--Description detail is nullable column and we do not need to validate its value thus we use only bound field />--%>
                <asp:BoundField DataField="DescriptionDetail" HeaderText="Description Detail" />

                <asp:TemplateField HeaderText="Creation" SortExpression="Creation">
                    <ItemTemplate>
                        <asp:Label runat="server" Text='<%# Eval("Creation") %>' />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="TextCreation" runat="server" Text='<%# Bind("Creation","{0:yyyy-MM-dd HH:mm}") %>' />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="TextCreation" CssClass="error" >*</asp:RequiredFieldValidator>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="End" SortExpression="End">
                    <ItemTemplate>
                        <asp:Label  runat="server" Text='<%# Eval("End") %>' />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="TextEnd" runat="server" Text='<%# Bind("End","{0:yyyy-MM-dd HH:mm}") %>' />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="TextEnd" CssClass="error" >*</asp:RequiredFieldValidator>
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Category" SortExpression="Category">
                    <ItemTemplate>
                        <asp:Label runat="server" Text='<%# Eval("Category.Name") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList ID="ListCategory" runat="server" DataSourceID="odsCategory"
                            DataTextField="Name" DataValueField="IdCategory" SelectedValue='<%# Bind("IdCategory") %>'>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="ValidatorCategory" runat="server" ControlToValidate="ListCategory"
                            ErrorMessage="Category is required" Display="None">
                        </asp:RequiredFieldValidator>
                    </EditItemTemplate>
                </asp:TemplateField>
                
                <asp:TemplateField HeaderText="Minimal Bid" >
                    <ItemTemplate>
                        <asp:Label  runat="server" Text='<%# Eval("MinBidValue") %>' />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="TextMinBid" runat="server" Text='<%# Bind("MinBidValue") %>' />
                        <asp:RegularExpressionValidator runat="server" ValidationExpression="\d*" ControlToValidate="TextMinBid" ErrorMessage="Must be a number." CssClass="error">!</asp:RegularExpressionValidator>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Maximal Bid" >
                    <ItemTemplate>
                        <asp:Label  runat="server" Text='<%# Eval("MaxBidValue") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="User with Maximal Bid">
                    <ItemTemplate>
                        <asp:Label ID="LabelMaxBidder" runat="server" Text='<%# Eval("MaxBidder.Login") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:CommandField ShowInsertButton="True" ShowEditButton="True" />
            </Fields>
        </asp:DetailsView>
    </p>

    <asp:ObjectDataSource ID="odsAuction" runat="server"
        TypeName="AuctionWebApp.Database.Proxy.AuctionTableProxy"
        SelectMethod="Select" DeleteMethod="Delete">
        <DeleteParameters>
            <asp:ControlParameter Type="Int32" Name="IdAuction" ControlID="GridViewAuction"></asp:ControlParameter>
        </DeleteParameters>
        <SelectParameters>
            <asp:SessionParameter Name="IDUSER" SessionField="IDUSER" DefaultValue="1" />
        </SelectParameters>
    </asp:ObjectDataSource>

    <asp:ObjectDataSource ID="odsAuctionDetail" runat="server"
        TypeName="AuctionWebApp.Database.Proxy.AuctionTableProxy"
        SelectMethod="SelectOne" DataObjectTypeName="AuctionWebApp.Database.Auction" InsertMethod="Insert" UpdateMethod="Update">
        <SelectParameters>
            <asp:ControlParameter PropertyName="SelectedValue" Type="Int32" Name="IdAuction"
                ControlID="GridViewAuction" DefaultValue="1"></asp:ControlParameter>
        </SelectParameters>
    </asp:ObjectDataSource>

    <asp:ObjectDataSource ID="odsCategory" runat="server"
        TypeName="AuctionWebApp.Database.Proxy.CategoryTableProxy" SelectMethod="Select"></asp:ObjectDataSource>
</asp:Content>

