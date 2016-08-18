<%-- 
    Document   : workshop
    Created on : May 5, 2016, 10:00:14 AM
    Author     : joanne.ong.2014
--%>

<%@page import="dao.FetchEmailDAO"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashMap"%>
<%@page import="entity.Vehicle"%>
<%@page import="entity.Customer"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="entity.QuotationRequest"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.QuotationRequestDAO"%>
<%@page import="dao.EmailDAO"%>
<%@page import="javax.mail.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="ProtectWorkshop.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Hello workshop</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta charset="UTF-8" />

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
        <%
            QuotationRequestDAO qDAO = new QuotationRequestDAO();
            HashMap<Integer, QuotationRequest> qList = qDAO.retrieveAllQuotationRequests(user.getStaffId(), user.getToken(), 0, 1, "requested_datetime", "desc");
            HashMap<Integer, Integer> statusSize = qDAO.retrieveStatusSize(user.getStaffId(), user.getToken(), 0, 0, "", "requested_datetime", "desc");
            int newSize = statusSize.get(0);
            int sendFinalSize = statusSize.get(1);
            int finalAcceptSize = statusSize.get(2);
        %>   

        <!-- Preloader -->
        <div class="mask"><div id="loader"></div></div>
        <!--/Preloader -->

        <!-- Wrap all page content here -->
        <div id="wrap">
            <!-- Make page fluid -->
            <div class="row">
                <!-- Top and leftbar -->
                <%--<jsp:include page="include/topbar.jsp"/>--%>
                <%@include file="include/topbar.jsp"%>
                <!-- Top and leftbar end -->

                <!-- Page content -->
                <div id="content" class="col-md-12">

                    <!-- page header -->
                    <div class="pageheader">

                        <h2><i class="fa fa-file-o" style="line-height: 48px;padding-left: 2px;"></i> Dashboard <span>// overview </span></h2>
                    </div>
                    <!-- /page header -->

                    <!-- content main container -->
                    <div class="main">
                        <!-- row -->
                        <div class="row">

                            <!-- col 12 -->
                            <div class="col-md-12">

                                <section class="tile transparent">
                                    <%--
                                    <!-- tile header -->
                                    <div class="tile-header transparent">
                                        <h1><strong>Today</strong> at a glance</h1>
                                        <div class="controls">
                                            <a href="#" class="minimize"><i class="fa fa-chevron-down"></i></a>
                                            <a href="#" class="refresh"><i class="fa fa-refresh"></i></a>
                                        </div>
                                    </div>
                                    <!-- /tile header -->
                                    --%>
                                    <!-- tile body -->
                                    <div class="tile-body color transparent-black rounded-corners">

                                        <!-- cards -->
                                        <div class="row cards">

                                            <div class="card-container col-lg-3 col-sm-6 col-sm-12">
                                                <div class="card card-redbrown hover">
                                                    <div class="front"> 

                                                        <div class="media">        
                                                            <span class="pull-left">
                                                                <i class="fa fa-users media-object"></i>
                                                            </span>

                                                            <div class="media-body">
                                                                New Requests
                                                                <h2 class="media-heading animate-number" data-value="<%=newSize%>" data-animation-duration="1500">0</h2>
                                                            </div>
                                                        </div> 

                                                    </div>
                                                    <div class="back">
                                                        <a href="ViewRequest.jsp#New">
                                                            <i class="fa fa-bar-chart-o fa-4x"></i>
                                                            <span>More Information</span>
                                                        </a>  
                                                    </div>
                                                </div>
                                            </div>


                                            <div class="card-container col-lg-3 col-sm-6 col-sm-12">
                                                <div class="card card-blue hover">
                                                    <div class="front">        

                                                        <div class="media">                  
                                                            <span class="pull-left">
                                                                <i class="fa fa-shopping-cart media-object"></i>
                                                            </span>

                                                            <div class="media-body">
                                                                Send Final Quote
                                                                <h2 class="media-heading animate-number" data-value="<%=sendFinalSize%>" data-animation-duration="1500">0</h2>
                                                            </div>
                                                        </div> 

                                                    </div>
                                                    <div class="back">
                                                        <a href="ViewRequest.jsp#Send_Final_Quote">
                                                            <i class="fa fa-bar-chart-o fa-4x"></i>
                                                            <span>More Information</span>
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>



                                            <div class="card-container col-lg-3 col-sm-6 col-sm-12">
                                                <div class="card card-greensea hover">
                                                    <div class="front">        

                                                        <div class="media">
                                                            <span class="pull-left">
                                                                <i class="fa fa-usd media-object"></i>
                                                            </span>

                                                            <div class="media-body">
                                                                Final Quote Accepted
                                                                <h2 class="media-heading animate-number" data-value="<%=finalAcceptSize%>" data-animation-duration="1500">0</h2>
                                                            </div>
                                                        </div>



                                                    </div>
                                                    <div class="back">
                                                        <a href="ViewRequest.jsp#Final_Quote_Accepted">
                                                            <i class="fa fa-bar-chart-o fa-4x"></i>
                                                            <span>More Information</span>
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="card-container col-lg-3 col-sm-6 col-xs-12">
                                                <div class="card1 card-slategray hover">
                                                    <div class="front"> 

                                                        <div class="media">                   
                                                            <span class="pull-left">
                                                                <i class="fa fa-eye media-object"></i>
                                                            </span>

                                                            <div class="media-body">
                                                                Average Rating
                                                                <h2 class="media-heading animate-number" data-value="4.2" data-animation-duration="1500">0</h2>
                                                            </div>
                                                        </div> 
                                                    </div>
                                                    <!--                                                    <div class="back">
                                                                                                            <a href="#">
                                                                                                                <i class="fa fa-bar-chart-o fa-4x"></i>
                                                                                                                <span>Check Summary</span>
                                                                                                            </a>
                                                                                                        </div>-->
                                                </div>
                                            </div>
                                        </div>
                                        <!-- /cards -->
                                    </div>
                                    <!-- /tile body -->
                                </section>
                                <!-- /tile -->
                            </div>
                            <!-- /col 12 -->        
                        </div>
                        <!-- /row -->



                        <!-- row -->
                        <div class="row">
                            <!-- col 8 -->
                            <div class="col-lg-8 col-md-12">


                                <!-- tile -->
                                <section class="tile color transparent-black">




                                    <!-- tile header -->
                                    <div class="tile-header">
                                        <h1 style="margin-right: 20px;"><strong>NEW</strong> Requests</h1>
                                        <div class="search">
                                            <input type="search" class="light-table-filter" data-table="order-table" placeholder="Filter">
                                        </div>
                                        <div class="controls">
                                            <a href="#" class="minimize"><i class="fa fa-chevron-down"></i></a>
                                            <a href="#" class="refresh"><i class="fa fa-refresh"></i></a>
                                            <a href="#" class="remove"><i class="fa fa-times"></i></a>
                                        </div>
                                    </div>
                                    <!-- /tile header -->


                                    <!-- tile body -->
                                    <div class="tile-body no-vpadding">
                                        <div class="table-responsive">
                                            <table class="table table-custom1 table-sortable1 tablesorter order-table " id="myTable">
                                                <thead>
                                                    <tr>
                                                        <th class="sortable">DateTime</th>
                                                        <th class="sortable">Name</th>
                                                        <th class="sortable">No. Plate</th>
                                                        <th class="sortable">Services</th>
                                                        <!--<th class="sortable">Email</th>-->
                                                        <th class="sortable">Phone</th>
                                                        <th>Attachment</th>
                                                    </tr>
                                                </thead>
                                                <tbody id='tableBody'>
                                                    <!--Loop per new request-->
                                                    <%
                                                        Iterator it = qList.entrySet().iterator();
                                                        while (it.hasNext()) {
                                                            Map.Entry pair = (Map.Entry) it.next();
                                                            QuotationRequest qr = (QuotationRequest) pair.getValue();
                                                            int i = 1;
//                                                            Timestamp timeStamp = qr.getRequestedDate();
                                                            String dateTime = "01-01-1990 00:00:00";
                                                            Timestamp timeStamp = qr.getRequestedDate();
//                                                             String dateTime = "01-01-1990 00:00:00";
                                                            if (timeStamp != null) {
                                                                dateTime = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(timeStamp);
                                                            }
                                                            String serviceName = qr.getName();
                                                            if (serviceName.indexOf("-") > -1) {
                                                                serviceName = serviceName.substring(0, serviceName.indexOf("-"));
                                                            }
                                                            String address = qr.getAddress();
                                                            String serviceAmenities = qr.getAmenities();
                                                            String serviceDescription = qr.getDescription();
                                                            String serviceDetails = qr.getDetails();
                                                            int serviceId = qr.getId();
                                                            String serviceMileage = qr.getMileage();
                                                            String carPhoto = qr.getPhotos();
                                                            int serviceStatus = qr.getOffer().getStatus();
                                                            String serviceUrgency = qr.getUrgency();

                                                            Customer cust = qr.getCustomer();
                                                            String custName = cust.getName();
                                                            String custEmail = cust.getEmail();
                                                            String custPhone = cust.getHandphone();

                                                            Vehicle vehicle = qr.getVehicle();
                                                            String carPlate = vehicle.getPlateNumber();
                                                            String carModel = vehicle.getModel();
                                                            String carMake = vehicle.getMake();
                                                            int carYear = vehicle.getYear();
                                                            String carColor = vehicle.getColour();
                                                            String carControl = vehicle.getControl();

                                                    %>
                                                    <tr>
                                                        <td><% out.print(dateTime);%></td>
                                                        <td><% out.print(custName);%></td>
                                                        <td><% out.print(carPlate);%></td>
                                                        <td><% out.print(serviceName);%></td>
                                                        <!--<td><% out.print(custEmail);%></td>-->
                                                        <td><% out.print(custPhone);%></td>
                                                        <!--Picture Attachment-->
                                                        <td class="text-center"><a href="<% out.print("#myModal" + i);%>" id="myBtn" data-toggle="modal"><img src="images/file.png"/></a></td>

                                                        <!-- Modal -->
                                                <div class="modal fade" id="<% out.print("myModal" + i);%>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog-img">
                                                        <div class="modal-content">
                                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                                            <div class="modal-header">
                                                                <h4 class="modal-title"><% out.print(carMake + " " + carModel + " - " + carYear);%></h4>
                                                            </div>
                                                            <div class="modal-body">
                                                                <img class="img-responsive"src="<%="http://119.81.43.85/uploads/" + carPhoto%>"/>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                                <!--<button type="button" class="btn btn-primary">Save changes</button>-->
                                                            </div>
                                                        </div> <!--/.modal-content--> 
                                                    </div><!-- /.modal-dialog -->
                                                </div><!-- /.modal -->

                                                </tr>

                                                <%
                                                        i++;
                                                    }
                                                %>

                                                </tbody>

                                            </table>
                                        </div>

                                    </div>


                                    <!-- /tile body -->


                                    <!-- tile footer -->
                                    <div class="tile-footer text-center">
                                        <ul class="pagination pagination-sm nomargin pagination-custom pager" id='myPager'>
                                            <!--                                            <li class="disabled"><a href="#"><i class="fa fa-angle-double-left"></i></a></li>
                                                                                        <li class="active"><a href="#">1</a></li>
                                                                                        <li><a href="#">2</a></li>
                                                                                        <li><a href="#">3</a></li>
                                                                                        <li><a href="#">4</a></li>
                                                                                        <li><a href="#">5</a></li>
                                                                                        <li><a href="#"><i class="fa fa-angle-double-right"></i></a></li>-->
                                        </ul>
                                    </div>
                                    <!-- /tile footer -->



                                </section>
                                <!-- /tile -->
                            </div>
                            <!-- /col 8 -->

                            <div class="col-md-4">
                                <div class="main vertical-mail"> 
                                    <%
                                        //Instantiate FetchEmailDAO object to fetch emails into Message array
                                        FetchEmailDAO email = new FetchEmailDAO();
                                        Message[] emailArr = email.fetchEmail();
                                    %>                                
                                    <!-- temporary Inbox Header -->
                                    <ul class="inbox">
                                        <li class="heading"><h3>Emails</h3></li>
                                    </ul>
                                    <!-- /temporary Inbox Header -->

                                    <ul class="inbox" id="mail-inbox">
                                        <%
                                            int msgCounter = 1;
                                            String id = "msg" + msgCounter;
                                        %>

                                        <%
                                            //for loop to iterate through all emails except last email.
                                            for (int i = msgCounter - 1; i < emailArr.length; i++) {

                                        %>
                                        <li class="msg">
                                            <div class="checkbox check-transparent">
                                                <input type="checkbox" value="1" checked id="<%=id%>">
                                            </div>

                                            <div>
                                                <h5><strong>From: <% Address[] senderArr0 = emailArr[i].getFrom();
                                                    for (Address a : senderArr0) {
                                                        out.print(a.toString());
                                                    }%></strong></h5>
                                                <h5><strong>Subject:</strong> <%out.print(emailArr[i].getSubject()); %></h5>
                                                <span class="delivery-time"><%out.print(emailArr[i].getSentDate()); %></span>
                                                <div class="mail-attachment"><i class="fa fa-paperclip"></i></div>
                                                <div class="mail-label bg-red"></div>
                                                <div class="mail-actions">
                                                    <a href="#" class="reply"><i class="fa fa-reply"></i></a> 
                                                    <a href="#" class="delete"><i class="fa fa-trash-o"></i></a>
                                                </div>
                                            </div>
                                        </li>
                                        <%
                                                //increment counter for email message counter.
                                                msgCounter++;
                                                //close for loop for email
                                            }
                                        %>


                                        <%-- Last email 
                                        <li class="msg last">
                                            <div class="checkbox check-transparent">
                                                <input type="checkbox" id="<%=id %>">
                                                <label for="<%=id %>"></label>
                                            </div>

                                            <div>
                                                <h5><strong>From: <% Address[] senderArr2 = emailArr[emailArr.length - 1].getFrom();
                                                    for (Address a : senderArr2) {
                                                        out.print(a.toString());
                                                    }%></strong></h5>
                                                <h5><strong>Subject:</strong> <%out.print(emailArr[emailArr.length - 1].getSubject()); %>;</h5>
                                                <span class="delivery-time"><%out.print(emailArr[emailArr.length - 1].getSentDate());%></span>
                                                <div class="mail-label bg-greensea"></div>
                                                <div class="mail-actions">
                                                    <a href="#" class="reply"><i class="fa fa-reply"></i></a> 
                                                    <a href="#" class="delete"><i class="fa fa-trash-o"></i></a>
                                                </div>
                                            </div>
                                        </li>
                                        /Last email --%>

                                        <!-- /inbox list-->
                                    </ul>
                                    <div class="pagination pagination-sm nomargin pagination-custom pager" id='myPager1'>
                                        <%-- remove first.
                                        <span>1 of 3 of <%=emailArr.length%></span>
                                        <div class="btn-group btn-group-sm">
                                            <button type="button" class="btn btn-default"><i class="fa fa-angle-left"></i></button>
                                            <button type="button" class="btn btn-default"><i class="fa fa-angle-right"></i></button>
                                        </div>
                                        --%>
                                    </div>
                                </div>
                                <!-- /col-md-4 -->
                            </div>
                            <!-- /vertical-mail-->
                        </div>
                        <!-- /row -->

                    </div>

                </div>
            </div>

        </div>
        <!-- /wrap -->
    </div>
    <!-- /content container -->
