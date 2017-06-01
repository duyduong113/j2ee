/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.StockInDAO;
import dao.UsersDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.StockIn;
import org.json.simple.JSONObject;

/**
 *
 * @author DUONG
 */
public class getStockInServlet extends HttpServlet {

    StockInDAO stockInDAO = new StockInDAO();
    UsersDAO usersDAO = new UsersDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setCharacterEncoding("utf-8");
            response.setCharacterEncoding("utf-8");
            DateFormat dateformat = new SimpleDateFormat("dd/MM/yyyy");
            String Code = "";
            if (request.getParameter("Code") != null) {
                Code = request.getParameter("Code");
            }
            StockIn stockIn = new StockIn();
            stockIn = stockInDAO.getStockInByCode(Code);
            JSONObject json = new JSONObject();
            JSONObject jstockIn;
            jstockIn = new JSONObject();
            jstockIn.put("ID", stockIn.getID());
            jstockIn.put("Code", stockIn.getCode());
            jstockIn.put("CreatedDate", stockIn.getCreatedDate() == null ? "" : dateformat.format(stockIn.getCreatedDate()).toString());
            jstockIn.put("CreatedBy", usersDAO.getUserByUserName(stockIn.getCreatedBy()).getName());
            jstockIn.put("ModifiedDate", stockIn.getModifiedDate() == null ? "" : dateformat.format(stockIn.getModifiedDate()).toString());
            jstockIn.put("ModifiedBy", usersDAO.getUserByUserName(stockIn.getModifiedBy()).getName());
            jstockIn.put("Note", stockIn.getNote());
            jstockIn.put("Status", stockIn.getStatus());
            json.put("stockin", jstockIn);
            response.setContentType("application/json");
            response.getWriter().write(json.toString());
        } catch (SQLException ex) {
            Logger.getLogger(getStockInServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
