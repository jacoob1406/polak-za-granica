<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Messages.aspx.cs" Inherits="User_Messages" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="messages">
        <div id="messagesSmall1" style="float: left; text-align: left">
            <br />
            <center>
            <asp:RadioButtonList ID="RadioButtonList1" runat="server" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonList1_SelectedIndexChanged">
                <asp:ListItem Selected="True">Otrzymane wiadomości</asp:ListItem>
                <asp:ListItem>Wysłane wiadomości</asp:ListItem>
            </asp:RadioButtonList>
                </center>
            <br />
            <asp:Label ID="sentLabel" runat="server" Text="" Font-Bold="True"></asp:Label>
        </div>
        <div id="messagesSmall2">
        <asp:Label ID="Label1" runat="server" Text="Wyślij wiadomość do: "></asp:Label>
        <asp:DropDownList ID="toUserDropDown" runat="server" DataSourceID="SqlDataSource2" DataTextField="username" DataValueField="username" AutoPostBack="true" OnDataBound="toUserDropDown_DataBound" BackColor="#ffffe6"></asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
            SelectCommand="SELECT [username] FROM [User] WHERE [username]<>@touser"></asp:SqlDataSource>
        <asp:Button ID="sendButton" CssClass="allButtons" runat="server" Text="WYŚLIJ" OnClick="sendButton_Click" BackColor="#ffcccc" Height="32" Width="10%" Font-Names="Book Antiqua" Font-Bold="true" ForeColor="#661616" />
        <br />
        <asp:TextBox ID="messageTestBox" runat="server" TextMode="MultiLine" Width="60%" Height="75" BackColor="#ffffe6"></asp:TextBox>
        <br />
        <br />
            </div>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" Width="100%">
            <Columns>
                <asp:BoundField DataField="from_user" HeaderText="OD" SortExpression="from_user" ItemStyle-Width="15%" />
                <asp:BoundField DataField="message" HeaderText="WIADOMOŚCI OTRZYMANE" SortExpression="message" ItemStyle-Width="70%" />
                <asp:BoundField DataField="date" HeaderText="DATA" SortExpression="date" DataFormatString="{0:dd.MM.yyyy; HH:mm}" ItemStyle-Width="15%" />
            </Columns>
            <RowStyle BackColor="#ffcccc"
                ForeColor="#4d0000" Height="32px"/>

            <AlternatingRowStyle BackColor="#ffffe6"
                ForeColor="#4d0000" Height="32px"/>
        </asp:GridView>

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
            SelectCommand="SELECT [from_user], [message], [date] FROM [Message] WHERE [to_user]=@touser ORDER BY [date] DESC"></asp:SqlDataSource>

        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource3" Visible="False" Width="100%">
            <Columns>
                <asp:BoundField DataField="to_user" HeaderText="DO" SortExpression="to_user" ItemStyle-Width="15%" />
                <asp:BoundField DataField="message" HeaderText="WIADOMOŚCI WYSŁANE" SortExpression="message" ItemStyle-Width="70%" />
                <asp:BoundField DataField="date" HeaderText="DATA" SortExpression="date" DataFormatString="{0:dd.MM.yyyy; HH:mm}" ItemStyle-Width="15%" />
            </Columns>
            <RowStyle BackColor="#ffcccc"
                ForeColor="#4d0000" Height="32px"/>

            <AlternatingRowStyle BackColor="#ffffe6"
                ForeColor="#4d0000" Height="32px" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
            SelectCommand="SELECT [to_user], [from_user], [message], [date] FROM [Message] WHERE [message].[from_user]=@touser ORDER BY [date] DESC"></asp:SqlDataSource>

    </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="Server">
    <div id="messages2">
        <asp:Label ID="Label2" runat="server" Text="Użytkownik: "></asp:Label>
        <asp:ListView ID="aboutUserListView" runat="server" DataSourceID="SqlDataSource4">
            <ItemTemplate>

                <asp:Label ID="userPostLabel" runat="server" Text='<%# Eval("username") %>' Font-Bold="True" />
                <br /><br />
                <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("image").ToString() == "" ? "~/images/profile_pictures/NoImage.png" : Eval("image") %>' CssClass="messagesprofpic" />
                <br /><br />
                <asp:Label ID="fnameLabel" runat="server" Text='<%# Eval("f_name") %>' />

                <asp:Label ID="lnameLabel" runat="server" Text='<%# Eval("l_name") %>' />
                <br /><br />
                <asp:Label ID="Label4" runat="server" Text="Data urodzenia: "></asp:Label>
                <asp:Label ID="dobLabel" runat="server" Text='<%# Eval("DOB", "{0:dd.MM.yyyy}") %>' />
                <br /><br />
                <asp:Label ID="Label5" runat="server" Text="Obecne miejsce zamieszkania: "></asp:Label>
                <asp:Label ID="Label3" runat="server" Text='<%# Eval("residence") %>' />

            </ItemTemplate>
        </asp:ListView>
        <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
            SelectCommand="SELECT [username], [f_name], [l_name], [DOB], [residence], [image] FROM [User] WHERE ([username] = @username)">
            <SelectParameters>
                <asp:ControlParameter ControlID="ContentPlaceholder1$toUserDropDown" Name="username"
                    PropertyName="SelectedValue" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br /><br />
    </div>
    

</asp:Content>