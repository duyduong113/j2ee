/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import common.AllConstant;
import common.SendMail;
import dao.HelperDAO;
import dao.OrdersDAO;
import dao.OrdersDetailDAO;
import dao.ProductWarehouseDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.util.Date;
import java.util.Map;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Cart;
import model.Item;
import model.Orders;
import model.OrdersDetail;
import model.ProductWarehouse;
import model.Users;

/**
 *
 * @author DUONG
 */
public class CheckOutServlet extends HttpServlet {

    private final OrdersDAO orderDAO = new OrdersDAO();
    private final OrdersDetailDAO ordersDetailDAO = new OrdersDetailDAO();
    private final HelperDAO helperDAO = new HelperDAO();
    ProductWarehouseDAO productWarehouseDAO = new ProductWarehouseDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");

        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        Users usersCurrent = (Users) session.getAttribute("user");
        DecimalFormat df = new DecimalFormat("#,###");

        String ShipName_err = "", ShipMobile_err = "", ShipAddress_err = "", ShipEmail_err = "", Quantity_err = "",
                ShipName = "", ShipMobile = "", ShipAddress = "", ShipEmail = "";

        //get data from jsp
        if (request.getParameter("ShipName") != null) {
            ShipName = request.getParameter("ShipName");
        }
        if (request.getParameter("ShipMobile") != null) {
            ShipMobile = request.getParameter("ShipMobile");
        }
        if (request.getParameter("ShipAddress") != null) {
            ShipAddress = request.getParameter("ShipAddress");
        }
        if (request.getParameter("ShipEmail") != null) {
            ShipEmail = request.getParameter("ShipEmail");
        }

        //set data to jsp
        request.setAttribute("ShipName", ShipName);
        request.setAttribute("ShipMobile", ShipMobile);
        request.setAttribute("ShipAddress", ShipAddress);
        request.setAttribute("ShipEmail", ShipEmail);

        if (ShipName.equals("")) {
            ShipName_err = "Vui lòng nhập tên người nhận";
        }
        if (ShipName_err.length() > 0) {
            request.setAttribute("ShipName_err", ShipName_err);
        }
        if (ShipMobile.equals("")) {
            ShipMobile_err = "Vui lòng nhập số điện thoại người nhận";
        }
        if (ShipMobile_err.length() > 0) {
            request.setAttribute("ShipMobile_err", ShipMobile_err);
        }
        if (ShipAddress.equals("")) {
            ShipAddress_err = "Vui lòng nhập địa chỉ người nhận";
        }
        if (ShipAddress_err.length() > 0) {
            request.setAttribute("ShipAddress_err", ShipAddress_err);
        }
        if (ShipEmail.equals("")) {
            ShipEmail_err = "Vui lòng nhập địa chỉ email người nhận";
        } else if (helperDAO.isValidEmailAddress(ShipEmail) == false) {
            ShipEmail_err = "Địa chỉ Email không hợp lệ";
        }
        if (ShipEmail_err.length() > 0) {
            request.setAttribute("ShipEmail_err", ShipEmail_err);
        }
        //check quantity Product
        for (Map.Entry<String, Item> list : cart.getCartItems().entrySet()) {
            ProductWarehouse pw = productWarehouseDAO.getProductWarehouseByCode(list.getValue().getProduct().getCode());
            if (pw.getStockAvailable() < list.getValue().getQuantity()) {
                Quantity_err += "Số lượng sản phẩm " + list.getValue().getProduct().getName() + " tối đa có thể mua là: " + pw.getStockAvailable() + "<br>";
            }
        }
        if (Quantity_err.length() > 0) {
            request.setAttribute("Quantity_err", Quantity_err);
        }

        try {
            if (ShipName_err.length() == 0 && ShipMobile_err.length() == 0 && ShipAddress_err.length() == 0 && ShipEmail_err.length() == 0 && Quantity_err.length() == 0) {
                //Insert Orders
                String Code = Long.toString(new Date().getTime());
                Orders order = new Orders();
                order.setCode(Code);
                order.setCreatedDate(new Timestamp(new Date().getTime()));
                order.setCustomerID(usersCurrent.getID());
                order.setShipName(ShipName);
                order.setShipMobile(ShipMobile);
                order.setShipAddress(ShipAddress);
                order.setShipEmail(ShipEmail);
                order.setStatus(AllConstant.Order_NEW);
                orderDAO.insertOrder(order);

                //Insert OrdersDetail & Update ProductWarehouse
                for (Map.Entry<String, Item> list : cart.getCartItems().entrySet()) {
                    //Insert OrdersDetail
                    OrdersDetail orderDetail = new OrdersDetail();
                    orderDetail.setProductCode(list.getValue().getProduct().getCode());
                    orderDetail.setOrdersCode(Code);
                    orderDetail.setQuantity(list.getValue().getQuantity());
                    orderDetail.setPrice(list.getValue().getProduct().getPrice());
                    ordersDetailDAO.insertOrderDetail(orderDetail);

                    //Update ProductWarehouse
                    ProductWarehouse pw = productWarehouseDAO.getProductWarehouseByCode(list.getValue().getProduct().getCode());
                    //Update
                    ProductWarehouse productWarehouse = new ProductWarehouse();
                    productWarehouse.setStockOnhand(pw.getStockOnhand());
                    productWarehouse.setStockAvailable(pw.getStockAvailable() - list.getValue().getQuantity());
                    productWarehouse.setModifiedDate(new Timestamp(new Date().getTime()));
                    productWarehouse.setModifiedBy(usersCurrent.getUserName());
                    productWarehouse.setProductCode(pw.getProductCode());
                    productWarehouseDAO.updateProductWarehouse(productWarehouse);

                }

                //Send mail
                String MailContent = new AllConstant().MailNewOrder(usersCurrent.getName(),
                        usersCurrent.getUserName(),
                        usersCurrent.getName(),
                        usersCurrent.getPhone(),
                        usersCurrent.getEmail(),
                        df.format(cart.totalCart()).toString(),
                        "Đơn hàng của bạn đã đặt thành công. Vui lòng chờ hệ thống xác nhận lại tình trạng đơn hàng của bạn!.");
                SendMail sm = new SendMail();
                sm.sendMail(usersCurrent.getEmail(), "KingPhone", MailContent);
                cart = new Cart();
                session.setAttribute("cart", cart);
                response.sendRedirect("/shopbanhang/index.jsp");
            } else {
//                response.sendRedirect("/shopbanhang/checkout.jsp");
                RequestDispatcher rd = getServletContext().getRequestDispatcher("/checkout.jsp");
                rd.forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
//        response.sendRedirect("/shop/index.jsp");
    }

}