</div>
<!-- Page content end -->




<jsp:include page="include/rightbar.jsp"/>






</div>
<!-- Make page fluid-->




</div>
<!-- Wrap all page content end -->



<section class="videocontent" id="video"></section>
</body>



<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://code.jquery.com/jquery.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="js/bootstrap.min.js"></script>
<script src="js/bootstrap-dropdown-multilevel.js"></script>
<script src="https://google-code-prettify.googlecode.com/svn/loader/run_prettify.js?lang=css&amp;skin=sons-of-obsidian"></script>
<script type="text/javascript" src="js/jquery.mmenu.min.js"></script>
<script type="text/javascript" src="js/jquery.sparkline.min.js"></script>
<script type="text/javascript" src="js/jquery.nicescroll.min.js"></script>
<script type="text/javascript" src="js/jquery.animateNumbers.js"></script>
<script type="text/javascript" src="js/jquery.videobackground.js"></script>
<script type="text/javascript" src="js/jquery.blockUI.js"></script>
<script type="text/javascript" src="js/jquery.bootpag.js"></script>

<script src="js/minimal.min.js"></script>

<script type="text/javascript" src="js/jquery.tablesorter.js"></script> 

<script>
    //Mail favourite star.
    $(function () {
        $('#mail-inbox .mail-favourite').click(function () {
            $(this).toggleClass('active');
        });
    })
