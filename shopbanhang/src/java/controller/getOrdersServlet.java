/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.OrdersDAO;
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
import model.Orders;
import org.json.simple.JSONObject;

/**
 *
 * @author DUONG
 */
public class getOrdersServlet extends HttpServlet {

    OrdersDAO ordersDAO = new OrdersDAO();
    UsersDAO usersDAO = new UsersDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        try {
            String Code = "";
            if (request.getParameter("Code") != null) {
                Code = request.getParameter("Code");
            }
            Orders orders = new Orders();
            orders = ordersDAO.getOrderByCode(Code);
            DateFormat dateformat = new SimpleDateFormat("dd/MM/yyyy");

            JSONObject json = new JSONObject();
            JSONObject jorders;
            jorders = new JSONObject();
            jorders.put("ID", orders.getID());
            jorders.put("Code", orders.getCode());
            jorders.put("CustomerID", orders.getCustomerID());
            jorders.put("ShipName", orders.getShipName());
            jorders.put("ShipMobile", orders.getShipMobile());
            jorders.put("ShipAddress", orders.getShipAddress());
            jorders.put("ShipEmail", orders.getShipEmail());
            jorders.put("CreatedDate", orders.getCreatedDate() == null ? "" : dateformat.format(orders.getCreatedDate()).toString());
            jorders.put("CreatedBy", usersDAO.getUserByUserName(orders.getCreatedBy()).getName());
            jorders.put("ModifiedDate", orders.getModifiedDate() == null ? "" : dateformat.format(orders.getModifiedDate()).toString());
            jorders.put("ModifiedBy", usersDAO.getUserByUserName(orders.getModifiedBy()).getName());
            jorders.put("Status", orders.getStatus());

            json.put("orders", jorders);
            response.setContentType("application/json");
            response.getWriter().write(json.toString());

        } catch (SQLException ex) {
            Logger.getLogger(getOrdersServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
