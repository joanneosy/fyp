<%-- 
    Document   : FetchEmailDAO
    Created on : 20 Jul, 2016, 11:31:51 PM
    Author     : Joshymantou
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <%
            
         
import java.util.*;
import javax.mail.*;

public class FetchingEmails {

    public static void main(String[] args) {
        Properties props = new Properties();
        props.setProperty("mail.store.protocol", "imaps");
        try {
            Session session = Session.getInstance(props, null);
            Store store = session.getStore();
            store.connect("imap.gmail.com", "fixxlar@gmail.com", "fixxlarfyp");
            Folder inbox = store.getFolder("INBOX");
            inbox.open(Folder.READ_ONLY);
            Message[] msgArr = inbox.getMessages();
            System.out.println(msgArr.length);
            for (int i = 0; i < msgArr.length; i++) {
                Message msg = msgArr[i];
                Address[] in = msg.getFrom();
                for (Address address : in) {
                    System.out.println("FROM:" + address.toString());
                }
                
                Multipart mp = (Multipart) msg.getContent();
                BodyPart bp = mp.getBodyPart(0);
                System.out.println("SENT DATE:" + msg.getSentDate());
                System.out.println("SUBJECT:" + msg.getSubject());
                System.out.println("CONTENT:" + bp.getContent());
            }
        } catch (Exception mex) {
            mex.printStackTrace();
        }
    }

}
   
         %>
    </body>
</html>