</script>

<script>
    $(document).ready(function () {
        $('#myTable').tablesorter();
    });
</script>
<script>
    $(function () {
        // Initialize card flip
        $('.card.hover').hover(function () {
            $(this).addClass('flip');
        }, function () {
            $(this).removeClass('flip');
        });

        // sortable table
//            $('.table.table-sortable th.sortable').click(function () {
//                var o = $(this).hasClass('sort-asc') ? 'sort-desc' : 'sort-asc';
//                $('th.sortable').removeClass('sort-asc').removeClass('sort-desc');
//                $(this).addClass(o);
//            });

        //todo's
        $('#todolist li label').click(function () {
            $(this).toggleClass('done');
        });


    });

    $(function () {

        var contentHeight = $('#content').height();
        var chatInboxHeight = contentHeight - 178;
        var chatContentHeight = contentHeight - 178 - 200;

        var setChatHeight = function () {
            $('#chat-inbox').css('height', chatInboxHeight);
            $('#chat-content').css('height', chatContentHeight);
        };

        setChatHeight();

        $(window).resize(function () {
            contentHeight = $('#content').height();
            chatInboxHeight = contentHeight - 178;
            chatContentHeight = contentHeight - 178 - 200;

            setChatHeight();
        });

        $("#chat-inbox").niceScroll({
            cursorcolor: '#000000',
            zindex: 999999,
            bouncescroll: true,
            cursoropacitymax: 0.4,
            cursorborder: '',
            cursorborderradius: 0,
            cursorwidth: '5px'
        });

        $("#chat-content").niceScroll({
            cursorcolor: '#000000',
            zindex: 999999,
            bouncescroll: true,
            cursoropacitymax: 0.4,
            cursorborder: '',
            cursorborderradius: 0,
            cursorwidth: '5px'
        });

        $('#chat-inbox .chat-actions > span').tooltip({
            placement: 'top',
            trigger: 'hover',
            html: true,
            container: 'body'
        });

        $('#initialize-search').click(function () {
            $('#chat-search').toggleClass('active').focus();
        });

        $(document).click(function (e) {
            if (($(e.target).closest("#initialize-search").attr("id") != "initialize-search") && $(e.target).closest("#chat-search").attr("id") != "chat-search") {
                $('#chat-search').removeClass('active');
            }
        });

        $(window).mouseover(function () {
            $("#chat-inbox").getNiceScroll().resize();
            $("#chat-content").getNiceScroll().resize();
        });

    });


