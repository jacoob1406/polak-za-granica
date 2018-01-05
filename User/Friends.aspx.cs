using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Configuration;
using System.Data.SqlClient;

public partial class User_Friends : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            SqlDataSource1.SelectParameters.Add("username", User.Identity.Name);
            SqlDataSource2.SelectParameters.Add("username", User.Identity.Name);
            SqlDataSource3.SelectParameters.Add("username", User.Identity.Name);
            SqlDataSource4.SelectParameters.Add("username", User.Identity.Name);
            SqlDataSource5.SelectParameters.Add("username", User.Identity.Name);

        }

        if (Session["friend"] != null)
        {
            pickFriendLabel.Visible = false;
            selectedUserLabel.Text = Session["friend"].ToString();
        }
    }

    protected void ListView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        string friend = ListView1.SelectedDataKey.Value.ToString();
        selectedUserLabel.Text = friend;
        pickFriendLabel.Visible = false;
        //Session["friend"] = friend;
        // Response.Redirect("~/User/Messages.aspx");
    }

    protected void ListView2_SelectedIndexChanged(object sender, EventArgs e)
    {
        string friend = ListView2.SelectedDataKey.Value.ToString();
        selectedUserLabel.Text = friend;
        pickFriendLabel.Visible = false;
        //  Session["friend"] = friend;
        //  Response.Redirect("~/User/Messages.aspx");
    }
    protected void addFriendButton_Click(object sender, EventArgs e)
    {
        if (addUserDropDown.Items.Count > 0)
        {
            string dbstring = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            SqlConnection con = new SqlConnection(dbstring);


            string sqlStr3 = "INSERT INTO [User_friends] (username, username_friend, sent_date) VALUES (@from, @to, @date)";

            SqlCommand sqlCmd3 = new SqlCommand(sqlStr3, con);

            con.Open();

            sqlCmd3.Parameters.AddWithValue("@from", this.User.Identity.Name);
            sqlCmd3.Parameters.AddWithValue("@to", addUserDropDown.SelectedValue);
            sqlCmd3.Parameters.AddWithValue("@date", DateTime.Now);


            sqlCmd3.ExecuteNonQuery();
            invitationSentLabel.Text = "WYSŁANO ZAPROSZENIE!";

            con.Close();

            Response.Redirect(Request.RawUrl);

            RadioButtonList1.SelectedIndex = 1;
        }
    }

    protected void acceptFriendGridView_SelectedIndexChanged(object sender, EventArgs e)
    {
        string username = acceptFriendGridView.SelectedDataKey.Value.ToString();

        string dbstring = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        SqlConnection con = new SqlConnection(dbstring);

        con.Open();

        string sqlStr = "UPDATE [User_friends] SET [status]= 'true', [accepted_date] = @date WHERE [username]=@username AND [username_friend] = @user";

        SqlCommand sqlCmd = new SqlCommand(sqlStr, con);

        sqlCmd.Parameters.AddWithValue("@username", username);
        sqlCmd.Parameters.AddWithValue("@user", this.User.Identity.Name);
        sqlCmd.Parameters.AddWithValue("@date", DateTime.Now);

        sqlCmd.ExecuteNonQuery();

        con.Close();

        Response.Redirect(Request.RawUrl);
    }






    protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (RadioButtonList1.SelectedIndex == 0)
        {
            acceptFriendGridView.Visible = true;
            sentFriendsGridView.Visible = false;
        }
        else if (RadioButtonList1.SelectedIndex == 1)
        {
            acceptFriendGridView.Visible = false;
            sentFriendsGridView.Visible = true;
        }
    }
    protected void sentFriendsGridView_SelectedIndexChanged(object sender, EventArgs e)
    {
        string username = sentFriendsGridView.SelectedDataKey.Value.ToString();

        string dbstring = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        SqlConnection con = new SqlConnection(dbstring);

        con.Open();

        string sqlStr = "DELETE FROM [User_friends] WHERE [username]=@username AND [username_friend] = @user";

        SqlCommand sqlCmd = new SqlCommand(sqlStr, con);

        sqlCmd.Parameters.AddWithValue("@username", this.User.Identity.Name);
        sqlCmd.Parameters.AddWithValue("@user", username);

        sqlCmd.ExecuteNonQuery();

        con.Close();

        Response.Redirect(Request.RawUrl);
    }
    protected void sentMesToFriendButton_Click(object sender, EventArgs e)
    {
        string friend = selectedUserLabel.Text.ToString();
        Session["friend"] = friend;
        Response.Redirect("~/User/Messages.aspx");
    }
    protected void removeFriendButton_Click(object sender, EventArgs e)
    {
       

        CheckBox cb = ((CheckBox)aboutFriendFormView.FindControl("removeFriendCheckBox"));
        Button b = (Button)aboutFriendFormView.FindControl("removeFriendButton");

        if (cb.Checked)
        {
            string dbstring = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            SqlConnection con = new SqlConnection(dbstring);

            string sqlStr = "DELETE FROM [User_friends] WHERE [username]=@username1 AND [username_friend]=@username2";
            string sqlStr2 = "DELETE FROM [User_friends] WHERE [username]=@username1 AND [username_friend]=@username2";

            SqlCommand sqlCmd = new SqlCommand(sqlStr, con);
            SqlCommand sqlCmd2 = new SqlCommand(sqlStr2, con);

            con.Open();

            sqlCmd.Parameters.AddWithValue("@username1", this.User.Identity.Name);
            sqlCmd.Parameters.AddWithValue("@username2", selectedUserLabel.Text);

            sqlCmd2.Parameters.AddWithValue("@username1", selectedUserLabel.Text);
            sqlCmd2.Parameters.AddWithValue("@username2", this.User.Identity.Name);

            sqlCmd.ExecuteNonQuery();
            sqlCmd2.ExecuteNonQuery();

            con.Close();

            Session["friend"] = null;

            Response.Redirect(Request.RawUrl);



    }
        else
        {
           b.Text = "Potwierdź";
        }
    }
}
