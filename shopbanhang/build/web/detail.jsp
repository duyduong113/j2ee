<%-- 
    Document   : detail
    Created on : May 10, 2017, 1:25:56 PM
    Author     : DUONG
--%>

<%@page import="dao.ProductWarehouseDAO"%>
<%@page import="com.sun.org.apache.bcel.internal.generic.AALOAD"%>
<%@page import="dao.ProductDetailDAO"%>
<%@page import="common.AllConstant"%>
<%@page import="model.Product"%>
<%@page import="model.ProductDetail"%>
<%@page import="dao.ProductDAO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chi tiết sản phẩm</title>
        <%@include file="include/headtag.jsp" %>

        <script>
            function show_thongtinchitiet() {
                $('.thong-so-ky-thuat').css("display", "block");

            }
        </script>
    </head>
    <body>

        <%
            DecimalFormat df = new DecimalFormat("#,###");
            ProductDAO productDAO = new ProductDAO();
            ProductDetailDAO productDetailDAO = new ProductDetailDAO();
            ProductWarehouseDAO productWarehouseDAO = new ProductWarehouseDAO();
            String productCode = "";
            int count = 0;
            Product product = new Product();
            if (request.getParameter("product") != null) {
                productCode = request.getParameter("product");
                product = productDAO.getProductByCode(productCode);
            }

            String url = "";
            if (request.getQueryString() == null) {
                url = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getRequestURI();

            } else {
                url = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getRequestURI() + "?" + request.getQueryString();
            }

        %>

        <jsp:include page="header.jsp"></jsp:include>    
            <div class="container">
                <div class="single">
                    <h3 class="future" style="margin-bottom: 3%">Chi tiết</h3>

                    <div class="col-md-12 top-in-single">
                        <div class="col-md-4 single-top">	
                            <ul id="etalage">
                                <li>
                                    <img class="etalage_thumb_image img-responsive" src="<%=product.getImage() == null ? AllConstant.url_no_image : product.getImage()%>" alt="" >
                                <img class="etalage_source_image img-responsive" src="<%=product.getImage() == null ? AllConstant.url_no_image : product.getImage()%>" alt="" >

                            </li>
                        </ul>

                    </div>	
                    <div class="col-md-8 single-top-in">
                        <div class="single-para">
                            <h4><%=product.getName()%></h4>
                            <div class="para-grid">
                                <span  class="add-to"><%=df.format(product.getPrice())%> đ</span>
                                <a href="CartServlet?url=<%=url%>
                                   &command=plus&product=<%=product.getCode()%>" class="hvr-shutter-in-vertical cart-to">Thêm vào giỏ</a>					
                                <div class="clearfix"></div>
                            </div>
                            <h5>Trạng thái: <%=productWarehouseDAO.getProductWarehouseByCode(product.getCode()).getStockAvailable()%> sản phẩm trong kho</h5>
                            <p><%=product.getDescription()%>.</p>
                            <button class="btn btn-info" onclick="show_thongtinchitiet()"> Xem chi tiết</button>
                        </div>
                    </div>
                    <div class="clearfix"> </div>
                    <div class="thong-so-ky-thuat col-md-12" style="margin-bottom: 2%;display: none">
                        <h3 class="bg-info">Thông tin chi tiết</h3>

                        <%
                            for (ProductDetail productDetail : productDetailDAO.getListProductDetailByProduct(productCode)) {
                        %>

                        <div class="row" style="padding:1% 0 0 2%; ">
                            <strong class="col-md-3"><%=productDetail.getName()%>:</strong>
                            <%=productDetail.getValue()%>
                        </div>

                        <%
                            }
                        %>
                    </div>
                    <div class="clearfix"> </div>
                    <h3 class="future">Liên quan</h3>
                    <div class="content-top-in">
                        <%
                            count = 0;
                            for (Product p : productDAO.getListProduct(product.getCode(), product.getCategoryID())) {
                                if (count < AllConstant.Product_RELATED_Quantity) {
                                    count++;

                        %>
                        <div class="col-md-3 top-single-in">
                            <div class="col-md">
                                <a href="detail.jsp?product=<%=p.getCode()%>"><img  src="<%=p.getImage() == null ? AllConstant.url_no_image : p.getImage()%>" alt="" />	</a>
                                <div class="top-content">
                                    <h5><a href="detail.jsp?product=<%=p.getCode()%>"><%=p.getName()%></a></h5>
                                    <div class="white">
                                        <a href="CartServlet?url=<%=url%>&command=plus&product=<%=product.getCode()%>" class="hvr-shutter-in-vertical hvr-shutter-in-vertical2">Thêm vào giỏ</a>
                                        <p class="dollar"><span class="in-dollar"><%=df.format(p.getPrice())%></span></p>
                                        <div class="clearfix"></div>
                                    </div>
                                </div>							
                            </div>
                        </div>
                        <%                            }
                            }
                        %>
                        <div class="clearfix"></div>
                    </div>
                    <div class="fb-comments" data-href="http://localhost:8080/shopbanhang/detail.jsp?product=<%=productCode%>" width="100%" data-numposts="5"></div>
                </div>
                <div class="clearfix"> </div>
            </div>
        </div>
        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>
