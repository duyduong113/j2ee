<%-- 
    Document   : checkout
    Created on : May 10, 2017, 1:20:20 PM
    Author     : DUONG
--%>

<%@page import="java.sql.Connection"%>
<%@page import="connect.DBConnect"%>
<%@page import="dao.CustomDataDAO"%>
<%@page import="dao.UsersDAO"%>
<%@page import="common.AllConstant"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Map"%>
<%@page import="model.Item"%>
<%@page import="model.Cart"%>
<%@page import="model.Users"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thanh toán</title>
        <%@include file="include/headtag.jsp" %>
        <link href="css/cart.css" rel="stylesheet" type="text/css" media="all" />

        <script type="text/javascript">
            $(document).ready(function () {
                var x_timer;
                $("#ShipEmail").keyup(function (e) {
                    clearTimeout(x_timer);
                    var email = $(this).val();
                    x_timer = setTimeout(function () {
                        check_email_ajax(email);
                    }, 1000);
                });

                function check_email_ajax(email) {
                    $("#email-result").html('<img src="img/ajax-loader.gif" />');
                    $.post('CheckEmailServlet', {'email': email}, function (data) {
                        $("#email-result").html(data);
                    });
                }
            });
        </script>
    </head>
    <body>
        <%

            DecimalFormat df = new DecimalFormat("#,###");
            CustomDataDAO customDataDAO = new CustomDataDAO();
            Cart cart = (Cart) session.getAttribute("cart");
            Users users = (Users) session.getAttribute("user");
            if (cart == null) {
                cart = new Cart();
                session.setAttribute("cart", cart);
            }

            if (cart.countItem() > 0) {
                if (users == null) {
                    users = new Users();
                    response.sendRedirect("/shopbanhang/login.jsp");
                }
            }

//            
            String url = "";
            if (request.getQueryString() == null) {
                url = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getRequestURI();

            } else {
                url = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getRequestURI() + "?" + request.getQueryString();
            }

            String ShipName_err = "", ShipMobile_err = "", ShipAddress_err = "", ShipEmail_err = "",
                    ShipName = "", ShipMobile = "", ShipAddress = "", ShipEmail = "";
            if (request.getAttribute("ShipName_err") != null) {
                ShipName_err = (String) request.getAttribute("ShipName_err");
            }
            if (request.getAttribute("ShipMobile_err") != null) {
                ShipMobile_err = (String) request.getAttribute("ShipMobile_err");
            }
            if (request.getAttribute("ShipAddress_err") != null) {
                ShipAddress_err = (String) request.getAttribute("ShipAddress_err");
            }
            if (request.getAttribute("ShipEmail_err") != null) {
                ShipEmail_err = (String) request.getAttribute("ShipEmail_err");
            }
            if (request.getAttribute("ShipName") != null) {
                ShipName = (String) request.getAttribute("ShipName");
            }
            if (request.getAttribute("ShipMobile") != null) {
                ShipMobile = (String) request.getAttribute("ShipMobile");
            }
            if (request.getAttribute("ShipAddress") != null) {
                ShipAddress = (String) request.getAttribute("ShipAddress");
            }
            if (request.getAttribute("ShipEmail") != null) {
                ShipEmail = (String) request.getAttribute("ShipEmail");
            }


        %>
        <jsp:include page="header.jsp"></jsp:include> 
            <section id="cart_items">
                <div class="container">

                <%                         if (cart.countItem() == 0) {
                %>
                <h2 class="account-in" style="margin-top:5%;">Giỏ hàng</h2>
                <div class="cart-empty" style="margin-bottom: 5%;">
                    <h4 class="title">Giỏ hàng trống!</h4>
                    <p class="">Bạn không có sản phẩm nào trong giỏ hàng của bạn.<br>Nhấn <a href="index.jsp"> vào đây</a> để tiếp tục mua hàng</p>
                </div>
                <%
                } else {
                %>

                <h3 class="bg-info" style="margin:  2% 0;">Thông tin đơn hàng</h3>
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

                            <%                                for (Map.Entry<String, Item> list : cart.getCartItems().entrySet()) {
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
                                    <p><%=df.format(list.getValue().getProduct().getPrice())%></p>
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
                                        <tr>
                                            <td>Tổng tiền</td>
                                            <td><span><%=df.format(cart.totalCart())%> đ</span></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <div class="check-out1">
                    <h3 class="bg-info" style="margin:  2% 0;">Thông tin thanh toán</h3>
                    <form action="CheckOutServlet" method="POST" >
                        <!--                    <input type="hidden" value="insert" name="command">-->
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">			
                                    <label>Họ tên người nhận*</label>
                                    <input class="form-control" type="text" style="width: 99%;" name="ShipName" value="<%=ShipName == "" ? users.getName() : ShipName%>"  > 
                                    <p class="text-danger"><%=ShipName_err%></p>
                                </div>	
                                <div class="form-group">			
                                    <label>Số điện thoại người nhận*</label>
                                    <input class="form-control" type="text" style="width: 99%;" name="ShipMobile" onkeypress='return event.charCode >= 48 && event.charCode <= 57'  id="ShipMobile" value="<%=ShipMobile == "" ? users.getPhone() : ShipMobile%>"> 
                                    <p class="text-danger"><%=ShipMobile_err%></p>
                                </div>
                                <div class="form-group">			
                                    <label>Địa chỉ người nhận*</label>
                                    <input class="form-control" style="width: 99%;" type="text" name="ShipAddress" value="<%=ShipAddress == "" ? users.getAddress() + "-" + customDataDAO.getDistrictByCode(users.getDistrictCode()).getName() + "-" + customDataDAO.getCityByCode(users.getProvinceCode()).getName() : ShipAddress%>" > 
                                    <p class="text-danger"><%=ShipAddress_err%></p>
                                </div>
                                <div class="form-group"> 	
                                    <label>Email người nhận*</label>
                                    <input class="form-control" style="width: 99%;float: left;" type="text" name="ShipEmail" id="ShipEmail" value="<%=ShipEmail == "" ? users.getEmail() : ShipEmail%>" > 
                                    <span style="width: 1%;float:right;margin-top: 5px"  id="email-result"></span>
                                    <p class="text-danger"><%=ShipEmail_err%></p>
                                </div>

                                <dic class="clearfix"></dic>

                                <div class="action" style="margin: 2% 0;" >
                                    <input class="btn btn-primary"  type="submit" value="Xác nhận thanh toán"> 
                                    <a href="CartServlet?url=/shopbanhang/index.jsp&command=clear" class="btn btn-danger">Hủy đơn hàng</a>
                                </div>

                            </div>
                        </div>

                    </form>
                </div>

                <%
                    }
                %>

            </div>
        </section>

        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>
