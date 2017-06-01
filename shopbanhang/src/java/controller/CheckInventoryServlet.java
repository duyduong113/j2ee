/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import common.AllConstant;
import common.CodeAutoIncrease;
import dao.CheckInventoryDAO;
import dao.CheckInventoryDetailDAO;
import dao.ProductWarehouseDAO;
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
import model.CheckInventory;
import model.CheckInventoryDetail;
import model.ProductWarehouse;
import model.Users;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author DUONG
 */
public class CheckInventoryServlet extends HttpServlet {

    CheckInventoryDAO checkInventoryDAO = new CheckInventoryDAO();
    CheckInventoryDetailDAO checkInventoryDetailDAO = new CheckInventoryDetailDAO();
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

        CheckInventory checkInventory = new CheckInventory();
        CheckInventoryDetail checkInventoryDetail = new CheckInventoryDetail();
        ArrayList<CheckInventoryDetail> listCheckInventoryDetail = new ArrayList<>();

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
            boolean Status = true;
            if (request.getParameter("Code") != null) {
                Code = request.getParameter("Code");
            }
            if (request.getParameter("Status") != null) {
                Status = Boolean.parseBoolean(request.getParameter("Status"));
            }
            try {
                //update status
                checkInventory.setModifiedDate(new Timestamp(new Date().getTime()));
                checkInventory.setModifiedBy(usersCurrent.getUserName());// chèn người dùng hiện tại
                checkInventory.setStatus(Status);
                checkInventory.setCode(Code);
                checkInventoryDAO.changeStatusCheckInventory(checkInventory);
                // update product warehouse
                listCheckInventoryDetail = checkInventoryDetailDAO.getListCheckInventoryDetailByStockInCode(Code);
                for (CheckInventoryDetail detail : listCheckInventoryDetail) {
                    ProductWarehouse pw = productWarehouseDAO.getProductWarehouseByCode(detail.getProductCode());
                    //Update ProductWarehouse
                    ProductWarehouse productWarehouse = new ProductWarehouse();
                    productWarehouse.setStockOnhand(detail.getQuantity());//updae
                    productWarehouse.setStockAvailable(pw.getStockAvailable() + (detail.getQuantity()- detail.getStockOnhand()));
                    productWarehouse.setModifiedDate(new Timestamp(new Date().getTime()));
                    productWarehouse.setModifiedBy(usersCurrent.getUserName());
                    productWarehouse.setProductCode(pw.getProductCode());
                    productWarehouseDAO.updateProductWarehouse(productWarehouse);
                }

                url = "/shopbanhang/administrator/checkinventory.jsp?keyword=" + keyword + "&pages=" + pages + "";
                response.sendRedirect(url);
            } catch (IOException e) {
            } catch (SQLException ex) {
                Logger.getLogger(CheckInventoryServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (command.equals("insertupdate")) {
            String ID = "", Code = "", Description = "";
            String ProductCode = "";
            String Quantity = "0";
  
            //get data
            if (request.getParameter("ID") != null) {
                ID = request.getParameter("ID");
            }
            if (request.getParameter("Code") != null) {
                Code = request.getParameter("Code");
            }
            if (request.getParameter("Description") != null) {
                Description = request.getParameter("Description");
            }

            if (ID.length() == 0) {
                try {
                    //INSERT CheckInventory
                    Code = new CodeAutoIncrease().getCode(checkInventoryDAO.getTOPCheckInventory().getCode(), AllConstant.Prefix_CheckInventory);
                    checkInventory.setCode(Code);
                    checkInventory.setDescription(Description);
                    checkInventory.setCreatedDate(new Timestamp(new Date().getTime()));
                    checkInventory.setCreatedBy(usersCurrent.getUserName());
                    checkInventory.setStatus(false);
                    checkInventoryDAO.insertCheckInventory(checkInventory);
                } catch (Exception e) {
                }
            } else {
                try {
                    //UPDATE CheckInventory
                    checkInventory.setModifiedDate(new Timestamp(new Date().getTime()));
                    checkInventory.setModifiedBy(usersCurrent.getUserName());
                    checkInventory.setDescription(Description);
                    checkInventory.setCode(Code);
                    checkInventoryDAO.updateCheckInventory(checkInventory);
                } catch (Exception e) {
                }
            }

            //INSERT UPDATE STOCKINDETAIL
            try {
                //Delete StockInDetail
                checkInventoryDetailDAO.deleteCheckInventoryDetail(Code);
                //Insert Update
                JSONArray jsonArray = new JSONArray(request.getParameter("listCheckInventoryDetail"));
                for (int i = 0; i < jsonArray.length(); i++) {
                    JSONObject jObj = (JSONObject) jsonArray.get(i);
                    Iterator<String> it = jObj.keys(); //gets all the keys
                    ProductCode = "";
                    Quantity = "0";
                  
                    while (it.hasNext()) {
                        String key = (String) it.next(); // get key
                        switch (key) {
                            case "ProductCode":
                                ProductCode = (String) jObj.get(key);
                                break;
                            case "Quantity":
                                Quantity = (String) jObj.get(key);
                                break;
                            default:
                                break;
                        }
                    }
                    //Insert CheckInventoryDetail 
                    checkInventoryDetail.setCheckInventoryCode(Code);
                    checkInventoryDetail.setProductCode(ProductCode);
                    checkInventoryDetail.setQuantity(Integer.parseInt(Quantity));
                    checkInventoryDetail.setStockOnhand(productWarehouseDAO.getProductWarehouseByCode(ProductCode).getStockOnhand());
                    checkInventoryDetailDAO.insertCheckInventoryDetail(checkInventoryDetail);
                }
                //set url
                if (ID.length() > 0) {
                    url = "/shopbanhang/administrator/checkinventory.jsp?keyword=" + keyword + "&pages=" + pages + "";
                } else {
                    url = "/shopbanhang/administrator/checkinventory.jsp";
                }
                
                response.setContentType("text/plain");
                response.getWriter().write(url);
            } catch (JSONException ex) {
            }
        }
    }

}
