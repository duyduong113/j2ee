<%-- 
    Document   : banner
    Created on : May 10, 2017, 8:09:26 AM
    Author     : DUONG
--%>

<%@page import="model.Banner"%>
<%@page import="dao.BannerDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Banner</title>

    </head>
    <body>

        <%
            BannerDAO bannerDAO = new BannerDAO();

        %>
        <!--banner-->
        <div class="banner-mat">
            <div class="container">
                <div class="banner">

                    <!-- Slideshow 4 -->
                    <div class="slider">
                        <ul class="rslides" id="slider1">
                            <%                                for (Banner banner : bannerDAO.getListBanner()) {
                            %>
                            </li>
                            <li><a href="detail.jsp?product=<%=banner.getProductCode()%>"> <img src="<%=banner.getImage()%>" alt="" style="max-width: 1112px;max-height: 405px;"  width="1112" height="405"></a>
                            </li>

                            <%
                                }
                            %>
                        </ul>
                    </div>

                    <div class="banner-bottom">
                        <div class="banner-matter">
                            <p>Hệ thống điện thoại KingPhone</p> 
                            <a href="category.jsp" class="hvr-shutter-in-vertical ">Mua ngay</a>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>				
                <!-- //slider-->
            </div>
        </div>
    </body>
</html>
