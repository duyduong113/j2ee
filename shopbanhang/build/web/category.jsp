<%-- 
    Document   : product
    Created on : May 10, 2017, 1:20:08 PM
    Author     : DUONG
--%>

<%@page import="common.AllConstant"%>
<%@page import="model.ProductCategory"%>
<%@page import="dao.ProductCategoryDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sản phẩm</title>
        <%@include file="include/headtag.jsp" %>
    </head>
    <body>
        <%
            ProductCategoryDAO productCategoryDAO = new ProductCategoryDAO();
        %>
        <jsp:include page="header.jsp"></jsp:include>    
        
        <div class="container">
            <div class="products">
                <h2 class=" products-in">Danh mục</h2>
                <h3 style="padding-left: 15px">TẤT CẢ DANH MỤC SẢN PHẨM [<%=productCategoryDAO.getListProductCategory().size()%> DANH MỤC]</h3>
                <div class=" top-products">
                    <%
                        for (ProductCategory productCategory : productCategoryDAO.getListProductCategory()) {
                    %>
                    <div class="col-md-3 md-col">
                        <div class="col-md">
                            <a href="product.jsp?category=<%=productCategory.getID()%>" class="compare-in"><img  src="<%=productCategory.getImage() == null ? AllConstant.url_no_image : productCategory.getImage()%>" alt="" width="239" height="209" />
                            </a>	
                            <div class="top-content">
                                <h5 class="text-center"><a href="detail.jsp"><%=productCategory.getName()%></a></h5>
                                <div class="white text-center">
                                    <a href="product.jsp?category=<%=productCategory.getID()%>" class="btn btn-block" style="background: #FB5E33; color: #FFFFFF">Xem chi tiết</a>
                                    <div class="clearfix"></div>
                                </div>
                            </div>							
                        </div>
                    </div>
                    <%
                        }
                    %>
                    
                    <div class="clearfix"></div>
                </div>
                
<!--                <ul class="start text-center">
                    <li ><a href="#"><i></i></a></li>
                    <li><span>1</span></li>
                    <li class="arrow"><a href="#">2</a></li>
                    <li class="arrow"><a href="#">3</a></li>
                    <li class="arrow"><a href="#">4</a></li>
                    <li class="arrow"><a href="#">5</a></li>
                    <li ><a href="#"><i  class="next"> </i></a></li>
                </ul>-->
            </div>
        </div>
        
        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>
