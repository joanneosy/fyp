<%-- 
    Document   : admin
    Created on : May 5, 2016, 10:00:22 AM
    Author     : joanne.ong.2014
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="ProtectAdmin.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Admin</h1>
        <%            String successChangePasswordMsg = (String) request.getAttribute("successChangePasswordMsg");
            if (successChangePasswordMsg != null) {
                out.println(successChangePasswordMsg + "<br/><br/>");
            }
        %>
        <a href = "ChangePassword.jsp">Change Password</a><br/><br/>
        <a href = "AddWorkshop.jsp">Add Workshop</a><br/><br/>
        <a href = "ViewWorkshop.jsp">View all Workshop</a><br/><br/>
        <a href="Logout.jsp">Logout</a>
        
    </body>
</html>
