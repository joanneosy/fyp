<%-- 
    Document   : AddOffer
    Created on : Jul 5, 2016, 3:29:45 PM
    Author     : Joanne
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Offer</title>
    </head>
    <body>

        <h1>Add Offer</h1>

        <%
            String successMsg = (String) request.getAttribute("isSuccess");
            if (successMsg != null) {
                out.println(successMsg + "<br/>");
            }
            int quotationRequestId = Integer.parseInt(request.getParameter("id"));
        %>
        <form action = "AddInitialQuotation" method= "post">
            Min Price: <input type="number" name="minPrice" required/><br/>
            Max Price: <input type="number" name="maxPrice" required/><br/>
            Description: <input type="text" name="description" /><br/>
            <input type="hidden" name="id" value="<%=quotationRequestId%>"><br/>
            <input type="submit" value="Add Offer"><br/><br/>
        </form><br/>
    </body>
</html>
