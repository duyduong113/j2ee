<%-- 
    Document   : menu
    Created on : May 15, 2017, 5:13:21 PM
    Author     : DUONG
--%>

<%@page import="common.AllConstant"%>
<%@page import="model.Users"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Menu</title>
        <c:set var="root" value="${pageContext.request.contextPath}"/>
    </head>
    <body>
        <%
            Users usersCurrent = (Users) session.getAttribute("users");
            if (usersCurrent == null) {
                response.sendRedirect("/shopbanhang/administrator/login.jsp");
            }
        %>
        <!-- Left side column. contains the logo and sidebar -->
        <aside class="left-side sidebar-offcanvas">
            <!-- sidebar: style can be found in sidebar.less -->
            <section class="sidebar">
                <!-- Sidebar user panel -->
                <div class="user-panel">
                    <div class="pull-left image">
                        <img src="${root}/<%=usersCurrent == null ? AllConstant.url_no_image : usersCurrent.getImage()%>" class="img-circle" alt="User Image" />
                    </div>
                    <div class="pull-left info">
                        <p>Hello, <%=usersCurrent == null ? "Guest" : usersCurrent.getName()%></p>

                        <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
                    </div>
                </div>
                <!-- search form -->
                <form class="sidebar-form" onsubmit="return false;">
                    <div class="input-group">
                        <input type="text" name="q" class="form-control" placeholder="Search..."/>
                        <span class="input-group-btn">
                            <button name='seach' id='search-btn' class="btn btn-flat"><i class="fa fa-search"></i></button>
                        </span>
                    </div>
                </form>
                <!-- /.search form -->
                <!-- sidebar menu: : style can be found in sidebar.less -->
                <ul class="sidebar-menu">
                    <li id="index">
                        <a href="${root}/administrator/index.jsp">
                            <i class="fa fa-home" aria-hidden="true"></i> <span>Trang chủ</span>
                        </a>
                    </li>
                    <li id="category">
                        <a href="${root}/administrator/category.jsp">
                            <i class="glyphicon glyphicon-indent-left"></i> <span>Quản lý danh mục</span>
                        </a>
                    </li>

                    <li id="product">
                        <a href="${root}/administrator/product.jsp">
                            <i class="glyphicon glyphicon-globe"></i> <span>Quản lý sản phẩm</span>
                        </a>
                    </li>

                    <li id="orders">
                        <a href="${root}/administrator/orders.jsp">
                            <i class="fa fa-bars"></i> <span>Quản lý đơn hàng</span>
                        </a>
                    </li>

                    <li id="customer">
                        <a href="${root}/administrator/customer.jsp">
                            <i class="fa fa-user"></i> <span>Quản lý khách hàng</span>
                        </a>
                    </li>
                    <%
                        if (usersCurrent != null && usersCurrent.getGroupID().equals(AllConstant.Group_ADMIN)) {
                    %>

                    <li id="users">
                        <a href="${root}/administrator/users.jsp">
                            <i class="fa fa-user"></i> <span>Quản lý người dùng</span>
                        </a>
                    </li>
                    
                    <li id="banner">
                        <a href="${root}/administrator/banner.jsp">
                            <i class="fa fa-terminal"></i> <span>Quản lý banner</span>
                        </a>
                    </li>
                    <%
                        }
                    %>
                    <li id="stockin">
                        <a href="${root}/administrator/stockin.jsp">
                            <i class="glyphicon glyphicon-import"></i> <span>Quản lý nhập kho</span>
                        </a>
                    </li>

                     <li id="inventory">
                        <a href="${root}/administrator/inventory.jsp">
                            <i class="glyphicon glyphicon-gift"></i> <span>Quản lý tồn kho</span>
                        </a>
                    </li>
                    
                    <li id="checkinventory">
                        <a href="${root}/administrator/checkinventory.jsp">
                            <i class="fa fa-check" aria-hidden="true"></i> <span>Quản lý kiểm kho</span>
                        </a>
                    </li>
                    
                    <li id="statistics">
                        <a href="${root}/StatisticsServlet?command=tab1">
                            <i class="fa fa-bar-chart-o"></i> <span>Thống kê</span>
                        </a>
                    </li>

                    <li id="feedback">
                        <a href="${root}/administrator/feedback.jsp">
                            <i class="fa fa-rss"></i> <span>Quản lý phản hồi</span>
                        </a>
                    </li>

                </ul>
            </section>
            <!-- /.sidebar -->
        </aside>

    </body>
</html>
