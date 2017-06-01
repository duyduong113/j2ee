/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.UsersDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author DUONG
 */
public class CheckUserNameServlet extends HttpServlet {
    
    UsersDAO usersDAO = new UsersDAO();
  
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
    }

  
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        if (usersDAO.checkUserNameExist(request.getParameter("username"))) {
            response.getWriter().write("<img src=\"img/not-available.png\" title=\"Tên đăng nhập đã tồn tại!\" />");
        } else {
            response.getWriter().write("<img src=\"img/available.png\" title=\"Tên đăng nhập khả dụng!\" />");
        }
    }


}
