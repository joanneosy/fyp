<%-- 
    Document   : AddEstimatedCompletionTime
    Created on : Jul 18, 2016, 11:43:48 AM
    Author     : Joanne
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Estimated Completion Time</title>
    </head>
    <body>
        
        <h1>Add Estimated Completion Time</h1>
        <%
            String successMsg = (String) request.getAttribute("isSuccess");
            if (successMsg != null) {
                out.println(successMsg + "<br/>");
            }
            int quotationRequestId = Integer.parseInt(request.getParameter("id"));
        %>
        <form action = "AddEstimatedCompletionTime" method= "post">
            Estimated Completion Time: <input type="datetime-local" name="dateTime" required/><br/>
            <input type="hidden" name="id" value="<%=quotationRequestId%>"><br/>
            <input type="submit" value="Add Estimated Completion Time"><br/><br/>
        </form><br/>
    </body>
</html>
