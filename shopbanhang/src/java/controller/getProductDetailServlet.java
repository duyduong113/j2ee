/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.ProductDetailDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.District;
import model.Product;
import model.ProductDetail;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author DUONG
 */
public class getProductDetailServlet extends HttpServlet {

    ProductDetailDAO productDetailDAO = new ProductDetailDAO();

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
            String Code = "";
            if (request.getParameter("Code") != null) {
                Code = request.getParameter("Code");
            }

            ArrayList<ProductDetail> lst = new ArrayList<>();
            lst = productDetailDAO.getListProductDetailByProduct(Code);

            JSONObject json = new JSONObject();
            JSONArray lstdetail = new JSONArray();
            JSONObject detail;

            for (int i = 0; i < lst.size(); i++) {
                detail = new JSONObject();
                detail.put("ID", lst.get(i).getID());
                detail.put("Name", lst.get(i).getName());
                detail.put("ProductCode", lst.get(i).getProductCode());
                detail.put("AttributeCode", lst.get(i).getAttributeCode());
                detail.put("Value", lst.get(i).getValue());
                lstdetail.add(detail);
            }

            json.put("lstdetail", lstdetail);
            response.setContentType("application/json");
            response.getWriter().write(json.toString());

        } catch (SQLException ex) {
            Logger.getLogger(getProductDetailServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
