<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Friends.aspx.cs" Inherits="User_Friends" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder3" runat="Server">
    <div id="myFriends">
        MOI ZNAJOMI:
        <br />
        <br />
        <asp:ListView ID="ListView1" runat="server" DataSourceID="SqlDataSource1" DataKeyNames="username_friend" OnSelectedIndexChanged="ListView1_SelectedIndexChanged">

            <ItemTemplate>
                <asp:LinkButton ID="LinkButton1" runat="server" CssClass="friendslist1" Text='<%# Eval("username_friend") %>' CommandName="select"></asp:LinkButton>

                <br />
            </ItemTemplate>
        </asp:ListView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
            SelectCommand="SELECT [username_friend] FROM [User_friends] WHERE [username] = @username AND [status] = 'true'"></asp:SqlDataSource>

        <asp:ListView ID="ListView2" runat="server" DataSourceID="SqlDataSource2" DataKeyNames="username" OnSelectedIndexChanged="ListView2_SelectedIndexChanged">

            <ItemTemplate>
                <asp:LinkButton ID="LinkButton2" runat="server" CssClass="friendslist2" Text='<%# Eval("username") %>' CommandName="select"></asp:LinkButton>

                <br />
            </ItemTemplate>
        </asp:ListView>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
            SelectCommand="SELECT [username] FROM [User_friends] WHERE [username_friend] = @username AND [status] = 'true'  "></asp:SqlDataSource>

    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="friendsMain">
        <div id="addFriends">
            <asp:Label ID="selectedUserLabel" visible="false" runat="server" Text=""></asp:Label>
            <asp:Label ID="pickFriendLabel" runat="server" Text="Wybierz znajomego by zobaczyć jego profil"></asp:Label>
            
            
            <asp:FormView ID="aboutFriendFormView" runat="server" DataSourceID="SqlDataSource6">
                <ItemTemplate>
                <asp:Label ID="Label2" runat="server" Text="Użytkownik: "></asp:Label>
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
                <br /><br />
                <asp:Label ID="Label8" runat="server" Text="Mail: "></asp:Label>
                <asp:Label ID="Label9" runat="server" Text='<%# Eval("mail") %>' />
                <br /><br />
                <asp:Label ID="Label6" runat="server" Text="Numer telefonu: "></asp:Label>
                <asp:Label ID="Label7" runat="server" Text='<%# Eval("phone_no") %>' />
                
                <br /><br />
                  <asp:Button ID="sentMesToFriendButton" runat="server" Text="WYŚLIJ WIADOMOŚĆ" OnClick="sentMesToFriendButton_Click" BackColor="#ffcccc" Height="32" Width="80%" Font-Names="Book Antiqua" Font-Bold="true" ForeColor="#661616" CssClass="friendbuttons"/>
            <br /><br />
            <asp:Button ID="removeFriendButton" runat="server" Text="USUŃ" OnClick="removeFriendButton_Click" BackColor="#ffcccc" Height="32" Width="55%" Font-Names="Book Antiqua" Font-Bold="true" ForeColor="#661616" CssClass="friendbuttons2"/>
                <asp:CheckBox ID="removeFriendCheckBox" runat="server" text="USUŃ"/>
                <br />
            </ItemTemplate>



            </asp:FormView>




            
 
            <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [username], [l_name], [f_name], [mail], [DOB], [image], [phone_no], [residence] FROM [User] WHERE ([username] = @username)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="selectedUserLabel" Name="username" PropertyName="Text" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
         
            <br />
        </div>

        <div id="acceptFriends">
            
            <asp:Label ID="Label1" runat="server" Text="DODAJ DO ZNAJOMYCH"></asp:Label>
            <br />
            <asp:DropDownList ID="addUserDropDown" Width="50%" runat="server" DataSourceID="SqlDataSource3" DataTextField="username" DataValueField="username" BackColor="#ffffe6"></asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="(SELECT [username] FROM [User] WHERE [Username]<>@username) EXCEPT (select [username_friend] from [User_friends] where [username]=@username) EXCEPT (select [username] from [User_friends] where [username_friend]=@username)"></asp:SqlDataSource>
            <br />
            <br />
            <asp:Button ID="addFriendButton" CssClass="allButtons" runat="server" Text="Zaproś!" OnClick="addFriendButton_Click" BackColor="#ffcccc" Height="32" Width="40%" Font-Names="Book Antiqua" Font-Bold="true" ForeColor="#661616" />


            <br />
            <asp:Label ID="invitationSentLabel" runat="server" Text=""></asp:Label>
            <br />
            <br />
            ZAPROSZENIA DO GRONA ZNAJOMYCH:
            <br />
            <center>
            <asp:RadioButtonList ID="RadioButtonList1" runat="server" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonList1_SelectedIndexChanged" RepeatDirection="Horizontal">
                <asp:ListItem Selected="True">Otrzymane</asp:ListItem>
                <asp:ListItem>Wysłane</asp:ListItem>
            </asp:RadioButtonList>
                </center>
            <br />
            <asp:GridView ID="acceptFriendGridView" runat="server" AutoGenerateColumns="False" DataKeyNames="username" DataSourceID="SqlDataSource4" OnSelectedIndexChanged="acceptFriendGridView_SelectedIndexChanged" Width="100%">
                <Columns>
                    
                    <asp:CommandField ItemStyle-CssClass="acceptButton" ShowSelectButton="True" SelectText="Zaakceptuj!" ItemStyle-Width="20%" />
                    <asp:BoundField DataField="username" HeaderText="otrzymane od" SortExpression="username" ItemStyle-Width="40%" />
                    <asp:BoundField DataField="sent_date" HeaderText="data otrzymania" SortExpression="sent_date" DataFormatString="{0:dd.MM.yyyy; HH:mm}" ItemStyle-Width="40%" />

                </Columns>
                <RowStyle BackColor="#ffcccc"
                    ForeColor="#4d0000" Height="32px" />

                <AlternatingRowStyle BackColor="#ffffe6"
                    ForeColor="#4d0000" Height="32px" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                SelectCommand="SELECT [username], [sent_date] FROM [User_friends] WHERE [username_friend] = @username AND [status] = 'false'"></asp:SqlDataSource>

            <asp:GridView ID="sentFriendsGridView" Visible="false" runat="server" AutoGenerateColumns="False" DataKeyNames="username_friend" DataSourceID="SqlDataSource5" OnSelectedIndexChanged="sentFriendsGridView_SelectedIndexChanged" Width="100%">
                <Columns>
                    <asp:CommandField ItemStyle-CssClass="acceptButton" ShowSelectButton="True" SelectText="Anuluj!" ItemStyle-Width="20%" />
                    <asp:BoundField DataField="username_friend" HeaderText="wysłane do" SortExpression="username_friend" ItemStyle-Width="40%" />
                    <asp:BoundField DataField="sent_date" HeaderText="data wysłania" SortExpression="sent_date" DataFormatString="{0:dd.MM.yyyy; HH:mm}" ItemStyle-Width="40%" />

                </Columns>
                <RowStyle BackColor="#ffcccc"
                    ForeColor="#4d0000" Height="32px" />

                <AlternatingRowStyle BackColor="#ffffe6"
                    ForeColor="#4d0000" Height="32px" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                SelectCommand="SELECT [username_friend], [sent_date] FROM [User_friends] WHERE [username] = @username AND [status] = 'false'"></asp:SqlDataSource>

            <br />
            <br />
        </div>
    </div>
</asp:Content>

