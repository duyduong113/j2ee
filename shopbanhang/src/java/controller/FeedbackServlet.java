/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import common.AllConstant;
import dao.HelperDAO;
import dao.OrdersDetailDAO;
import dao.OrdersDAO;
import dao.FeedbackDAO;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.Map;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Cart;
import model.Feedback;
import model.Item;
import model.OrdersDetail;
import model.Orders;
import model.Users;

/**
 *
 * @author DUONG
 */
public class FeedbackServlet extends HttpServlet {

    private final FeedbackDAO feedbackDAO = new FeedbackDAO();
    private final HelperDAO helperDAO = new HelperDAO();

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
        Users usersCurrent = (Users) session.getAttribute("users");

        String Name_err = "", Phone_err = "", Address_err = "", Email_err = "", Content_err = "",
                Name = request.getParameter("Name"),
                Phone = request.getParameter("Phone"),
                Address = request.getParameter("Address"),
                Email = request.getParameter("Email"),
                Content = request.getParameter("Content");

        request.setAttribute("Name", Name);
        request.setAttribute("Phone", Phone);
        request.setAttribute("Address", Address);
        request.setAttribute("Email", Email);
        request.setAttribute("Content", Content);

        if (Name.equals("")) {
            Name_err = "Vui lòng nhập tên người gửi";
        }
        if (Name_err.length() > 0) {
            request.setAttribute("Name_err", Name_err);
        }
//        if (Phone.equals("")) {
//            Phone_err = "Vui lòng nhập số điện thoại";
//        }
//        if(Phone_err.length()>0){
//            request.setAttribute("Phone_err", Phone_err);
//        }
        if (Email.equals("") == false) {
            if (helperDAO.isValidEmailAddress(Email) == false) {
                Email_err = "Địa chỉ Email không hợp lệ";
            }
        }

        if (Email_err.length() > 0) {
            request.setAttribute("Email_err", Email_err);
        }

        if (Content.equals("")) {
            Content_err = "Vui lòng nhập nội dung phản hồi";
        }
        if (Content_err.length() > 0) {
            request.setAttribute("Content_err", Content_err);
        }

        try {
            if (Name_err.length() == 0 && Phone_err.length() == 0 && Address_err.length() == 0 && Email_err.length() == 0) {
                String Code = Long.toString(new Date().getTime());
                Feedback feedback = new Feedback();
                feedback.setName(Name);
                feedback.setPhone(Phone);
                feedback.setEmail(Email);
                feedback.setAddress(Address);
                feedback.setContent(Content);
                feedback.setCreatedDate(new Timestamp(new Date().getTime()));
                feedback.setStatus(false);

                feedbackDAO.insertFeedback(feedback);

                response.sendRedirect("/shopbanhang/contact.jsp");
            } else {

                RequestDispatcher rd = getServletContext().getRequestDispatcher("/contact.jsp");
                rd.forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
