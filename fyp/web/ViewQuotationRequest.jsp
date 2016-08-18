<%-- 
    Document   : ViewRequest
    Created on : Jun 9, 2016, 3:12:40 PM
    Author     : Joanne
--%>

<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashMap"%>
<%@page import="entity.WebUser"%>
<%@page import="dao.CustomerDAO"%>
<%@page import="dao.VehicleDAO"%>
<%@page import="entity.Workshop"%>
<%@page import="dao.WorkshopDAO"%>
<%@page import="dao.QuotationRequestDAO"%>
<%@page import="entity.QuotationRequest"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>All Requests</title>
    </head>
    <body>
        <h1>All requests</h1>
        <%
            String successMsg = (String) request.getAttribute("isSuccess");
            if (successMsg != null) {
                out.println(successMsg + "<br/>");
            }
            
            WorkshopDAO wDAO = new WorkshopDAO();
            String userType = (String) session.getAttribute("loggedInUserType");
            WebUser user = (WebUser) session.getAttribute("loggedInUser");
            String token = user.getToken();
            int staffId = user.getStaffId();

            QuotationRequestDAO qrDAO = new QuotationRequestDAO();
            HashMap<Integer, QuotationRequest> allQuotationRequests = qrDAO.retrieveAllQuotationRequests(staffId, token, 0, 0, "requested_datetime", "desc");
        %>
        <table style="width:100%" border="1">
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Details</th>
                <th>Description</th>
                <th>Vehicle ID</th>
                <th>Mileage</th>
                <th>Urgency</th>
                <th>Amenities</th>
                <th>Address</th>
                <th>Photos</th>
                <th>Car Make</th>
                <th>Car Model</th>
                <th>Year of Manufacture</th>
                <th>Plate Number</th>
                <th>Date</th>
                <th>Status</th>
                <th>Workshop ID</th>
                <th>Change</th>
            </tr>

            <%
                Iterator it = allQuotationRequests.entrySet().iterator();
                while (it.hasNext()) {
                    Map.Entry pair = (Map.Entry) it.next();
                    QuotationRequest qr = (QuotationRequest) pair.getValue();
                    out.println("<tr>");
                    out.println("<td align=\"center\"> " + qr.getId() + "</td>");
                    out.println("<td>" + qr.getName() + "</td>");
                    out.println("<td>" + qr.getDetails() + "</td>");
                    out.println("<td>" + qr.getDescription() + "</td>");
                    out.println("<td>" + qr.getVehicle().getId() + "</td>");
                    out.println("<td>" + qr.getMileage() + "</td>");
                    out.println("<td>" + qr.getUrgency() + "</td>");
                    out.println("<td>" + qr.getAmenities() + "</td>");
                    out.println("<td>" + qr.getAddress() + "</td>");
                    out.println("<td>" + qr.getPhotos() + "</td>");
                    out.println("<td>" + qr.getVehicle().getMake() + "</td>");
                    out.println("<td>" + qr.getVehicle().getModel() + "</td>");
                    out.println("<td>" + qr.getVehicle().getYear() + "</td>");
                    out.println("<td>" + qr.getVehicle().getPlateNumber() + "</td>");
                    out.println("<td>" + qr.getRequestedDate() + "</td>");
                    int status = qr.getOffer().getStatus();
                    if (status == 1) {
                        out.println("<td>New</td>");
                    } else if (status == 2) {
                        out.println("<td>Waiting for response</td>");
                    } else if (status == 3) {
                        out.println("<td>Give final quotation</td>");
                    } else if (status == 4) {
                        out.println("<td>Waiting for final quotation acceptance</td>");
                    } else if (status == 5) {
                        out.println("<td>Quote given for non valet request</td>");
                    } else if (status == 6) {
                        out.println("<td>Final quotation accepted / Ongoing service</td>"); //what about giving estimated completion time / duration
                    } else if (status == 7) {
                        out.println("<td>Completed service</td>");
                    } else if (status == 8) {
                        out.println("<td>Offer declined</td>");
                    } else {
                        out.println("<td>Others</td>");
                    }
                    out.println("<td>" + qr.getWorkshopId() + "</td>");
                    if (userType.equals("Admin")) {
                        out.println("<td><a href = \"ViewOneQuotationRequest.jsp?id=" + qr.getId() + "\">View</a></td>");
                    } else if (userType.equals("Workshop") && status == 1) {
                        out.println("<td><a href = \"AddInitialQuotation.jsp?id=" + qr.getId() + "\">Give Quotation</a></td>");
                    } else if (userType.equals("Workshop") && (status == 2 || status == 4 || status == 5 || status == 6)) {
                        out.println("<td><a href = \"ViewOneQuotationRequest?&id=" + qr.getId() + "\">View</a></td>");
                    } else if (userType.equals("Workshop") && status == 3) {
                        out.println("<td><a href = \"AddFinalQuotation.jsp?&id=" + qr.getOffer().getId() + "\">View Details</a></td>");
                    } else if (userType.equals("Workshop") && status == 6) {
                        out.println("<td><a href = \"CompleteService?&id=" + qr.getOffer().getId() + "\">Complete Request</a></td>");
                    } else {
                        out.println("<td>Others</td>");
                    }
                    out.println("</tr>");
                }
            %>
        </table>
        <a href="<%=(String) session.getAttribute("loggedInUserType")%>.jsp">Home</a>
    </body>
</html>
