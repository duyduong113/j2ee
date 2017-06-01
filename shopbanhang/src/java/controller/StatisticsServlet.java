/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.StatisticsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author DUONG
 */
public class StatisticsServlet extends HttpServlet {

    StatisticsDAO statisticsDAO = new StatisticsDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        //query tab
        String command = "tab1";
        if (request.getParameter("command") != null) {
            command = request.getParameter("command");
        }
        //set tab selected
        request.setAttribute("command", command);
        switch (command) {
            case "tab1":
                request.setAttribute("listItem", statisticsDAO.ByProductCategory());
                break;
            case "tab2":
                break;
        }
        RequestDispatcher rd = getServletContext().getRequestDispatcher("/administrator/statistics.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
