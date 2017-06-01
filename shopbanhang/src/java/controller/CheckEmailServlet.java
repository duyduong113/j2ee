/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.HelperDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author DUONG
 */
public class CheckEmailServlet extends HttpServlet {
   
    HelperDAO helperDAO = new HelperDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");

        if (helperDAO.isValidEmailAddress(request.getParameter("email"))) {
            response.getWriter().write("<img src=\"img/available.png\" title=\"Email hợp lệ!\" />");
        } else {
            response.getWriter().write("<img src=\"img/not-available.png\" title=\"Email không hợp lệ!\" />");
        }
    }
}
