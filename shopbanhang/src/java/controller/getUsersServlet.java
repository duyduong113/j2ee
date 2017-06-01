/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.UsersDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Product;
import model.Users;
import org.json.simple.JSONObject;

/**
 *
 * @author DUONG
 */
public class getUsersServlet extends HttpServlet {

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
            String ID = "";
            if (request.getParameter("ID") != null) {
                ID = request.getParameter("ID");
            }
            Users users = new Users();
            users = usersDAO.getUser(Long.parseLong(ID));

            JSONObject json = new JSONObject();
            JSONObject jusers;
            jusers = new JSONObject();
            jusers.put("ID", users.getID());
            jusers.put("UserName", users.getUserName());
            jusers.put("Password", users.getPassword());
            jusers.put("GroupID", users.getGroupID());
            jusers.put("Name", users.getName());
            jusers.put("Address", users.getAddress());
            jusers.put("Email", users.getEmail());
            jusers.put("Phone", users.getPhone());
            jusers.put("Image", users.getImage());
            jusers.put("ProvinceCode", users.getProvinceCode());
            jusers.put("DistrictCode", users.getDistrictCode());
            jusers.put("CreatedDate", users.getCreatedDate() == null ? "" : users.getCreatedDate().toString());
            jusers.put("CreatedBy", users.getCreatedBy());
            jusers.put("ModifiedDate", users.getModifiedDate() == null ? "" : users.getModifiedDate().toString());
            jusers.put("ModifiedBy", users.getModifiedBy());
            jusers.put("Status", users.isStatus());

            json.put("users", jusers);
            response.setContentType("application/json");
            response.getWriter().write(json.toString());

        } catch (SQLException ex) {
            Logger.getLogger(getUsersServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
