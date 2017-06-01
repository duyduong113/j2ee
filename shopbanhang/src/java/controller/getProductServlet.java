/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.ProductDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Product;
import org.json.simple.JSONObject;

/**
 *
 * @author DUONG
 */
public class getProductServlet extends HttpServlet {

    ProductDAO productDAO = new  ProductDAO();
    
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
            Product product = new Product();
            product = productDAO.getProductByCode(Code);
            DecimalFormat df = new DecimalFormat("#,###");

            JSONObject json = new JSONObject();
            JSONObject jproduct;
            jproduct = new JSONObject();
            jproduct.put("ID", product.getID());
            jproduct.put("Code", product.getCode());
            jproduct.put("Name", product.getName());
            jproduct.put("Price", df.format(product.getPrice()));
            jproduct.put("PromotionPrice", df.format(product.getPromotionPrice()));
            jproduct.put("Warranty", product.getWarranty());
            jproduct.put("CategoryID", product.getCategoryID());
            jproduct.put("Description", product.getDescription());
            jproduct.put("Image", product.getImage());
            jproduct.put("Status", product.isStatus());

            json.put("product", jproduct);
            response.setContentType("application/json");
            response.getWriter().write(json.toString());

        } catch (SQLException ex) {
            Logger.getLogger(getProductServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
