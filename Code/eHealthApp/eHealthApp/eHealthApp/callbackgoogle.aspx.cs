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


namespace eHealthApp
{
    public partial class callback : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(Request.QueryString["access_token"])) return;

            //let's send an http-request to Google+ API using the token           
            string json = GetGoogleUserJSON(Request.QueryString["access_token"]);

            //and Deserialize the JSON response
            JavaScriptSerializer js = new JavaScriptSerializer();
            GoogleEmail oUser = js.Deserialize<GoogleEmail>(json);

            if (oUser != null)
            {
                //Response.Write("Welcome, " + oUser.data.email);
                Response.Redirect("DoctorHome.aspx");
            }
        }

        /// <summary>
        /// sends http-request to Google+ API and returns the response string
        /// </summary>
        private string GetGoogleUserJSON(string access_token)
        {
            string url = "https://www.googleapis.com/userinfo/email?alt=json";

            WebClient wc = new WebClient();
            wc.Headers.Add("Authorization", "OAuth " + Request.QueryString["accessToken"]);
            Stream data = wc.OpenRead(url);
            StreamReader reader = new StreamReader(data);
            string retirnedJson = reader.ReadToEnd();
            data.Close();
            reader.Close();

            return retirnedJson;
        }
    }
}