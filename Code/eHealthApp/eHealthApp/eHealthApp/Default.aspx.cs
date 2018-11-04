using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.NetworkInformation;
using System.Net.Sockets;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Web.Script.Serialization;
using System.Web.Services;

namespace eHealthApp
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //if (!string.IsNullOrEmpty(Session["name"] as string))
                //{
                //    Response.Redirect("Dashboard.aspx", false);
                //}
            }
            //else
            //{
            //    txtem.Focus();
            //}


        }

        protected void lblogin_Click(object sender, EventArgs e)
        {
            string Role = "";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["cs_ehealthDB"].ToString());
            SqlCommand cmd = new SqlCommand();
            SqlDataReader dr;
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "Select * from users where email = '" + txtem.Text + "' and Role_IDrole='1'";
            dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                System.Web.HttpContext.Current.Session["user_id"] = dr["userID"].ToString();
                System.Web.HttpContext.Current.Session["role"] = dr["Role_IDRole"].ToString();
                Role = dr["Role_IDRole"].ToString();
                Response.Redirect("PatientHome.aspx");
              
            }
            else
            {
                lblError.Text = "Login Failed";
            }
            con.Close();
        }
        [WebMethod]
        public static string VerifyUser(string Email, string User_id, string Provider)
        {
            string Role = "";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["cs_ehealthDB"].ToString());
            SqlCommand cmd = new SqlCommand();
            SqlDataReader dr;
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "Select * from users where email = '" + Email + "'";
            dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                System.Web.HttpContext.Current.Session["user_id"] = dr["userID"].ToString();
                System.Web.HttpContext.Current.Session["role"] = dr["Role_IDRole"].ToString();
                Role = dr["Role_IDRole"].ToString();

                con.Close();
            }
            else
            {
                con.Close();
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "insert into users(username,email,Role_IDRole,Organization,Lat,Long) output inserted.userID values (@username,@email,@Role_IDRole,@Organization,@Lat,@Long)";
                cmd.Parameters.AddWithValue("@username", "New_User");
                cmd.Parameters.AddWithValue("@email", Email);
                cmd.Parameters.AddWithValue("@Role_IDRole", '2');
                cmd.Parameters.AddWithValue("@Organization", '1');
                cmd.Parameters.AddWithValue("@Lat", '0');
                cmd.Parameters.AddWithValue("@Long", '0');
                int id = (int)cmd.ExecuteScalar();
                System.Web.HttpContext.Current.Session["user_id"] = id.ToString();
                System.Web.HttpContext.Current.Session["role"] = "2";
                con.Close();
                Role = "2";
            }
         
            return Role;
        }
    }
}