</script>
<script>
    (function (document) {
        'use strict';

        var LightTableFilter = (function (Arr) {

            var _input;

            function _onInputEvent(e) {
                _input = e.target;
                var tables = document.getElementsByClassName(_input.getAttribute('data-table'));
                Arr.forEach.call(tables, function (table) {
                    Arr.forEach.call(table.tBodies, function (tbody) {
                        Arr.forEach.call(tbody.rows, _filter);
                    });
                });
            }

            function _filter(row) {
                var text = row.textContent.toLowerCase(), val = _input.value.toLowerCase();
                row.style.display = text.indexOf(val) === -1 ? 'none' : 'table-row';
            }

            return {
                init: function () {
                    var inputs = document.getElementsByClassName('light-table-filter');
                    Arr.forEach.call(inputs, function (input) {
                        input.oninput = _onInputEvent;
                    });
                }
            };
        })(Array.prototype);

        document.addEventListener('readystatechange', function () {
            if (document.readyState === 'complete') {
                LightTableFilter.init();
            }
        });

    })(document);
</script>
<script>
    $.fn.pageMe = function (opts) {
        var $this = this,
                defaults = {
                    perPage: 5,
                    showPrevNext: false,
                    hidePageNumbers: false
                },
        settings = $.extend(defaults, opts);

        var listElement = $this;
        var perPage = settings.perPage;
        var children = listElement.children();
        var pager = $('.pager');

        if (typeof settings.childSelector != "undefined") {
            children = listElement.find(settings.childSelector);
        }

        if (typeof settings.pagerSelector != "undefined") {
            pager = $(settings.pagerSelector);
        }

        var numItems = children.size();
        var numPages = Math.ceil(numItems / perPage);

        pager.data("curr", 0);

        if (settings.showPrevNext) {
            $('<li><a href="#" class="prev_link">«</a></li>').appendTo(pager);
        }

        var curr = 0;
        while (numPages > curr && (settings.hidePageNumbers == false)) {
            $('<li><a href="#" class="page_link">' + (curr + 1) + '</a></li>').appendTo(pager);
            curr++;
        }

        if (settings.showPrevNext) {
            $('<li><a href="#" class="next_link">»</a></li>').appendTo(pager);
        }

        pager.find('.page_link:first').addClass('active');
        pager.find('.prev_link').hide();
        if (numPages <= 1) {
            pager.find('.next_link').hide();
        }
        pager.children().eq(1).addClass("active");

        children.hide();
        children.slice(0, perPage).show();

        pager.find('li .page_link').click(function () {
            var clickedPage = $(this).html().valueOf() - 1;
            goTo(clickedPage, perPage);
            return false;
        });
        pager.find('li .prev_link').click(function () {
            previous();
            return false;
        });
        pager.find('li .next_link').click(function () {
            next();
            return false;
        });

        function previous() {
            var goToPage = parseInt(pager.data("curr")) - 1;
            goTo(goToPage);
        }

        function next() {
            goToPage = parseInt(pager.data("curr")) + 1;
            goTo(goToPage);
        }

        function goTo(page) {
            var startAt = page * perPage,
                    endOn = startAt + perPage;

            children.css('display', 'none').slice(startAt, endOn).show();

            if (page >= 1) {
                pager.find('.prev_link').show();
            }
            else {
                pager.find('.prev_link').hide();
            }

            if (page < (numPages - 1)) {
                pager.find('.next_link').show();
            }
            else {
                pager.find('.next_link').hide();
            }

            pager.data("curr", page);
            pager.children().removeClass("active");
            pager.children().eq(page + 1).addClass("active");

        }
    };

    $(document).ready(function () {

        $('#tableBody').pageMe({pagerSelector: '#myPager', showPrevNext: true, hidePageNumbers: false, perPage: 4});

    });
