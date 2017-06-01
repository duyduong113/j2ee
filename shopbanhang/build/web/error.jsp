<%-- 
    Document   : error
    Created on : May 16, 2017, 6:13:35 PM
    Author     : DUONG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lỗi</title>
        <%@include file="include/headtag.jsp" %>
        <c:set var="root" value="${pageContext.request.contextPath}"/>
    </head>
    <body>

        <div class="wrapper">

            <!--inner block start here-->
            <div class="inner-block col-md-4 col-md-offset-4"  style="margin-top: 100px;">
                <div class="error-404">  	
                    <div class="error-page-left">
                        <img class="img-responsive" src="${root}/images/generals/404.png" alt="">
                    </div>
                    <div class="text-center">
                        <h2 style="margin-bottom: 10px;">Lỗi! Mở trang thất bại</h2>
                        <h4 style="margin-bottom: 10px;">Không tìm thấy trang!!</h4>
                        <a href="${root}/index.jsp" class="btn btn-success">Mua hàng</a>
                        <a href="${root}/administrator/index.jsp" class="btn btn-danger">Quản trị</a>
                    </div>
                </div>
            </div>
            <!--inner block end here-->

        </div>




        <!--        <div class="error-page-body">
                    <div class="error-page">
                        <img src="images/generals/404.png" alt="" />
                    </div>
                    <div class="go-back">
                        <a href="index.html">Go To Home</a>
                    </div>
                </div>-->




    </body>
</html>
