/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import common.AllConstant;
import common.CodeAutoIncrease;
import dao.ProductWarehouseDAO;
import dao.StockInDAO;
import dao.StockInDetailDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.ProductWarehouse;
import model.StockIn;
import model.StockInDetail;
import model.Users;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author DUONG
 */
public class StockInServlet extends HttpServlet {

    StockInDAO stockInDAO = new StockInDAO();
    StockInDetailDAO stockInDetailDAO = new StockInDetailDAO();
    ProductWarehouseDAO productWarehouseDAO = new ProductWarehouseDAO();

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

        HttpSession session = request.getSession();
        Users usersCurrent = (Users) session.getAttribute("users");

        StockIn stockIn = new StockIn();
        StockInDetail stockInDetail = new StockInDetail();
        ArrayList<StockInDetail> listStockInDetail = new ArrayList<>();

        String command = "null";
        String url = "";
        String pages = "1";
        String keyword = "";
        if (request.getParameter("keyword") != null) {
            keyword = request.getParameter("keyword");
        }
        if (request.getParameter("pages") != null) {
            pages = request.getParameter("pages");
        }
        if (request.getParameter("command") != null) {
            command = request.getParameter("command");
        }

        if (command.equals("changestatus")) {
            String Code = "";
            int Status = 3;
            if (request.getParameter("Code") != null) {
                Code = request.getParameter("Code");
            }
            if (request.getParameter("Status") != null) {
                Status = Integer.parseInt(request.getParameter("Status"));
            }
            try {
                //update status
                stockIn.setModifiedDate(new Timestamp(new Date().getTime()));
                stockIn.setModifiedBy(usersCurrent.getUserName());// chèn người dùng hiện tại
                stockIn.setStatus(Status);
                stockIn.setCode(Code);
                stockInDAO.changeStatusStockIn(stockIn);
                // update product warehouse
                if (Status == 2) {
                    listStockInDetail = stockInDetailDAO.getListStockInDetailByStockInCode(Code);
                    for (StockInDetail stock : listStockInDetail) {
                        ProductWarehouse pw = productWarehouseDAO.getProductWarehouseByCode(stock.getProductCode());
                        //Update
                        ProductWarehouse productWarehouse = new ProductWarehouse();
                        productWarehouse.setStockOnhand(pw.getStockOnhand() + stock.getQuantity());
                        productWarehouse.setStockAvailable(pw.getStockAvailable() + stock.getQuantity());
                        productWarehouse.setModifiedDate(new Timestamp(new Date().getTime()));
                        productWarehouse.setModifiedBy(usersCurrent.getUserName());
                        productWarehouse.setProductCode(pw.getProductCode());
                        productWarehouseDAO.updateProductWarehouse(productWarehouse);
                    }
                }
                url = "/shopbanhang/administrator/stockin.jsp?keyword=" + keyword + "&pages=" + pages + "";
                response.sendRedirect(url);
            } catch (IOException e) {
            } catch (SQLException ex) {
                Logger.getLogger(StockInServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (command.equals("insertupdate")) {
            String ID = "", Code = "", Note = "";
            String ProductCode = "";
            String UnitCode = "";
            String Quantity = "0";
            //get data
            if (request.getParameter("ID") != null) {
                ID = request.getParameter("ID");
            }
            if (request.getParameter("Code") != null) {
                Code = request.getParameter("Code");
            }
            if (request.getParameter("Note") != null) {
                Note = request.getParameter("Note");
            }

            if (ID.length() == 0) {
                try {
                    //INSERT STOCKIN
                    Code = new CodeAutoIncrease().getCode(stockInDAO.getStockInTOP().getCode(), AllConstant.Prefix_StockIn);
                    stockIn.setCode(Code);
                    stockIn.setCreatedDate(new Timestamp(new Date().getTime()));
                    stockIn.setCreatedBy(usersCurrent.getUserName());
                    stockIn.setNote(Note);
                    stockIn.setStatus(1);
                    stockInDAO.insertStockIn(stockIn);
                } catch (Exception e) {
                }
            } else {
                try {
                    //UPDATE STOCKIN
                    stockIn.setModifiedDate(new Timestamp(new Date().getTime()));
                    stockIn.setModifiedBy(usersCurrent.getUserName());
                    stockIn.setNote(Note);
                    stockIn.setCode(Code);
                    stockInDAO.updateStockIn(stockIn);
                } catch (Exception e) {
                }
            }

            //INSERT UPDATE STOCKINDETAIL
            try {
                //Delete StockInDetail
                stockInDetailDAO.deleteStockInDetail(Code);
                //Insert Update
                JSONArray jsonArray = new JSONArray(request.getParameter("listStockInDetail"));
                for (int i = 0; i < jsonArray.length(); i++) {
                    JSONObject jObj = (JSONObject) jsonArray.get(i);
                    Iterator<String> it = jObj.keys(); //gets all the keys
                    ProductCode = "";
                    UnitCode = "";
                    Quantity = "0";
                    while (it.hasNext()) {
                        String key = (String) it.next(); // get key
                        switch (key) {
                            case "ProductCode":
                                ProductCode = (String) jObj.get(key);
                                break;
                            case "UnitCode":
                                UnitCode = (String) jObj.get(key);
                                break;
                            case "Quantity":
                                Quantity = (String) jObj.get(key);
                                break;
                            default:
                                break;
                        }
                    }
                    //Insert StockIn DETAIL
                    stockInDetail.setStockInCode(Code);
                    stockInDetail.setProductCode(ProductCode);
                    stockInDetail.setUnitCode(UnitCode);
                    stockInDetail.setQuantity(Integer.parseInt(Quantity));
                    stockInDetailDAO.insertStockInDetail(stockInDetail);
                }
                //set url
                if (ID.length() > 0) {
                    url = "/shopbanhang/administrator/stockin.jsp?keyword=" + keyword + "&pages=" + pages + "";
                } else {
                    url = "/shopbanhang/administrator/stockin.jsp";
                }
                response.setContentType("text/plain");
                response.getWriter().write(url);
            } catch (JSONException ex) {
            } catch (SQLException ex) {
                Logger.getLogger(StockInServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
}
