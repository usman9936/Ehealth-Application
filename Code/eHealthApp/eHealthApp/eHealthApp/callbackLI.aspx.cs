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
    public partial class callback1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //    if (string.IsNullOrEmpty(Request.QueryString["access_token"])) return;

            //    WebUtility oAuthLi = new WebUtility("linkedin");
            //    string response = oAuthLi.oAuthWebRequest(WebUtility.Method.POST, "https://api.linkedin.com/uas/oauth/accessToken?xoauth_oauth2_access_token=" + oAuthLi.UrlEncode(Request.QueryString["accessToken"]), "");
            //    string[] tokens = response.Split('&');
            //    string token = tokens[0].Split('=')[1];
            //    string token_secret = tokens[1].Split('=')[1];

            //    //STORE THESE TOKENS FOR LATER CALLS
            //    oAuthLi.Token = token;
            //    oAuthLi.TokenSecret = token_secret;

            //    //SAMPLE LINKEDIN API CALL
            //    string url = "http://api.linkedin.com/v1/people/~:(id,first-name,last-name,email-address,picture-url)?format=json";

            //    string json = oAuthLi.oAuthWebRequest(WebUtility.Method.GET, url, "");

            //    JavaScriptSerializer js = new JavaScriptSerializer();
            //    LinkedinUser linkedinUser = js.Deserialize<LinkedinUser>(json);
            //    if (linkedinUser != null)
            //    {
            //        Response.Write("Welcome, " + linkedinUser.emailAddress);
            //    }
            //}
        }
    }
}