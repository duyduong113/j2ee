/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.CheckInventoryDAO;
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
import model.CheckInventory;
import org.json.simple.JSONObject;

/**
 *
 * @author DUONG
 */
public class getCheckInventoryServlet extends HttpServlet {
    
    CheckInventoryDAO checkInventoryDAO = new CheckInventoryDAO();
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
            request.setCharacterEncoding("utf-8");
            response.setCharacterEncoding("utf-8");
            DateFormat dateformat = new SimpleDateFormat("dd/MM/yyyy");
            String Code = "";
            if (request.getParameter("Code") != null) {
                Code = request.getParameter("Code");
            }
            CheckInventory checkInventory = new CheckInventory();
            checkInventory = checkInventoryDAO.getCheckInventoryByCode(Code);
            JSONObject json = new JSONObject();
            JSONObject jcheckinventory;
            jcheckinventory = new JSONObject();
            jcheckinventory.put("ID", checkInventory.getID());
            jcheckinventory.put("Code", checkInventory.getCode());
            jcheckinventory.put("Description", checkInventory.getDescription());
            jcheckinventory.put("CreatedDate", checkInventory.getCreatedDate() == null ? "" : dateformat.format(checkInventory.getCreatedDate()).toString());
            jcheckinventory.put("CreatedBy", usersDAO.getUserByUserName(checkInventory.getCreatedBy()).getName());
            jcheckinventory.put("ModifiedDate", checkInventory.getModifiedDate() == null ? "" : dateformat.format(checkInventory.getModifiedDate()).toString());
            jcheckinventory.put("ModifiedBy", usersDAO.getUserByUserName(checkInventory.getModifiedBy()).getName());
            jcheckinventory.put("Status", checkInventory.isStatus());
            json.put("checkinventory", jcheckinventory);
            response.setContentType("application/json");
            response.getWriter().write(json.toString());
        } catch (SQLException ex) {
            Logger.getLogger(getCheckInventoryServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
