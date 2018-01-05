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

public partial class Admin_AdminPanel : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            SqlDataSource1.SelectParameters.Add("touser", User.Identity.Name);
        }
    }
    protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
    {
        articleIdLabel.Text = DropDownList2.SelectedValue;
    }
    protected void addPlaceInfoButton_Click(object sender, EventArgs e)
    {
        string dbstring = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        SqlConnection con = new SqlConnection(dbstring);

        string sqlStr = "UPDATE [Place] SET [place_info]=@placeinfo WHERE [place_name]=@placename";

        SqlCommand sqlCmd = new SqlCommand(sqlStr, con);

        con.Open();

        sqlCmd.Parameters.AddWithValue("@placeinfo", adminPlaceInfoTextBox.Text);
        sqlCmd.Parameters.AddWithValue("@placename", placeDropDown.SelectedValue);

        sqlCmd.ExecuteNonQuery();
        adminPlaceInfoTextBox.Text = String.Empty;


        con.Close();
        resultLabel4.ForeColor = System.Drawing.Color.Red;
        resultLabel4.Text = "Dodano!";
    }
    protected void removeArticleButton_Click(object sender, EventArgs e)
    {
        if (!articleCheckBox.Checked)
        {
            resultLabel2.ForeColor = System.Drawing.Color.Red;
            resultLabel2.Text = "Oznacz chęć usunięcia!";
        }
        else if (articleCheckBox.Checked)
        {
            string dbstring = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            SqlConnection con = new SqlConnection(dbstring);

            string sqlStr = "DELETE FROM [Article] WHERE [article_id]=@articleid";

            SqlCommand sqlCmd = new SqlCommand(sqlStr, con);

            con.Open();

            sqlCmd.Parameters.AddWithValue("@articleid", articleIdLabel.Text);

            sqlCmd.ExecuteNonQuery();

            con.Close();

            resultLabel2.ForeColor = System.Drawing.Color.Red;
            resultLabel2.Text = "Artykuł usunięty!";
        }
    }
    protected void removePostButton_Click(object sender, EventArgs e)
    {
        if (!postCheckBox.Checked)
        {
            resultLabel3.ForeColor = System.Drawing.Color.Red;
            resultLabel3.Text = "Oznacz chęć usunięcia!";
        }
        else if (postCheckBox.Checked)
        {
            string dbstring = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            SqlConnection con = new SqlConnection(dbstring);

            string sqlStr = "DELETE FROM [Post] WHERE [post_id]=@postid";

            SqlCommand sqlCmd = new SqlCommand(sqlStr, con);

            con.Open();

            sqlCmd.Parameters.AddWithValue("@postid", postRemoveDropDown.Text);

            sqlCmd.ExecuteNonQuery();

            con.Close();

            resultLabel3.ForeColor = System.Drawing.Color.Red;
            resultLabel3.Text = "Post usunięty!";
        }
    }
    protected void removeUserButton_Click(object sender, EventArgs e)
    {
        if (!usernameCheckBox.Checked)
        {
            resultLabel1.ForeColor = System.Drawing.Color.Red;
            resultLabel1.Text = "Oznacz chęć zablokowania!";
        }
        else if (usernameCheckBox.Checked)
        {

            string dbstring = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(dbstring);
            string sqlStr = "SELECT mail FROM [User] WHERE [username]=@username";

            SqlCommand sqlCmd = new SqlCommand(sqlStr, con);

            con.Open();

            sqlCmd.Parameters.AddWithValue("@username", userRemoveDropDown.Text);


            string value = (string)sqlCmd.ExecuteScalar();

            con.Close();

            MailMessage message = new MailMessage();
            message.IsBodyHtml = true;
            message.From = new MailAddress("polakzagranica.com@gmail.com");
            message.To.Add(new MailAddress(value));
            message.CC.Add(new MailAddress("polakzagranica.com@gmail.com"));
            message.Subject = "Twoje konto na polakzagranica.com zostało usunięte!";
            string text = File.ReadAllText(Server.MapPath("~/MailTemplates/DeactivateUserTemplate.txt"));

            message.Body = text;
            message.BodyEncoding = System.Text.Encoding.UTF8;
            message.Body = message.Body.Replace("<%Username%>", userRemoveDropDown.Text);

            SmtpClient client = new SmtpClient();
            client.EnableSsl = true;
            client.Send(message);

            MembershipUser user = Membership.GetUser(userRemoveDropDown.Text);
            user.IsApproved = false;
            Membership.UpdateUser(user);

            resultLabel1.ForeColor = System.Drawing.Color.Red;
            resultLabel1.Text = "Użytkownik zablokowany!";
        }
    }
    protected void removeEventButton_Click(object sender, EventArgs e)
    {
        if (!eventCheckBox.Checked)
        {
            resultLabel5.ForeColor = System.Drawing.Color.Red;
            resultLabel5.Text = "Oznacz chęć usunięcia!";
        }
        else if (eventCheckBox.Checked)
        {
            string dbstring = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            SqlConnection con = new SqlConnection(dbstring);

            string sqlStr = "DELETE FROM [Event_participants] WHERE [event_id]=@eventid";
            string sqlStr2 = "DELETE FROM [Event] WHERE [event_id]=@eventid";

            SqlCommand sqlCmd = new SqlCommand(sqlStr, con);
            SqlCommand sqlCmd2 = new SqlCommand(sqlStr2, con);

            con.Open();

            sqlCmd.Parameters.AddWithValue("@eventid", eventsDropDown.SelectedValue);
            sqlCmd2.Parameters.AddWithValue("@eventid", eventsDropDown.SelectedValue);

            sqlCmd.ExecuteNonQuery();
            sqlCmd2.ExecuteNonQuery();

            con.Close();

            resultLabel5.ForeColor = System.Drawing.Color.Red;
            resultLabel5.Text = "Wydarzenie usunięte!";
        }
    }
    protected void removeGroupButton_Click(object sender, EventArgs e)
    {
        if (!removeGroupCheckBox.Checked)
        {
            resultLabel6.ForeColor = System.Drawing.Color.Red;
            resultLabel6.Text = "Oznacz chęć usunięcia!";
        }
      
        else if (removeGroupCheckBox.Checked)
        {
            string dbstring = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            SqlConnection con = new SqlConnection(dbstring);

           /* string sqlStr0 = "SELECT Count(event_id) FROM [Event] WHERE [place]=@place";
            SqlCommand sqlCmd0 = new SqlCommand(sqlStr0, con);
            sqlCmd0.Parameters.AddWithValue("@place", placeDropDown2.Text);
            Int32 value = (Int32)sqlCmd0.ExecuteScalar();

            string sqlStr00 = "SELECT (event_id) FROM [Event] WHERE [place]=@place";
            int[] eventIDs = new int[value];
            for (int i = 0; i < value; i++)
            {

            }
            */
            string sqlStr1 = "DELETE FROM [Article] WHERE [place]=@place";
            
                string sqlStr11 = "DELETE FROM [Event_participants] WHERE [event_id] IN (SELECT [event_id] from [Event] WHERE [place]=@place)";
            
            string sqlStr2 = "DELETE FROM [Event] WHERE [place]=@place";
            string sqlStr3 = "DELETE FROM [Group] WHERE [place]=@place";
            string sqlStr4 = "DELETE FROM [Post] WHERE [place]=@place";
            string sqlStr5 = "DELETE FROM [Place] WHERE [place_name]=@place";

            SqlCommand sqlCmd1 = new SqlCommand(sqlStr1, con);
          SqlCommand sqlCmd11 = new SqlCommand(sqlStr11, con);
            SqlCommand sqlCmd2 = new SqlCommand(sqlStr2, con);
            SqlCommand sqlCmd3 = new SqlCommand(sqlStr3, con);
            SqlCommand sqlCmd4 = new SqlCommand(sqlStr4, con);
            SqlCommand sqlCmd5 = new SqlCommand(sqlStr5, con);

            con.Open();

            sqlCmd1.Parameters.AddWithValue("@place", placeDropDown2.Text);
           sqlCmd11.Parameters.AddWithValue("@place", placeDropDown2.Text);
            sqlCmd2.Parameters.AddWithValue("@place", placeDropDown2.Text);
            sqlCmd3.Parameters.AddWithValue("@place", placeDropDown2.Text);
            sqlCmd4.Parameters.AddWithValue("@place", placeDropDown2.Text);
            sqlCmd5.Parameters.AddWithValue("@place", placeDropDown2.Text);


            sqlCmd1.ExecuteNonQuery();
          sqlCmd11.ExecuteNonQuery();
            sqlCmd2.ExecuteNonQuery();
            sqlCmd3.ExecuteNonQuery();
            sqlCmd4.ExecuteNonQuery();
            sqlCmd5.ExecuteNonQuery();

            con.Close();

            resultLabel6.ForeColor = System.Drawing.Color.Red;
            resultLabel6.Text = "Grupa usunięta!";
        } 
    }
    protected void newsletterButton_Click(object sender, EventArgs e)
    {
        string maill = newsletterToDropDown.SelectedItem.ToString(); 

        if (!sendToAllCheckBox.Checked)
        {

            MailMessage message = new MailMessage();
            message.IsBodyHtml = true;
            message.From = new MailAddress("polakzagranica.com@gmail.com");
            message.To.Add(new MailAddress(maill));
            message.Subject = "Newsletter polakzagranica.com !";
            string text = File.ReadAllText(Server.MapPath("~/MailTemplates/NewsletterTemplate.txt"));
            message.Body = text;
            message.BodyEncoding = System.Text.Encoding.UTF8;
            message.Body = message.Body.Replace("<%Username%>", userRemoveDropDown.SelectedValue);
            message.Body = message.Body.Replace("<%newslettertext%>", newsletterBodyTextBox.Text);

            SmtpClient client = new SmtpClient();
            client.EnableSsl = true;
            client.Send(message);

            resultLabel7.ForeColor = System.Drawing.Color.Red;
            resultLabel7.Text = "Wysłano!";
        }

        else if (sendToAllCheckBox.Checked)
        {
            int numMails = newsletterToDropDown.Items.Count;

            for (int i = 0; i < numMails; i++)
            {
                MailMessage message = new MailMessage();
                message.IsBodyHtml = true;
                message.From = new MailAddress("polakzagranica.com@gmail.com");
                message.To.Add(new MailAddress(newsletterToDropDown.Items[i].Text));
                message.Subject = "Newsletter polakzagranica.com !";
                string text = File.ReadAllText(Server.MapPath("~/MailTemplates/NewsletterTemplate.txt"));
                message.Body = text;
                message.BodyEncoding = System.Text.Encoding.UTF8;
                message.Body = message.Body.Replace("<%Username%>", userRemoveDropDown.SelectedValue);
                message.Body = message.Body.Replace("<%newslettertext%>", newsletterBodyTextBox.Text);

                SmtpClient client = new SmtpClient();
                client.EnableSsl = true;
                client.Send(message);
            }

            resultLabel7.ForeColor = System.Drawing.Color.Red;
            resultLabel7.Text = "Wysłano!";
        }
    }
}