<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="UserSettings.aspx.cs" Inherits="User_UserSettings" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="Server">
    <div class="createhalf0">
        <asp:Label ID="titleLabel" runat="server" Text="Aktualizuj swój profil:" ></asp:Label>
        <br />
        <br />
        <asp:Label ID="nameLabel" runat="server" Text="Imię:" ></asp:Label>
        <br />
        <asp:TextBox ID="nameTextBox" runat="server" MaxLength="50" Width="70%" BackColor="#ffffe6"></asp:TextBox>
        <br />
        <asp:Label ID="surnameLabel" runat="server" Text="Nazwisko:"></asp:Label>
        <br />
        <asp:TextBox ID="surnameTextBox" runat="server" MaxLength="50" Width="70%" BackColor="#ffffe6"></asp:TextBox>
        <br />
        <asp:Label ID="mailLabel" runat="server" Text="Mail:"></asp:Label>
        <br />
        <asp:TextBox ID="mailTextBox" runat="server" MaxLength="50" Width="70%" BackColor="#ffffe6"></asp:TextBox>
        <br />
        <asp:Label ID="residenceLabel" runat="server" Text="Aktualne miejsce pobytu:"></asp:Label>
        <br />
        <asp:TextBox ID="residenceTextBox" runat="server" MaxLength="50" Width="70%" BackColor="#ffffe6"></asp:TextBox>
        <br />
        <asp:Label ID="phoneNoLabel" runat="server" Text="Numer telefonu:"></asp:Label>
        <br />
        <div style="font-size: 7pt">FORMAT: +YYXXXXXXXX</div>
        <asp:TextBox ID="phoneNoTextBox" runat="server" MaxLength="12" Width="70%" BackColor="#ffffe6"></asp:TextBox>
        <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" TargetControlID="phoneNoTextBox" FilterType="Numbers,Custom" ValidChars="+" runat="server"></asp:FilteredTextBoxExtender>
        <br />
        <br />
        <asp:Button ID="updateAccountButton" CssClass="allButtons" runat="server" Text="Aktualizuj" OnClick="updateAccountButton_Click" BackColor="#ffcccc" Height="32" Width="55%" Font-Names="Book Antiqua" Font-Bold="true" ForeColor="#661616"/>
        <br />
        <br />

    </div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"></asp:ToolkitScriptManager>
    <div class="createhalf1">
        <div id="profilepic1">
        <asp:ListView ID="ListView1" runat="server" DataSourceID="SqlDataSource1">
            <ItemTemplate>
        <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("image").ToString() == "" ? "~/images/profile_pictures/NoImage.png" : Eval("image") %>' AlternateText="Room Image"  Width="80%" CssClass="profilepicsettings"/>
            </ItemTemplate>
        </asp:ListView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
            SelectCommand="SELECT [image] FROM [User] WHERE [username]=@touser"></asp:SqlDataSource>
