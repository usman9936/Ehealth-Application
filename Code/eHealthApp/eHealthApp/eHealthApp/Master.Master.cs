using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.NetworkInformation;
using System.Net.Sockets;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace eHealthApp
{
    public partial class Master : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {

                //if (Session["name"] == null)
                //{
                //    Response.Redirect("Default.aspx", false);

                //}
                //else
                //{
                //    if (!string.IsNullOrEmpty(Session["name"] as string))
                //    {

                //        unittesting.Style["width"] = "15%";
                //        lblnm.Text = Session["name"].ToString();
                //        //pagename.Text = Session["PageName"].ToString();
                //        string name = System.IO.Path.GetFileName(HttpContext.Current.Request.FilePath);
                //        pagename.Text = name.Replace(".aspx", "");
                //    }
                //}
                string name = System.IO.Path.GetFileName(HttpContext.Current.Request.FilePath);
                pagename.Text = name.Replace(".aspx", "");

            }
        }
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["cs_ehealthDB"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;

        protected void lnkLogOut_Click(object sender, EventArgs e)
        {
            try
            {

                Session.RemoveAll();
                
                Response.Redirect("Default.aspx", false);
            }
            catch (Exception ex)
            {
                Response.Redirect("Error-500.aspx");
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }

            }
        }
    }
}