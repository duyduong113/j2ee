<%-- 
    Document   : header
    Created on : May 10, 2017, 7:59:07 AM
    Author     : DUONG
--%>

<%@page import="common.AllConstant"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="model.Item"%>
<%@page import="java.util.Map"%>
<%@page import="model.Cart"%>
<%@page import="model.Users"%>
<%@page import="model.ProductCategory"%>
<%@page import="dao.ProductCategoryDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Header</title>

        <script type="text/javascript">
            $(document).ready(function () {
                $("#txtSearch").keydown(function (e) {
                    if (e.keyCode == 13) {
                        $('#searchForm').submit();
                    }
                });

            });
        </script>
    </head>
    <body>

        <%
            DecimalFormat df = new DecimalFormat("#,###");
            ProductCategoryDAO productCategoryDAO = new ProductCategoryDAO();
            Users users = null;
            if (session.getAttribute("user") != null) {
                users = (Users) session.getAttribute("user");
            }
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

        <!--header-->
        <div class="header">
            <div class="header-top">
                <div class="container">	
                    <div class="header-top-in">			
                        <div class="logo">
                            <a href="index.jsp"><img src="images/generals/logo.png" alt=" " ></a>
                        </div>
                        <div class="header-in">
                            <ul class="icon1 sub-icon1">
                                <%                                    if (users == null) {

                                %>
                                <li><a href="login.jsp"> Đăng nhập</a></li>
                                <li><a href="register.jsp">Đăng ký</a></li>
                                <%                                } else {
                                %>
                                <li><a href="profile.jsp">Xin chào <%=users.getName()%></a></li>
                                <li><a href="UsersServlet?command=logout">Đăng xuất</a></li>
                                <%
                                    }
                                %>

                                <li ><a href="cart.jsp" > Giỏ hàng</a></li>
                                <li > <a href="checkout.jsp" >Thanh toán</a> </li>	
                                <li><div class="cart">
                                        <a href="#" class="cart-in"> </a>
                                        <span> <%=cart.countItem()%></span>
                                    </div>
                                    <ul class="sub-icon1 list">
                                        <h3>Số sản phẩm đã thêm(<%=cart.countItem()%>)</h3>
                                        <div class="shopping_cart">

                                            <%
                                                for (Map.Entry<String, Item> list : cart.getCartItems().entrySet()) {
                                            %>
                                            <div class="cart_box">
                                                <div class="message">
                                                    <a href="CartServlet?url=<%=url%>&command=remove&product=<%=list.getValue().getProduct().getCode()%>" class="alert-close"> </a> 
                                                    <div class="list_img"><img src="<%=list.getValue().getProduct().getImage() == null ? AllConstant.url_no_image : list.getValue().getProduct().getImage()%>" class="img-responsive" alt=""><!--<a href="detail.jsp?product=<%=list.getValue().getProduct().getCode()%>" ></a>--></div>

                                                    <div class="list_desc"><h4><a href="detail.jsp?product=<%=list.getValue().getProduct().getCode()%>"><%=list.getValue().getProduct().getName()%></a></h4>
                                                        <%=list.getValue().getQuantity()%> x <span class="actual"><%=df.format(list.getValue().getProduct().getPromotionPrice() == 0 ? list.getValue().getProduct().getPrice() : list.getValue().getProduct().getPromotionPrice())%></span>
                                                    </div>
                                                    <div class="clearfix"></div>
                                                </div>
                                            </div>
                                            <%
                                                }
                                            %>

                                        </div>
                                        <div class="total">
                                            <div class="total_left">Tổng tiền : </div>
                                            <div class="total_right"><%=df.format(cart.totalCart())%> đ</div>
                                            <div class="clearfix"> </div>
                                        </div>
                                        <div class="login_buttons">
                                            <div class="check_button"><a href="checkout.jsp">Thanh toán</a></div>
                                            <div class="clearfix"></div>
                                        </div>
                                        <div class="clearfix"></div>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                        <div class="clearfix"> </div>
                    </div>
                </div>
            </div>
            <div class="header-bottom">
                <div class="container">
                    <div class="h_menu4">
                        <a class="toggleMenu" href="#">Menu</a>
                        <ul class="nav">
                            <li class="active"><a href="index.jsp"><i> </i>Trang chủ</a></li>
                            <li>
                                <a href="category.jsp" >Sản phẩm</a>
                                <ul class="drop">
                                    <%
                                        for (ProductCategory p : productCategoryDAO.getListProductCategory()) {
                                    %>

                                    <li><a href="product.jsp?category=<%=p.getID()%>"><%=p.getName()%></a></li>
                                        <%
                                            }
                                        %>
                                </ul>
                            </li> 						

                            <li><a href="product.jsp?category=<%=AllConstant.Product_PROMOTION%>">Khuyến mãi</a></li>
                            <li><a href="about.jsp">Giới thiệu</a></li>
                            <li><a href="contact.jsp">Liên hệ</a></li>
                            <li><a href="#">Tin tức</a></li>		
                            <li><a href="#">Diễn đàn</a></li>						  				 


                        </ul>
                        <script type="text/javascript" src="js/nav.js"></script>
                    </div>
                </div>
            </div>
            <div class="header-bottom-in">
                <div class="container">
                    <div class="header-bottom-on">
                        <p class="wel"><a href="login.jsp">Chào bạn, bạn có thể đăng nhập hoặc tạo tài khoản.</a></p>
                        <div class="header-can">
                            <ul class="social-in">
                                <li><a href="#"><i> </i></a></li>
                                <li><a href="#"><i class="facebook"> </i></a></li>
                                <li><a href="#"><i class="twitter"> </i></a></li>					
                                <li><a href="#"><i class="skype"> </i></a></li>
                            </ul>	
                            <div class="down-top">		
                                <select class="in-drop">
                                    <option value="Dollars" class="in-of">Dollars</option>
                                    <option value="Euro" class="in-of">Euro</option>
                                    <option value="Yen" class="in-of">Yen</option>
                                </select>
                            </div>
                            <div class="search">
                                <form id="searchForm" action="SearchServlet" method="POST">
                                    <input id="txtSearch" name="keyword" type="text" value="Search" onfocus="this.value = '';" onblur="if (this.value == '') {
                                                this.value = '';}" >
                                    <input type="submit" value="">
                                </form>
                            </div>
                            <div class="clearfix"> </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
