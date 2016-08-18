<%-- 
    Document   : AddMasterAdmin
    Created on : Aug 1, 2016, 8:55:30 PM
    Author     : Joanne
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Master Admin</title>
    </head>
    <body>
         <%
            String errMsg = (String) request.getAttribute("errMsg");
            if (errMsg != null) {
                out.println(errMsg + "<br/>");
            }
        %>
        <form action = "AddMasterAdmin" method= "post">
            
            <h3>Add Master Admin</h3>
            Name: <input type="text" name="staffName" required/><br/> 
            Email: <input type="text" name="staffEmail" required/><br/> 
            Password: <input type="password" name="password" required/><br/>
            Confirm Password: <input type="password" name="confirmPassword" required/><br/>
            Handphone number: <input type="number" name="staffHpNo" required/><br/> 
            <input type="submit" value="Add Master Admin"><br/><br/>
            <a href="<%=(String) session.getAttribute("loggedInUserType")%>.jsp">Home</a>
        </form><br/>
    </body>
</html>
