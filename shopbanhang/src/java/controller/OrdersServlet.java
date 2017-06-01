/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import common.AllConstant;
import common.SendMail;
import dao.OrdersDAO;
import dao.OrdersDetailDAO;
import dao.ProductWarehouseDAO;
import dao.UsersDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Orders;
import model.OrdersDetail;
import model.ProductWarehouse;
import model.Users;

public class OrdersServlet extends HttpServlet {

    OrdersDAO ordersDAO = new OrdersDAO();
    OrdersDetailDAO ordersDetailDAO = new OrdersDetailDAO();
    UsersDAO usersDAO = new UsersDAO();
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

        DecimalFormat df = new DecimalFormat("#,###");
        Orders orders = new Orders();

        String command = "null";
        String pages = "1";
        String url = "";
        String keyword = "";

        if (request.getParameter("keyword") != null) {
            keyword = request.getParameter("keyword");
        }
        if (request.getParameter("command") != null) {
            command = request.getParameter("command");
        }
        if (request.getParameter("pages") != null) {
            pages = request.getParameter("pages");
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
                orders.setModifiedDate(new Timestamp(new Date().getTime()));
                orders.setModifiedBy(usersCurrent.getUserName());// chèn người dùng hiện tại
                orders.setStatus(Status);
                orders.setCode(Code);
                ordersDAO.changeStatusOrders(orders);

                //Mail thông báo cho khách hàng & Update Product Warehouse
                String MailContent = "";
                if (Status == 2) {
                    //Update Product Warehouse
                    for (OrdersDetail odetail : ordersDetailDAO.getListOrdersDetailByOrdersCode(Code)) {
                        ProductWarehouse pw = productWarehouseDAO.getProductWarehouseByCode(odetail.getProductCode());
                        ProductWarehouse productWarehouse = new ProductWarehouse();
                        productWarehouse.setStockOnhand(pw.getStockOnhand() - odetail.getQuantity());
                        productWarehouse.setStockAvailable(pw.getStockAvailable());
                        productWarehouse.setModifiedDate(new Timestamp(new Date().getTime()));
                        productWarehouse.setModifiedBy(usersCurrent.getUserName());
                        productWarehouse.setProductCode(pw.getProductCode());
                        productWarehouseDAO.updateProductWarehouse(productWarehouse);
                    }

                    //Conten mail
                    MailContent = new AllConstant().MailNewOrder(usersDAO.getUser(ordersDAO.getOrderByCode(Code).getCustomerID()).getName(),
                            usersDAO.getUser(ordersDAO.getOrderByCode(Code).getCustomerID()).getUserName(),
                            usersDAO.getUser(ordersDAO.getOrderByCode(Code).getCustomerID()).getName(),
                            usersDAO.getUser(ordersDAO.getOrderByCode(Code).getCustomerID()).getPhone(),
                            usersDAO.getUser(ordersDAO.getOrderByCode(Code).getCustomerID()).getEmail(),
                            df.format(ordersDetailDAO.Total(Code)).toString(),
                            "Đơn hàng của bạn đã được xác nhận thành công! Hàng của bạn sẽ được giao đến bạn trong thời gian sớm nhất cos thể.");
                } else {
                    //Update Product Warehouse
                    for (OrdersDetail odetail : ordersDetailDAO.getListOrdersDetailByOrdersCode(Code)) {
                        ProductWarehouse pw = productWarehouseDAO.getProductWarehouseByCode(odetail.getProductCode());
                        ProductWarehouse productWarehouse = new ProductWarehouse();
                        productWarehouse.setStockOnhand(pw.getStockOnhand());
                        productWarehouse.setStockAvailable(pw.getStockAvailable() + odetail.getQuantity());
                        productWarehouse.setModifiedDate(new Timestamp(new Date().getTime()));
                        productWarehouse.setModifiedBy(usersCurrent.getUserName());
                        productWarehouse.setProductCode(pw.getProductCode());
                        productWarehouseDAO.updateProductWarehouse(productWarehouse);
                    }

                    //Conten mail
                    MailContent = new AllConstant().MailNewOrder(usersDAO.getUser(ordersDAO.getOrderByCode(Code).getCustomerID()).getName(),
                            usersDAO.getUser(ordersDAO.getOrderByCode(Code).getCustomerID()).getUserName(),
                            usersDAO.getUser(ordersDAO.getOrderByCode(Code).getCustomerID()).getName(),
                            usersDAO.getUser(ordersDAO.getOrderByCode(Code).getCustomerID()).getPhone(),
                            usersDAO.getUser(ordersDAO.getOrderByCode(Code).getCustomerID()).getEmail(),
                            df.format(ordersDetailDAO.Total(Code)).toString(),
                            "Rất tiếc đơn hàng của bạn đã bị hủy bỏ bởi hệ thống!.");
                }
                SendMail sm = new SendMail();
                sm.sendMail(usersDAO.getUser(ordersDAO.getOrderByCode(Code).getCustomerID()).getEmail(), "KingPhone", MailContent);

                url = "/shopbanhang/administrator/orders.jsp?keyword=" + keyword + "&pages=" + pages + "";
                response.sendRedirect(url);

            } catch (IOException e) {
            } catch (SQLException ex) {
                Logger.getLogger(OrdersServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

}
