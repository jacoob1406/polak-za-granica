<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <link href="StyleSheet.css" rel="stylesheet" />

</head>

<body>
    <form id="form1" runat="server">

        <!-- <asp:SiteMapDataSource ID="SiteMapDataSource1" runat="server" />


        <asp:SiteMapDataSource ID="UserSiteMapDataSource" runat="server" SiteMapProvider="UserSiteMap" />
        <asp:SiteMapDataSource ID="AdminSiteMapDataSource" runat="server" SiteMapProvider="AdminSiteMap" /> -->

        <asp:ToolkitScriptManager runat="server"></asp:ToolkitScriptManager>
        <div id="wrapper">
            <div id="loginheader">
                <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/User/UserMain.aspx" Font-Underline="False">
                <span id="titlered">POLAK ZA</span><span id="titlewhite">  GRANICĄ</span>
                    </asp:HyperLink>
                    </div>
            <br />
            <br />
            <asp:Label ID="userLabel" runat="server" Text="" Visible="false"></asp:Label>
            <div id="headerdefault">
                <div id="leftdefault">
                    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/User/UserMain.aspx">STRONA <br /> GŁÓWNA</asp:HyperLink>
                   <!-- <img src="images/flaga.jpg" style="width: 70px; height: auto;" /> -->
                </div>
                <div id="right1default">
                    <asp:Login ID="Login2" runat="server" BorderStyle="NotSet" CheckBoxStyle-HorizontalAlign="Left" CssClass="loginVertical" Orientation="Vertical" TitleText="" Height="65px" Style="margin-left: 0px" VisibleWhenLoggedIn="False" DestinationPageUrl="User/UserMain.aspx" PasswordRequiredErrorMessage="Hasło jest wymagane" UserNameRequiredErrorMessage="Nazwa użytkownika jest wymagana" UserNameLabelText="Nazwa Użytkowika:" RememberMeText="Zapamiętaj mnie" PasswordLabelText="Hasło:" LoginButtonText="Zaloguj" FailureText="Nie zalogowano. Spróbuj ponownie" LoginButtonStyle-CssClass="button123"></asp:Login>
                    <asp:Login ID="Login1" runat="server" BorderStyle="NotSet" CheckBoxStyle-HorizontalAlign="Left" CssClass="loginHorizontal" Orientation="Horizontal" TitleText="" Height="65px" Style="margin-left: 0px" VisibleWhenLoggedIn="False" DestinationPageUrl="User/UserMain.aspx" PasswordRequiredErrorMessage="Hasło jest wymagane" UserNameRequiredErrorMessage="Nazwa użytkownika jest wymagana" UserNameLabelText="Nazwa Użytkowika:" RememberMeText="Zapamiętaj mnie" PasswordLabelText="Hasło:" LoginButtonText="Zaloguj" FailureText="Nie zalogowano. Spróbuj ponownie" LoginButtonStyle-CssClass="button123"></asp:Login>
                </div>
                <div id="right2default">
                    <asp:LoginView ID="LoginView1" runat="server">
                        <AnonymousTemplate>
                            Witaj: Gość,
                            <asp:LoginStatus ID="LoginStatus1" runat="server" Font-Bold="True" LogoutText="Wyloguj się" LoginText="Zaloguj się" />
                        </AnonymousTemplate>
                        <LoggedInTemplate>
                            Witaj:
                            <asp:LoginName ID="LoginName1" runat="server" />
                            , 
              <asp:LoginStatus ID="LoginStatus2" runat="server" LogoutPageUrl="Logout.aspx" LogoutAction="Redirect" LogoutText="Wyloguj się" LoginText="Zaloguj się" />
                        </LoggedInTemplate>
                    </asp:LoginView>
                </div>
            </div>

            <div id="defaultmain">
                <div id="half2default">

                    <br />
                    Witaj na stronie łączącej polską społeczność za granicą. Dołącz do nas i ciesz się 
        możliwościami serwisu społecznościowego polakzagranica.com
        <br /><br />
                    <div id="defaultJeden">
                       <div style="width: 100%; text-align:center;"> OBIECUJEMY!</div>
                        <ol>
                            <li>ŁĄCZYMY POLAKÓW ZA GRANICĄ</li>
                            <li>Nie jesteśmy drugim Facebookiem</li>
                            <li>Znajdziesz tu osoby poszukujące tego co TY</li>
                            <li>Jesteśmy dla Was - Polaków za granicą</li>
                            <li>I zawsze będziemy</li>
                            <li>Treść strony będzie zawsze powiązana z Polonią</li>
                            <li>Treść jest kontrolowana przez administrację</li>
                            <li>I zawsze będzie</li>
                            <li> &#9786; </li>
                        </ol>
                    </div>
                    <div id="defaultDwa">
                    <br />
                    <asp:CreateUserWizard ID="CreateUserWizard1" runat="server" OnCreatedUser="CreateUserWizard1_CreatedUser" ContinueDestinationPageUrl="User/UserMain.aspx" CreateUserButtonText="ZAŁÓŹ KONTO" CreateUserButtonStyle-CssClass="allButtons" CreateUserButtonStyle-BackColor="#ffcccc" CreateUserButtonStyle-Font-Names="Book Antiqua" CreateUserButtonStyle-Font-Bold="true" CreateUserButtonStyle-Width="40%" CreateUserButtonStyle-Height="32" CreateUserButtonStyle-ForeColor="#661616" CompleteSuccessText="Twoje konto zostało założone!" CancelButtonText="Anuluj" ConfirmPasswordLabelText="Potwierdź hasło" ContinueButtonText="Kontynuuj" DuplicateEmailErrorMessage="Wprowadzony adres e-mail jest zajęty. Proszę wprowadzić inny adres e-mail" DuplicateUserNameErrorMessage="Proszę wprowadzić inną nazwę użytkownika." FinishCompleteButtonText="Zakończono" FinishPreviousButtonText="Poprzedni" InvalidEmailErrorMessage="Proszę wprowadziś prawidłowy adres email:" InvalidPasswordErrorMessage="Minimalna liczba znaków w haśle to 5" PasswordLabelText="Hasło:" StepNextButtonText="Następny" UnknownErrorMessage="Twoje konto nie zostało założone. Proszę spróbować jeszcze raz." CssClass="createPage">
                    <WizardSteps>
                        <asp:CreateUserWizardStep ID="CreateUserWizardStep1" runat="server">
                            <ContentTemplate>
                                <div id="createaccount">
                                    <table>
                                        <tr>
                                            <td align="center" colspan="2">ZAŁÓŻ NOWE KONTO</td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:Label ID="FirstNameLabel" runat="server" AssociatedControlID="firstNameTextBox">Imię:&nbsp</asp:Label>
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="firstNameTextBox" runat="server" Width="150" MaxLength="50" BackColor="#ffffe6"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:Label ID="LastNameLabel" runat="server" AssociatedControlID="lastNameTextBox">Nazwisko:&nbsp</asp:Label>
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="lastNameTextBox" runat="server" Width="150" MaxLength="50" BackColor="#ffffe6"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">Nazwa użytkownika:&nbsp</asp:Label>
                                            </td>
                                            <td align="right">
                                                <asp:TextBox ID="UserName" runat="server" Width="150" MaxLength="30" BackColor="#ffffe6"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td align="right">
                                                <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Hasło:&nbsp</asp:Label>
                                            </td>
                                            <td align="right">
                                                <asp:TextBox ID="Password" runat="server" TextMode="Password" Width="150" BackColor="#ffffe6"> </asp:TextBox>
                                                <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:Label ID="ConfirmPasswordLabel" runat="server" AssociatedControlID="ConfirmPassword">Potwierdź Hasło:&nbsp</asp:Label>
                                            </td>
                                            <td align="right">
                                                <asp:TextBox ID="ConfirmPassword" runat="server" TextMode="Password" Width="150" BackColor="#ffffe6"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="ConfirmPasswordRequired" runat="server" ControlToValidate="ConfirmPassword" ErrorMessage="Confirm Password is required." ToolTip="Confirm Password is required." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:Label ID="EmailLabel" runat="server" AssociatedControlID="Email">E-mail:&nbsp</asp:Label>
                                            </td>
                                            <td align="right">
                                                <asp:TextBox ID="Email" runat="server" Width="150" MaxLength="50" BackColor="#ffffe6"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="EmailRequired" runat="server" ControlToValidate="Email" ErrorMessage="E-mail is required." ToolTip="E-mail is required." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="regexEmailValid" runat="server" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="Email" ValidationGroup="CreateUserWizard1" ErrorMessage=""></asp:RegularExpressionValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:Label ID="DOBLabel" runat="server" AssociatedControlID="dobTextBox">Data Urodzenia:&nbsp</asp:Label>
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="dobTextBox" runat="server" Width="150" BackColor="#ffffe6"></asp:TextBox>
                                            </td>
                                            <asp:CalendarExtender TargetControlID="dobTextBox" ID="CalendarExtender1" runat="server"
                                                FirstDayOfWeek="Monday" Format="dd.MM.yyyy">
                                            </asp:CalendarExtender>

                                        </tr>


                                        <tr>
                                            <td align="center" colspan="2">
                                                <asp:CompareValidator ID="PasswordCompare" runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword" Display="Dynamic" ErrorMessage="Hasło i potwierdzające hasło muszą być takie same." ValidationGroup="CreateUserWizard1"></asp:CompareValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" colspan="2" style="color: Red;">
                                                <asp:Literal ID="ErrorMessage" runat="server" EnableViewState="False"></asp:Literal>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </ContentTemplate>
                        </asp:CreateUserWizardStep>
                        <asp:CompleteWizardStep ID="CompleteWizardStep1" runat="server">
                            <ContentTemplate>
                                <table>
                                    <tr>
                                        <td align="center">Gotowe</td>
                                    </tr>
                                    <tr>
                                        <td>Twoje konto zostało założone!</td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            <asp:Button ID="ContinueButton" runat="server" CausesValidation="False" CommandName="Kontynuuj" Text="Kontynuuj" ValidationGroup="CreateUserWizard1" OnClick="ContinueButton_Click" />
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:CompleteWizardStep>
                    </WizardSteps>
                </asp:CreateUserWizard>
                        </div>
                </div>
                <div id="half3default">
                    <img id="logoondefault" src="images/logoKuba1.jpg" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>
