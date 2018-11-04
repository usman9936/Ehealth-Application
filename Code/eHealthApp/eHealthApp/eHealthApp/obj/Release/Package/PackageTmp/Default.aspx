<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs"
    EnableEventValidation="false" Inherits="eHealthApp.Login" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta charset="utf-8" />
    <link rel="shortcut icon" href="dist/images/gallery/icon.png" />
    <script src="https://connect.facebook.net/en_US/all.js" type="text/javascript"></script>
    <script src="scripts/all.js" type="text/javascript"></script>
    <title>Login - eHealth Management System</title>

    <meta name="description" content="User login page" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />

    <!-- bootstrap & fontawesome -->
    <link rel="stylesheet" href="dist/css/bootstrap.min.css" />
    <link rel="stylesheet" href="../../../../../maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css" />

    <!-- text fonts -->
    <link href="dist/css/GoogleFonts.css" rel="stylesheet" />


    <!-- ace styles -->
    <link rel="stylesheet" href="dist/css/ace.min.css" />

    <!--[if lte IE 9]>
			<link rel="stylesheet" href="./dist/css/ace-part2.min.css" />
		<![endif]-->
    <link rel="stylesheet" href="dist/css/ace-rtl.min.css" />

    <!--[if lte IE 9]>
		  <link rel="stylesheet" href="./dist/css/ace-ie.min.css" />
		<![endif]-->

    <!-- HTML5shiv and Respond.js for IE8 to support HTML5 elements and media queries -->

    <!--[if lte IE 8]>
		<script src="./components/html5shiv/dist/html5shiv.min.js"></script>
		<script src="./components/respond/dest/respond.min.js"></script>
		<![endif]-->

    <style>
        .modalBackground {
            background-color: white;
            filter: alpha(opacity=90);
            opacity: 0.8;
        }

        .modalPopup h2 {
            color: white;
        }
    </style>
    <script type="text/javascript" src="http://platform.linkedin.com/in.js">
        <%--api_key: 77wutm9o4zjwxm--%><%--localhost key--%>
        api_key:77y4ink1dhxsmi<%--live key--%>
        authorize: false
        credentials_cookie: true
    </script>
    
    <script language="javascript" type="text/javascript">
        var OAUTHURL = 'https://accounts.google.com/o/oauth2/auth?';
        var VALIDURL = 'https://www.googleapis.com/oauth2/v1/tokeninfo?access_token=';
        var SCOPE = 'https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email';
        //var CLIENTID = '1015391212664-jndlcs0b41jvs9jl3fvk1tjjqpjupdo6.apps.googleusercontent.com';
        var CLIENTID = '277719133680-ilhp40cupjrdj7l6o79ql5itlhfa0nrl.apps.googleusercontent.com';
        var REDIRECT = 'http://localhost:52182/DoctorHome.aspx';
        var LOGOUT = 'http://accounts.google.com/Logout';
        var TYPE = 'token';
        var _url = OAUTHURL + 'scope=' + SCOPE + '&client_id=' + CLIENTID + '&redirect_uri=' + REDIRECT + '&response_type=' + TYPE;
        var acToken;
        var tokenType;
        var expiresIn;
        var user;
        var loggedIn = false;
        function login() {
            var win = window.open(_url, "windowname1", 'width=800, height=600');
            var pollTimer = window.setInterval(function () {
                try {
                    console.log(win.document.URL);
                    if (win.document.URL.indexOf(REDIRECT) != -1) {
                        window.clearInterval(pollTimer);
                        var url = win.document.URL;
                        acToken = gup(url, 'access_token');
                        tokenType = gup(url, 'token_type');
                        expiresIn = gup(url, 'expires_in');
                        win.close();
                        validateToken(acToken);
                    }
                } catch (e) {
                }
            }, 500);
        }
        function validateToken(token) {
            $.ajax({
                url: VALIDURL + token,
                data: null,
                success: function (responseText) {
                    //getUserInfo();
                    loggedIn = true;
                    var loc = 'DoctorHome.aspx'
                    window.location.href = loc;
                },
                dataType: "jsonp"
            });
        }
        function getUserInfo() {
            $.ajax({
                url: 'https://www.googleapis.com/oauth2/v1/userinfo?access_token=' + acToken,
                data: null,
                success: function (resp) {
                    user = resp;
                    console.log(user);
                    $('#uName').text('Welcome ' + user.name);
                    $('#imgHolder').attr('src', user.picture);
                },
                dataType: "jsonp"
            });
        }
        //credits: http://www.netlobo.com/url_query_string_javascript.html
        function gup(url, name) {
            name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
            var regexS = "[\\#&]" + name + "=([^&#]*)";
            var regex = new RegExp(regexS);
            var results = regex.exec(url);
            if (results == null)
                return "";
            else
                return results[1];
        }
        function startLogoutPolling() {
            $('#loginText').show();
            $('#logoutText').hide();
            loggedIn = false;
            $('#uName').text('Welcome ');
            $('#imgHolder').attr('src', 'none.jpg');
        }

    </script>
