<%-- 
    Document   : AdminSettings
    Created on : 3 Aug, 2016, 12:26:26 PM
    Author     : Joshymantou
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="entity.Workshop"%>
<%@page import="dao.WorkshopDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="ProtectAdmin.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Workshops</title>
        <jsp:include page="include/head.jsp"/>
        <link rel="stylesheet" href="js/dataTables.bootstrap.css">
        <link rel="stylesheet" href="js/ColVis.css">
        <link rel="stylesheet" href="js/TableTools.css">
    </head>
    <body class="bg-3">
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
                        <h2><i class="fa fa-file-o" style="line-height: 48px;padding-left: 2px;"></i>All Workshops</h2>

                    </div>
                    <!-- /page header -->
                    <%                        ArrayList<Workshop> allWorkshops = (ArrayList<Workshop>) request.getAttribute("workshops");
                        if (allWorkshops == null) {
                            WorkshopDAO wDAO = new WorkshopDAO();
                            allWorkshops = wDAO.retrieveAllWorkshops(user.getStaffId(), user.getToken());
                        }
                        if (allWorkshops.size() == 0) {
                            out.println("No workshop found. Try again.<br/>");
                        } else {
                        }
                    %>

                    <!-- content main container -->
                    <div class="main">
                        <div class="row">
                            <!-- col 12 -->
                            <div class="col-md-12">
                                <!-- tile -->
                                <section class="tile color transparent-black">


                                    <div class="tile-body color transparent-black rounded-corners">
                                        <div class="col-md-12 col-md-offset-10">
                                            <a href="AddWorkshop.jsp" class="btn btn-primary btn-sm" role="button">Add Workshop</a>
                                        </div>
                                        <div class="table-responsive">
                                            <table id="example" class="table table-custom1 table-sortable" cellspacing="0" width="100%">

                                                <thead>
                                                    <tr>
                                                        <th class="sortable">ID</th>
                                                        <th class="sortable">Name</th>
                                                        <th class="sortable">Address</th>
                                                        <th class="sortable">Postal Code</th>
                                                        <th>Opening Hours</th>
                                                        <th>Contact</th>
                                                        <th>Alt. Contact</th>
                                                        <th>Category</th>
                                                        <th>Edit/Remove</th>

                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        for (Workshop ws : allWorkshops) {
                                                            int idToDelete = ws.getId();
                                                            String name = ws.getName();
                                                            String wsAddress = ws.getAddress();
                                                            String address = wsAddress.substring(0, wsAddress.lastIndexOf(" "));
                                                            String postal = wsAddress.substring(wsAddress.lastIndexOf(" ") + 1);
                                                            String openingHr = ws.getOpeningHour();
                                                            String contact = ws.getContact();
                                                            String contact2 = ws.getContact2();
                                                            String category = ws.getCategory();
                                                    %>
                                                    <tr>
                                                        <td><%=idToDelete%></td>
                                                        <td><%=name%></td>
                                                        <td><%=address%></td>
                                                        <td><%=postal%></td>
                                                        <td>

                                                            <%
                                                                ArrayList<String> compiled = new ArrayList<String>();
                                                                //Monday-0900-1800
                                                                String[] daysAndTime = openingHr.split(",");
                                                                //openCloseTimings[0] = Monday, openCloseTimings[1] = 0900, openCloseTimings[2] = 1800
                                                                String[] openCloseTimings = daysAndTime[0].split("-");
                                                                String dayToCompare = openCloseTimings[0];
                                                                String openToCompare = openCloseTimings[1];
                                                                String closeToCompare = openCloseTimings[2];
                                                                String toAdd = dayToCompare + "-" + dayToCompare + "-" + openToCompare + "-" + closeToCompare;

                                                                for (int i = 1; i < daysAndTime.length - 2; i++) {
                                                                    openCloseTimings = daysAndTime[i].split("-");
                                                                    if (openCloseTimings[1].equals(openToCompare) && openCloseTimings[2].equals(closeToCompare)) {
                                                                        String[] toAddArr = toAdd.split("-");
                                                                        toAdd = toAddArr[0] + "-" + openCloseTimings[0] + "-" + openToCompare + "-" + closeToCompare;
                                                                    } else {
                                                                        String[] toAddArr = toAdd.split("-");
                                                                        //Closed-Closed
                                                                        if (toAddArr[2].equals("Closed")) {
                                                                            //Saturday-Saturday
                                                                            if (toAddArr[0].equals(toAddArr[1])) {
                                                                                toAdd = toAddArr[0] + ": Closed";
                                                                            } else {
                                                                                toAdd = toAddArr[0] + " to " + toAddArr[1] + ": Closed";
                                                                            }
                                                                        } else //Saturday-Saturday
                                                                         if (toAddArr[0].equals(toAddArr[1])) {
                                                                                toAdd = toAddArr[0] + ": " + toAddArr[2] + " - " + toAddArr[3];
                                                                            } else {
                                                                                toAdd = toAddArr[0] + " to " + toAddArr[1] + ": " + toAddArr[2] + " - " + toAddArr[3];
                                                                            }
                                                                        compiled.add(toAdd);
                                                                        dayToCompare = openCloseTimings[0];
                                                                        openToCompare = openCloseTimings[1];
                                                                        closeToCompare = openCloseTimings[2];
                                                                        toAdd = dayToCompare + "-" + dayToCompare + "-" + openToCompare + "-" + closeToCompare;
                                                                    }

                                                                    if (i == daysAndTime.length - 3) {
                                                                        String[] toAddArr = toAdd.split("-");
                                                                        //Closed-Closed
                                                                        if (toAddArr[2].equals("Closed")) {
                                                                            //Saturday-Saturday
                                                                            if (toAddArr[0].equals(toAddArr[1])) {
                                                                                toAdd = toAddArr[0] + ": Closed";
                                                                            } else {
                                                                                toAdd = toAddArr[0] + " to " + toAddArr[1] + ": Closed";
                                                                            }
                                                                        } else //Saturday-Saturday
                                                                         if (toAddArr[0].equals(toAddArr[1])) {
                                                                                toAdd = toAddArr[0] + ": " + toAddArr[2] + " - " + toAddArr[3];
                                                                            } else {
                                                                                toAdd = toAddArr[0] + " to " + toAddArr[1] + ": " + toAddArr[2] + " - " + toAddArr[3];
                                                                            }
                                                                        compiled.add(toAdd);
                                                                    }
                                                                }

                                                                for (int i = 7; i < 9; i++) {
                                                                    openCloseTimings = daysAndTime[i].split("-");
                                                                    //Closed-Closed
                                                                    if (openCloseTimings[2].equals("Closed")) {
                                                                        toAdd = openCloseTimings[0] + ": Closed";
                                                                    } else {
                                                                        toAdd = openCloseTimings[0] +  ": " + openCloseTimings[1] + " - " + openCloseTimings[2];
                                                                    }
                                                                    compiled.add(toAdd);
                                                                }
                                                                for (String x : compiled) {
                                                                    out.println(x + "<br/>");
                                                                }
                                                            %>

                                                        </td>
                                                        <td><%=contact%></td>
                                                        <td><%=contact2%></td>
                                                        <td>
                                                            <%
                                                                String[] categoryArr = category.split(",");
                                                                for (String s: categoryArr) {
                                                                    out.println(s + "<br/>");
                                                                }
                                                            %>
                                                        </td>
                                                        <td>
                                                            <a href="EditWorkshop.jsp?id=<%=idToDelete%>" class="btn btn-primary btn-xs" role="button">Edit</a>
                                                            <form class="form-horizontal" role="form" action="DeleteWorkshop" method="POST">
                                                                <button type="submit" name="idToDelete" value="<%=idToDelete%>" class="btn btn-primary btn-xs">Delete</button>
                                                            </form> 
                                                        </td>
                                                    </tr>

                                                    <%
                                                        }
                                                    %>
                                                </tbody>
                                            </table>
                                        </div>   
                                        <!--end table responsive-->
                                    </div>
                                    <!--end tile body-->
                                </section>
                                <!--end section-->
                            </div>
                            <!--end col 12-->
                        </div>
                        <!--end row-->
                    </div>
                    <!--end main-->

                </div>
                <!-- End Page content -->
            </div>
            <!--End page fluid-->
        </div>
        <!--End page wrap-->
        <%-- scripts --%>
        <jsp:include page="include/scripts.jsp"/>

        <script src="assets/js/vendor/chosen/chosen.jquery.min.js"></script>
        <script>
            $(function () {

                // Add custom class to pagination div
                $.fn.dataTableExt.oStdClasses.sPaging = 'dataTables_paginate paging_bootstrap paging_custom';

                $('div.dataTables_filter input').addClass('form-control');
                $('div.dataTables_length select').addClass('form-control');

                /*************************************************/
                /**************** BASIC DATATABLE ****************/
                /*************************************************/

                /* Define two custom functions (asc and desc) for string sorting */
                jQuery.fn.dataTableExt.oSort['string-case-asc'] = function (x, y) {
                    return ((x < y) ? -1 : ((x > y) ? 1 : 0));
                };

                jQuery.fn.dataTableExt.oSort['string-case-desc'] = function (x, y) {
                    return ((x < y) ? 1 : ((x > y) ? -1 : 0));
                };

                /* Add a click handler to the rows - this could be used as a callback */
                $("#basicDataTable tbody tr").click(function (e) {
                    if ($(this).hasClass('row_selected')) {
                        $(this).removeClass('row_selected');
                    } else {
                        oTable01.$('tr.row_selected').removeClass('row_selected');
                        $(this).addClass('row_selected');
                    }

                    // FadeIn/Out delete rows button
                    if ($('#basicDataTable tr.row_selected').length > 0) {
                        $('#deleteRow').stop().fadeIn(300);
                    } else {
                        $('#deleteRow').stop().fadeOut(300);
                    }
                });

                /* Build the DataTable with third column using our custom sort functions */
                var oTable01 = $('#basicDataTable').dataTable({
                    "sDom":
                            "R<'row'<'col-md-6'l><'col-md-6'f>r>" +
                            "t" +
                            "<'row'<'col-md-4 sm-center'i><'col-md-4'><'col-md-4 text-right sm-center'p>>",
                    "oLanguage": {
                        "sSearch": ""
                    },
                    "aaSorting": [[0, 'asc'], [1, 'asc']],
                    "aoColumns": [
                        null,
                        null,
                        {"sType": 'string-case'},
                        null,
                        null
                    ],
                    "fnInitComplete": function (oSettings, json) {
                        $('.dataTables_filter input').attr("placeholder", "Search");
                    }
                });

                // Append delete button to table
                var deleteRowLink = '<a href="#" id="deleteRow" class="btn btn-red btn-xs delete-row">Delete selected row</a>'
                $('#basicDataTable_wrapper').append(deleteRowLink);

                /* Add a click handler for the delete row */
                $('#deleteRow').click(function () {
                    var anSelected = fnGetSelected(oTable01);
                    if (anSelected.length !== 0) {
                        oTable01.fnDeleteRow(anSelected[0]);
                        $('#deleteRow').stop().fadeOut(300);
                    }
                });

                /* Get the rows which are currently selected */
                function fnGetSelected(oTable01Local) {
                    return oTable01Local.$('tr.row_selected');
                }
                ;

                /*******************************************************/
                /**************** INLINE EDIT DATATABLE ****************/
                /*******************************************************/

                function restoreRow(oTable02, nRow) {
                    var aData = oTable02.fnGetData(nRow);
                    var jqTds = $('>td', nRow);

                    for (var i = 0, iLen = jqTds.length; i < iLen; i++) {
                        oTable02.fnUpdate(aData[i], nRow, i, false);
                    }

                    oTable02.fnDraw();
                }
                ;

                function editRow(oTable02, nRow) {
                    var aData = oTable02.fnGetData(nRow);
                    var jqTds = $('>td', nRow);
                    jqTds[0].innerHTML = '<input type="text" value="' + aData[0] + '" class="form-control">';
                    jqTds[1].innerHTML = '<input type="text" value="' + aData[1] + '" class="form-control">';
                    jqTds[2].innerHTML = '<input type="text" value="' + aData[2] + '" class="form-control">';
                    jqTds[3].innerHTML = '<input type="text" value="' + aData[3] + '" class="form-control">';
                    jqTds[4].innerHTML = '<input type="text" value="' + aData[4] + '" class="form-control">';
                    jqTds[5].innerHTML = '<a class="edit save" href="#">Save</a><a class="delete" href="#">Delete</a>';
                }
                ;

                function saveRow(oTable02, nRow) {
                    var jqInputs = $('input', nRow);
                    oTable02.fnUpdate(jqInputs[0].value, nRow, 0, false);
                    oTable02.fnUpdate(jqInputs[1].value, nRow, 1, false);
                    oTable02.fnUpdate(jqInputs[2].value, nRow, 2, false);
                    oTable02.fnUpdate(jqInputs[3].value, nRow, 3, false);
                    oTable02.fnUpdate(jqInputs[4].value, nRow, 4, false);
                    oTable02.fnUpdate('<a class="edit" href="#">Edit</a><a class="delete" href="#">Delete</a>', nRow, 5, false);
                    oTable02.fnDraw();
                }
                ;




                var oTable02 = $('#inlineEditDataTable').dataTable({
                    "sDom":
                            "R<'row'<'col-md-6'l><'col-md-6'f>r>" +
                            "t" +
                            "<'row'<'col-md-4 sm-center'i><'col-md-4'><'col-md-4 text-right sm-center'p>>",
                    "oLanguage": {
                        "sSearch": ""
                    },
                    "aoColumnDefs": [
                        {'bSortable': false, 'aTargets': ["no-sort"]}
                    ],
                    "fnInitComplete": function (oSettings, json) {
                        $('.dataTables_filter input').attr("placeholder", "Search");
                    }
                });

                // Append add row button to table
                var addRowLink = '<a href="#" id="addRow" class="btn btn-green btn-xs add-row">Add row</a>'
                $('#inlineEditDataTable_wrapper').append(addRowLink);

                var nEditing = null;

                // Add row initialize
                $('#addRow').click(function (e) {
                    e.preventDefault();

                    // Only allow a new row when not currently editing
                    if (nEditing !== null) {
                        return;
                    }

                    var aiNew = oTable02.fnAddData(['', '', '', '', '', '<a class="edit" href="">Edit</a>', '<a class="delete" href="">Delete</a>']);
                    var nRow = oTable02.fnGetNodes(aiNew[0]);
                    editRow(oTable02, nRow);
                    nEditing = nRow;

                    $(nRow).find('td:last-child').addClass('actions text-center');
                });

                // Delete row initialize
                $(document).on("click", "#inlineEditDataTable a.delete", function (e) {
                    e.preventDefault();

                    var nRow = $(this).parents('tr')[0];
                    oTable02.fnDeleteRow(nRow);
                });

                // Edit row initialize
                $(document).on("click", "#inlineEditDataTable a.edit", function (e) {
                    e.preventDefault();

                    /* Get the row as a parent of the link that was clicked on */
                    var nRow = $(this).parents('tr')[0];

                    if (nEditing !== null && nEditing != nRow) {
                        /* A different row is being edited - the edit should be cancelled and this row edited */
                        restoreRow(oTable02, nEditing);
                        editRow(oTable02, nRow);
                        nEditing = nRow;
                    } else if (nEditing == nRow && this.innerHTML == "Save") {
                        /* This row is being edited and should be saved */
                        saveRow(oTable02, nEditing);
                        nEditing = null;
                    } else {
                        /* No row currently being edited */
                        editRow(oTable02, nRow);
                        nEditing = nRow;
                    }
                });

                /******************************************************/
                /**************** DRILL DOWN DATATABLE ****************/
                /******************************************************/

                var anOpen = [];

                var oTable03 = $('#drillDownDataTable').dataTable({
                    "sDom":
                            "R<'row'<'col-md-6'l><'col-md-6'f>r>" +
                            "t" +
                            "<'row'<'col-md-4 sm-center'i><'col-md-4'><'col-md-4 text-right sm-center'p>>",
                    "oLanguage": {
                        "sSearch": ""
                    },
                    "aoColumnDefs": [
                        {'bSortable': false, 'aTargets': ["no-sort"]}
                    ],
                    "aaSorting": [[1, "asc"]],
                    "bProcessing": true,
                    "sAjaxSource": "assets/js/vendor/datatables/ajax/sources/objects.txt",
                    "aoColumns": [
                        {
                            "mDataProp": null,
                            "sClass": "control text-center",
                            "sDefaultContent": '<a href="#"><i class="fa fa-plus"></i></a>'
                        },
                        {"mDataProp": "engine"},
                        {"mDataProp": "browser"},
                        {"mDataProp": "grade"}
                    ],
                    "fnInitComplete": function (oSettings, json) {
                        $('.dataTables_filter input').attr("placeholder", "Search");
                    }
                });

                $(document).on('click', '#drillDownDataTable td.control', function () {
                    var nTr = this.parentNode;
                    var i = $.inArray(nTr, anOpen);

                    $(anOpen).each(function () {
                        if (this !== nTr) {
                            $('td.control', this).click();
                        }
                    });

                    if (i === -1) {
                        $('i', this).removeClass().addClass('fa fa-minus');
                        $(this).parent().addClass('drilled');
                        var nDetailsRow = oTable03.fnOpen(nTr, fnFormatDetails(oTable03, nTr), 'details');
                        $('div.innerDetails', nDetailsRow).slideDown();
                        anOpen.push(nTr);
                    } else {
                        $('i', this).removeClass().addClass('fa fa-plus');
                        $(this).parent().removeClass('drilled');
                        $('div.innerDetails', $(nTr).next()[0]).slideUp(function () {
                            oTable03.fnClose(nTr);
                            anOpen.splice(i, 1);
                        });
                    }

                    return false;
                });

                function fnFormatDetails(oTable03, nTr) {
                    var oData = oTable03.fnGetData(nTr);
                    var sOut =
                            '<div class="innerDetails">' +
                            '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">' +
                            '<tr><td>Rendering engine:</td><td>' + oData.engine + '</td></tr>' +
                            '<tr><td>Browser:</td><td>' + oData.browser + '</td></tr>' +
                            '<tr><td>Platform:</td><td>' + oData.platform + '</td></tr>' +
                            '<tr><td>Version:</td><td>' + oData.version + '</td></tr>' +
                            '<tr><td>Grade:</td><td>' + oData.grade + '</td></tr>' +
                            '</table>' +
                            '</div>';
                    return sOut;
                }
                ;


                /****************************************************/
                /**************** ADVANCED DATATABLE ****************/
                /****************************************************/

                var oTable04 = $('#advancedDataTable').dataTable({
                    "sDom":
                            "<'row'<'col-md-4'l><'col-md-4 text-center sm-left'T C><'col-md-4'f>r>" +
                            "t" +
                            "<'row'<'col-md-4 sm-center'i><'col-md-4'><'col-md-4 text-right sm-center'p>>",
                    "oLanguage": {
                        "sSearch": ""
                    },
                    "oTableTools": {
                        "sSwfPath": "assets/js/vendor/datatables/tabletools/swf/copy_csv_xls_pdf.swf",
                        "aButtons": [
                            "copy",
                            "print",
                            {
                                "sExtends": "collection",
                                "sButtonText": 'Save <span class="caret" />',
                                "aButtons": ["csv", "xls", "pdf"]
                            }
                        ]
                    },
                    "fnInitComplete": function (oSettings, json) {
                        $('.dataTables_filter input').attr("placeholder", "Search");
                    },
                    "oColVis": {
                        "buttonText": '<i class="fa fa-eye"></i>'
                    }
                });

                $('.ColVis_MasterButton').on('click', function () {
                    var newtop = $('.ColVis_collection').position().top - 45;

                    $('.ColVis_collection').addClass('dropdown-menu');
                    $('.ColVis_collection>li>label').addClass('btn btn-default')
                    $('.ColVis_collection').css('top', newtop + 'px');
                });

                $('.DTTT_button_collection').on('click', function () {
                    var newtop = $('.DTTT_dropdown').position().top - 45;
                    $('.DTTT_dropdown').css('top', newtop + 'px');
                });

                //initialize chosen
                $('.dataTables_length select').chosen({disable_search_threshold: 10});

                // Add custom class
                $('div.dataTables_filter input').addClass('form-control');
                $('div.dataTables_length select').addClass('form-control');

            });

        </script>
    </body>
</html>