<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" 
    CodeBehind="PatientHome.aspx.cs" Inherits="eHealthApp.PatientHome" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- page specific plugin styles -->
    <link rel="stylesheet" href="components/_mod/jquery-ui.custom/jquery-ui.custom.min.css" />
    <link rel="stylesheet" href="components/chosen/chosen.min.css" />
    <link rel="stylesheet" href="components/bootstrap-datepicker/dist/css/bootstrap-datepicker3.min.css" />
    <link rel="stylesheet" href="components/bootstrap-timepicker/css/bootstrap-timepicker.min.css" />
    <link rel="stylesheet" href="components/bootstrap-daterangepicker/daterangepicker.min.css" />
    <link rel="stylesheet" href="components/eonasdan-bootstrap-datetimepicker/build/css/bootstrap-datetimepicker.min.css" />
    <link rel="stylesheet" href="components/mjolnic-bootstrap-colorpicker/dist/css/bootstrap-colorpicker.min.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="page-header">
        <h1>Helpful Videos for Parkin's Patients</h1>
    </div>
    <div class="row">
                    <div class="col-lg-12 col-xs-12">
                       <%-- <video controls>

                            <source src="https://www.youtube.com/watch?v=I4xmX4SBm7M"  type="video/mp4"/> 

                        </video>--%>
                        <iframe width="560" height="315" src="https://www.youtube.com/embed/no0ifu7Yzo4" frameborder="1" allow="autoplay; encrypted-media" allowfullscreen></iframe>
                        
                        
                        </div>
        </div>
    <div class="row">
                    <div class="col-lg-12 col-xs-12">
                       <%-- <video controls>

                            <source src="https://www.youtube.com/watch?v=I4xmX4SBm7M"  type="video/mp4"/> 

                        </video>--%>
                        <iframe width="560" height="315" src="https://www.youtube.com/embed/hu4eTijdIv0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
                       
                        
                        </div>
        </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="plugin" runat="server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="inlinescript" runat="server">
</asp:Content>