</head>
<body class="login-layout">

    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" />
        <div class="main-container">
            <div class="main-content">
                <div class="row">
                    <div class="col-sm-10 col-sm-offset-1">
                        <div class="login-container">
                            <div class="center">
                                <h1>
                                    <i class="ace-icon fa fa-leaf green"></i>
                                    <span class="white">e-Health Application</span>
                                    <%--<span class="white" id="id-text2">Army Telephone Complaint Management System</span>--%>
                                </h1>
                                <h4 class="blue" id="H1">&copy; Trio Tech Pakistan</h4>
                            </div>

                            <div class="space-6"></div>

                            <div class="position-relative">
                                <div id="login-box" class="login-box visible widget-box no-border">
                                    <div class="widget-body">
                                        <div class="widget-main">
                                            <h4 class="header blue lighter bigger">
                                                <i class="ace-icon fa fa-coffee green"></i>
                                                Please Enter Your Information
                                            </h4>

                                            <div class="space-6"></div>

                                            <form action="">
                                                <fieldset>
                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox runat="server" ID="txtem" CssClass="form-control" placeholder="Email" />

                                                            <i class="ace-icon fa fa-user"></i>
                                                        </span>
                                                    </label>
                                                    <asp:Panel ID="Panel1" runat="server" DefaultButton="lblogin">
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox runat="server" ID="txtpwd" TextMode="Password" CssClass="form-control" placeholder="Password" />
                                                                <i class="ace-icon fa fa-lock"></i>
                                                            </span>
                                                        </label>
                                                        <asp:Label ID="lblError" runat="server" ForeColor="Red" Visible="false"></asp:Label>
                                                        <div class="space"></div>

                                                        <div class="clearfix">
                                                            <asp:LinkButton runat="server" ID="lblogin" OnClick="lblogin_Click" class="width-35 pull-right btn btn-sm btn-primary"><i class="ace-icon fa fa-key"></i><span class="bigger-110">Login</span>
                                                            </asp:LinkButton>

                                                        </div>

                                                        <div class="hr hr-18 dotted hr-double"></div>

                                                        <div class="center">Login using other services</div>
                                                        <br />
                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <a class="width-100 btn btn-sm btn-primary" href='#' onclick='login();' id="loginText">Signin with Google Plus </a>

                                                            </div>
                                                        </div>
                                                        <br />
                                                        <div class="row">
                                                              <div class="col-md-12"> 
                                                            <div id="linkedin_login" class="width-100 btn btn-sm btn-primary">
                                                                <script type="in/login" data-onauth="onLinkedInAuth">
                                                                    <a class="pull-center btn btn-sm btn-primary" href="#" onclick="location.reload();">Reload Page</a></script>
                                                            </div>
                                                      </div>
                                                             </div>
                                                        <br />
                                                        <div class="row">

                                                            <div class="col-md-12">

                                                                <!-- this initializes the fb controls-->
                                                                <div id="fb-root"></div>
                                                                <a class="width-100 btn btn-sm btn-primary" href="#" onclick="loginByFacebook();">Signin with Facebook</a>

                                                            </div>
                                                        </div>
                                                        
                                                        
                                                    </asp:Panel>


                                                    <div class="space-4"></div>



                                                </fieldset>
                                            </form>

                                        </div>
                                        <!-- /.widget-main -->


                                    </div>
                                    <!-- /.widget-body -->
                                </div>
                                <!-- /.login-box -->


                                <!-- /.widget-main -->


                            </div>
                            <!-- /.widget-body -->
                        </div>
                        <!-- /.forgot-box -->

                        <!-- /.position-relative -->
                        <%--   <div class="center">
                                    <h4 class="blue" id="id-company-text">&copy; Trio Tech</h4>
                                </div>--%>
                        <div class="navbar-fixed-top align-right">
                            <br />
                            &nbsp;
								<a id="btn-login-dark" href="#">Dark</a>
                            &nbsp;
								<span class="blue">/</span>
                            &nbsp;
								<a id="btn-login-blur" href="#">Blur</a>
                            &nbsp;
								<span class="blue">/</span>
                            &nbsp;
								<a id="btn-login-light" href="#">Light</a>
                            &nbsp; &nbsp; &nbsp;
                        </div>
                    </div>
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->
        </div>
        <!-- /.main-content -->

        <!-- /.main-container -->

        <!-- basic scripts -->

        <!--[if !IE]> -->
        <script src="../../../../../ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>

        <!-- <![endif]-->

        <!--[if IE]>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<![endif]-->
        <script type="text/javascript">
            if ('ontouchstart' in document.documentElement) document.write("<script src='components/_mod/jquery.mobile.custom/jquery.mobile.custom.min.js'>" + "<" + "/script>");
        </script>

        <!-- inline scripts related to this page -->
        <script type="text/javascript">
            jQuery(function ($) {
                $(document).on('click', '.toolbar a[data-target]', function (e) {
                    e.preventDefault();
                    var target = $(this).data('target');
                    $('.widget-box.visible').removeClass('visible');//hide others
                    $(target).addClass('visible');//show target
                });
            });



            //you don't need this, just used for changing background
            jQuery(function ($) {
                $('#btn-login-dark').on('click', function (e) {
                    $('body').attr('class', 'login-layout');
                    $('#id-text2').attr('class', 'white');
                    $('#id-company-text').attr('class', 'blue');

                    e.preventDefault();
                });
                $('#btn-login-light').on('click', function (e) {
                    $('body').attr('class', 'login-layout light-login');
                    $('#id-text2').attr('class', 'grey');
                    $('#id-company-text').attr('class', 'blue');

                    e.preventDefault();
                });
                $('#btn-login-blur').on('click', function (e) {
                    $('body').attr('class', 'login-layout blur-login');
                    $('#id-text2').attr('class', 'white');
                    $('#id-company-text').attr('class', 'light-blue');

                    e.preventDefault();
                });

            });
        </script>


    </form>



    <%--Facebook--%>
    <script type="text/javascript">
        window.fbAsyncInit = function () {
            FB.init({
                appId: '718427485191545', //Localhost key
                status: true, // check login status
                cookie: true, // enable cookies to allow the server to access the session
                xfbml: true, // parse XFBML
                oauth: true // enable OAuth 2.0
            });
        };
        (function () {
            var e = document.createElement('script'); e.async = true;
            e.src = document.location.protocol +
            '//connect.facebook.net/en_US/all.js';
            document.getElementById('fb-root').appendChild(e);
        }());

        function loginByFacebook() {
            FB.login(function (response) {
                if (response.authResponse) {
                    FacebookLoggedIn(response);
                } else {
                    console.log('User cancelled login or did not fully authorize.');
                }
            }, { scope: 'user_birthday,user_about_me,user_hometown,user_location,email,publish_stream' });
        }

        function FacebookLoggedIn(response) {
            //var loc = 'callbackfb.aspx';
            var loc = 'PatientHome.aspx';
            if (loc.indexOf('?') > -1)
                window.location = loc + '&authprv=facebook&access_token=' + response.authResponse.accessToken;
            else
                window.location = loc + '?authprv=facebook&access_token=' + response.authResponse.accessToken;
        }

    </script>

    <%--Linked In--%>
    <script type="text/javascript">
        //LinkedIn Auth Event
        function onLinkedInAuth() {
            //var loc = 'callback1.aspx?accessToken=' + IN.ENV.auth.oauth_token;
            var loc = 'ResearcherHome.aspx'
            window.location.href = loc;
        }
        //End LinkedIn
    </script>

   
</body>
</html>
