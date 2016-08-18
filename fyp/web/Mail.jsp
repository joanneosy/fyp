<%-- 
    Document   : Mail
    Created on : 28 Jul, 2016, 12:18:30 AM
    Author     : Joshymantou
--%>

<%@page import="java.util.HashMap"%>
<%@page import="entity.QuotationRequest"%>
<%@page import="dao.QuotationRequestDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mail</title>
        <link rel="icon" type="image/ico" href="images/favicon.ico" />
        <!-- Bootstrap -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/animate.css">
        <link type="text/css" rel="stylesheet" media="all" href="css/jquery.mmenu.all.css" />
        <link rel="stylesheet" href="css/jquery.videobackground.css">
        <link rel="stylesheet" href="css/bootstrap-checkbox.css">

        <link href="css/minimal.css" rel="stylesheet">
        <link rel="stylesheet" href="css/custom.css">

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
          <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
        <![endif]-->
    </head>
    <body>
        <%            String successChangePasswordMsg = (String) request.getAttribute("successChangePasswordMsg");
            if (successChangePasswordMsg != null) {
                out.println(successChangePasswordMsg + "<br/><br/>");
            }
        %>


        <!-- Preloader -->
        <div class="mask"><div id="loader"></div></div>
        <!--/Preloader -->
        <!-- Wrap all page content here -->
        <div id="wrap">
            <!-- Make page fluid -->
            <div class="row">
                <!-- topbar.jsp includes leftbar -->
                <jsp:include page="include/topbar.jsp"/>

                <!-- Page content -->
                <div id="content" class="col-md-12">

                    <!-- page header -->
                    <div class="pageheader">


                        <h2><i class="fa fa-envelope" style="line-height: 48px;padding-left: 0;"></i> Mail <span>// Place subtitle here...</span></h2>


                        <div class="breadcrumbs">
                            <ol class="breadcrumb">
                                <li>You are here</li>
                                <li><a href="index.html">Minimal</a></li>
                                <li><a href="#">Example Pages</a></li>
                                <li class="active">Mail</li>
                            </ol>
                        </div>

                    </div>
                    <!-- /page header -->






                    <!-- content main container -->
                    <div class="main vertical-mail">




                        <!-- row -->
                        <div class="row">


                            <div class="col-md-2">

                                <ul class="navigation" id="mail-navigation">
                                    <li class="mark"><i class="fa fa-envelope-o"></i></li>
                                    <li class="compose"><a href="#" class="btn btn-red">Compose Mail</a></li>
                                    <li class="folders heading">
                                        <h5><i class="fa fa-folder"></i> Folders <a href="#" class="pull-right"><i class="fa fa-plus"></i></a></h5>
                                        <ul>
                                            <li class="active"><a href="#"><span class="badge badge-red">5</span>Inbox</a></li>
                                            <li><a href="#">Sent</a></li>
                                            <li><a href="#">Draft</a></li>
                                            <li><a href="#">Trash</a></li>
                                            <li class="divider"></li>
                                            <li class="other"><a href="#">Private</a></li>
                                            <li class="other"><a href="#">Work</a></li>
                                        </ul>
                                    </li>
                                    <li class="labels heading">
                                        <h5><i class="fa fa-tags"></i> Labels <a href="#" class="pull-right"><i class="fa fa-plus"></i></a></h5>
                                        <ul>
                                            <li class="tag"><a href="#">Family <span class="label label-cyan"></span></a></li>
                                            <li class="tag"><a href="#">Work <span class="label label-red"></span></a></li>
                                            <li class="tag"><a href="#">Shop <span class="label label-orange"></span></a></li>
                                            <li class="tag"><a href="#">Themeforest <span class="label label-amethyst"></span></a></li>
                                            <li class="tag"><a href="#">Google <span class="label label-green"></span></a></li>
                                            <li class="tag"><a href="#">Facebook <span class="label label-hotpink"></span></a></li>
                                        </ul>
                                </ul>

                            </div>              

                            <div class="col-md-3">

                                <ul class="inbox" id="mail-inbox">
                                    <li class="heading"><h1>Inbox</h1></li>
                                    <li class="search"><i class="fa fa-search"></i> <input type="text" placeholder="Search in inbox..." /></li>
                                    <li class="msg">
                                        <div class="checkbox check-transparent">
                                            <input type="checkbox" value="1" checked id="msg01">
                                            <label for="msg01"></label>
                                        </div>
                                        <a href="#" class="mail-favourite active"><i class="fa fa-star-o"></i></a>
                                        <div>
                                            <h5><strong>Lucius</strong> Cashmere (5)</h5>
                                            <p><strong>Mail Message Subject</strong>, Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                                            <span class="delivery-time">today, 4:23pm</span>
                                            <div class="mail-attachment"><i class="fa fa-paperclip"></i></div>
                                            <div class="mail-label bg-red"></div>
                                            <div class="mail-actions">
                                                <a href="#" class="reply"><i class="fa fa-reply"></i></a> 
                                                <a href="#" class="delete"><i class="fa fa-trash-o"></i></a>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="msg">
                                        <div class="checkbox check-transparent">
                                            <input type="checkbox" id="msg02">
                                            <label for="msg02"></label>
                                        </div>
                                        <a href="#" class="mail-favourite"><i class="fa fa-star-o"></i></a>
                                        <div>
                                            <h5><strong>Jesse</strong> Phoenix</h5>
                                            <p><strong>Mail Message Subject</strong>, Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                                            <span class="delivery-time">yesterday, 7:58am</span>
                                            <div class="mail-attachment"><i class="fa fa-paperclip"></i></div>
                                            <div class="mail-label bg-red"></div>
                                            <div class="mail-actions">
                                                <a href="#" class="reply"><i class="fa fa-reply"></i></a> 
                                                <a href="#" class="delete"><i class="fa fa-trash-o"></i></a>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="msg active">
                                        <div class="checkbox check-transparent">
                                            <input type="checkbox" id="msg03">
                                            <label for="msg03"></label>
                                        </div>
                                        <a href="#" class="mail-favourite"><i class="fa fa-star-o"></i></a>
                                        <div>
                                            <h5><strong>Dell</strong> MacApple</h5>
                                            <p><strong>Mail Message Subject</strong>, Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                                            <span class="delivery-time">yesterday, 9:24am</span>
                                            <div class="mail-actions">
                                                <a href="#" class="reply"><i class="fa fa-reply"></i></a> 
                                                <a href="#" class="delete"><i class="fa fa-trash-o"></i></a>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="msg">
                                        <div class="checkbox check-transparent">
                                            <input type="checkbox" id="msg04">
                                            <label for="msg04"></label>
                                        </div>
                                        <a href="#" class="mail-favourite active"><i class="fa fa-star-o"></i></a>
                                        <div>
                                            <h5><strong>Roger</strong> Flopple (3)</h5>
                                            <p><strong>Mail Message Subject</strong>, Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                                            <span class="delivery-time">yesterday, 11:12am</span>
                                            <div class="mail-attachment"><i class="fa fa-paperclip"></i></div>
                                            <div class="mail-label bg-cyan"></div>
                                            <div class="mail-actions">
                                                <a href="#" class="reply"><i class="fa fa-reply"></i></a> 
                                                <a href="#" class="delete"><i class="fa fa-trash-o"></i></a>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="msg">
                                        <div class="checkbox check-transparent">
                                            <input type="checkbox" id="msg05">
                                            <label for="msg05"></label>
                                        </div>
                                        <a href="#" class="mail-favourite active"><i class="fa fa-star-o"></i></a>
                                        <div>
                                            <h5><strong>Nico</strong> Vulture (8)</h5>
                                            <p><strong>Mail Message Subject</strong>, Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                                            <span class="delivery-time">yesterday, 01:28pm</span>
                                            <div class="mail-label bg-red"></div>
                                            <div class="mail-actions">
                                                <a href="#" class="reply"><i class="fa fa-reply"></i></a> 
                                                <a href="#" class="delete"><i class="fa fa-trash-o"></i></a>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="msg">
                                        <div class="checkbox check-transparent">
                                            <input type="checkbox" id="msg06">
                                            <label for="msg06"></label>
                                        </div>
                                        <a href="#" class="mail-favourite"><i class="fa fa-star-o"></i></a>
                                        <div>
                                            <h5><strong>Bobby</strong> Socks (2)</h5>
                                            <p>Mail Message Subject, Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                                            <span class="delivery-time">yesterday, 01:33pm</span>
                                            <div class="mail-actions">
                                                <a href="#" class="reply"><i class="fa fa-reply"></i></a> 
                                                <a href="#" class="delete"><i class="fa fa-trash-o"></i></a>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="msg">
                                        <div class="checkbox check-transparent">
                                            <input type="checkbox" id="msg07">
                                            <label for="msg07"></label>
                                        </div>
                                        <a href="#" class="mail-favourite"><i class="fa fa-star-o"></i></a>
                                        <div>
                                            <h5><strong>Silk</strong> Teddy</h5>
                                            <p>Mail Message Subject, Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                                            <span class="delivery-time">yesterday, 04:18pm</span>
                                            <div class="mail-attachment"><i class="fa fa-paperclip"></i></div>
                                            <div class="mail-actions">
                                                <a href="#" class="reply"><i class="fa fa-reply"></i></a> 
                                                <a href="#" class="delete"><i class="fa fa-trash-o"></i></a>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="msg">
                                        <div class="checkbox check-transparent">
                                            <input type="checkbox" id="msg08">
                                            <label for="msg08"></label>
                                        </div>
                                        <a href="#" class="mail-favourite active"><i class="fa fa-star-o"></i></a>
                                        <div>
                                            <h5><strong>Rodney</strong> Hacksaw</h5>
                                            <p>Mail Message Subject, Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                                            <span class="delivery-time">yesterday, 05:12pm</span>
                                            <div class="mail-actions">
                                                <a href="#" class="reply"><i class="fa fa-reply"></i></a> 
                                                <a href="#" class="delete"><i class="fa fa-trash-o"></i></a>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="msg">
                                        <div class="checkbox check-transparent">
                                            <input type="checkbox" id="msg09">
                                            <label for="msg09"></label>
                                        </div>
                                        <a href="#" class="mail-favourite"><i class="fa fa-star-o"></i></a>
                                        <div>
                                            <h5><strong>Paul</strong> Corduroy</h5>
                                            <p>Mail Message Subject, Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                                            <span class="delivery-time">yesterday, 05:35pm</span>
                                            <div class="mail-attachment"><i class="fa fa-paperclip"></i></div>
                                            <div class="mail-label bg-orange"></div>
                                            <div class="mail-actions">
                                                <a href="#" class="reply"><i class="fa fa-reply"></i></a> 
                                                <a href="#" class="delete"><i class="fa fa-trash-o"></i></a>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="msg last">
                                        <div class="checkbox check-transparent">
                                            <input type="checkbox" id="msg10">
                                            <label for="msg10"></label>
                                        </div>
                                        <a href="#" class="mail-favourite active"><i class="fa fa-star-o"></i></a>
                                        <div>
                                            <h5><strong>Tex</strong> Montreal (4)</h5>
                                            <p>Mail Message Subject, Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                                            <span class="delivery-time">yesterday, 07:12pm</span>
                                            <div class="mail-label bg-greensea"></div>
                                            <div class="mail-actions">
                                                <a href="#" class="reply"><i class="fa fa-reply"></i></a> 
                                                <a href="#" class="delete"><i class="fa fa-trash-o"></i></a>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="pagination pull-right">
                                        <span>1-10 of 154</span>
                                        <div class="btn-group btn-group-sm">
                                            <button type="button" class="btn btn-default"><i class="fa fa-angle-left"></i></button>
                                            <button type="button" class="btn btn-default"><i class="fa fa-angle-right"></i></button>
                                        </div>
                                    </li>
                                </ul>
                            </div>


                            <div class="col-md-7">


                                <div class="mail-content" id="mail-content">

                                    <div class="quick-navigation">
                                        <button type="button" class="btn btn-default pull-left prev"><i class="fa fa-angle-left"></i></button>
                                        <h3><strong>Inbox</strong> (3/154)</h3>
                                        <button type="button" class="btn btn-default pull-right next"><i class="fa fa-angle-right"></i></button>
                                    </div>

                                    <div class="message">

                                        <div class="header">
                                            <h1><strong>Mail Message</strong> Subject</h1>

                                            <ul class="message-info">
                                                <li>From: <em>Dell MacApple</em></li>
                                                <li>To: <em>me, admin@minoral.com</em></li>
                                                <li>Date: <em>10.02.2014, 9:24am</em></li>
                                                <li><i class="fa fa-paperclip"></i> <em>(1 file, 12.9 KB)</em></li>
                                            </ul>

                                            <div class="actions">
                                                <div class="btn-group">
                                                    <button type="button" class="btn btn-default"><i class="fa fa-reply"></i></button>
                                                    <button type="button" class="btn btn-default"><i class="fa fa-mail-reply-all"></i></button>
                                                    <button type="button" class="btn btn-default"><i class="fa fa-share"></i></button>
                                                </div>

                                                <button type="button" class="btn btn-default pull-right"><i class="fa fa-trash-o"></i></button>

                                            </div>
                                        </div>

                                        <div class="content">

                                            <p>
                                                Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                                            </p>

                                            <blockquote class="filled withoutHeader">
                                                <p><i class="fa fa-quote-left pull-left"></i>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
                                            </blockquote>

                                            <h4 class="filled"><i class="icon-tags"></i> Attachments</h4>
                                            <div class="filled">
                                                <ul class="attachments">
                                                    <li><span class="label label-warning">zip</span> <em>zipped_file.zip (2,9MB) <span class="att-actions"><i class="fa fa-eye att-show"></i><i class="fa fa-share att-forward"></i><i class="fa fa-download att-download"></i></span></em></li>
                                                    <li><span class="label label-success">doc</span> <em>word_document.docx (1,2MB) <span class="att-actions"><i class="fa fa-eye att-show"></i><i class="fa fa-share att-forward"></i><i class="fa fa-download att-download"></i></span></em></li>
                                                    <li><span class="label label-primary">xls</span> <em>excel_document.xlsx (459KB) <span class="att-actions"><i class="fa fa-eye att-show"></i><i class="fa fa-share att-forward"></i><i class="fa fa-download att-download"></i></span></em></li>
                                                </ul>
                                            </div>

                                            <h4 class="filled"><i class="icon-mail-reply"></i> Reply</h4>
                                            <div>
                                                <form>
                                                    <div id="message-wysiwyg"></div>
                                                    <button type="submit" class="btn btn-greensea">Send</button>
                                                </form>
                                            </div>


                                        </div>

                                    </div>
                                </div>


                            </div>



                        </div>
                        <!-- /row -->



                    </div>
                    <!-- /content container -->






                </div>
                <!-- Page content end -->




                <div id="mmenu" class="right-panel">
                    <!-- Nav tabs -->
                    <ul class="nav nav-tabs nav-justified">
                        <li class="active"><a href="#mmenu-users" data-toggle="tab"><i class="fa fa-users"></i></a></li>
                        <li class=""><a href="#mmenu-history" data-toggle="tab"><i class="fa fa-clock-o"></i></a></li>
                        <li class=""><a href="#mmenu-friends" data-toggle="tab"><i class="fa fa-heart"></i></a></li>
                        <li class=""><a href="#mmenu-settings" data-toggle="tab"><i class="fa fa-gear"></i></a></li>
                    </ul>

                    <!-- Tab panes -->
                    <div class="tab-content">
                        <div class="tab-pane active" id="mmenu-users">
                            <h5><strong>Online</strong> Users</h5>

                            <ul class="users-list">

                                <li class="online">
                                    <div class="media">
                                        <a class="pull-left profile-photo" href="#">
                                            <img class="media-object" src="assets/images/ici-avatar.jpg" alt>
                                        </a>
                                        <div class="media-body">
                                            <h6 class="media-heading">Ing. Imrich <strong>Kamarel</strong></h6>
                                            <small><i class="fa fa-map-marker"></i> Ulaanbaatar, Mongolia</small>
                                            <span class="badge badge-outline status"></span>
                                        </div>
                                    </div>
                                </li>

                                <li class="online">
                                    <div class="media">

                                        <a class="pull-left profile-photo" href="#">
                                            <img class="media-object" src="assets/images/arnold-avatar.jpg" alt>
                                        </a>
                                        <span class="badge badge-red unread">3</span>

                                        <div class="media-body">
                                            <h6 class="media-heading">Arnold <strong>Karlsberg</strong></h6>
                                            <small><i class="fa fa-map-marker"></i> Bratislava, Slovakia</small>
                                            <span class="badge badge-outline status"></span>
                                        </div>

                                    </div>
                                </li>

                                <li class="online">
                                    <div class="media">
                                        <a class="pull-left profile-photo" href="#">
                                            <img class="media-object" src="assets/images/peter-avatar.jpg" alt>

                                        </a>
                                        <div class="media-body">
                                            <h6 class="media-heading">Peter <strong>Kay</strong></h6>
                                            <small><i class="fa fa-map-marker"></i> Kosice, Slovakia</small>
                                            <span class="badge badge-outline status"></span>
                                        </div>
                                    </div>
                                </li>

                                <li class="online">
                                    <div class="media">
                                        <a class="pull-left profile-photo" href="#">
                                            <img class="media-object" src="assets/images/george-avatar.jpg" alt>
                                        </a>
                                        <div class="media-body">
                                            <h6 class="media-heading">George <strong>McCain</strong></h6>
                                            <small><i class="fa fa-map-marker"></i> Prague, Czech Republic</small>
                                            <span class="badge badge-outline status"></span>
                                        </div>
                                    </div>
                                </li>

                                <li class="busy">
                                    <div class="media">
                                        <a class="pull-left profile-photo" href="#">
                                            <img class="media-object" src="assets/images/random-avatar1.jpg" alt>
                                        </a>
                                        <div class="media-body">
                                            <h6 class="media-heading">Lucius <strong>Cashmere</strong></h6>
                                            <small><i class="fa fa-map-marker"></i> Wien, Austria</small>
                                            <span class="badge badge-outline status"></span>
                                        </div>
                                    </div>
                                </li>

                                <li class="busy">
                                    <div class="media">
                                        <a class="pull-left profile-photo" href="#">
                                            <img class="media-object" src="assets/images/random-avatar2.jpg" alt>
                                        </a>
                                        <div class="media-body">
                                            <h6 class="media-heading">Jesse <strong>Phoenix</strong></h6>
                                            <small><i class="fa fa-map-marker"></i> Berlin, Germany</small>
                                            <span class="badge badge-outline status"></span>
                                        </div>
                                    </div>
                                </li>

                            </ul>

                            <h5><strong>Offline</strong> Users</h5>

                            <ul class="users-list">

                                <li class="offline">
                                    <div class="media">
                                        <a class="pull-left profile-photo" href="#">
                                            <img class="media-object" src="assets/images/random-avatar4.jpg" alt>
                                        </a>
                                        <div class="media-body">
                                            <h6 class="media-heading">Dell <strong>MacApple</strong></h6>
                                            <small><i class="fa fa-map-marker"></i> Paris, France</small>
                                            <span class="badge badge-outline status"></span>
                                        </div>
                                    </div>
                                </li>

                                <li class="offline">
                                    <div class="media">

                                        <a class="pull-left profile-photo" href="#">
                                            <img class="media-object" src="assets/images/random-avatar5.jpg" alt>
                                        </a>

                                        <div class="media-body">
                                            <h6 class="media-heading">Roger <strong>Flopple</strong></h6>
                                            <small><i class="fa fa-map-marker"></i> Rome, Italia</small>
                                            <span class="badge badge-outline status"></span>
                                        </div>

                                    </div>
                                </li>

                                <li class="offline">
                                    <div class="media">
                                        <a class="pull-left profile-photo" href="#">
                                            <img class="media-object" src="assets/images/random-avatar6.jpg" alt>

                                        </a>
                                        <div class="media-body">
                                            <h6 class="media-heading">Nico <strong>Vulture</strong></h6>
                                            <small><i class="fa fa-map-marker"></i> Kyjev, Ukraine</small>
                                            <span class="badge badge-outline status"></span>
                                        </div>
                                    </div>
                                </li>

                                <li class="offline">
                                    <div class="media">
                                        <a class="pull-left profile-photo" href="#">
                                            <img class="media-object" src="assets/images/random-avatar7.jpg" alt>
                                        </a>
                                        <div class="media-body">
                                            <h6 class="media-heading">Bobby <strong>Socks</strong></h6>
                                            <small><i class="fa fa-map-marker"></i> Moscow, Russia</small>
                                            <span class="badge badge-outline status"></span>
                                        </div>
                                    </div>
                                </li>

                                <li class="offline">
                                    <div class="media">
                                        <a class="pull-left profile-photo" href="#">
                                            <img class="media-object" src="assets/images/random-avatar8.jpg" alt>
                                        </a>
                                        <div class="media-body">
                                            <h6 class="media-heading">Anna <strong>Opichia</strong></h6>
                                            <small><i class="fa fa-map-marker"></i> Budapest, Hungary</small>
                                            <span class="badge badge-outline status"></span>
                                        </div>
                                    </div>
                                </li>

                            </ul>

                        </div>

                        <div class="tab-pane" id="mmenu-history">
                            <h5><strong>Chat</strong> History</h5>

                            <ul class="history-list">

                                <li class="online">
                                    <div class="media">
                                        <a class="pull-left profile-photo" href="#">
                                            <img class="media-object" src="assets/images/ici-avatar.jpg" alt>
                                        </a>
                                        <div class="media-body">
                                            <h6 class="media-heading">Ing. Imrich <strong>Kamarel</strong></h6>
                                            <small>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor</small>
                                            <span class="badge badge-outline status"></span>
                                        </div>
                                    </div>
                                </li>

                                <li class="busy">
                                    <div class="media">

                                        <a class="pull-left profile-photo" href="#">
                                            <img class="media-object" src="assets/images/arnold-avatar.jpg" alt>
                                        </a>
                                        <span class="badge badge-red unread">3</span>

                                        <div class="media-body">
                                            <h6 class="media-heading">Arnold <strong>Karlsberg</strong></h6>
                                            <small>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur</small>
                                            <span class="badge badge-outline status"></span>
                                        </div>

                                    </div>
                                </li>

                                <li class="offline">
                                    <div class="media">
                                        <a class="pull-left profile-photo" href="#">
                                            <img class="media-object" src="assets/images/peter-avatar.jpg" alt>

                                        </a>
                                        <div class="media-body">
                                            <h6 class="media-heading">Peter <strong>Kay</strong></h6>
                                            <small>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit </small>
                                            <span class="badge badge-outline status"></span>
                                        </div>
                                    </div>
                                </li>

                            </ul>

                        </div>

                        <div class="tab-pane" id="mmenu-friends">
                            <h5><strong>Friends</strong> List</h5>
                            <ul class="favourite-list">

                                <li class="online">
                                    <div class="media">

                                        <a class="pull-left profile-photo" href="#">
                                            <img class="media-object" src="assets/images/arnold-avatar.jpg" alt>
                                        </a>
                                        <span class="badge badge-red unread">3</span>

                                        <div class="media-body">
                                            <h6 class="media-heading">Arnold <strong>Karlsberg</strong></h6>
                                            <small><i class="fa fa-map-marker"></i> Bratislava, Slovakia</small>
                                            <span class="badge badge-outline status"></span>
                                        </div>

                                    </div>
                                </li>

                                <li class="offline">
                                    <div class="media">
                                        <a class="pull-left profile-photo" href="#">
                                            <img class="media-object" src="assets/images/random-avatar8.jpg" alt>
                                        </a>
                                        <div class="media-body">
                                            <h6 class="media-heading">Anna <strong>Opichia</strong></h6>
                                            <small><i class="fa fa-map-marker"></i> Budapest, Hungary</small>
                                            <span class="badge badge-outline status"></span>
                                        </div>
                                    </div>
                                </li>

                                <li class="busy">
                                    <div class="media">
                                        <a class="pull-left profile-photo" href="#">
                                            <img class="media-object" src="assets/images/random-avatar1.jpg" alt>
                                        </a>
                                        <div class="media-body">
                                            <h6 class="media-heading">Lucius <strong>Cashmere</strong></h6>
                                            <small><i class="fa fa-map-marker"></i> Wien, Austria</small>
                                            <span class="badge badge-outline status"></span>
                                        </div>
                                    </div>
                                </li>

                                <li class="online">
                                    <div class="media">
                                        <a class="pull-left profile-photo" href="#">
                                            <img class="media-object" src="assets/images/ici-avatar.jpg" alt>
                                        </a>
                                        <div class="media-body">
                                            <h6 class="media-heading">Ing. Imrich <strong>Kamarel</strong></h6>
                                            <small><i class="fa fa-map-marker"></i> Ulaanbaatar, Mongolia</small>
                                            <span class="badge badge-outline status"></span>
                                        </div>
                                    </div>
                                </li>

                            </ul>
                        </div>

                        <div class="tab-pane pane-settings" id="mmenu-settings">
                            <h5><strong>Chat</strong> Settings</h5>

                            <ul class="settings">

                                <li>
                                    <div class="form-group">
                                        <label class="col-xs-8 control-label">Show Offline Users</label>
                                        <div class="col-xs-4 control-label">
                                            <div class="onoffswitch greensea">
                                                <input type="checkbox" name="onoffswitch" class="onoffswitch-checkbox" id="show-offline" checked="">
                                                <label class="onoffswitch-label" for="show-offline">
                                                    <span class="onoffswitch-inner"></span>
                                                    <span class="onoffswitch-switch"></span>
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </li>

                                <li>
                                    <div class="form-group">
                                        <label class="col-xs-8 control-label">Show Fullname</label>
                                        <div class="col-xs-4 control-label">
                                            <div class="onoffswitch greensea">
                                                <input type="checkbox" name="onoffswitch" class="onoffswitch-checkbox" id="show-fullname">
                                                <label class="onoffswitch-label" for="show-fullname">
                                                    <span class="onoffswitch-inner"></span>
                                                    <span class="onoffswitch-switch"></span>
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </li>

                                <li>
                                    <div class="form-group">
                                        <label class="col-xs-8 control-label">History Enable</label>
                                        <div class="col-xs-4 control-label">
                                            <div class="onoffswitch greensea">
                                                <input type="checkbox" name="onoffswitch" class="onoffswitch-checkbox" id="show-history" checked="">
                                                <label class="onoffswitch-label" for="show-history">
                                                    <span class="onoffswitch-inner"></span>
                                                    <span class="onoffswitch-switch"></span>
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </li>

                                <li>
                                    <div class="form-group">
                                        <label class="col-xs-8 control-label">Show Locations</label>
                                        <div class="col-xs-4 control-label">
                                            <div class="onoffswitch greensea">
                                                <input type="checkbox" name="onoffswitch" class="onoffswitch-checkbox" id="show-location" checked="">
                                                <label class="onoffswitch-label" for="show-location">
                                                    <span class="onoffswitch-inner"></span>
                                                    <span class="onoffswitch-switch"></span>
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </li>

                                <li>
                                    <div class="form-group">
                                        <label class="col-xs-8 control-label">Notifications</label>
                                        <div class="col-xs-4 control-label">
                                            <div class="onoffswitch greensea">
                                                <input type="checkbox" name="onoffswitch" class="onoffswitch-checkbox" id="show-notifications">
                                                <label class="onoffswitch-label" for="show-notifications">
                                                    <span class="onoffswitch-inner"></span>
                                                    <span class="onoffswitch-switch"></span>
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </li>

                                <li>
                                    <div class="form-group">
                                        <label class="col-xs-8 control-label">Show Undread Count</label>
                                        <div class="col-xs-4 control-label">
                                            <div class="onoffswitch greensea">
                                                <input type="checkbox" name="onoffswitch" class="onoffswitch-checkbox" id="show-unread" checked="">
                                                <label class="onoffswitch-label" for="show-unread">
                                                    <span class="onoffswitch-inner"></span>
                                                    <span class="onoffswitch-switch"></span>
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </li>

                            </ul>

                        </div><!-- tab-pane -->

                    </div><!-- tab-content -->
                </div>






            </div>
            <!-- Make page fluid-->




        </div>
        <!-- Wrap all page content end -->



        <section class="videocontent" id="video"></section>
    </body>


    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://code.jquery.com/jquery.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="assets/js/vendor/bootstrap/bootstrap.min.js"></script>
    <script src="assets/js/vendor/bootstrap/bootstrap-dropdown-multilevel.js"></script>
    <script src="https://google-code-prettify.googlecode.com/svn/loader/run_prettify.js?lang=css&amp;skin=sons-of-obsidian"></script>
    <script type="text/javascript" src="assets/js/vendor/mmenu/js/jquery.mmenu.min.js"></script>
    <script type="text/javascript" src="assets/js/vendor/sparkline/jquery.sparkline.min.js"></script>
    <script type="text/javascript" src="assets/js/vendor/nicescroll/jquery.nicescroll.min.js"></script>
    <script type="text/javascript" src="assets/js/vendor/animate-numbers/jquery.animateNumbers.js"></script>
    <script type="text/javascript" src="assets/js/vendor/videobackground/jquery.videobackground.js"></script>
    <script type="text/javascript" src="assets/js/vendor/blockui/jquery.blockUI.js"></script>

    <script src="assets/js/vendor/summernote/summernote.min.js"></script>

    <script src="assets/js/minimal.min.js"></script>

    <script>
        $(function () {


            $('#mail-inbox .mail-favourite').click(function () {
                $(this).toggleClass('active');
            });

            $("#mail-content .content").niceScroll({
                cursorcolor: '#000000',
                zindex: 999999,
                bouncescroll: true,
                cursoropacitymax: 0.4,
                cursorborder: '',
                cursorborderradius: 0,
                cursorwidth: '5px'
            });

            //load wysiwyg editor
            $('#message-wysiwyg').summernote({
                height: 158, //set editable area's height
                toolbar: [
                    //['style', ['style']], // no style button
                    ['style', ['bold', 'italic', 'underline', 'clear']],
                    ['fontsize', ['fontsize']],
                    ['color', ['color']],
                    ['para', ['ul', 'ol', 'paragraph']],
                    ['height', ['height']],
                            //['insert', ['picture', 'link']], // no insert buttons
                            //['table', ['table']], // no table button
                            //['help', ['help']] //no help button
                ]
            });


        })

    </script>


</html>
