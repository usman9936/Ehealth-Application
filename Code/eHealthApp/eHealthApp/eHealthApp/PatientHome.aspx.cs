using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Text;

namespace eHealthApp
{
    public partial class PatientHome : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["cs_ehealthDB"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        DataTable dt = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                
                if (string.IsNullOrEmpty(Session["user_id"] as string))
                {
                    Response.Redirect("Default.aspx", false);
                }
                else
                {
                    BindChart();
                }
            }
        }
        private void BindChart()
        {
            //, int ProjType, int Proj, int Region, int City, int Exchange
            DataTable dtChartData = new DataTable();
            StringBuilder strScript = new StringBuilder();
            ltScripts.Text = "";

            try
            {
                dtChartData = GetRecords();

                //, ProjType, Proj, Region, City, Exchange
                strScript.Append(@"<script type='text/javascript'>  
                         google.charts.load('current', {'packages':['corechart']});
                     google.charts.setOnLoadCallback(drawVisualization);
                    function drawVisualization() {         
                    
                var data = google.visualization.arrayToDataTable([

        ['No of Session', 'Date'],");

                if (dtChartData.Rows.Count == 0)
                {
                    strScript.Append("['-',0,0,0,0,0 ],");
                }

                else
                {

                    foreach (DataRow row in dtChartData.Rows)
                    {
                        strScript.Append("['" + row["TestDate"] + "'," + row["totalSession"] + " ],");
                    }
                }
                strScript.Remove(strScript.Length - 1, 1);
                strScript.Append("]);");

                strScript.Append(" var options = {          title: 'No of Exercise vs Exercise Date',          hAxis: { title: 'Date', minValue: 0, maxValue: 31},          vAxis: { title: 'Session', minValue: 0, maxValue: 5},          legend: 'none'        }; ");
                strScript.Append("  var chart = new google.visualization.ScatterChart(document.getElementById('chart_div'));        chart.draw(data, options);            }");
                strScript.Append(" </script>");

                ltScripts.Text = strScript.ToString();
            }
            catch(Exception ex)
            {
            }
            finally
            {
                dtChartData.Dispose();
                strScript.Clear();
            }
        }
        private DataTable GetRecords()
        {

            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select u.username,convert(varchar, test.dateTime, 106) as TestDate,count(convert(varchar, test.dateTime, 106)) as totalSession from users u inner join Therapy as t on u.userID = t.User_IDpatient inner join Test as test on t.therapyID = test.Therapy_IDtherapy where u.userID = 3 group by u.username, convert(varchar, test.dateTime, 106)";
            SqlDataAdapter dAdapter = new SqlDataAdapter();
            dAdapter.SelectCommand = cmd;
            DataSet objDs = new DataSet();
            dAdapter.Fill(objDs);
            con.Close();
            return objDs.Tables[0];

        }
    }
}