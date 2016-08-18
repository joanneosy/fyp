<%-- 
    Document   : AddDiagnosticPrice
    Created on : Jul 18, 2016, 11:24:55 AM
    Author     : Joanne
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Diagnostic Price</title>
    </head>
    <body>
        
        <h1>Add Diagnostic Price</h1>
        <%
            String successMsg = (String) request.getAttribute("isSuccess");
            if (successMsg != null) {
                out.println(successMsg + "<br/>");
            }
            int quotationRequestId = Integer.parseInt(request.getParameter("id"));
        %>
        <form action = "AddDiagnosticPrice" method= "post">
            Price: <input type="number" name="price" required/><br/>
            Description: <input type="text" name="description" /><br/>
            <input type="hidden" name="id" value="<%=quotationRequestId%>"><br/>
            <input type="submit" value="Add Diagnostic Price"><br/><br/>
        </form><br/>
    </body>
</html>
