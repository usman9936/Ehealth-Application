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

namespace eHealthApp
{
    public partial class ResearcherHome : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGridBrand();
                BindChart();
            }
        }
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["cs_ehealthDB"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        private DataTable GetRecords()
        {

            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select u.userID, u.username,org.name as oganization, tl.name as 'therapy', md.name as 'medicine', tl.Dosage, t.testID, t.dateTime,  nt.note, ts.DataURL from users u inner join Organization as org on org.organizationID=u.Organization inner join Therapy as th on th.User_IDpatient=u.userID inner join Therapy_List as tl on tl.therapy_listID=th.therapyID inner join Medicine as md on md.medicineID=tl.Medicine_IDmedicine inner join Test as t on t.Therapy_IDtherapy=th.therapyID inner join Test_Session ts on ts.Test_IDtest=t.testID left join Note as nt on nt.Test_Session_IDtest_session=ts.test_SessionID where u.Role_IDrole=1; ";
            SqlDataAdapter dAdapter = new SqlDataAdapter();
            dAdapter.SelectCommand = cmd;
            DataSet objDs = new DataSet();
            dAdapter.Fill(objDs);
            con.Close();
            return objDs.Tables[0];

        }
        private void BindGridBrand()
        {
            DataTable dt = GetRecords();
            if (dt.Rows.Count > 0)
            {
                gvdetail.DataSource = dt;
                gvdetail.DataBind();
                gvdetail.DataSource = dt;
                gvdetail.DataBind();
                if (gvdetail.Rows.Count > 0)
                {
                    gvdetail.UseAccessibleHeader = true;
                    gvdetail.HeaderRow.TableSection = TableRowSection.TableHeader;
                }
            }
            else
            {
                gvdetail.DataSource = null;
                gvdetail.DataBind();
            }

        }

        protected void gvdetail_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvdetail.PageIndex = e.NewPageIndex;
            BindGridBrand();

        }

        protected void gvdetail_Sorting(object sender, GridViewSortEventArgs e)
        {
            try
            {
                DataTable dt;
                //strSQL = "select j.nJob_id, a.strActionName, n.strNo, pi.strName, r.strRankName, jh.strMarkedTo, ap.strAppt, pi.strOff_ResType,c.strCatCode, pi.strAddress,et.strExchTypeName, tc.strCatExpiry,j.strStatus,j.dtAddDateTime from tbl_Job as j inner join tbl_JobHist as jh on j.nJob_id = jh.nJob_id inner join tbl_Tel as t on j.nTel_id = t.nTel_id inner join tbl_No as n on t.nNum_id = n.nNum_id inner join tbl_PersInfo as pi on j.nPer_Id = pi.nPer_Id inner join tbl_TelCatDetail as tc on j.nTelCatDet_id = tc.nTelCatDet_id inner join tbl_TelDetail as td on j.nTelDet_id = td.nTelDet_id inner join tbl_Rank as r on pi.nRank_id = r.nRank_id inner join tbl_Appt as ap on pi.nAppt_id = ap.nAppt_id inner join tbl_Cat as c on tc.nCat_id = c.nCat_id inner join tbl_ExchType as et on n.nExchType_id = et.nExchType_id inner join tbl_Action as a on jh.nAction_id = a.nAction_id where j.dtAddDateTime=convert(date,SYSDATETIME())";
                dt = GetRecords();
                {
                    string SortDir = string.Empty;
                    if (dir == SortDirection.Ascending)
                    {
                        dir = SortDirection.Descending;
                        SortDir = "Desc";
                    }
                    else
                    {
                        dir = SortDirection.Ascending;
                        SortDir = "Asc";
                    }
                    DataView sortedView = new DataView(dt);
                    sortedView.Sort = e.SortExpression + " " + SortDir;
                    gvdetail.DataSource = sortedView;
                    gvdetail.DataBind();

                }
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "$('#v1').show(); $('#v2').hide(); $('#v3').hide();", true);
            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx");
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }

            }
        }
        protected SortDirection dir
        {
            get
            {
                if (ViewState["dirState"] == null)
                {
                    ViewState["dirState"] = SortDirection.Ascending;
                }
                return (SortDirection)ViewState["dirState"];
            }
            set
            {
                ViewState["dirState"] = value;
            }
        }
        protected void lnkAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("RssFeed.aspx");

        }
        private void BindChart()
        {
            //, int ProjType, int Proj, int Region, int City, int Exchange
            DataTable dtChartData = new DataTable();
            StringBuilder strScript = new StringBuilder();
            ltScripts.Text = "";

            try
            {
                dtChartData = GetRecordsCharts();

                //, ProjType, Proj, Region, City, Exchange
                strScript.Append(@"<script type='text/javascript'>  
                         google.charts.load('current', {'packages':['map'],
'mapsApiKey': 'AIzaSyDmLG4Fh-4Op4INyucvfiYcGqz0VkXqa4c'
});
                     google.charts.setOnLoadCallback(drawVisualization);
                    function drawVisualization() {         
                    
                var data = google.visualization.arrayToDataTable([

        ['Lat', 'Long', 'Name'],");

                if (dtChartData.Rows.Count == 0)
                {
                    strScript.Append("['-',0,0,0,0,0 ],");
                }

                else
                {

                    foreach (DataRow row in dtChartData.Rows)
                    {
                        strScript.Append("[" + row["Lat"] + "," + row["Long"] + ",'" + row["Name"] + "'],");
                    }
                }
                strScript.Remove(strScript.Length - 1, 1);
                strScript.Append("]);");

                strScript.Append(" var map = new google.visualization.Map(document.getElementById('map_div'));");
                strScript.Append("map.draw(data, {          showInfoWindow: true        });        }");
                strScript.Append(" </script>");

                ltScripts.Text = strScript.ToString();
            }
            catch (Exception ex)
            {
            }
            finally
            {
                dtChartData.Dispose();
                strScript.Clear();
            }
        }
        private DataTable GetRecordsCharts()
        {

            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "Select username as Name,Lat,Long from Users where Role_IDrole = '1'";
            SqlDataAdapter dAdapter = new SqlDataAdapter();
            dAdapter.SelectCommand = cmd;
            DataSet objDs = new DataSet();
            dAdapter.Fill(objDs);
            con.Close();
            return objDs.Tables[0];
           
        }
    }
}