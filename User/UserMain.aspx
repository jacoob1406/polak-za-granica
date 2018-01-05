<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="UserMain.aspx.cs" Inherits="User_UserMain" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="Server">
    <div id="placeinfo">
        INFORMACJE O MIEJSCU
        <br />
        <br />
        <asp:ListView ID="ListView3" runat="server" DataSourceID="SqlDataSource5">

            <ItemTemplate>

                <asp:Label ID="placeInfoLabel" runat="server" Text='<%# Eval("place_info").ToString().ToUpper() %>' Font-Size="9" Font-Names='Candara, Calibri, Segoe, "Segoe UI", Optima, Arial, sans-serif' CssClass="infoTekst" />

            </ItemTemplate>


        </asp:ListView>

        <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [place_info] FROM [Place] WHERE ([place_name] = @place)">
            <SelectParameters>
                <asp:ControlParameter ControlID="countryDropDownList" Name="place"
                    PropertyName="SelectedValue" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>

    </div>
    <div id="usermainfriends">
        TWOI ZNAJOMI
        <br />
        <br />
        <asp:ListView ID="ListView4" runat="server" DataSourceID="SqlDataSource7" DataKeyNames="username_friend" OnSelectedIndexChanged="ListView4_SelectedIndexChanged">

            <ItemTemplate>
                <asp:LinkButton ID="LinkButton1" runat="server" CssClass="friendslist1" Text='<%# Eval("username_friend") %>' CommandName="select"></asp:LinkButton>

                <br />
            </ItemTemplate>
        </asp:ListView>
        <asp:SqlDataSource ID="SqlDataSource7" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
            SelectCommand="SELECT [username_friend] FROM [User_friends] WHERE [username] = @username AND [status] = 'true'"></asp:SqlDataSource>

        <asp:ListView ID="ListView5" runat="server" DataSourceID="SqlDataSource8" DataKeyNames="username" OnSelectedIndexChanged="ListView5_SelectedIndexChanged">

            <ItemTemplate>
                <asp:LinkButton ID="LinkButton2" runat="server" CssClass="friendslist2" Text='<%# Eval("username") %>' CommandName="select"></asp:LinkButton>

                <br />
            </ItemTemplate>
        </asp:ListView>
        <asp:SqlDataSource ID="SqlDataSource8" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
            SelectCommand="SELECT [username] FROM [User_friends] WHERE [username_friend] = @username AND [status] = 'true'  "></asp:SqlDataSource>

    </div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"></asp:ToolkitScriptManager>
    <div id="userOne">
        POSTY
        <br />
        <br />
        <asp:TextBox ID="ownPostTextBox" runat="server" MaxLength="300" EnableViewState="True" Height="70" Width="400" TextMode="MultiLine" Text="max. 300 znaków" BackColor="#ffffe6"></asp:TextBox>
        <br />
        <asp:Button ID="ownPostButton" CssClass="allButtons" runat="server" Text="Dodaj post" autoPostBack="true" OnClick="ownPostButton_Click" BackColor="#ffcccc" Width="40%" Height="32" Font-Names="Book Antiqua" Font-Bold="true" ForeColor="#661616"/>
        <br />
        <br />
        <asp:ListView ID="ListView1" runat="server" DataSourceID="SqlDataSource1">

            <ItemTemplate>
                <!-- The ItemTemplate defines how each item in the database will be displayed. 
              To get the value from each column we can use Eval("columnName")
            -->
                <span id="spanright"><span>
                    <asp:Label ID="datePostLabel" runat="server" Text='<%# Eval("date", "{0:dd.MM.yyyy}") %>' />
                </span>
                    by: 
            <span>
                <i>
                    <asp:Label ID="userPostLabel" runat="server" Text='<%# Eval("username") %>' />
                </i>
            </span>
                </span>
                <br />
                <span id="spanleft">
                    <asp:Label ID="textPostLabel" runat="server" Text='<%# Eval("text") %>' />
                </span>
                <br />
                <br />


            </ItemTemplate>

            <LayoutTemplate>
                <div id="itemPlaceholderContainer" runat="server" style="">
                    <span runat="server" id="itemPlaceholder" />
                </div>
                <div style="text-align: center">
                    <asp:DataPager ID="DataPager1" runat="server" PageSize="5">
                        <Fields>
                            <asp:NextPreviousPagerField ButtonCssClass="pagerbutton" ButtonType="Button" ShowFirstPageButton="False" ShowNextPageButton="False" ShowPreviousPageButton="True" FirstPageText="Początek" LastPageText="Koniec" NextPageText="Następna" PreviousPageText="Poprzedni" />
                            <asp:NumericPagerField />
                            <asp:NextPreviousPagerField ButtonCssClass="pagerbutton" ButtonType="Button" ShowLastPageButton="False" ShowNextPageButton="True" ShowPreviousPageButton="False" FirstPageText="Początek" LastPageText="Koniec" NextPageText="Następna" PreviousPageText="Poprzedni"  />
                        </Fields>
                    </asp:DataPager>
                </div>
            </LayoutTemplate>
            <EmptyDataTemplate>
                Brak postów w danej grupie
            </EmptyDataTemplate>

        </asp:ListView>
        <br />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server"
            ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
            SelectCommand="SELECT [username], [text], [date] FROM [Post] WHERE ([place] = @place) ORDER BY [date] desc">
            <SelectParameters>
                <asp:ControlParameter ControlID="countryDropDownList" Name="place"
                    PropertyName="SelectedValue" Type="String" />
            </SelectParameters>

        </asp:SqlDataSource>

    </div>

    <div id="userTwo">
        NOWE ARTYKUŁY
        <br />
        <br />
        <asp:Panel ID="Panel2" runat="server">
            <asp:Label ID="ArticleLabel" runat="server">Wybierz Artykuł:</asp:Label>
            <asp:DropDownList ID="ArticleDropDownList" runat="server" DataSourceID="SqlDataSource3" DataTextField="article_name" DataValueField="article_id" AutoPostBack="true" BackColor="#ffffe6"></asp:DropDownList>
        </asp:Panel>
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [article_name], [article_id] FROM [Article]  WHERE ([place] = @place)">
            <SelectParameters>
                <asp:ControlParameter ControlID="countryDropDownList" Name="place"
                    PropertyName="SelectedValue" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />

        <asp:ListView ID="ListView2" runat="server" DataSourceID="SqlDataSource2">

            <ItemTemplate>

                <span id="spanright"><span>
                    <asp:Label ID="dateArticleLabel" runat="server" Text='<%# Eval("date", "{0:dd.MM.yyyy}") %>' />
                </span>
                    by: 
            <span>
                <i>
                    <asp:Label ID="userArticleLabel" runat="server" Text='<%# Eval("username") %>' />
                </i>
            </span>
                </span>
                <br />
                <span id="spanleft">
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Eval("text") %>' Height="240" Width="95%" TextMode="MultiLine" ReadOnly="True" BackColor="#ffcccc"></asp:TextBox>

                </span>
                <br />
                <br />


            </ItemTemplate>
            <EmptyDataTemplate>
                Brak artykułów w danej grupie
            </EmptyDataTemplate>
        </asp:ListView>

        <asp:SqlDataSource ID="SqlDataSource2" runat="server"
            ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
            SelectCommand="SELECT [username], [text], [date] FROM [Article] WHERE ([place] = @place AND [article_id] = @artname) ORDER BY [date] desc">
            <SelectParameters>
                <asp:ControlParameter ControlID="countryDropDownList" Name="place"
                    PropertyName="SelectedValue" Type="String" />
                <asp:ControlParameter ControlID="ArticleDropDownList" Name="artname"
                    PropertyName="SelectedValue" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>


        <asp:TextBox ID="commentTextBox" runat="server" Width="70%" MaxLength="300" BackColor="#ffffe6"></asp:TextBox>
        <asp:Button ID="commentArticleButton" CssClass="allButtons" runat="server" Text="Skomentuj" Width="25%" OnClick="commentArticleButton_Click" BackColor="#ffcccc" Font-Names="Book Antiqua" Font-Bold="true" ForeColor="#661616"/>
        <br />
        <asp:Label ID="Label1" runat="server" Text=""></asp:Label><br />
        <asp:ListView ID="commentsListView" runat="server" DataSourceID="SqlDataSource6">
            <ItemTemplate>
                <span id="spanright" style="font-size: 11pt;"><span>
                    <asp:Label ID="datePostLabel" runat="server" Text='<%# Eval("date", "{0:dd.MM.yyyy; HH:mm}") %>' />
                </span>
                    by: 
            <span style="font-size: 11pt;">
                <i>
                    <asp:Label ID="userPostLabel" runat="server" Text='<%# Eval("username") %>' />
                </i>
            </span>
                </span>
                <br />
                <span id="spanleft" style="font-size: 11pt;">
                    <asp:Label ID="textPostLabel" runat="server" Text='<%# Eval("comment") %>' />
                </span>
                <br />
                <br />


            </ItemTemplate>

        </asp:ListView>

        <asp:SqlDataSource ID="SqlDataSource6" runat="server"
            ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
            SelectCommand="SELECT [username], [comment], [date] FROM [Article_comment] WHERE ([article_id] = @articleid) ORDER BY [date] desc">
            <SelectParameters>
                <asp:ControlParameter ControlID="ArticleDropDownList" Name="articleid"
                    PropertyName="SelectedValue" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>

    <div id="userThree">
        WYDARZENIA 
        <br />
        <br />
        Dodaj wydarzenie:
   <br />
        <table>
            <tr>
                <td>
                    <asp:Label ID="eventNameLabel" runat="server" Width="124px" Text="Nazwa wydarzenia:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="eventNameTextBox" runat="server" Width="90%" MaxLength="100" BackColor="#ffffe6"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="dateLabel" runat="server" Width="124px" Text="Data:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="eventDateTextBox" runat="server" Width="90%" BackColor="#ffffe6"></asp:TextBox>
                    <asp:CalendarExtender TargetControlID="eventDateTextBox" ID="CalendarExtender1" runat="server" FirstDayOfWeek="Monday" Format="dd.MM.yyyy"></asp:CalendarExtender>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="timeLabel" runat="server" Width="70px" Text="Czas:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="eventTimeTextBox" runat="server" Width="90%" MaxLength="5" BackColor="#ffffe6"></asp:TextBox>
                    <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" TargetControlID="eventTimeTextBox" FilterType="Numbers,Custom" ValidChars=":" runat="server">
                    </asp:FilteredTextBoxExtender>
                </td>
                <td class="notvisib">
                    <asp:Label ID="LabelX" runat="server" Width="70px" Text="format GG:MM"></asp:Label></td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="locationLabel" runat="server" Width="70px" Text="Lokalizacja:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox CssClass="eventmargin" ID="eventLocationTextBox" runat="server" Width="90%" MaxLength="100" BackColor="#ffffe6"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <asp:Button ID="CreateEventButton" CssClass="allButtons" runat="server" Text="Stwórz wydarzenie"
                        OnClick="CreateEventButton_Click" BackColor="#ffcccc" Height="32" Width="90%" Font-Names="Book Antiqua" Font-Bold="true" ForeColor="#661616"/>
                </td>
                <td></td>
            </tr>
            <tr>
                <td>

                    <asp:Label ID="resultEventLabel" runat="server" Text=""></asp:Label></td>
            </tr>
        </table>
        <br />

        <asp:RadioButtonList ID="RadioButtonList1" runat="server" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonList1_SelectedIndexChanged" Width="200" CssClass="radiocss">


            <asp:ListItem Selected="True">Wszystkie wydarzenia</asp:ListItem>
            <asp:ListItem>Moje wydarzenia</asp:ListItem>


        </asp:RadioButtonList>
        <br />
        <asp:Panel ID="Panel1" runat="server">
            <asp:Label ID="resultLabel" runat="server" Text=""></asp:Label>
            <br />

        </asp:Panel>
        <asp:GridView ID="EventsGridView" runat="server" AutoGenerateColumns="False" DataKeyNames="event_id" DataSourceID="SqlDataSource4" OnSelectedIndexChanged="EventsGridView_SelectedIndexChanged" BorderColor="Red" AlternatingRowStyle-BorderColor="Red" BorderStyle="Solid" EmptyDataRowStyle-CssClass="EmptyData" EmptyDataRowStyle-BorderWidth="0" Width="100%">
            <Columns>
                <asp:CommandField ShowSelectButton="True" SelectText="Biorę udział" ItemStyle-Width="10%"/>
                <asp:BoundField DataField="event_id" HeaderText="ID" SortExpression="event_id" Visible="false" />
                <asp:BoundField DataField="event_name" HeaderText="Nazwa" SortExpression="event_name" ItemStyle-Width="25%" />
                <asp:BoundField DataField="username" HeaderText=" Twórca " SortExpression="username" ItemStyle-Width="15%"/>
                <asp:BoundField DataField="date" HeaderText="Data" SortExpression="date" DataFormatString="{0:dd.MM.yyyy}" ItemStyle-Width="15%" />
                <asp:BoundField DataField="time" HeaderText="Czas" SortExpression="time" ItemStyle-Width="10%" />
                <asp:BoundField DataField="location" HeaderText="Gdzie?" SortExpression="location" ItemStyle-Width="15%"/>
                <asp:BoundField DataField="summa" HeaderText="Bierze udział" SortExpression="summa" ItemStyle-Width="10%" />

            </Columns>
            <EmptyDataTemplate>
                &nbsp&nbsp&nbsp&nbsp&nbsp Brak nadchodzących wydarzeń w tym mieście...&nbsp&nbsp&nbsp&nbsp&nbsp
            </EmptyDataTemplate>

            <RowStyle BackColor="#ffcccc"
                ForeColor="#4d0000" Height="32px"/>

            <AlternatingRowStyle BackColor="#ffffe6"
                ForeColor="#4d0000" Height="32px"/>
        </asp:GridView>

        <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
            SelectCommand="SELECT [event_id], [event_name], [username], [date], [time], [location], (select COUNT([user]) from [Event_participants] where [event_id] = e.event_id) as summa FROM [Event] e WHERE ([place] = @place) AND ([date] >= CAST(GETDATE() AS DATE))">
            <SelectParameters>
                <asp:ControlParameter ControlID="countryDropDownList" Name="place"
                    PropertyName="SelectedValue" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>


        <asp:GridView ID="myEventsGridView" Visible="false" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource9" BorderColor="Red" AlternatingRowStyle-BorderColor="Red" BorderStyle="Solid" EmptyDataRowStyle-CssClass="EmptyData" EmptyDataRowStyle-BorderWidth="0" Width="100%">
            <Columns>
                <asp:BoundField DataField="event_name" HeaderText="Nazwa" SortExpression="event_name" ItemStyle-Width="30%"/>
                <asp:BoundField DataField="username" HeaderText=" Twórca " SortExpression="username" ItemStyle-Width="15%"/>
                <asp:BoundField DataField="date" HeaderText="Data" SortExpression="date" DataFormatString="{0:dd.MM.yyyy}" ItemStyle-Width="15%"/>
                <asp:BoundField DataField="time" HeaderText="Czas" SortExpression="time" ItemStyle-Width="10%" />
                <asp:BoundField DataField="location" HeaderText="Gdzie?" SortExpression="location" ItemStyle-Width="20%"/>
                <asp:BoundField DataField="summa" HeaderText="Bierze udział" SortExpression="summa" ItemStyle-Width="10%" />

            </Columns>
            <EmptyDataTemplate>
                &nbsp&nbsp&nbsp&nbsp&nbsp Brak nadchodzących wydarzeń w tym mieście...&nbsp&nbsp&nbsp&nbsp&nbsp
            </EmptyDataTemplate>
            <RowStyle BackColor="#ffcccc"
                ForeColor="#4d0000" Height="32px"/>

            <AlternatingRowStyle BackColor="#ffffe6"
                ForeColor="#4d0000" Height="32px"/>
        </asp:GridView>

        <asp:SqlDataSource ID="SqlDataSource9" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
            SelectCommand="SELECT [event_name], [username], [date], [time], [location], (select COUNT([user]) from [Event_participants] where [event_id] = e.event_id) as summa FROM [Event] e WHERE ([place] = @place) AND ([date] >= CAST(GETDATE() AS DATE))">
            <SelectParameters>
                <asp:ControlParameter ControlID="countryDropDownList" Name="place"
                    PropertyName="SelectedValue" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>



        <br />
    </div>

    <div id="userFour">
        DODAJ WŁASNY ARTYKUŁ
        <br />
        <br />
        <asp:Label ID="ownArticleLable" runat="server" Text="TYTUŁ"></asp:Label>
        <asp:TextBox ID="ownArticleTitle" runat="server" MaxLength="50" EnableViewState="True" Height="20" Width="75%" TextMode="SingleLine" BackColor="#ffcccc"></asp:TextBox>
        <br />
        <asp:TextBox ID="ownArticleTextBox" runat="server" EnableViewState="True" Height="230" Width="95%" TextMode="MultiLine" BackColor="#ffffe6"></asp:TextBox>
        <br />
        <asp:Button ID="ownArticleButton" CssClass="allButtons" runat="server" Text="Dodaj artykuł" autoPostBack="true" OnClick="ownArticleButton_Click" BackColor="#ffcccc" Height="32" Width="40%" Font-Names="Book Antiqua" Font-Bold="true" ForeColor="#661616"/>
        <br />
        <br />
        <asp:Label ID="articleResultLabel" runat="server" Text=""></asp:Label>
    </div>
</asp:Content>

