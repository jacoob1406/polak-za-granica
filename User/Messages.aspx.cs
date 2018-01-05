using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Configuration;
using System.Data.SqlClient;

public partial class User_Messages : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            SqlDataSource1.SelectParameters.Add("touser", User.Identity.Name);
            SqlDataSource2.SelectParameters.Add("touser", User.Identity.Name);
            SqlDataSource3.SelectParameters.Add("touser", User.Identity.Name);
            
            if( Session["friend"] != null)
            {
                toUserDropDown.SelectedValue = Session["friend"].ToString();
            }
        }


    }
    protected void sendButton_Click(object sender, EventArgs e)
    {
        string dbstring = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        SqlConnection con = new SqlConnection(dbstring);

        string sqlStr = "INSERT INTO Message (from_user, to_user, message, [date]) VALUES (@from, @to, @message, @date)";

        SqlCommand sqlCmd = new SqlCommand(sqlStr, con);

        con.Open();

        sqlCmd.Parameters.AddWithValue("@from", this.User.Identity.Name);
        sqlCmd.Parameters.AddWithValue("@to", toUserDropDown.SelectedValue);
        sqlCmd.Parameters.AddWithValue("@message", messageTestBox.Text);
        sqlCmd.Parameters.AddWithValue("@date", DateTime.Now);


        sqlCmd.ExecuteNonQuery();
        messageTestBox.Text = String.Empty;
        //  Response.Redirect(Request.RawUrl);


        con.Close();

        sentLabel.Text = "Twoja wiadomość została wysłana!";
    }
    protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (RadioButtonList1.SelectedIndex == 0)
        {
            GridView1.Visible = true;
            GridView2.Visible = false;
        }
        else if (RadioButtonList1.SelectedIndex == 1)
        {
            GridView1.Visible = false;
            GridView2.Visible = true;
        }
    }
    protected void toUserDropDown_DataBound(object sender, EventArgs e)
    {
        aboutUserListView.DataBind();
    }
    protected void removeFriendButton_Click(object sender, EventArgs e)
    {

    }
}