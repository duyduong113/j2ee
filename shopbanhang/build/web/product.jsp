<%-- 
    Document   : product
    Created on : May 10, 2017, 1:20:08 PM
    Author     : DUONG
--%>

<%@page import="common.AllConstant"%>
<%@page import="model.Cart"%>
<%@page import="model.ProductCategory"%>
<%@page import="dao.ProductCategoryDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="model.Product"%>
<%@page import="dao.ProductDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sản phẩm</title>
        <%@include file="include/headtag.jsp" %>


        <script type="text/javascript">
            $(document).ready(function () {
                getUrlVars();
                function getUrlVars() {
                    for (var vObj = {}, i = 0, vArr = window.location.search.substring(1).split('&');
                            i < vArr.length; v = vArr[i++].split('='), vObj[v[0]] = v[1]) {
                    }
                    if (typeof vObj.pages === "undefined") {
                          $('#number1').css("background","#FB5E33");
//                        var demo = document.getElementById("number1");
//                        demo.style.cssText = 'background: #FB5E33';

                    } else {
                        $('#number'+vObj.pages+'').css("background", "#FB5E33");
                    }
                }

            });
        </script>

    </head>
    <body>

        <%
            DecimalFormat df = new DecimalFormat("#,###");
            ProductDAO productDAO = new ProductDAO();
            String categoryID = "";
            if (request.getParameter("category") != null) {
                categoryID = request.getParameter("category");
            }

            int total = 1;
            int pages = 1;
            if (request.getParameter("pages") != null) {
                pages = Integer.parseInt(request.getParameter("pages"));
            }

            ProductCategoryDAO productCategoryDAO = new ProductCategoryDAO();
            ProductCategory productCategory = null;

            ArrayList<Product> listProduct = new ArrayList<Product>();

            if (categoryID.equals(AllConstant.Product_PROMOTION) == false) {
                productCategory = productCategoryDAO.getProductCategoryByID(Long.parseLong(categoryID));
                listProduct = productDAO.getListProductByNav(AllConstant.Product_BYCATEGORY, Long.parseLong(categoryID), (pages - 1) * AllConstant.Paging_record, AllConstant.Paging_record);
                total = productDAO.countProductByCategory(Long.parseLong(categoryID));
            } else {
                listProduct = productDAO.getListProductByNav(AllConstant.Product_PROMOTION, 0L, (pages - 1) * AllConstant.Paging_record, AllConstant.Paging_record);
                total = productDAO.countProductByPromotion();
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

        <jsp:include page="header.jsp"></jsp:include>    

            <div class="container">
                <div class="products">


                <%                    if (productCategory != null) {

                %>
                <h2 class=" products-in"><%=productCategory.getName()%></h2>
                <%
                } else {
                %>
                <h2 class=" products-in">Khuyến mãi</h2>
                <%
                    }
                    if (listProduct.size() == 0) {
                %>
                <h4 class="title">Không có kết quả nào!</h4>
                <%
                    } else{
                %>
                <div class=" top-products">
                    <%
                        for (Product p : listProduct) {
                    %>

                    <div class="col-md-3">
                        <div class="col-md" style="margin-bottom: 10%;">
                            <a href="detail.jsp?product=<%=p.getCode()%>" class="compare-in"><img  src="<%=p.getImage() == null ? AllConstant.url_no_image : p.getImage()%>" alt="" width="239" height="209" />
                            </a>	
                            <div class="top-content">
                                <h5><a href="detail.jsp?product=<%=p.getCode()%>"><%=p.getName()%></a></h5>
                                <div class="white">
                                    <a href="CartServlet?url=<%=url%>
                                       &command=plus&product=<%=p.getCode()%>" class="hvr-shutter-in-vertical hvr-shutter-in-vertical2">Thêm vào giỏ</a>
                                    <p class="dollar"><span><%=df.format(p.getPromotionPrice() == 0 ? p.getPrice() : p.getPromotionPrice())%> đ</span></p>
                                    <div class="clearfix"></div>
                                </div>
                            </div>							
                        </div>
                    </div>
                    <%
                        }
                    %>
                    <div class="clearfix"></div>

                    <ul class="start text-center">
                        <li><a href="product.jsp?category=<%=categoryID%>&pages=<%=pages == 1 ? pages : pages - 1%>"><i></i></a></li>

                        <%
                            for (int i = 1; i <= total / AllConstant.Paging_record + 1; i++) {
                        %>
                        <!-- <li><span>1</span></li>
                                                <li class="arrow"><a href="#">2</a></li>
                                                <li class="arrow"><a href="#">3</a></li>
                                                <li class="arrow"><a href="#">4</a></li>-->
                        <li class="arrow" ><a  id="number<%=i%>" href="product.jsp?category=<%=categoryID%>&pages=<%=i%>"><%=i%></a></li>
                            <%
                                }
                            %>
                        <li><a href="product.jsp?category=<%=categoryID%>&pages=<%=pages == (total / AllConstant.Paging_record + 1) ? pages : pages + 1%>"><i  class="next"> </i></a></li>
                    </ul>
                    <%
                        }
                    %>
                </div>

                
            </div>
        </div>

        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>
