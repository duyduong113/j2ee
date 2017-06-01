<%-- 
    Document   : cart
    Created on : May 13, 2017, 9:44:41 AM
    Author     : DUONG
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="model.Product"%>
<%@page import="dao.ProductDAO"%>
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
        <title>Kết quả tìm kiếm</title>
        <%@include file="include/headtag.jsp" %>

        <script type="text/javascript">
            $(document).ready(function () {
                getUrlVars();
                function getUrlVars() {
                    for (var vObj = {}, i = 0, vArr = window.location.search.substring(1).split('&');
                            i < vArr.length; v = vArr[i++].split('='), vObj[v[0]] = v[1]) {
                    }
                    if (typeof vObj.pages === "undefined") {
                        $('#number1').css("background", "#FB5E33");

                    } else {
                        $('#number' + vObj.pages + '').css("background", "#FB5E33");
                    }
                }

            });
        </script>

    </head>
    <body>
        <%
            DecimalFormat df = new DecimalFormat("#,###");
            ProductDAO productDAO = new ProductDAO();

            int total = 1;
            int pages = 1;
            String txtSearch = "", keyword = "";
            ArrayList<Product> listProduct = new ArrayList<Product>();

            if (request.getParameter("keyword") != null) {
                keyword = request.getParameter("keyword");
            }

            if (request.getParameter("pages") != null) {
                pages = Integer.parseInt(request.getParameter("pages"));
            }

            total = productDAO.countProductBySearch(keyword);
            listProduct = productDAO.getListProductByNavSearch(keyword, (pages - 1) * AllConstant.Paging_record, AllConstant.Paging_record);

            String url = "";
            if (request.getQueryString() == null) {
                url = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getRequestURI();

            } else {
                url = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getRequestURI() + "?" + request.getQueryString();
            }

        %>

        <jsp:include page="header.jsp"></jsp:include>


            <div class="container">
                <h2 class="bg-info" style="margin:3% 0;">Kết quả tìm kiếm</h2>

            <%                if (keyword.equals("") == false) {
                    if (listProduct.size() == 0) {


            %>
            <h4 class="title">Không có kết quả nào!</h4>
            <%                } else {
                for (Product product : listProduct) {
            %>

            <div class="col-md-3">
                <div class="col-md" style="margin-bottom: 10%;">
                    <a href="detail.jsp?product=<%=product.getCode()%>" class="compare-in"><img  src="<%=product.getImage() == null ? AllConstant.url_no_image : product.getImage()%>" alt="" width="239" height="209" />
                    </a>	
                    <div class="top-content">
                        <h5><a href="detail.jsp?product=<%=product.getCode()%>"><%=product.getName()%></a></h5>
                        <div class="white">
                            <a href="CartServlet?url=<%=url%>
                               &command=plus&product=<%=product.getCode()%>" class="hvr-shutter-in-vertical hvr-shutter-in-vertical2">Thêm vào giỏ</a>
                            <p class="dollar"><span><%=df.format(product.getPromotionPrice() == 0 ? product.getPrice() : product.getPromotionPrice())%> đ</span></p>
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
                <li><a href="search.jsp?keyword=<%=keyword == null ? txtSearch : keyword%>&pages=<%=pages == 1 ? pages : pages - 1%>"><i></i></a></li>

                <%
                    for (int i = 1; i <= total / AllConstant.Paging_record + 1; i++) {
                %>
                <li class="arrow" ><a  id="number<%=i%>" href="search.jsp?keyword=<%=keyword == null ? txtSearch : keyword%>&pages=<%=i%>"><%=i%></a></li>
                    <%
                        }
                    %>
                <li><a href="search.jsp?keyword=<%=keyword == null ? txtSearch : keyword%>&pages=<%=pages == (total / AllConstant.Paging_record + 1) ? pages : pages + 1%>"><i  class="next"> </i></a></li>
            </ul>
            <%
                }
            } else {
            %>
            <h4 class="title">Vui lòng nhập từ khóa cần tìm!</h4>
            <%
                }
            %>


        </div>



        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>
