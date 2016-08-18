/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dao.WebUserDAO;
import dao.WorkshopDAO;
import entity.WebUser;
import entity.Workshop;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Joanne
 */
@WebServlet(name = "EditWorkshopServlet", urlPatterns = {"/EditWorkshop"})
public class EditWorkshopServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        response.setContentType("text/html;charset=UTF-8");
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String postalCode = request.getParameter("postalCode");
        String email = request.getParameter("email");
        String[] specializeArr = request.getParameterValues("specialize");
        String description = request.getParameter("description");

        String website = request.getParameter("website");
        if (!website.contains("http://") && !website.contains("https://")) {
            website = "http://" + website;
        }

        String mondayOpen = request.getParameter("mondayOpen");
        String mondayClose = request.getParameter("mondayClose");
        String tuesdayOpen = request.getParameter("tuesdayOpen");
        String tuesdayClose = request.getParameter("tuesdayClose");
        String wednesdayOpen = request.getParameter("wednesdayOpen");
        String wednesdayClose = request.getParameter("wednesdayClose");
        String thursdayOpen = request.getParameter("thursdayOpen");
        String thursdayClose = request.getParameter("thursdayClose");
        String fridayOpen = request.getParameter("fridayOpen");
        String fridayClose = request.getParameter("fridayClose");
        String saturdayOpen = request.getParameter("saturdayOpen");
        String saturdayClose = request.getParameter("saturdayClose");
        String sundayOpen = request.getParameter("sundayOpen");
        String sundayClose = request.getParameter("sundayClose");
        String phOpen = request.getParameter("phOpen");
        String phClose = request.getParameter("phClose");
        String phEveOpen = request.getParameter("phEveOpen");
        String phEveClose = request.getParameter("phEveClose");

        String openingHour = "";
        openingHour = "Monday-" + mondayOpen + "-" + mondayClose + ","
                + "Tuesday-" + tuesdayOpen + "-" + tuesdayClose + ","
                + "Wednesday-" + wednesdayOpen + "-" + wednesdayClose + ","
                + "Thursday-" + thursdayOpen + "-" + thursdayClose + ","
                + "Friday-" + fridayOpen + "-" + fridayClose + ","
                + "Saturday-" + saturdayOpen + "-" + saturdayClose + ","
                + "Sunday-" + sundayOpen + "-" + sundayClose + ","
                + "Ph-" + phOpen + "-" + phClose + ","
                + "PhEve-" + phEveOpen + "-" + phEveClose;
        System.out.println(openingHour);
        String openingHourFormat = request.getParameter("openingHourFormat");
        double latitude = 0.0;
        double longitude = 0.0;
        String contact = request.getParameter("contact");
        String contact2 = request.getParameter("contact2");
        String location = request.getParameter("location");
        String brandsCarried = request.getParameter("brandsCarried");
        String[] categoryArr = request.getParameterValues("category");
        String remark = request.getParameter("remark");
        String statusStr = request.getParameter("isActive");
        int status = 1;
        if (statusStr == null) {
            status = 0;
        }
        String specialize = "";

        ArrayList<String> errMsg = new ArrayList<String>();

        if (specializeArr == null) {
            errMsg.add("No car brands selected.");
        } else {
            specialize = specializeArr[0];
            for (int i = 1; i < specializeArr.length; i++) {
                specialize += "," + specializeArr[i];
            }
        }

        String category = "";
        if (categoryArr == null) {
            errMsg.add("No category selected.");
        } else {
            category = categoryArr[0];
            for (int i = 1; i < categoryArr.length; i++) {
                category += "," + categoryArr[i];
            }
        }

        WorkshopDAO wDAO = new WorkshopDAO();
        String[] latLong = wDAO.retrieveLatLong("Singapore " + postalCode);
        if (latLong == null) {
            errMsg.add("Invalid address.");
        } else {
            latitude = Double.parseDouble(latLong[0]);
            longitude = Double.parseDouble(latLong[1]);
        }
        HttpSession session = request.getSession(true);
        String userType = (String) session.getAttribute("loggedInUserType");
        if (errMsg.size() == 0) {

            WebUser user = (WebUser) session.getAttribute("loggedInUser");

            int staffId = user.getStaffId();
            String token = user.getToken();
            ArrayList<String> addErrMsg = wDAO.updateWorkshop(id, email, name, description, website, address + " " + postalCode, openingHour, openingHourFormat,
                    latitude, longitude, contact, contact2, location, specialize, category, brandsCarried, remark, status, staffId, token);
            if (addErrMsg.size() == 0) {
                request.setAttribute("successMsg", "Workshop successfully edited!");
                RequestDispatcher view = request.getRequestDispatcher("ViewWorkshop.jsp");
                if (userType.equals("Workshop")) {
                    view = request.getRequestDispatcher("Profile.jsp");
                }
                view.forward(request, response);
            } else {
                request.setAttribute("errMsg", addErrMsg);
                if (userType.equals("Admin")) {
                    RequestDispatcher view = request.getRequestDispatcher("EditWorkshop.jsp?id=" + id);
                    view.forward(request, response);
                } else if (userType.equals("Workshop")) {
                    RequestDispatcher view = request.getRequestDispatcher("EditProfile.jsp");
                    view.forward(request, response);
                }

            }
        } else {
            request.setAttribute("errMsg", errMsg);
            if (userType.equals("Admin")) {
                RequestDispatcher view = request.getRequestDispatcher("EditWorkshop.jsp?id=" + id);
                view.forward(request, response);
            } else if (userType.equals("Workshop")) {
                RequestDispatcher view = request.getRequestDispatcher("EditProfile.jsp");
                view.forward(request, response);
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(EditWorkshopServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(EditWorkshopServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
