using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Results;

namespace eHealthApp
{
    public class MediaController : ApiController
    {
        // GET api/<controller>
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["cs_ehealthDB"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        public IEnumerable<clsMedia> Get()
        {
            clsMedia media = null;
            List<clsMedia> mediaList = new List<clsMedia>();
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "Select * from tbl_Media";
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                media = new clsMedia();
                media.Media_id = Convert.ToInt32(dr["media_id"]);
                media.Media_URL = dr["Media_URL"].ToString();
                mediaList.Add(media);
            }
            return mediaList;
        }
    }
}