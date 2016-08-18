<%-- 
    Document   : AddFinalQuotation
    Created on : Jul 18, 2016, 11:26:49 AM
    Author     : Joanne
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Final Quotation</title>
    </head>
    <body>
        
        <h1>Add Final Quotation</h1>
        <%
            String successMsg = (String) request.getAttribute("isSuccess");
            if (successMsg != null) {
                out.println(successMsg + "<br/>");
            }
            int quotationRequestId = Integer.parseInt(request.getParameter("id"));
        %>
        <form action = "AddFinalQuotation" method= "post">
            Price: <input type="number" name="price" required/><br/>
            <input type="hidden" name="id" value="<%=quotationRequestId%>"><br/>
            <input type="submit" value="Add Final Quotation"><br/><br/>
        </form><br/>
    </body>
</html>
