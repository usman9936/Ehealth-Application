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
    public partial class callbackfb : System.Web.UI.Page
    {
        public const string FaceBookAppKey = "718427485191545";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(Request.QueryString["access_token"])) return; //ERROR! No token returned from Facebook!!

            //let's send an http-request to facebook using the token            
            string json = GetFacebookUserJSON(Request.QueryString["access_token"]);

            //and Deserialize the JSON response
            JavaScriptSerializer js = new JavaScriptSerializer();
            FacebookUser oUser = js.Deserialize<FacebookUser>(json);

            if (oUser != null)
            {
                Response.Redirect("PatientHome.aspx");
                //Response.Write("Welcome, " + oUser.name);
                //Response.Write("<br />id, " + oUser.id);
                //Response.Write("<br />email, " + oUser.email);
                //Response.Write("<br />first_name, " + oUser.first_name);
                //Response.Write("<br />last_name, " + oUser.last_name);
                //Response.Write("<br />gender, " + oUser.gender);
                //Response.Write("<br />link, " + oUser.link);
                //Response.Write("<br />updated_time, " + oUser.updated_time);
                //Response.Write("<br />birthday, " + oUser.birthday);
                //Response.Write("<br />locale, " + oUser.locale);
                //Response.Write("<br />picture, " + oUser.picture);
                if (oUser.location != null)
                {
                    //Response.Write("<br />locationid, " + oUser.location.id);
                    //Response.Write("<br />location_name, " + oUser.location.name);
                    Response.Redirect("PatientHome.aspx");
                }
            }
        }

        /// <summary>
        /// sends http-request to Facebook and returns the response string
        /// </summary>
        private static string GetFacebookUserJSON(string access_token)
        {
            string url = string.Format("https://graph.facebook.com/me?access_token={0}&fields=email,name,first_name,last_name,link", access_token);

            WebClient wc = new WebClient();
            Stream data = wc.OpenRead(url);
            StreamReader reader = new StreamReader(data);
            string s = reader.ReadToEnd();
            data.Close();
            reader.Close();

            return s;
        }
    }
}