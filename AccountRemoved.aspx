<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AccountRemoved.aspx.cs" Inherits="AccountRemoved" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Polak Za Granicą</title>
</head>
<body>
    <link href="StyleSheet.css" rel="stylesheet" />
    <form id="form1" runat="server">
        <div id="loginheader"><asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/User/UserMain.aspx" Font-Underline="False">
            <span id="titlered">POLAK ZA</span><span id="titlewhite">  GRANICĄ</span>
            </asp:HyperLink>
            </div>
        <div id="mainn">
            <div id="loginsquare2">
                <div id="thankyou">DZIĘKI ZA WSPÓLNY CZAS!</div>
                <br />
                <br />
                <br />
                <br />
                <img id="kontur" src="images/logokuba2.jpg" />
                <br />
                <br />
                <br />
                <br />
                <div id="createaccount2">
                    <p>Wracasz &nbsp do&nbsp nas? &nbsp Załóż &nbsp konto   &nbsp <a id="tutaj" href="CreateUser.aspx">tutaj</a></p>
                </div>
            </div>

        </div>
    </form>
</body>
</html>
