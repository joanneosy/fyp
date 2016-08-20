<%-- 
    Document   : AdminSettings
    Created on : 3 Aug, 2016, 12:26:26 PM
    Author     : Joshymantou
--%>


<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashMap"%>
<%@page import="entity.WebUser"%>
<%@page import="entity.Workshop"%>
<%@page import="dao.WorkshopDAO"%>
<%@page import="dao.WebUserDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Employees</title>
        <jsp:include page="include/head.jsp"/>
    </head>
    <body class="bg-3">

        <%            WebUserDAO webUserDAO = new WebUserDAO();
            HashMap<Integer, WebUser> webUserMap = new HashMap<Integer, WebUser>();
            HashMap<Integer, WebUser> adminUserMap = new HashMap<Integer, WebUser>();
            
            WebUser user = (WebUser) session.getAttribute("loggedInUser");
            String userType = (String) session.getAttribute("loggedInUserType");
            int workshopStaffType = user.getStaffType();
            if (userType.equals("Admin")) {
                // Retrieve the master work shop staffs + Fixir staff
                int staffType = user.getStaffType();
                //only super user and master user can view admin and master staff
                if (staffType == 1 || staffType == 2) {
                    webUserMap = webUserDAO.retrieveAllMasterWorkshopStaff(user.getStaffId(), user.getToken());
                    adminUserMap = webUserDAO.retrieveAllAdmin(user.getStaffId(), user.getToken());
                } else {
                    //normal fixir admin can only view master worshop
                    webUserMap = webUserDAO.retrieveAllMasterWorkshopStaff(user.getStaffId(), user.getToken());
                }

            } else {//workshop 

                webUserMap = webUserDAO.retrieveNormalWorkshopStaff(user.getStaffId(), user.getToken(), user.getShopId());
            }
        %>
        <!-- Wrap all page content here -->
        <div id="wrap">
            <!-- Make page fluid -->
            <div class="row">
                <div class="mask"><div id="loader"></div></div>
                <!-- Page content -->
                <div id="content" class="col-md-12">
                    <%--<jsp:include page="include/topbar.jsp"/>--%>
                    <%@include file="include/topbar.jsp"%>
                    <!-- page header -->
                    <div class="pageheader">
                        <h2><i class="fa fa-file-o" style="line-height: 48px;padding-left: 2px;"></i> Employees</h2>
                        <!--<a href="AddWorshop.jsp" class="btn btn-primary btn-lg pull-right margin-top-15"  role="button">Submit</a>-->
                    </div>
                    <!-- /page header -->

                    <!-- content main container -->
                    <div class="main">
                        <div class="row">
                            <!-- col 12 -->
                            <div class="col-md-12">
                                <!-- tile -->
                                <section class="tile color transparent-black">

                                    <!-- tile header -->
                                    <div class="tile-header">
                                        <div class="col-md-12">
                                            <% if (workshopStaffType == 1) { %>
                                            <div class="col-md-offset-11">
                                                <!--<a href ="AddEmployee.jsp" type="button" class="btn btn-primary">Add Employee</a>-->
                                                <a href="AddEmployee.jsp" class="btn btn-primary btn-xs" role="button">Add Employee</a>
                                            </div>
                                            <% } %>
                                        </div>
                                    </div>
                                    <!-- /tile header -->

                                    <!-- tile body -->
                                    <div class="tile-body nopadding">

                                        <table class="table">
                                            <thead>
                                                <tr>
                                                    <th>Employee ID</th>
                                                    <th>Name</th>
                                                    <th>Email</th>
                                                    <th>Phone Number</th>
                                                    <th>Edit/Delete</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                   
                                                    Iterator it = webUserMap.entrySet().iterator();
                                                    //counter for delete id
                                                    int deleteCounter = 0;
                                                    while (it.hasNext()) {
                                                        Map.Entry pair = (Map.Entry) it.next();
                                                        WebUser staff = (WebUser) pair.getValue();
                                                        String email = staff.getEmail();
                                                        int idToDelete = staff.getStaffId();
                                                        String name = staff.getName();
                                                        String hp = staff.getHandphone();
                                                        

                                                %>
                                                <tr>
                                                    <td><%=idToDelete%></td>
                                                    <td><%=name%></td>
                                                    <td><%=email%></td>
                                                    <td><%=hp%></td>                                                
                                                    <!--<td id="01"> <a href="#" class="btn btn-p1rimary btn-xs" role="button">Delete</a></td>-->

                                                    <!--<td><button onclick="remove(staffId)" class="btn btn-primary btn-xs" role="button">Delete</button></td>-->
                                                    <td>
                                                        <% 
                                                        //check only master workshop can edit/delete staff
                                                        
                                                        if (user.getStaffId() != idToDelete && workshopStaffType == 1) {
                                                            //if (userType.equals("Admin")) { 
                                                        %>
                                                        
                                                        <form class="form-horizontal" role="form" action="DeleteEmployee" method="POST">
                                                            <a href="EditEmployee.jsp?id=<%=idToDelete%>" name="idToDelete" class="btn btn-xs btn-primary" role="button">Edit</a>
                                                            <button type="submit" name="idToDelete" value="<%=idToDelete%>" class="btn btn-primary btn-xs">Delete</button>
                                                        </form>
                                                        <% }  %>
                                                        
                                                    </td>
                                                    
                                                </tr>


                                                <%
                                                        deleteCounter++;
                                                    }

                                                    //print admin staff if webUser is admin
                                                    if (userType.equals("Admin")) {
                                                        Iterator it2 = adminUserMap.entrySet().iterator();
                                                        while (it2.hasNext()) {
                                                            Map.Entry pair = (Map.Entry) it2.next();
                                                            WebUser adminStaff = (WebUser) pair.getValue();
                                                            String email = adminStaff.getEmail();
                                                            int idToDelete = adminStaff.getStaffId();
                                                            String name = adminStaff.getName();
                                                            String hp = adminStaff.getHandphone();
                                                            
                                                            int currentStaffType = adminStaff.getStaffType();
                                                %>
                                                <tr>
                                                    <td><%=idToDelete%></td>
                                                    <td><%=name%></td>
                                                    <td><%=email%></td>
                                                    <td><%=hp%></td>
                                                    
                                                        <%
                                                        int staffType = user.getStaffType(); 
                                                        //super and master admin can edit/delete normal admin
                                                        if ((staffType == 1 || staffType == 2)&& currentStaffType ==3) {
                                                            
                                                        
                                                        %>
                                                    <td>
                                                        <form class="form-horizontal" role="form" action="DeleteEmployee" method="POST">
                                                            <a href="EditEmployee.jsp?id=<%=idToDelete%>" name="idToDelete" class="btn btn-xs btn-primary" role="button">Edit</a>
                                                            <button type="submit" name="idToDelete" value="<%=idToDelete%>" class="btn btn-primary btn-xs">Delete</button>
                                                        </form>
                                                    </td>
                                                        <% } else { %>
                                                    <td>
                                                        <button type="button" disabled class="btn btn-primaryb btn-xs">Edit</button>
                                                        <button type="button" disabled class="btn btn-primaryb btn-xs">Delete </button>
                                                    </td>
                                                </tr>
                                                <%
                                                        }
                                                    }
                                                }

                                                %>
                                            </tbody>
                                        </table>

                                    </div>
                                    <!-- /tile body -->
                                </section>
                                <!--end tile-->
                            </div>
                            <!--end col 12-->
                        </div>
                        <!--end row-->
                    </div>
                    <!--end main container-->
                </div>
                <!-- End Page content -->
            </div>
            <!--End page fluid-->
        </div>
        <!--End page wrap-->
        <%-- scripts --%>

        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="js/jquery.js"></script>
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

        <script src="js/summernote.min.js"></script>

        <script src="js/chosen.jquery.min.js"></script>

        <script src="js/moment-with-langs.min.js"></script>
        <script src="js/bootstrap-datetimepicker.js"></script>

        <script src="js/bootstrap-colorpicker.min.js"></script>

        <script src="js/bootstrap-colorpalette.js"></script>

        <script src="js/minimal.min.js"></script>


        <script>

            //initialize file upload button function
            $(document)
                    .on('change', '.btn-file :file', function () {
                        var input = $(this),
                                numFiles = input.get(0).files ? input.get(0).files.length : 1,
                                label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
                        input.trigger('fileselect', [numFiles, label]);
                    });


            $(function () {

                //load wysiwyg editor
                $('#input06').summernote({
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
                    ],
                    height: 137   //set editable area's height
                });

                //chosen select input
                $(".chosen-select").chosen({disable_search_threshold: 10});

                //initialize datepicker
                $('#datepicker').datetimepicker({
                    icons: {
                        time: "fa fa-clock-o",
                        date: "fa fa-calendar",
                        up: "fa fa-arrow-up",
                        down: "fa fa-arrow-down"
                    }
                });

                $("#datepicker").on("dp.show", function (e) {
                    var newtop = $('.bootstrap-datetimepicker-widget').position().top - 45;
                    $('.bootstrap-datetimepicker-widget').css('top', newtop + 'px');
                });

                //initialize colorpicker
                $('#colorpicker').colorpicker();

                $('#colorpicker').colorpicker().on('showPicker', function (e) {
                    var newtop = $('.dropdown-menu.colorpicker.colorpicker-visible').position().top - 45;
                    $('.dropdown-menu.colorpicker.colorpicker-visible').css('top', newtop + 'px');
                });

                //initialize colorpicker RGB
                $('#colorpicker-rgb').colorpicker({
                    format: 'rgb'
                });

                $('#colorpicker-rgb').colorpicker().on('showPicker', function (e) {
                    var newtop = $('.dropdown-menu.colorpicker.colorpicker-visible').position().top - 45;
                    $('.dropdown-menu.colorpicker.colorpicker-visible').css('top', newtop + 'px');
                });

                //initialize file upload button
                $('.btn-file :file').on('fileselect', function (event, numFiles, label) {

                    var input = $(this).parents('.input-group').find(':text'),
                            log = numFiles > 1 ? numFiles + ' files selected' : label;

                    console.log(log);

                    if (input.length) {
                        input.val(log);
                    } else {
                        if (log)
                            alert(log);
                    }

                });

                // Initialize colorpalette
                $('#event-colorpalette').colorPalette({
                    colors: [['#428bca', '#5cb85c', '#5bc0de', '#f0ad4e', '#d9534f', '#ff4a43', '#22beef', '#a2d200', '#ffc100', '#cd97eb', '#16a085', '#FF0066', '#A40778', '#1693A5']]
                }).on('selectColor', function (e) {
                    var data = $(this).data();

                    $(data.returnColor).val(e.color);
                    $(this).parents(".input-group").css("border-bottom-color", e.color);
                });

            })

            function remove(staffId) {
                $.post("url", function (data, status) {
                    alert(data + " " + status);
                });
            }

        </script>
    </body>
</html>