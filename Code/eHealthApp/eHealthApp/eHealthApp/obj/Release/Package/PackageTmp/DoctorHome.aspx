<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="DoctorHome.aspx.cs" Inherits="eHealthApp.DoctorHome" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   <style>
        .modalBackground {
            background-color: white;
            filter: alpha(opacity=90);
            opacity: 0.8;
        }

        .modalPopup {
            background-color: white;
            text-align: center;
            width: 100%;
        }

            .modalPopup h2 {
                text-align: center;
                color: red;
            }
    </style>
    <script>

        function printDiv(printable) {
            var printContents = document.getElementById(printable).innerHTML;
            var originalContents = document.body.innerHTML;

            document.body.innerHTML = printContents;

            window.print();

            document.body.innerHTML = originalContents;
        }
    </script>
    <script type="text/javascript">

        function KeyUp(txtboxID, GridViewID) {
            if ($(txtboxID).val() != "") {

                $(GridViewID).children('tbody').children('tr').each(function () {
                    $(this).show();
                });

                $(GridViewID).children('tbody').children('tr').each(function () {
                    var match = false;
                    if ($(this).text().toUpperCase().indexOf($(txtboxID).val().toUpperCase()) > 0) match = true;
                    if (match) $(this).show();
                    else $(this).hide();
                });
            }
            else {

                $(GridViewID).children('tbody').children('tr').each(function () {
                    $(this).show();
                });
            }
        }

    </script>
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
        <h1>Patient Data and Activities</h1>
    </div>
    <div id="v1">
                <%--<asp:LinkButton Text="Add" ID="lnkAdd" CssClass="btn btn-info" OnClick="lnkAdd_Click" runat="server" />
                <%--<input class="btn btn-info" type="button" id="btnadd" name="Add" value="Add" title="Add" />--%>
                <%--<div class="hr hr-18 dotted hr-double"></div>--%>

                <div class="row">
                    <div class="col-xs-12">
                        <div class="clearfix">
                            <div class="pull-right tableTools-container"></div>
                        </div>
                        <div class="table-header">
                            Results for "Patients and their activities"
                        </div>

                        <!-- div.table-responsive -->

                        <!-- div.dataTables_borderWrap -->
                        <div class="col-lg-8 col-md-8 col-sm-6 col-xs-6"></div>
                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6">
                            <div class="form-group input-group">
                                <asp:TextBox ID="TextBox1" runat="server" type="text" class="form-control" onkeyup="return KeyUp(this, '#ContentPlaceHolder1_gvdetail');" placeholder="Search. . . " />
                                <span class="input-group-btn">
                                    <button class="btn btn-default" type="button">
                                        <i class="fa fa-search"></i>
                                    </button>
                                </span>

                            </div>
                        </div>
                        <div>

                            <asp:GridView ID="gvdetail" EmptyDataText="NO DATA FOUND" AllowPaging="false" class="table table-striped table-bordered table-hover" runat="server" AutoGenerateColumns="False" ShowFooter="false" ShowHeaderWhenEmpty="true" ShowHeader="true" EnableViewState="true" OnSorting="gvdetail_Sorting" AllowSorting="True">
                                <Columns>
                                    <asp:TemplateField HeaderText="Sr.#">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="hdnID" Text='<%# Eval("userID") %>' Visible="false"></asp:Label>
                                            <%# Container.DataItemIndex+1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%--<asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="userID," HeaderText="S.NO" SortExpression="userID," />--%>
                                    <asp:BoundField DataField="username" SortExpression="username" HeaderText=" Patient Name" />
                                    <asp:BoundField DataField="oganization" SortExpression="oganization" HeaderText=" Oganization" />
                                    <asp:BoundField DataField="therapy" SortExpression="therapy" HeaderText="Therapy" />
                                    <asp:BoundField DataField="medicine" SortExpression="medicine" HeaderText="Medicine" />
                                    <asp:BoundField DataField="Dosage" SortExpression="Dosage" HeaderText="Dosage" />
                                    <asp:BoundField DataField="testID" SortExpression="testID" HeaderText="Test ID" />
                                    <asp:BoundField DataField="dateTime" SortExpression="dateTime" HeaderText="Date Time" />
                                    <asp:BoundField DataField="note" SortExpression="note" HeaderText="Note" />
                                    <%--<asp:TemplateField HeaderText="Edit/Delete">--%>
                                        <%--<ItemTemplate>
                                            <asp:LinkButton ID="lbedit" class="btn btn-xs btn-info" OnClick="lbedit_Click" Text="" runat="server">
                                                        <i class="ace-icon fa fa-pencil bigger-120"></i>
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="lbdel" class="btn btn-xs btn-danger" OnClick="lbdel_Click" Text="" runat="server">
                                                        <i class="ace-icon fa fa-trash-o bigger-120"></i>
                                            </asp:LinkButton>

                                        </ItemTemplate>--%>
                                    <%--</asp:TemplateField>--%>
                                </Columns>
                            </asp:GridView>
                            <asp:HiddenField ID="h1" runat="server" />

                        </div>
                    </div>
                </div>
            </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="plugin" runat="server">
    <!--[if lte IE 8]>
		  <script src="./components/ExplorerCanvas/excanvas.min.js"></script>
		<![endif]-->
    <script src="components/_mod/jquery-ui.custom/jquery-ui.custom.min.js"></script>
    <script src="components/jqueryui-touch-punch/jquery.ui.touch-punch.min.js"></script>
    <script src="components/chosen/chosen.jquery.min.js"></script>
    <script src="components/jquery.gritter/js/jquery.gritter.min.js"></script>
    <script src="components/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>
    <script src="components/jqueryui-touch-punch/jquery.ui.touch-punch.min.js"></script>

    <script src="components/datatables/media/js/jquery.dataTables.min.js"></script>
    <script src="components/_mod/datatables/jquery.dataTables.bootstrap.min.js"></script>
    <script src="components/datatables.net-buttons/js/dataTables.buttons.min.js"></script>
    <script src="components/datatables.net-buttons/js/buttons.flash.min.js"></script>
    <script src="components/datatables.net-buttons/js/buttons.html5.min.js"></script>
    <script src="components/datatables.net-buttons/js/buttons.print.min.js"></script>
    <script src="components/datatables.net-buttons/js/buttons.colVis.min.js"></script>
    <script src="components/datatables.net-select/js/dataTables.select.min.js"></script>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="inlinescript" runat="server">
    <!-- inline scripts related to this page -->
    <script>
        $('#v2').hide();
        $('#v3').hide();
        //$('#btnadd').click(function () {
        //    $('#v1').hide();
        //    $('#v2').show();

        //});
        $('#btncancel').click(function () {
            $('#v1').show();
            $('#v2').hide();

        });
    </script>
    <script>
        function addbutton() {
            $('#btnadd').click(function () {
                $('#v1').show();
                $('#v2').hide();

            });
        }
    </script>
    <script>
        jQuery(function ($) {
            $('[data-rel=tooltip]').tooltip({ container: 'body' });
            $('[data-rel=popover]').popover({ container: 'body' });
            //"jQuery UI Slider"
            //range slider tooltip example
            $("#slider-range").css('height', '200px').slider({
                orientation: "vertical",
                range: true,
                min: 0,
                max: 100,
                values: [17, 67],
                slide: function (event, ui) {
                    var val = ui.values[$(ui.handle).index() - 1] + "";

                    if (!ui.handle.firstChild) {
                        $("<div class='tooltip right in' style='display:none;left:16px;top:-6px;'><div class='tooltip-arrow'></div><div class='tooltip-inner'></div></div>")
                        .prependTo(ui.handle);
                    }
                    $(ui.handle.firstChild).show().children().eq(1).text(val);
                }
            }).find('span.ui-slider-handle').on('blur', function () {
                $(this.firstChild).hide();
            });
        });
    </script>
    <script>
        function success_msg() {
            $('#ContentPlaceHolder1_btnreg').on(ace.click_event, function () {
                $.gritter.add({
                    title: 'Success !',
                    text: 'Student has been registered Successfully . . !',
                    class_name: 'gritter-info gritter-center' + (!$('#gritter-light').get(0).checked ? ' gritter-light' : '')
                });

                return false;
            });
        }
    </script>
    <script>
        function dropdown() {
            if (!ace.vars['touch']) {
                $('.chosen-select').chosen({ allow_single_deselect: true });
                //resize the chosen on window resize

                $(window)
                .off('resize.chosen')
                .on('resize.chosen', function () {
                    $('.chosen-select').each(function () {
                        var $this = $(this);
                        $this.next().css({ 'width': $this.parent().width() });
                    })
                }).trigger('resize.chosen');
                //resize chosen on sidebar collapse/expand
                $(document).on('settings.ace.chosen', function (e, event_name, event_val) {
                    if (event_name != 'sidebar_collapsed') return;
                    $('.chosen-select').each(function () {
                        var $this = $(this);
                        $this.next().css({ 'width': $this.parent().width() });
                    })
                });


                $('#chosen-multiple-style .btn').on('click', function (e) {
                    var target = $(this).find('input[type=radio]');
                    var which = parseInt(target.val());
                    if (which == 2) $('#form-field-select-4').addClass('tag-input-style');
                    else $('#form-field-select-4').removeClass('tag-input-style');
                });
            }
        }
    </script>
    <script>
        function datetime() {
            //datepicker plugin
            //link
            $('.date-picker').datepicker({
                autoclose: true,
                todayHighlight: true
            })
            //show datepicker when clicking on the icon
            .next().on(ace.click_event, function () {
                $(this).prev().focus();
            });
        }
    </script>
</asp:Content>
