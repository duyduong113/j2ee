<%-- 
    Document   : cart
    Created on : May 13, 2017, 9:44:41 AM
    Author     : DUONG
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="common.AllConstant"%>
<%@page import="java.util.Map"%>
<%@page import="model.Item"%>
<%@page import="java.util.HashMap"%>
<%@page import="model.Cart"%>
<%@page import="model.Users"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Giỏ hàng</title>
        <%@include file="include/headtag.jsp" %>
        <link href="css/cart.css" rel="stylesheet" type="text/css" media="all" />

    </head>
    <body>
        <%
//            Users users = (Users) session.getAttribute("user");
//            if (users == null) {
//                response.sendRedirect("/shopbanhang/login.jsp");
//            }
            DecimalFormat df = new DecimalFormat("#,###");
            Cart cart = (Cart) session.getAttribute("cart");
            if (cart == null) {
                cart = new Cart();
                session.setAttribute("cart", cart);
            }

            String url = "";
            if (request.getQueryString() == null) {
                url = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getRequestURI();

            } else {
                url = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getRequestURI() + "?" + request.getQueryString();
            }
        %>

        <jsp:include page="header.jsp"></jsp:include>

            <section id="cart_items">
                <div class="container">
                    <h2 class="account-in" style="margin-top:5%;">Giỏ hàng</h2>
                <%
                    if (cart.countItem() == 0) {
                %>
                <div class="cart-empty" style="margin-bottom: 5%;">
                    <h4 class="title">Giỏ hàng trống!</h4>
                    <p class="">Bạn không có sản phẩm nào trong giỏ hàng của bạn.<br>Nhấn <a href="index.jsp"> vào đây</a> để tiếp tục mua hàng</p>
                </div>
                <%
                } else {
                %>
                <div class="table-responsive cart_info">
                    <table class="table table-condensed">
                        <thead>
                            <tr class="cart_menu">
                                <td class="image">Sản phẩm</td>
                                <td class="description"></td>
                                <td class="price">Giá</td>
                                <td class="quantity">Số lượng</td>
                                <td class="total1">Thành tiền</td>
                                <td></td>
                            </tr>
                        </thead>
                        <tbody>

                            <%
                                for (Map.Entry<String, Item> list : cart.getCartItems().entrySet()) {
                            %>
                            <tr>
                                <td class="cart_product">
                                    <a href="detail.jsp?product=<%=list.getValue().getProduct().getCode()%>"><img src="<%=list.getValue().getProduct().getImage() == null ? AllConstant.url_no_image : list.getValue().getProduct().getImage()%>" alt="" width="110" height="110"></a>
                                </td>
                                <td class="cart_description">
                                    <h4><a href="detail.jsp?product=<%=list.getValue().getProduct().getCode()%>"><%=list.getValue().getProduct().getName()%></a></h4>
                                    <p>Mã sản phẩm: <%=list.getValue().getProduct().getCode()%></p>
                                </td>
                                <td class="cart_price">
                                    <p><%=df.format(list.getValue().getProduct().getPromotionPrice()==0?list.getValue().getProduct().getPrice():list.getValue().getProduct().getPromotionPrice())%></p>
                                </td>
                                <td class="cart_quantity">
                                    <div class="cart_quantity_button">
                                        <a class="cart_quantity_up" href="CartServlet?url=<%=url%>
                                       &command=plus&product=<%=list.getValue().getProduct().getCode()%>"> + </a>
                                        <input class="cart_quantity_input" type="text" name="Quantity" value="<%=list.getValue().getQuantity()%>" autocomplete="off" size="2">
                                        <a class="cart_quantity_down" href="CartServlet?url=<%=url%>
                                       &command=sub&product=<%=list.getValue().getProduct().getCode()%>"> - </a>
                                    </div>
                                </td>
                                <td class="cart_total">
                                    <p class="cart_total_price"><%=df.format(cart.totalItem(list.getValue().getProduct().getCode(), list.getValue()))%></p>
                                </td>
                                <td class="cart_delete">
                                    <a class="cart_quantity_delete" href="CartServlet?url=<%=url%>&command=remove&product=<%=list.getValue().getProduct().getCode()%>"><i class="fa fa-times"></i></a>
                                </td>
                            </tr>
                            <%
                                }
                            %>

                            <tr>
                                <td colspan="4">&nbsp;</td>
                                <td colspan="2">
                                    <table class="table table-condensed total-result">
                                        <!--                                        <tr>
                                                                                    <td>Tổng tiền</td>
                                                                                    <td>$59</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>Exo Tax</td>
                                                                                    <td>$2</td>
                                                                                </tr>
                                                                                <tr class="shipping-cost">
                                                                                    <td>Shipping Cost</td>
                                                                                    <td>Free</td>										
                                                                                </tr>-->
                                        <tr>
                                            <td>Tổng tiền</td>
                                            <td><span><%=df.format(cart.totalCart())%> đ</span></td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td><a href="checkout.jsp" class="btn btn-primary">Thanh toán</a>
                                                <a href="CartServlet?url=/shopbanhang/index.jsp&command=clear" class="btn btn-danger">Hủy đơn hàng</a></td>

                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <%
                    }
                %>


            </div>
        </section>


        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>
