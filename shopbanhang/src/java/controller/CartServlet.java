/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.ProductDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Cart;
import model.Item;
import model.Product;

/**
 *
 * @author DUONG
 */
public class CartServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String command = request.getParameter("command");
        String productCode = request.getParameter("product");
        Cart cart = (Cart) session.getAttribute("cart");
        String url = request.getParameter("url");

        try {
            Product product = productDAO.getProductByCode(productCode);
            switch (command) {
                case "plus":
                    if (cart.getCartItems().containsKey(productCode)) {
                        cart.plusToCart(productCode, new Item(product,
                                cart.getCartItems().get(productCode).getQuantity()));
                    } else {
                        cart.plusToCart(productCode, new Item(product, 1));
                    }
                    break;
                case "remove":
                    cart.removeToCart(productCode);
                    break;
                case "sub":
                    cart.subToCart(productCode, new Item(product,
                            cart.getCartItems().get(productCode).getQuantity()));
                    break;
                case "clear":
                    cart.clearCart();
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("/shopbanhang/index.jsp");
        }
        session.setAttribute("cart", cart);
        response.sendRedirect(url);
    }

}
