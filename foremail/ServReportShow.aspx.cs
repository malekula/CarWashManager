﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using CrystalDecisions.CrystalReports.Engine;
using System.Globalization;

namespace CarWashManager
{
    public partial class ServReportShow : System.Web.UI.Page
    {
        RServ r;
        //CrystalReport1 tr;
        SqlDataAdapter DA;
        DataSet DS;
        string s = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            DA = new SqlDataAdapter();
            DS = new DataSet();
            DA.SelectCommand = new SqlCommand();
            DA.SelectCommand.Connection = new SqlConnection("Data Source=127.0.0.1;Initial Catalog=CWM;Persist Security Info=True;User ID=CWM;Password=manager");
            DA.SelectCommand.Parameters.Add("start", SqlDbType.DateTime);
            DA.SelectCommand.Parameters.Add("end", SqlDbType.DateTime);
            DA.SelectCommand.Parameters.Add("serv", SqlDbType.NVarChar);
            DateTime start = DateTime.Parse(Request["start"], new CultureInfo("ru-RU", false));
            DateTime end = DateTime.Parse(Request["end"], new CultureInfo("ru-RU", false));
            string se = Request["serv"];
            DA.SelectCommand.Parameters["start"].Value = start;
            DA.SelectCommand.Parameters["end"].Value = end;
            DA.SelectCommand.Parameters["serv"].Value = se;
            if (Request["All"] == "0")
            {
                DA.SelectCommand.CommandText = "select * from CWM..GetServReportByDate(@start,@end) where pn in ("+se+")";
            }
            else
            {
                DA.SelectCommand.CommandText = "select * from CWM..GetServReportAllTime() where pn in (" + se + ")";
            }
            //DA.SelectCommand.CommandText = "select * from CWM..GetTeamReportByDate('20120423','20120423',1)";
            int i = DA.Fill(DS, "R");
            //((TextObject)r.Section2.ReportObjects["Text10"]).Text = "Отчет по бригадам с " +start.ToString("dd.MM.yyyy")+" по " +end.ToString("dd.MM.yyyy");

            ((TextObject)r.Section2.ReportObjects["Text6"]).Text = s;
            r.SetDataSource(DS.Tables["R"]);
            RepViewer.ReportSource = r;
            //RepViewer.Zoom(100);
            //RepViewer.BestFitPage = false;
            //UnitType t = RepViewer.Width.Type;
            //RepViewer.Width = 800;

        }
        override protected void OnInit(EventArgs e)
        {
            //
            // CODEGEN: This call is required by the ASP.NET Web Form Designer.
            //
            //InitializeComponent();
            base.OnInit(e);
            if (Request["All"] == "0")
            {
                s = "Отчет по услугам с " + Request["start"] + " по " + Request["end"];
            }
            else
            {
                s = "Отчет по услугам за все время";
            }
            r = new RServ();

        }
    }
}
