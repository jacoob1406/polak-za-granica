using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;
using System.IO;
using System.Text;

using System.Configuration;
using System.Data.SqlClient;

using System.Web.Security;



public partial class User_UserSettings : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            SqlDataSource1.SelectParameters.Add("touser", User.Identity.Name);

            //-----------------------------------------------------------------------------------

            string dbstring = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(dbstring);
            string sqlStr1 = "SELECT f_name FROM [User] WHERE [username]=@username";
            string sqlStr2 = "SELECT l_name FROM [User] WHERE [username]=@username";
            string sqlStr3 = "SELECT mail FROM [User] WHERE [username]=@username";
            string sqlStr4 = "SELECT residence FROM [User] WHERE [username]=@username";
            string sqlStr5 = "SELECT phone_no FROM [User] WHERE [username]=@username";


            SqlCommand sqlCmd1 = new SqlCommand(sqlStr1, con);
            SqlCommand sqlCmd2 = new SqlCommand(sqlStr2, con);
            SqlCommand sqlCmd3 = new SqlCommand(sqlStr3, con);
            SqlCommand sqlCmd4 = new SqlCommand(sqlStr4, con);
            SqlCommand sqlCmd5 = new SqlCommand(sqlStr5, con);

            con.Open();

            sqlCmd1.Parameters.AddWithValue("@username", this.User.Identity.Name);
            sqlCmd2.Parameters.AddWithValue("@username", this.User.Identity.Name);
            sqlCmd3.Parameters.AddWithValue("@username", this.User.Identity.Name);
            sqlCmd4.Parameters.AddWithValue("@username", this.User.Identity.Name);
            sqlCmd5.Parameters.AddWithValue("@username", this.User.Identity.Name);

            string value1 = (string)sqlCmd1.ExecuteScalar();
            nameTextBox.Text = value1;

            string value2 = (string)sqlCmd2.ExecuteScalar();
            surnameTextBox.Text = value2;

            string value3 = (string)sqlCmd3.ExecuteScalar();
            mailTextBox.Text = value3;

            string value4 = (string)sqlCmd4.ExecuteScalar();
            residenceTextBox.Text = value4;

            string value5 = (string)sqlCmd5.ExecuteScalar();
            phoneNoTextBox.Text = value5;


            con.Close();


        }
    }


    protected void RemoveMyAccountButton_Click(object sender, EventArgs e)
    {
        if (!removeMyAccountCheckBox.Checked)
        {
            resultLabel.ForeColor = System.Drawing.Color.Red;
            resultLabel.Text = "Oznacz chęć dezaktywacji!";
        }
        else if (removeMyAccountCheckBox.Checked)
        {

            string dbstring = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(dbstring);
            string sqlStr = "SELECT mail FROM [User] WHERE [username]=@username";

            SqlCommand sqlCmd = new SqlCommand(sqlStr, con);

            con.Open();

            sqlCmd.Parameters.AddWithValue("@username", this.User.Identity.Name);

            string value = (string)sqlCmd.ExecuteScalar();

            con.Close();

            MailMessage message = new MailMessage();
            message.IsBodyHtml = true;
            message.From = new MailAddress("polakzagranica.com@gmail.com");
            message.To.Add(new MailAddress(value));
            message.CC.Add(new MailAddress("polakzagranica.com@gmail.com"));
            message.Subject = "Twoje konto na polakzagranica.com zostało dezaktywowane!";
            string text = File.ReadAllText(Server.MapPath("~/MailTemplates/DeactivateMyAccountTemplate.txt"));

            message.Body = text;
            message.BodyEncoding = System.Text.Encoding.UTF8;
            message.Body = message.Body.Replace("<%Username%>", this.User.Identity.Name);

            SmtpClient client = new SmtpClient();
            client.EnableSsl = true;
            client.Send(message);

            MembershipUser user = Membership.GetUser(this.User.Identity.Name);
            user.IsApproved = false;
            Membership.UpdateUser(user);

            Response.Redirect("~/AccountRemoved.aspx");
        }
    }
    protected void newsLetterButton_Click(object sender, EventArgs e)
    {
        string dbstring = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        SqlConnection con = new SqlConnection(dbstring);

        string sqlStr = "SELECT [mail] FROM [Newsletter] WHERE [mail] = @mail";

        SqlCommand sqlCmd = new SqlCommand(sqlStr, con);

        sqlCmd.Parameters.AddWithValue("@mail", newsletterTextBox.Text);

        con.Open();

        object result = sqlCmd.ExecuteScalar();

        if (result == null)
        {
            string sqlStr2 = "INSERT INTO [Newsletter] ([mail], [username]) VALUES (@mail, @username)";

            SqlCommand sqlCmd2 = new SqlCommand(sqlStr2, con);

            sqlCmd2.Parameters.AddWithValue("@mail", newsletterTextBox.Text);
            sqlCmd2.Parameters.AddWithValue("@username", this.User.Identity.Name);

            sqlCmd2.ExecuteNonQuery();

            con.Close();

            resultLabel.ForeColor = System.Drawing.Color.Black;
            newsletterResultLabel.Text = "Mail dodany do bazy!";
        }
        else
        {
            newsletterResultLabel.ForeColor = System.Drawing.Color.Black;
            newsletterResultLabel.Text = "Mail znajduje się już w naszej bazie!";
        }
    }
    protected void messageFromUserButton_Click(object sender, EventArgs e)
    {
        string dbstring = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(dbstring);
        string sqlStr = "SELECT mail FROM [User] WHERE [username]=@username";

        SqlCommand sqlCmd = new SqlCommand(sqlStr, con);

        con.Open();

        sqlCmd.Parameters.AddWithValue("@username", this.User.Identity.Name);


        string value = (string)sqlCmd.ExecuteScalar();
        string subject = messageSubjectTextBox.Text;
        string messageBody = messageFromUserTextBox.Text;

        con.Close();

        MailMessage message = new MailMessage();
        message.IsBodyHtml = true;
        message.From = new MailAddress("polakzagranica.com@gmail.com");
        message.To.Add(new MailAddress("polakzagranica.com@gmail.com"));
        message.Subject = subject;
        string text = File.ReadAllText(Server.MapPath("~/MailTemplates/MessageFromUserTemplate.txt"));

        message.Body = text;
        message.BodyEncoding = System.Text.Encoding.UTF8;
        message.Body = message.Body.Replace("<%Username%>", this.User.Identity.Name);
        message.Body = message.Body.Replace("<%Mail%>", value);
        message.Body = message.Body.Replace("<%MessageBody%>", messageBody);



        SmtpClient client = new SmtpClient();
        client.EnableSsl = true;
        client.Send(message);

        messageSubjectTextBox.Text = "Wpisz temat wiadomości";
        messageFromUserTextBox.Text = "TWOJA WIADOMOŚĆ ZOSTAŁA WYSŁANA!";

    }
    protected void updateAccountButton_Click(object sender, EventArgs e)
    {
        string dbstring = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        SqlConnection con = new SqlConnection(dbstring);

        string sqlStr = "UPDATE [User] SET [f_name]=@fname, [l_name]=@lname, [mail]=@mail, [residence]=@residence, [phone_no]=@phoneno WHERE [username]=@username";

        SqlCommand sqlCmd = new SqlCommand(sqlStr, con);

        con.Open();

        sqlCmd.Parameters.AddWithValue("@fname", nameTextBox.Text);
        sqlCmd.Parameters.AddWithValue("@lname", surnameTextBox.Text);
        sqlCmd.Parameters.AddWithValue("@mail", mailTextBox.Text);
        sqlCmd.Parameters.AddWithValue("@residence", residenceTextBox.Text);
        sqlCmd.Parameters.AddWithValue("@phoneno", phoneNoTextBox.Text);
        sqlCmd.Parameters.AddWithValue("@username", this.User.Identity.Name);

        sqlCmd.ExecuteNonQuery();

        con.Close();
        titleLabel.ForeColor = System.Drawing.Color.White;
        titleLabel.Text = "PROFIL ZAKTUALIZOWANY!";
    }
    protected void profilePicButton_Click(object sender, EventArgs e)
    {
        string dbstring = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        SqlConnection con = new SqlConnection(dbstring);

        con.Open();

        string sqlStr = "UPDATE [User] SET [image]=@image WHERE [username]=@username";

        SqlCommand sqlCmd = new SqlCommand(sqlStr, con);

        string imagePath = "~/images/profile_pictures/NoImage.jpg";

        //Check if the user has selected an image file that should be used instead of the default
        if (ImageFileUpload.HasFile)
        {
            //Check if the file has a valid extension
            string extension = System.IO.Path.GetExtension(ImageFileUpload.PostedFile.FileName);

            if (extension == ".png" || extension == ".gif" || extension == ".jpg" || extension == ".bmp")
            {
                //Save the file in the crooms folder on the server. I want the filename to be the name of the room,
                //but without any dots and dashes. E.g. an image for a room VBI-6.01, should be saved as VBI601.extension.

                //Remove any . and - from the room name
                string imageName = this.User.Identity.Name;

                //Now save the file
                ImageFileUpload.SaveAs(Server.MapPath("~/images/profile_pictures/" + imageName + extension));

                //Now set the imagePath that we will store in the DB to the path of the newly saved file
                imagePath = "~/images/profile_pictures/" + imageName + extension;
            }
        }

        sqlCmd.Parameters.AddWithValue("@username", this.User.Identity.Name);
        sqlCmd.Parameters.AddWithValue("@image", imagePath);

        sqlCmd.ExecuteNonQuery();

        con.Close();

        Response.Redirect(Request.RawUrl);

    }
}