</script>
<script>
    $.fn.pageMe = function (opts) {
        var $this = this,
                defaults = {
                    perPage: 5,
                    showPrevNext: false,
                    hidePageNumbers: false
                },
        settings = $.extend(defaults, opts);

        var listElement = $this;
        var perPage = settings.perPage;
        var children = listElement.children();
        var pager = $('.pager');

        if (typeof settings.childSelector != "undefined") {
            children = listElement.find(settings.childSelector);
        }

        if (typeof settings.pagerSelector != "undefined") {
            pager = $(settings.pagerSelector);
        }

        var numItems = children.size();
        var numPages = Math.ceil(numItems / perPage);

        pager.data("curr", 0);

        if (settings.showPrevNext) {
            $('<li><a href="#" class="prev_link">«</a></li>').appendTo(pager);
        }

        var curr = 0;
        while (numPages > curr && (settings.hidePageNumbers == false)) {
            $('<li><a href="#" class="page_link">' + (curr + 1) + '</a></li>').appendTo(pager);
            curr++;
        }

        if (settings.showPrevNext) {
            $('<li><a href="#" class="next_link">»</a></li>').appendTo(pager);
        }

        pager.find('.page_link:first').addClass('active');
        pager.find('.prev_link').hide();
        if (numPages <= 1) {
            pager.find('.next_link').hide();
        }
        pager.children().eq(1).addClass("active");

        children.hide();
        children.slice(0, perPage).show();

        pager.find('li .page_link').click(function () {
            var clickedPage = $(this).html().valueOf() - 1;
            goTo(clickedPage, perPage);
            return false;
        });
        pager.find('li .prev_link').click(function () {
            previous();
            return false;
        });
        pager.find('li .next_link').click(function () {
            next();
            return false;
        });

        function previous() {
            var goToPage = parseInt(pager.data("curr")) - 1;
            goTo(goToPage);
        }

        function next() {
            goToPage = parseInt(pager.data("curr")) + 1;
            goTo(goToPage);
        }

        function goTo(page) {
            var startAt = page * perPage,
                    endOn = startAt + perPage;

            children.css('display', 'none').slice(startAt, endOn).show();

            if (page >= 1) {
                pager.find('.prev_link').show();
            }
            else {
                pager.find('.prev_link').hide();
            }

            if (page < (numPages - 1)) {
                pager.find('.next_link').show();
            }
            else {
                pager.find('.next_link').hide();
            }

            pager.data("curr", page);
            pager.children().removeClass("active");
            pager.children().eq(page + 1).addClass("active");

        }
    };

    $(document).ready(function () {

        $('#mail-inbox').pageMe({pagerSelector: '#myPager1', showPrevNext: true, hidePageNumbers: false, perPage: 3});

    });
</script>
</html>