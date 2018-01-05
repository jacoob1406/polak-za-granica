using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Net.Mail;
using System.IO;
using System.Text;


using System.Configuration;
using System.Data.SqlClient;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void CreateUserWizard1_CreatedUser(object sender, EventArgs e)
    {
        Roles.AddUserToRole(CreateUserWizard1.UserName, "User");

        string dateStr = ((TextBox)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("dobTextBox")).Text;

        string[] splitDateStr = dateStr.Split(new char[] { '-', '/', '.' });

        DateTime theDate = new DateTime(Convert.ToInt32(splitDateStr[2]), Convert.ToInt32(splitDateStr[1]), Convert.ToInt32(splitDateStr[0]));

        string dbstring = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        SqlConnection con = new SqlConnection(dbstring);

        string sqlStr = "INSERT INTO [User] (username, f_name, l_name, mail, DOB) VALUES (@username, @fname, @lname, @mail, @dob)";

        SqlCommand sqlCmd = new SqlCommand(sqlStr, con);

        con.Open();

        sqlCmd.Parameters.AddWithValue("@username", CreateUserWizard1.UserName);
        sqlCmd.Parameters.AddWithValue("@fname", ((TextBox)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("firstNameTextBox")).Text);
        sqlCmd.Parameters.AddWithValue("@lname", ((TextBox)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("lastNameTextBox")).Text);
        sqlCmd.Parameters.AddWithValue("@mail", CreateUserWizard1.Email);
        sqlCmd.Parameters.AddWithValue("@dob", theDate);

        sqlCmd.ExecuteNonQuery();

        con.Close();



        MailMessage message = new MailMessage();
        message.IsBodyHtml = true;
        message.From = new MailAddress("polakzagranica.com@gmail.com");
        message.To.Add(new MailAddress(CreateUserWizard1.Email));
        message.CC.Add(new MailAddress("polakzagranica.com@gmail.com"));
        message.Subject = "Konto na polakzagranica.com zostało założone!";

        string text = File.ReadAllText(Server.MapPath("~/MailTemplates/WelcomeMailTemplate.txt"));

        message.Body = text;
        message.BodyEncoding = System.Text.Encoding.UTF8;
        message.Body = message.Body.Replace("<%Username%>", CreateUserWizard1.UserName);

        SmtpClient client = new SmtpClient();
        client.EnableSsl = true;
        client.Send(message);

    }
    protected void ContinueButton_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Login.aspx");
    }
}