/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import entity.Workshop;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.lucene.document.Document;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.TopDocs;
import org.apache.lucene.store.FSDirectory;
import util.Search;
import static util.Search.INDEX_DIRECTORY;

/**
 *
 * @author Joanne
 */
@WebServlet(name = "SearchWorkshopServlet", urlPatterns = {"/SearchWorkshop"})
public class SearchWorkshopServlet extends HttpServlet {

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
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String keyword = request.getParameter("search");
        Search search = new Search();
        int noOfColumns = search.createIndex("shops");
        TopDocs hits = search.search(keyword+"*", noOfColumns);
        IndexReader reader = IndexReader.open(FSDirectory.open(INDEX_DIRECTORY), true);
        IndexSearcher searcher = new IndexSearcher(reader);
        ArrayList<Workshop> workshops = new ArrayList<Workshop>();
        for (int i = 0; i < hits.totalHits; i++) {
            Document doc = searcher.doc(hits.scoreDocs[i].doc);//get the next  document
            System.out.println(doc.get("1") + " " + doc.get("2") + " " + doc.get("3"));
            Workshop ws = new Workshop(Integer.parseInt(doc.get("1")), doc.get("2"), doc.get("3"), doc.get("4"), doc.get("5"), doc.get("6"), doc.get("7"),
                    doc.get("8"), Double.parseDouble(doc.get("9")), Double.parseDouble(doc.get("10")), doc.get("11"), doc.get("12"), doc.get("13"), doc.get("14"), doc.get("15"), doc.get("16"),
                    doc.get("17"), Byte.parseByte(doc.get("18")));
            workshops.add(ws);
        }

        request.setAttribute("workshops", workshops);
        RequestDispatcher view = request.getRequestDispatcher("ViewWorkshop.jsp");
        view.forward(request, response);
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
        processRequest(request, response);
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
        processRequest(request, response);
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
