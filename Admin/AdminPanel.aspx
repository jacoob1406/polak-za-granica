<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="AdminPanel.aspx.cs" Inherits="Admin_AdminPanel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="Server">
    <div id="adminPanel1">
        <div style="width: 100%; text-align: center;">OBIECUJEMY!</div>
        <ol>
            <li>ŁĄCZYMY POLAKÓW ZA GRANICĄ</li>
            <li>Nie jesteśmy drugim Facebookiem</li>
            <li>Znajdziesz tu osoby poszukujące tego co TY</li>
            <li>Jesteśmy dla Was - Polaków za granicą</li>
            <li>I zawsze będziemy</li>
            <li>Treść strony będzie zawsze powiązana z Polonią</li>
            <li>Treść jest kontrolowana przez administrację</li>
            <li>I zawsze będzie</li>
            <li>&#9786; </li>
        </ol>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="adminPanel">

        <!-- zablokuj użytkownika -->

        <div class="adminright">
            <asp:Label ID="Label3" runat="server" Text=" ZABLOKUJ UŻYTKOWNIKA: "></asp:Label>

            <asp:DropDownList ID="userRemoveDropDown" runat="server" DataSourceID="SqlDataSource1" DataTextField="username" DataValueField="username" Width="85%" BackColor="#ffffe6"></asp:DropDownList>

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                SelectCommand="SELECT [username] FROM [User] WHERE [username]<>@touser"></asp:SqlDataSource>
        </div>
        <div class="adminleft">
            <asp:CheckBox ID="usernameCheckBox" runat="server" Text="Zablokuj użytkownika" />
            <br />
            <asp:Button ID="removeUserButton" runat="server" Text="BLOKUJ" Width="50%" OnClick="removeUserButton_Click" BackColor="#ffcccc" Height="22" Font-Names="Book Antiqua" Font-Bold="true" ForeColor="#661616" />


            <asp:Label ID="resultLabel1" runat="server" Text=""></asp:Label>
        </div>

        <!-- usuń artykuł -->

        <div class="adminright">
            <asp:Label ID="Label2" runat="server" Text=" USUŃ ARTYKUŁ:"></asp:Label>


            <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="true" DataSourceID="SqlDataSource2" DataTextField="article_name" DataValueField="article_id" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged" Width="85%" BackColor="#ffffe6"></asp:DropDownList>

            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                SelectCommand="SELECT [article_id], [article_name] FROM [Article]"></asp:SqlDataSource>
            <asp:Label ID="Label1" runat="server" Text="ID: "></asp:Label>
            <asp:Label ID="articleIdLabel" runat="server" Text="[...]"></asp:Label>
        </div>
        <div class="adminleft">
            <asp:CheckBox ID="articleCheckBox" runat="server" Text="Usuń artykuł" />
            <br />
            <asp:Button ID="removeArticleButton" runat="server" Text="USUŃ" Width="50%" OnClick="removeArticleButton_Click" BackColor="#ffcccc" Height="22" Font-Names="Book Antiqua" Font-Bold="true" ForeColor="#661616" />


            <asp:Label ID="resultLabel2" runat="server" Text=""></asp:Label>
        </div>

        <!-- usuń post -->

        <div class="adminright">
            <asp:Label ID="Label4" runat="server" Text="USUŃ POST: "></asp:Label>

            <asp:DropDownList ID="postRemoveDropDown" runat="server" DataSourceID="SqlDataSource3" DataTextField="post_id" DataValueField="post_id" Width="85%" BackColor="#ffffe6"></asp:DropDownList>

            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                SelectCommand="SELECT [post_id] FROM [Post]"></asp:SqlDataSource>
        </div>
        <div class="adminleft">
            <asp:CheckBox ID="postCheckBox" runat="server" Text="Usuń post" />

            <br />
            <asp:Button ID="removePostButton" runat="server" Text="USUŃ" Width="50%" OnClick="removePostButton_Click" BackColor="#ffcccc" Height="22" Font-Names="Book Antiqua" Font-Bold="true" ForeColor="#661616" />

            <asp:Label ID="resultLabel3" runat="server" Text=""></asp:Label>
        </div>

        <!-- usuń wydarzenie -->

        <div class="adminright">
            <asp:Label ID="Label6" runat="server" Text=" USUŃ WYDARZENIE: "></asp:Label>

            <asp:DropDownList ID="eventsDropDown" runat="server" DataSourceID="SqlDataSource5" DataTextField="event_name" DataValueField="event_id" Width="85%" BackColor="#ffffe6"></asp:DropDownList>

            <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                SelectCommand="SELECT [event_name], [event_id] FROM [Event] WHERE ([date] >= CAST(GETDATE() AS DATE))"></asp:SqlDataSource>
        </div>
        <div class="adminleft">
            <asp:CheckBox ID="eventCheckBox" runat="server" Text="Usuń wydarzenie" />
            <br />
            <asp:Button ID="removeEventButton" runat="server" Text="USUŃ" Width="50%" OnClick="removeEventButton_Click" BackColor="#ffcccc" Height="22" Font-Names="Book Antiqua" Font-Bold="true" ForeColor="#661616" />


            <asp:Label ID="resultLabel5" runat="server" Text=""></asp:Label>
        </div>

        <!-- usuń grupę -->

        <div class="adminright">
            <asp:Label ID="Label8" runat="server" Text=" USUŃ GRUPĘ: "></asp:Label>

            <asp:DropDownList ID="placeDropDown2" runat="server" DataSourceID="SqlDataSource6" DataTextField="place_name" DataValueField="place_name" Width="85%" BackColor="#ffffe6"></asp:DropDownList>

            <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                SelectCommand="SELECT [place_name] FROM [Place]"></asp:SqlDataSource>
        </div>
        <div class="adminleft">
            <asp:CheckBox ID="removeGroupCheckBox" runat="server" Text="Usuń grupę" />
            <br />
            <asp:Button ID="removeGroupButton" runat="server" Text="USUŃ" Width="50%" OnClick="removeGroupButton_Click" BackColor="#ffcccc" Height="22" Font-Names="Book Antiqua" Font-Bold="true" ForeColor="#661616" />


            <asp:Label ID="resultLabel6" runat="server" Text=""></asp:Label>
        </div>

        <!-- dodaj info o miejscu -->

        <div class="adminrightinfo">
            <asp:Label ID="Label5" runat="server" Text="DODAJ INFO O MIEJSCU:"></asp:Label>

            <asp:DropDownList ID="placeDropDown" runat="server" DataSourceID="SqlDataSource4" DataTextField="place_name" DataValueField="place_name" Width="85%" BackColor="#ffffe6"></asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                SelectCommand="SELECT [place_name] FROM [Place]"></asp:SqlDataSource>
            <br />
            <asp:Button ID="addPlaceInfoButton" runat="server" Text="DODAJ" Width="50%" CssClass="buttnoinfo" OnClick="addPlaceInfoButton_Click" BackColor="#ffcccc" Height="22" Font-Names="Book Antiqua" Font-Bold="true" ForeColor="#661616" />
            <asp:Label ID="resultLabel4" runat="server" Text=""></asp:Label>
        </div>
        <div class="adminleftinfo">
            <asp:TextBox ID="adminPlaceInfoTextBox" runat="server" TextMode="MultiLine" Height="70" Width="100%" BackColor="#ffcccc"></asp:TextBox>

        </div>

        <!-- newsletter -->

        <div class="adminrightinfo">
            <asp:Label ID="Label7" runat="server" Text="WYŚLIJ NEWSLETTER DO:"></asp:Label>
            <asp:DropDownList ID="newsletterToDropDown" runat="server" DataSourceID="SqlDataSource7" DataTextField="mail" DataValueField="username" BackColor="#ffffe6"></asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource7" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [mail], [username] FROM [Newsletter]"></asp:SqlDataSource>
            <br />
            <asp:CheckBox ID="sendToAllCheckBox" runat="server" Text="Wyślij do wszystkich" />
            <br />
            <asp:Button ID="newsletterButton" runat="server" Text="WYŚLIJ" Width="50%" CssClass="buttnoinfo" OnClick="newsletterButton_Click" BackColor="#ffcccc" Height="22" Font-Names="Book Antiqua" Font-Bold="true" ForeColor="#661616" />
            <asp:Label ID="resultLabel7" runat="server" Text=""></asp:Label>
        </div>
        <div class="adminleftinfo">
            <asp:TextBox ID="newsletterBodyTextBox" runat="server" TextMode="MultiLine" Height="70" Width="100%" BackColor="#ffcccc"></asp:TextBox>

        </div>

    </div>
</asp:Content>
