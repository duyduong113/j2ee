/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.ProductCategoryDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.ProductCategory;
import org.json.simple.JSONObject;

/**
 *
 * @author DUONG
 */
public class getProductCategoryServlet extends HttpServlet {

    ProductCategoryDAO productCategoryDAO = new ProductCategoryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        try {
            long categoryID = 0;
            if (request.getParameter("categoryID") != null) {
                categoryID = Long.parseLong(request.getParameter("categoryID"));
            }
            ProductCategory productCategory = new ProductCategory();
            productCategory = productCategoryDAO.getProductCategoryByID(categoryID);

            JSONObject json = new JSONObject();
            JSONObject category;
            category = new JSONObject();
            category.put("ID", productCategory.getID());
            category.put("Name", productCategory.getName());
            category.put("Image", productCategory.getImage());
            category.put("Status", productCategory.isStatus());
            
            json.put("category", category);
            response.setContentType("application/json");
            response.getWriter().write(json.toString());

        } catch (SQLException ex) {
            Logger.getLogger(getProductCategoryServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
