package controller;

import dao.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SearchServlet extends HttpServlet {

    ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        String keyword = "";
        if (request.getParameter("keyword") != null) {
            keyword = request.getParameter("keyword");
        }
        String url = "";
        if (request.getParameter("url") != null) {
            url = request.getParameter("url");
        }
        try {
            if (url.length() > 0) {
                response.sendRedirect(url + "?keyword=" + keyword);
            } else {
                response.sendRedirect("/shopbanhang/search.jsp?keyword=" + keyword + "");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

}
