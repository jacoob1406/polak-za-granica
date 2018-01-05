<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="GroupAddCreate.aspx.cs" Inherits="User_GroupAddCreate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="Server">
<div id="addcreatefriends">
        MOI ZNAJOMI
        <br /><br />
        <asp:ListView ID="ListView1" runat="server" DataSourceID="SqlDataSource4" DataKeyNames="username_friend" OnSelectedIndexChanged="ListView1_SelectedIndexChanged">
            
            <ItemTemplate>
                <asp:LinkButton ID="LinkButton1" runat="server" CssClass="friendslist1" Text='<%# Eval("username_friend") %>' CommandName="select"></asp:LinkButton>

                <br />
            </ItemTemplate>
        </asp:ListView>
        <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
            SelectCommand="SELECT [username_friend] FROM [User_friends] WHERE [username] = @username AND [status] = 'true'"></asp:SqlDataSource>
        
        <asp:ListView ID="ListView2" runat="server" DataSourceID="SqlDataSource3" DataKeyNames="username" OnSelectedIndexChanged="ListView2_SelectedIndexChanged">
            
            <ItemTemplate>
                <asp:LinkButton ID="LinkButton2" runat="server" CssClass="friendslist2" Text='<%# Eval("username") %>' CommandName="select"></asp:LinkButton>

                <br />
            </ItemTemplate>
        </asp:ListView>
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
            SelectCommand="SELECT [username] FROM [User_friends] WHERE [username_friend] = @username AND [status] = 'true'  "></asp:SqlDataSource>

        </div>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="createhalf1">
        DODAJ SIĘ DO GRUPY:
         <br />
        <br />

        WYBIERZ KRAJ:
        <br />
        <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSource1" DataTextField="country_name" DataValueField="country_id" AutoPostBack="true" Width="80%" BackColor="#ffffe6"></asp:DropDownList>
        <br />
        <br />
        WYBIERZ MIEJSCE:
        <br />
        <asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="SqlDataSource2" DataTextField="place_name" DataValueField="place_name" Width="80%" BackColor="#ffffe6"></asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [place_name] FROM [Place] WHERE ([country_id] = @country_id)">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList2" Name="country_id" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <br />

        <asp:Button ID="Button1" runat="server" Text="Dołącz" CssClass="allButtons"
            OnClick="AddToGroupButton_Click" BackColor="#ffcccc" Height="32" Width="40%" Font-Names="Book Antiqua" Font-Bold="true" ForeColor="#661616" />
        <br />
        <br />
        <asp:Label ID="addedToGroupLabel" runat="server" Text=""></asp:Label>
    </div>

    <div class="createhalf2">
        <div id="newplace1">
            STWÓRZ NOWE MIEJSCE NA MAPIE POLONII:
        <br />
            <br />
            WYBIERZ KRAJ:
            <br />
            <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource1" DataTextField="country_name" DataValueField="country_id" Width="80%" BackColor="#ffffe6"></asp:DropDownList>
            <br />
            <br />
            NAZWA MIEJSCOWOŚCI:
           <br />
            <asp:TextBox ID="placeNameTextBox" runat="server" Width="80%" MaxLength="100" BackColor="#ffffe6"></asp:TextBox>

            <br />
            <br />
            <asp:Button ID="CreateButton" CssClass="allButtons" runat="server" Text="Stwórz miejscowość"
                OnClick="CreateButton_Click" BackColor="#ffcccc" Height="32" Width="70%" Font-Names="Book Antiqua" Font-Bold="true" ForeColor="#661616" />
            <br />
            <br />
            <asp:Label ID="resultLabel" runat="server" Text=""></asp:Label>


            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [country_name], [country_id] FROM [Country]"></asp:SqlDataSource>
        </div>
        <div id="newplace2">
            <img src="../images/logoKuba1.jpg" id="logonewplace" />
        </div>
    </div>
</asp:Content>

