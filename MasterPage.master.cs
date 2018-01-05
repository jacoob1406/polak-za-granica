using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Configuration;
using System.Data.SqlClient;

public partial class MasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        userLabel.Text = HttpContext.Current.User.Identity.Name;
        
       if (!IsPostBack)
        {
            if (HttpContext.Current.User.IsInRole("admin"))
            {
                menuitem6.Visible = true;
                menuitem6HyperLink.Visible = true;
            }
            else
            {
                menuitem6.Visible = false;
                menuitem6HyperLink.Visible = false;
            }
        }
    }
    protected void countryDropDownList_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (countryDropDownList.Items.Count > 0)
        {
            Session["place"] = countryDropDownList.SelectedValue;
            Response.Redirect("~/User/UserMain.aspx");
        }
    }
 
    protected void leaveGroupButton_Click(object sender, EventArgs e)
    {
        if (leaveGroupCheckBox.Checked)
        {

            string dbstring = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            SqlConnection con = new SqlConnection(dbstring);

            con.Open();

            string sqlStr = "DELETE FROM [Group] WHERE [username]=@username AND [place] = @place";

            SqlCommand sqlCmd = new SqlCommand(sqlStr, con);

            sqlCmd.Parameters.AddWithValue("@username", HttpContext.Current.User.Identity.Name);
            sqlCmd.Parameters.AddWithValue("@place", countryDropDownList.SelectedValue);

            sqlCmd.ExecuteNonQuery();

            con.Close();

            countryDropDownList.DataBind();

            if (countryDropDownList.Items.Count > 0)
            {
                countryDropDownList.SelectedIndex = 0;
                Session["place"] = countryDropDownList.SelectedValue;
            }
            else 
            {
                Session["place"] = null;
            }
             Response.Redirect(Request.RawUrl);
        } 
        if (!leaveGroupCheckBox.Checked)
        {
            leaveGroupButton.Text = "Potwierdź!";
        }
    }
}
