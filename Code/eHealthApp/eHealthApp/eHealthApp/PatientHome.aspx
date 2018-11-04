<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="PatientHome.aspx.cs" Inherits="eHealthApp.PatientHome" %>

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
    <!--Load the AJAX API-->
    <script src="dist/js/jquery-1.8.2.min.js"></script>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

    <script type="text/javascript">
        function ChartFocus() {
            document.getElementById('chart_div').focus();

        }
    </script>
    <script type="text/javascript">
        function getMedia() {

            $.getJSON("api/Media",
                function (data) {
                    $('#Media').empty(); // Clear the table body.

                    // Loop through the list of Media.
                    $.each(data, function (index) {
                        // Add a table row for the product.
                        var row = '<td><iframe width="800" height="315" src=' + data[index].Media_URL + ' frameborder="1" allow="autoplay; encrypted-media" allowfullscreen></iframe></td>';
                        $('<tr/>', { html: row })  // Append the URL.
                            .appendTo($('#Media'));
                    });
                });
        }

        $(document).ready(getMedia);
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-header">
        <h1>Helpful Charts / Videos for Parkin's Patients</h1>
    </div>
    <div id="v1">
        <div class="row">
            <div class="col-lg-12">
                <div class="col-lg-10 text-center" style="margin-top: 10px;">
                    <asp:Literal ID="ltScripts" runat="server"></asp:Literal>
                    <div id="chart_div" style="height: 500px"></div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12 col-md-12">
                <table>
                    <tbody id="Media">
                    </tbody>
                </table>
            </div>
        </div>
        
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="plugin" runat="server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="inlinescript" runat="server">
</asp:Content>
