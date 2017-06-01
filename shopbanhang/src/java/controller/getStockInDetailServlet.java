/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.StockInDetailDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.StockInDetail;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author DUONG
 */
public class getStockInDetailServlet extends HttpServlet {

    StockInDetailDAO stockInDetailDAO = new StockInDetailDAO();

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

            ArrayList<StockInDetail> lst = new ArrayList<>();
            lst = stockInDetailDAO.getListStockInDetailByStockInCode(Code);

            JSONObject json = new JSONObject();
            JSONArray lstdetail = new JSONArray();
            JSONObject detail;

            for (int i = 0; i < lst.size(); i++) {
                detail = new JSONObject();
                detail.put("ID", lst.get(i).getID());
                detail.put("StockInCode", lst.get(i).getStockInCode());
                detail.put("ProductCode", lst.get(i).getProductCode());
                detail.put("UnitCode", lst.get(i).getUnitCode());
                detail.put("Quantity", lst.get(i).getQuantity());
                detail.put("ProductName", lst.get(i).getProductName());
                detail.put("UnitName", lst.get(i).getUnitName());
                lstdetail.add(detail);
            }

            json.put("lstdetail", lstdetail);
            response.setContentType("application/json");
            response.getWriter().write(json.toString());

        } catch (SQLException ex) {
            Logger.getLogger(getStockInDetailServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
