<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <link href="StyleSheet.css" rel="stylesheet" />

</head>
<body>
    <form id="form1" runat="server">

        <div id="loginheader">
            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/User/UserMain.aspx" Font-Underline="False">
            <span id="titlered">POLAK ZA</span><span id="titlewhite">  GRANICĄ</span>
                </asp:HyperLink>
                </div>
        <div id="mainn">

            <div id="loginsquare">

                <br />
                <br />
                <asp:Login ID="Login1" TextBoxStyle-CssClass="loginTextBox" CssClass="loginPage" runat="server" UserNameLabelText="Nazwa użytkownika:&nbsp&nbsp&nbsp&nbsp&nbsp" PasswordLabelText="Hasło:&nbsp&nbsp&nbsp&nbsp&nbsp" LoginButtonText="Zaloguj się" RememberMeText="Zapamiętaj mnie" TitleText=" " FailureText="Błędna nazwa użytkownika lub hasło. Spróbuj ponownie." LoginButtonStyle-CssClass="przycisk" DestinationPageUrl="User/UserMain.aspx" TextBoxStyle-BackColor="#ffffe6" TextBoxStyle-Width="90%" ></asp:Login>
                <br />
                <img id="kontur" src="images/logoKuba2.jpg" />
                <br />
                <div id="createaccount2">
                    <p>Nie &nbsp masz&nbsp konta? &nbsp Załóż &nbsp je   &nbsp <a id="tutaj" href="CreateUser.aspx">tutaj</a></p>
                </div>
            </div>

        </div>
    </form>
</body>
</html>