</div>
        <div id="profilepic2">
        <asp:Label ID="profilePicLabel" runat="server" Text="Aktualizuj zdjęcie profilowe"></asp:Label>
        <br />
        <asp:FileUpload ID="ImageFileUpload" runat="server" width="90%" />
        <br />
        <asp:Button ID="profilePicButton" CssClass="allButtons" runat="server" Text="Aktualizuj" OnClick="profilePicButton_Click" BackColor="#ffcccc" Height="32" Width="55%" Font-Names="Book Antiqua" Font-Bold="true" ForeColor="#661616" />
        
            </div>
        <br />
        <br />

        <asp:ChangePassword ID="ChangePassword1" runat="server" ConfirmPasswordCompareErrorMessage="Nowe Hasło musi być takie samo jak Nowe Hasło" ConfirmPasswordRequiredErrorMessage="Nowe Hasło jest wymagane" NewPasswordRegularExpressionErrorMessage="Proszę podać inne hasło" NewPasswordRequiredErrorMessage="Nowe Hasło jest wymagane" PasswordRequiredErrorMessage="Hasło jest wymagane" UserNameRequiredErrorMessage="Nazwa użytkownika jest wymagana" CancelButtonText="Anuluj" ChangePasswordButtonText="Zmień Hasło" ChangePasswordFailureText="Hasło błędne lub Nowe Hasło niepoprawne" ChangePasswordTitleText="Zmień swoje Hasło:" ConfirmNewPasswordLabelText="Potwierdź Nowe Hasło:" ContinueButtonText="Kontynuuj:" NewPasswordLabelText="Nowe Hasło:" PasswordLabelText="Hasło:" SuccessText="Hasło zostało zmienione!" SuccessTitleText="Zrobione!" UserNameLabelText="Nazwa Użytkownika:" ContinueDestinationPageUrl="UserMain.aspx" >
            <ChangePasswordTemplate>
                <table cellpadding="1" cellspacing="0" style="border-collapse:collapse;">
                    <tr>
                        <td>
                            <table cellpadding="0">
                                <tr>
                                    <td align="center" colspan="2">Zmień swoje Hasło:</td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        <asp:Label ID="CurrentPasswordLabel" runat="server" AssociatedControlID="CurrentPassword">Hasło:</asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="CurrentPassword" runat="server" TextMode="Password" BackColor="#ffffe6"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="CurrentPasswordRequired" runat="server" ControlToValidate="CurrentPassword" ErrorMessage="Hasło jest wymagane" ToolTip="Hasło jest wymagane" ValidationGroup="ChangePassword1">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        <asp:Label ID="NewPasswordLabel" runat="server" AssociatedControlID="NewPassword">Nowe Hasło:</asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="NewPassword" runat="server" TextMode="Password" BackColor="#ffffe6"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="NewPasswordRequired" runat="server" ControlToValidate="NewPassword" ErrorMessage="Nowe Hasło jest wymagane" ToolTip="Nowe Hasło jest wymagane" ValidationGroup="ChangePassword1">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        <asp:Label ID="ConfirmNewPasswordLabel" runat="server" AssociatedControlID="ConfirmNewPassword">Potwierdź Nowe Hasło:</asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="ConfirmNewPassword" runat="server" TextMode="Password" BackColor="#ffffe6"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="ConfirmNewPasswordRequired" runat="server" ControlToValidate="ConfirmNewPassword" ErrorMessage="Nowe Hasło jest wymagane" ToolTip="Nowe Hasło jest wymagane" ValidationGroup="ChangePassword1">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="2">
                                        <asp:CompareValidator ID="NewPasswordCompare" runat="server" ControlToCompare="NewPassword" ControlToValidate="ConfirmNewPassword" Display="Dynamic" ErrorMessage="Nowe Hasło musi być takie samo jak Nowe Hasło" ValidationGroup="ChangePassword1"></asp:CompareValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="2" style="color:Red;">
                                        <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        <asp:Button ID="ChangePasswordPushButton" CssClass="allButtons" runat="server" CommandName="ChangePassword" Text="Zmień Hasło" ValidationGroup="ChangePassword1" BackColor="#ffcccc" Height="26" Width="65%" Font-Names="Book Antiqua" Font-Bold="true" ForeColor="#661616" />
                                    </td>
                                    <td>
                                        <asp:Button ID="CancelPushButton" CssClass="allButtons" runat="server" CausesValidation="False" CommandName="Cancel" Text="Anuluj" BackColor="#ffcccc" Height="26" Width="55%" Font-Names="Book Antiqua" Font-Bold="true" ForeColor="#661616" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </ChangePasswordTemplate>
        </asp:ChangePassword>
        <br />
        <asp:Label ID="Label1" runat="server" Text="Dezaktywuj swoje konto:"></asp:Label>
        <br />
        <asp:CheckBox ID="removeMyAccountCheckBox" runat="server" Text="Potwierdź" />
        <br />
        <asp:Button ID="RemoveMyAccountButton" CssClass="allButtons" runat="server" Text="Dezaktywuj konto" OnClick="RemoveMyAccountButton_Click" BackColor="#ffcccc" Height="32" Width="55%" Font-Names="Book Antiqua" Font-Bold="true" ForeColor="#661616"/>
        <br />
        <br />
        <asp:Label ID="resultLabel" runat="server" Text=""></asp:Label>
    </div>

    <div class="createhalf2">
        <asp:Label ID="Label2" runat="server" Text="Zapisz się na nasz NEWSLETTER!"></asp:Label>
        <br />
        <asp:TextBox ID="newsletterTextBox" runat="server" MaxLength="50" BackColor="#ffffe6"></asp:TextBox>
        <br />
        <asp:Button ID="newsLetterButton" runat="server" Text="Zapisz się!" CssClass="sendButton" OnClick="newsLetterButton_Click" BackColor="#ffcccc" Height="28" Width="25%" Font-Names="Book Antiqua" Font-Bold="true" ForeColor="#661616" />
        <br />
        <asp:Label ID="newsletterResultLabel" runat="server" Text=""></asp:Label>
        <br />
        Napisz do nas:
        <br />
        <a href="mailto:polakzagranica.com@gmail.com" style="text-decoration: underline; color: white;">polakzagranica.com@gmail.com</a>
        <br />
        <br />
        Możesz też napisać tutaj:
        <br />
        <asp:TextBox ID="messageSubjectTextBox" runat="server" Text="Wpisz temat wiadomości" MaxLength="200" Width="75%" TextMode="SingleLine" CssClass="textboxpadding" BackColor="#ffcccc"></asp:TextBox>
        <br />
        <asp:TextBox ID="messageFromUserTextBox" runat="server" Width="75%" Height="100" TextMode="MultiLine" BackColor="#ffffe6"></asp:TextBox>
        <br />
        <asp:Button ID="messageFromUserButton" CssClass="allButtons" runat="server" Text="Wyślij" OnClick="messageFromUserButton_Click" BackColor="#ffcccc" Height="32" Width="55%" Font-Names="Book Antiqua" Font-Bold="true" ForeColor="#661616"/>
        <!--img src="../images/logoKuba1.jpg" id="logonewplace" style="width: 30%; height: auto" /-->
    </div>
</asp:Content>

