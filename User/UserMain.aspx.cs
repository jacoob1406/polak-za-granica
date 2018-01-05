using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Configuration;
using System.Data.SqlClient;

public partial class User_UserMain : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {


        if (!IsPostBack)
        {
            SqlDataSource7.SelectParameters.Add("username", User.Identity.Name);
            SqlDataSource8.SelectParameters.Add("username", User.Identity.Name);

            DropDownList countryList = ((DropDownList)Master.FindControl("countryDropDownList"));

            if (Session.Count > 0 && Session["place"] != null)
            {
                // if (countryList.Items.Count > 0)
                // {
                countryList.SelectedValue = Session["place"].ToString();
                //  }
            }
            else 
            {
                countryList.SelectedIndex = -1;
            }

            if (!IsPostBack)
            {
                ownPostTextBox.Attributes.Add("maxlength", ownPostTextBox.MaxLength.ToString());
            }
            
      
        }


    }


    protected void EventsGridView_DataBound(object sender, EventArgs e)
    {
        if (EventsGridView.Rows.Count == 0)
        {
            Panel1.Visible = false;
        }
        else
        {
            Panel1.Visible = true;
        }

    }

    protected void EventsGridView_SelectedIndexChanged(object sender, EventArgs e)
    {
        int eventId = Convert.ToInt32(EventsGridView.SelectedDataKey.Value.ToString());
        string dbstring = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        SqlConnection con = new SqlConnection(dbstring);

        string sqlStr = "SELECT * from Event_participants where (@eventid=event_id) AND (@user=[user])";

        SqlCommand sqlCmd = new SqlCommand(sqlStr, con);

        sqlCmd.Parameters.AddWithValue("@eventid", eventId);
        sqlCmd.Parameters.AddWithValue("@user", this.User.Identity.Name);

        con.Open();

        object result = sqlCmd.ExecuteScalar();

        if (result == null)
        {
            string sqlStr2 = "INSERT INTO event_participants (event_id, [user]) VALUES (@eventid, @user)";

            SqlCommand sqlCmd2 = new SqlCommand(sqlStr2, con);

            sqlCmd2.Parameters.AddWithValue("@eventid", eventId);
            sqlCmd2.Parameters.AddWithValue("@user", this.User.Identity.Name);


            sqlCmd2.ExecuteNonQuery();

            con.Close();
            resultLabel.ForeColor = System.Drawing.Color.Red;
            resultLabel.Text = "Bierzesz udział w wydarzeniu!";
        }
        else
        {
            resultLabel.ForeColor = System.Drawing.Color.Black;
            resultLabel.Text = "Jesteś już uczestnikiem tego wydarzenia!";
        }
    }

    protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (RadioButtonList1.SelectedIndex == 0)
        {
            EventsGridView.Visible = true;
            myEventsGridView.Visible = false;
            Response.Redirect(Request.RawUrl);
        }
        else if (RadioButtonList1.SelectedIndex == 1)
        {
            EventsGridView.Visible = false;
            myEventsGridView.Visible = true;
           
        }

    }
    protected void ownPostButton_Click(object sender, EventArgs e)
    {
        DropDownList countryList = ((DropDownList)Master.FindControl("countryDropDownList"));

        if (countryList.Items.Count != 0)
        {

            string dbstring = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            SqlConnection con = new SqlConnection(dbstring);

            string sqlStr = "INSERT INTO post ([username], place, text, [date]) VALUES (@username, @place, @text, @date)";

            SqlCommand sqlCmd = new SqlCommand(sqlStr, con);

            con.Open();

            sqlCmd.Parameters.AddWithValue("@username", this.User.Identity.Name);
            sqlCmd.Parameters.AddWithValue("@place", countryList.SelectedValue);
            sqlCmd.Parameters.AddWithValue("@text", ownPostTextBox.Text);
            sqlCmd.Parameters.AddWithValue("@date", DateTime.Now);


            sqlCmd.ExecuteNonQuery();
            ownPostTextBox.Text = String.Empty;
            Response.Redirect(Request.RawUrl);


            con.Close();
        }
        else
        {
            Response.Redirect("~/User/GroupAddCreate.aspx");
        }
    }


    protected void CreateEventButton_Click(object sender, EventArgs e)
    {
         DropDownList countryList = ((DropDownList)Master.FindControl("countryDropDownList"));

         if (countryList.Items.Count != 0 && eventDateTextBox.Text!="")
         {
             string datestr = eventDateTextBox.Text;
             string[] splitDateStr = datestr.Split(new char[] { '-', '/', '.' });
             DateTime theDate = new DateTime(Convert.ToInt32(splitDateStr[2]), Convert.ToInt32(splitDateStr[1]), Convert.ToInt32(splitDateStr[0]));

             string dbstring = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

             SqlConnection con = new SqlConnection(dbstring);

             string sqlStr = "INSERT INTO Event (event_name, [username], place, [date], time, location) VALUES (@name, @username, @place, @date, @time, @location)";

             SqlCommand sqlCmd = new SqlCommand(sqlStr, con);

             con.Open();


             sqlCmd.Parameters.AddWithValue("@name", eventNameTextBox.Text);
             sqlCmd.Parameters.AddWithValue("@username", this.User.Identity.Name);
             sqlCmd.Parameters.AddWithValue("@place", countryList.SelectedValue);
             sqlCmd.Parameters.AddWithValue("@date", theDate);
             sqlCmd.Parameters.AddWithValue("@time", eventTimeTextBox.Text);
             sqlCmd.Parameters.AddWithValue("@location", eventLocationTextBox.Text);

             sqlCmd.ExecuteNonQuery();
             ownPostTextBox.Text = String.Empty;
             Response.Redirect(Request.RawUrl);


             con.Close();
             resultEventLabel.ForeColor = System.Drawing.Color.Red;
             resultEventLabel.Text = "Wydarzenie zostało stworzone!";
         }
         else if (eventDateTextBox.Text=="")
         {
             CreateEventButton.Text = "USTAW DATĘ!";
         }
         else
         {
             Response.Redirect("~/User/GroupAddCreate.aspx");
         }
    }
    protected void ownArticleButton_Click(object sender, EventArgs e)
    {
         DropDownList countryList = ((DropDownList)Master.FindControl("countryDropDownList"));

         if (countryList.Items.Count != 0)
         {
             string dbstring = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

             SqlConnection con = new SqlConnection(dbstring);

             string sqlStr = "INSERT INTO Article (article_name, [username], place, text, [date]) VALUES (@name, @username, @place, @text, @date)";

             SqlCommand sqlCmd = new SqlCommand(sqlStr, con);

             con.Open();

             sqlCmd.Parameters.AddWithValue("@name", ownArticleTitle.Text);
             sqlCmd.Parameters.AddWithValue("@username", this.User.Identity.Name);
             sqlCmd.Parameters.AddWithValue("@place", countryList.SelectedValue);
             sqlCmd.Parameters.AddWithValue("@text", ownArticleTextBox.Text);
             sqlCmd.Parameters.AddWithValue("@date", DateTime.Now);

             sqlCmd.ExecuteNonQuery();
             ownArticleTextBox.Text = String.Empty;
             Response.Redirect(Request.RawUrl);

             con.Close();
             articleResultLabel.ForeColor = System.Drawing.Color.White;
             articleResultLabel.Text = "Dodano artykuł!";
         }
         else
         {
             Response.Redirect("~/User/GroupAddCreate.aspx");
         }
    }
    protected void commentArticleButton_Click(object sender, EventArgs e)
    {
        string dbstring = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        SqlConnection con = new SqlConnection(dbstring);

        string sqlStr = "SELECT * from Article_comment where (@articleid=article_id) AND (@user=[username]) AND (@commment = [comment])";

        SqlCommand sqlCmd = new SqlCommand(sqlStr, con);

        sqlCmd.Parameters.AddWithValue("@articleid", ArticleDropDownList.SelectedValue);
        sqlCmd.Parameters.AddWithValue("@user", this.User.Identity.Name);
        sqlCmd.Parameters.AddWithValue("@commment", commentTextBox.Text);

        con.Open();

        object result = sqlCmd.ExecuteScalar();

        if (ArticleDropDownList.Items.Count != 0)
        {
            if (result == null)
            {
                string sqlStr2 = "INSERT INTO Article_comment (article_id, username, comment, date) VALUES (@articleid, @user, @comment, @date)";

                string value = ArticleDropDownList.SelectedValue;

                SqlCommand sqlCmd2 = new SqlCommand(sqlStr2, con);

                sqlCmd2.Parameters.AddWithValue("@articleid", ArticleDropDownList.SelectedValue);
                sqlCmd2.Parameters.AddWithValue("@user", this.User.Identity.Name);
                sqlCmd2.Parameters.AddWithValue("@comment", commentTextBox.Text);
                sqlCmd2.Parameters.AddWithValue("@date", DateTime.Now);


                sqlCmd2.ExecuteNonQuery();

                con.Close();

                Response.Redirect(Request.RawUrl);

                //ArticleDropDownList.SelectedValue = value;

            }
            else
            {
                commentTextBox.Text = "Już tak skomentowałeś artykuł!";
            }
        }
      
    }

    protected void ListView4_SelectedIndexChanged(object sender, EventArgs e)
    {
        string friend = ListView4.SelectedDataKey.Value.ToString();
        Session["friend"] = friend;
        Response.Redirect("~/User/Friends.aspx");
    }

    protected void ListView5_SelectedIndexChanged(object sender, EventArgs e)
    {
        string friend = ListView5.SelectedDataKey.Value.ToString();
        Session["friend"] = friend;
        Response.Redirect("~/User/Friends.aspx");
    }
}