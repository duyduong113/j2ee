<%-- 
    Document   : index
    Created on : May 10, 2017, 7:38:24 AM
    Author     : DUONG
--%>

<%@page import="model.ProductCategory"%>
<%@page import="dao.ProductCategoryDAO"%>
<%@page import="model.Product"%>
<%@page import="common.AllConstant"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="dao.ProductDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Trang chủ</title>
        <%@include file="include/headtag.jsp" %>
    </head>
    <body>
        <%
            DecimalFormat df = new DecimalFormat("#,###");
            ProductDAO productDAO = new ProductDAO();
            ProductCategoryDAO productCategoryDAO = new ProductCategoryDAO();
            int count = 0;
            String url = "";
            if (request.getQueryString() == null) {
                url = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getRequestURI();

            } else {
                url = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getRequestURI() + "?" + request.getQueryString();
            }


        %>
        <jsp:include page="header.jsp"></jsp:include>

        <jsp:include page="banner.jsp"></jsp:include>

            <!--Container-->
            <div class="container">
                <div class="content">
                    <div class="content-top">
                        <h3 class="future">Nổi bật</h3>
                        <div class="content-top-in">

                        <%                            count = 0;
                            for (Product product : productDAO.getListProduct(AllConstant.Product_FEATURED, 0L)) {
                                if (count < AllConstant.Product_FEATURED_Quantity) {
                                    count++;
                        %>

                        <div class="col-md-3 md-col">
                            <div class="col-md">
                                <a href="detail.jsp?product=<%=product.getCode()%>"><img  src="<%=product.getImage() == null ? AllConstant.url_no_image : product.getImage()%>" alt="" width="239" height="208"  /></a>	
                                <div class="top-content">
                                    <h5><a href="detail.jsp?product=<%=product.getCode()%>"><%=product.getName()%></a></h5>
                                    <div class="white">
                                        <a href="CartServlet?url=<%=url%>&command=plus&product=<%=product.getCode()%>" class="hvr-shutter-in-vertical hvr-shutter-in-vertical2 ">Thêm vào giỏ</a>
                                        <p class="dollar"><span class="in-dollar"><%=df.format(product.getPromotionPrice() == 0 ? product.getPrice() : product.getPromotionPrice())%></span></p>
                                        <div class="clearfix"></div>
                                    </div>

                                </div>							
                            </div>
                        </div>

                        <%
                                }
                            }
                        %>

                        <div class="clearfix"></div>
                    </div>
                </div>
                <!---->
                <div class="content-middle">
                    <h3 class="future">Nhãn hiệu</h3>
                    <div class="content-middle-in">
                        <ul id="flexiselDemo1">	
                            <%
                                for (ProductCategory productCategory : productCategoryDAO.getListProductCategory()) {
                            %>
                            <li><a href="product.jsp?category=<%=productCategory.getID()%>" ><img src="<%=productCategory.getImage()== null ? AllConstant.url_no_image : productCategory.getImage()%>" width="66" height="66"/> </a></li>
                                    <%
                                        }
                                    %>
                        </ul>


                    </div>
                </div>
                <!---->
                <div class="content-bottom">
                    <h3 class="future">Mới nhất</h3>
                    <div class="content-bottom-in">
                        <ul id="flexiselDemo2">	
                            <%
                                count = 0;
                                for (Product product : productDAO.getListProduct(AllConstant.Product_LATEST, 0L)) {
                                    if (count < AllConstant.Product_LATEST_Quantity) {
                                        count++;
                            %>
                            <li>
                                <div class="col-md men">
                                    <a href="detail.jsp?product=<%=product.getCode()%>" class="compare-in ">
                                        <img  src="<%=product.getImage() == null ? AllConstant.url_no_image : product.getImage()%>" alt=""  width="220" height="191" />
           
<!--                                        <div class="compare in-compare">
                                            <span>Add to Compare</span>
                                            <span>Add to Whislist</span>
                                        </div>-->
                                    </a>
                                    <div class="top-content bag">
                                        <h5><a href="detail.jsp?product=<%=product.getCode()%>"><%=product.getName()%></a></h5>
                                        <div class="white">
                                            <a href="CartServlet?url=<%=url%>&command=plus&product=<%=product.getCode()%>" class="hvr-shutter-in-vertical hvr-shutter-in-vertical2">Thêm vào giỏ</a>
                                            <p class="dollar"><span class="in-dollar"><%=df.format(product.getPromotionPrice() == 0 ? product.getPrice() : product.getPromotionPrice())%></span></p>
                                            <div class="clearfix"></div>
                                        </div>
                                    </div>							
                                </div>
                            </li>
                            <%
                                    }
                                }
                            %>

                        </ul>

                    </div>
                </div>
                <!--                <ul class="start">
                                    <li ><a href="#"><i></i></a></li>
                                    <li><span>1</span></li>
                                    <li class="arrow"><a href="#">2</a></li>
                                    <li class="arrow"><a href="#">3</a></li>
                                    <li class="arrow"><a href="#">4</a></li>
                                    <li class="arrow"><a href="#">5</a></li>
                                    <li ><a href="#"><i  class="next"> </i></a></li>
                                </ul> -->
            </div>
        </div>

        <jsp:include page="footer.jsp"></jsp:include>

    </body>
</html>
