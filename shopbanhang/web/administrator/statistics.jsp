<%-- 
    Document   : category
    Created on : May 15, 2017, 6:47:54 PM
    Author     : DUONG
--%>

<%@page import="model.Statistics"%>
<%@page import="model.Users"%>
<%@page import="java.util.ArrayList"%>
<%@page import="common.AllConstant"%>
<%@page import="model.ProductCategory"%>
<%@page import="dao.ProductCategoryDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thống kê</title>
        <%@include file="/administrator/include/headtag.jsp" %>
        <script src="${root}/administrator/js/jquery.min.js" type="text/javascript"></script>

        <script type="text/javascript" src="http://www.google.com/jsapi"></script>
    </head>
    <body class="skin-black">
        <%
            Users usersCurrent = (Users) session.getAttribute("users");
            if (usersCurrent == null) {
                response.sendRedirect("/shopbanhang/administrator/login.jsp");
            }

            String command = "tab1";
            ArrayList<Statistics> listItem = new ArrayList<Statistics>();
            if (request.getAttribute("command") != null) {
                command = (String) request.getAttribute("command");
            }
            if (request.getAttribute("listItem") != null) {
                listItem = (ArrayList<Statistics>) request.getAttribute("listItem");
            }

            if (command.equals("tab1")) {
        %>
        <script>
            $(document).ready(function () {
                $('a[href="#statistics-tab1"]').tab('show');
            });
        </script>
        <%} else if (command.equals("tab2")) {%>
        <script>
            $(document).ready(function () {
                $('a[href="#statistics-tab2"]').tab('show');
            });
        </script>
        <%}%>

        <script type="text/javascript">
            // Load the Visualization API and the piechart package.
            google.load('visualization', '1', {'packages': ['columnchart']});

            // Set a callback to run when the Google Visualization API is loaded.
            google.setOnLoadCallback(drawChart);

            // Callback that creates and populates a data table,
            // instantiates the pie chart, passes in the data and
            // draws it.
            function drawChart() {
                var tab = window.location.search.toString().split('=')[1];
                // Create the data table.    
                var data = google.visualization.arrayToDataTable([
                ['Country', 'Area(square km)'],
            <%
                for (Statistics statistics : listItem) {
            %>
                ['<%=statistics.getName()%>'  , <%=statistics.getValue()%> ],
            <%
                }
            %>   
                //['JSP & Servlet', 20],['Spring', 8],['Struts', 13]
                ]);
                // Set chart options
                var options = {
                    'title': '',
                    is3D: true,
                    pieSliceText: 'label',
                    tooltip: {showColorCode: true},
                    'width': 700,
                    'height': 300
                };
                // Instantiate and draw our chart, passing in some options.
                var chart = new google.visualization.PieChart(document.getElementById('chart-' + tab));
                chart.draw(data, options);
            }
            </script>

        <jsp:include page="header.jsp"></jsp:include>

            <div class="wrapper row-offcanvas row-offcanvas-left">
            <jsp:include page="menu.jsp"></jsp:include>

                <aside class="right-side">
                    <!-- Main content -->
                    <section class="content">
                        <div class="row">
                            <div class="col-md-12">
                                <!--breadcrumbs start -->
                                <ul class="breadcrumb">
                                    <li><a href="${root}/administrator/index.jsp"><i class="fa fa-home"></i> Trang chủ</a></li>
                                <li class="active">Thống kê</li>
                            </ul>
                            <!--breadcrumbs end -->
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <!--tab nav start-->
                            <section class="panel general">
                                <header class="panel-heading tab-bg-dark-navy-blue">
                                    <ul class="nav nav-tabs">
                                        <li class="active">
                                            <a data-toggle="tab" href="#statistics-tab1">Thống kê danh mục sản phẩm</a>
                                        </li>
                                        <li>
                                            <a data-toggle="tab" href="#statistics-tab2">Thống kê danh thu</a>
                                        </li>
                                    </ul>
                                </header>
                                <div class="panel-body">
                                    <div class="tab-content">
                                        <div id="statistics-tab1" class="tab-pane active">
                                            <div class="row">
                                                <div class="col-xs-12">
                                                    <section class="panel">  
                                                        <header class="panel-heading">
                                                            <a href="#" role="button" class="btn btn-warning" data-toggle="modal"><i class="fa fa-file-excel-o"></i> Xuất dữ liệu </a>
                                                        </header>
                                                        <div class="panel-body">
                                                            <div id="tab-one" class="text-center">
                                                                <h3 class="text-green">Thống kê danh mục sản phẩm</h3>
                                                                <table class="data">
                                                                    <div id="chart-tab1"></div>
                                                                </table>
                                                            </div>
                                                        </div><!-- /.box-body -->
                                                    </section><!-- /.box -->
                                                </div>
                                            </div>
                                        </div>
                                        <div id="statistics-tab2" class="tab-pane">
                                            <div class="row">
                                                <div class="col-xs-12">
                                                    <section class="panel">
                                                        <header class="panel-heading">
                                                            <a href="#" role="button" class="btn btn-warning" data-toggle="modal"><i class="fa fa-file-excel-o"></i> Xuất dữ liệu </a>
                                                        </header>
                                                        <div class="panel-body">
                                                            <div id="tab-two" class="text-center">
                                                                <h3 class="text-green">Thống kê danh thu</h3>
                                                                <table class="data">
                                                                    <div id="chart-tab2"></div>
                                                                </table>
                                                            </div>
                                                        </div><!-- /.box-body -->
                                                    </section>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </section>
                            <!--tab nav start-->
                        </div>
                    </div>
                </section>
            </aside>
        </div>
        <%@include file="/administrator/include/foottag.jsp" %>
    </body>
</html>
