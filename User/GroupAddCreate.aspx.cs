using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Configuration;
using System.Data.SqlClient;

public partial class User_GroupAddCreate : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            SqlDataSource3.SelectParameters.Add("username", User.Identity.Name);
            SqlDataSource4.SelectParameters.Add("username", User.Identity.Name);
        }
    }

    protected void CreateButton_Click(object sender, EventArgs e)
    {
        string dbstring = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        SqlConnection con = new SqlConnection(dbstring);

        string sqlStr = "SELECT place_name FROM Place WHERE place_name = @place";

        SqlCommand sqlCmd = new SqlCommand(sqlStr, con);

        sqlCmd.Parameters.AddWithValue("@place", placeNameTextBox.Text);

        con.Open();

        object result = sqlCmd.ExecuteScalar();

        if (result == null)
        {
            string sqlStr2 = "INSERT INTO place (place_name, country_id) VALUES (@place, @country)";

            SqlCommand sqlCmd2 = new SqlCommand(sqlStr2, con);

            sqlCmd2.Parameters.AddWithValue("@place", placeNameTextBox.Text);
            sqlCmd2.Parameters.AddWithValue("@country", DropDownList1.SelectedValue);  //I ZNOWU !!!! --no i co to to false

            sqlCmd2.ExecuteNonQuery();

            con.Close();

            resultLabel.ForeColor = System.Drawing.Color.Black;
            resultLabel.Text = "Miejsce stworzone!";
        }
        else
        {
            resultLabel.ForeColor = System.Drawing.Color.White;
            resultLabel.Text = "Miejsce nie zostało stworzone, ponieważ już istnieje!";
        }
    }


    protected void AddToGroupButton_Click(object sender, EventArgs e)
    {
        string dbstring = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        SqlConnection con = new SqlConnection(dbstring);

        string sqlStr = "SELECT username FROM [group] WHERE username=@username AND place=@placename"; //  //ALLAN, GDZIE JEST TO @THEROOM, 

        SqlCommand sqlCmd = new SqlCommand(sqlStr, con);

        sqlCmd.Parameters.AddWithValue("@username", this.User.Identity.Name);
        sqlCmd.Parameters.AddWithValue("@placename", DropDownList3.SelectedValue);

        con.Open();

        object result = sqlCmd.ExecuteScalar();

        if (result == null)
        {
            string sqlStr2 = "INSERT INTO [group] (username, place) VALUES (@username, @placename)"; //tutaj znów ta nazwa karju

            SqlCommand sqlCmd2 = new SqlCommand(sqlStr2, con);

            sqlCmd2.Parameters.AddWithValue("@username", this.User.Identity.Name);
            sqlCmd2.Parameters.AddWithValue("@placename", DropDownList3.SelectedValue);  //I ZNOWU !!!! --no i co to to false

            sqlCmd2.ExecuteNonQuery();
            Response.Redirect(Request.RawUrl);

            con.Close();

            addedToGroupLabel.ForeColor = System.Drawing.Color.Black;
            addedToGroupLabel.Text = "Zostałeś dodany do grupy: " + DropDownList3.SelectedValue;

        }
        else
        {
            addedToGroupLabel.ForeColor = System.Drawing.Color.Red;
            addedToGroupLabel.Text = "Już znajdujesz się w tej grupie!";
        }
    }

    protected void ListView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        string friend = ListView1.SelectedDataKey.Value.ToString();
        Session["friend"] = friend;
        Response.Redirect("~/User/Friends.aspx");
    }

    protected void ListView2_SelectedIndexChanged(object sender, EventArgs e)
    {
        string friend = ListView2.SelectedDataKey.Value.ToString();
        Session["friend"] = friend;
        Response.Redirect("~/User/Friends.aspx");

    }
}