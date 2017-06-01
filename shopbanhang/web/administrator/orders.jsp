<%-- 
    Document   : order
    Created on : May 19, 2017, 12:10:14 AM
    Author     : DUONG
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="model.Users"%>
<%@page import="com.sun.org.apache.xpath.internal.compiler.Keywords"%>
<%@page import="dao.OrdersDetailDAO"%>
<%@page import="model.OrdersDetail"%>
<%@page import="dao.CustomDataDAO"%>
<%@page import="dao.UsersDAO"%>
<%@page import="common.AllConstant"%>
<%@page import="dao.OrdersDAO"%>
<%@page import="model.Orders"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.DecimalFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản lý đơn hàng</title>
        <%@include file="/administrator/include/headtag.jsp" %>
        <script src="${root}/administrator/js/jquery.min.js" type="text/javascript"></script>
    </head>
    <body class="skin-black">
        <%
            Users usersCurrent = (Users) session.getAttribute("users");
            if (usersCurrent == null) {
                response.sendRedirect("/shopbanhang/administrator/login.jsp");
            }

            DateFormat dateformat = new SimpleDateFormat("dd/MM/yyyy");
            DecimalFormat df = new DecimalFormat("#,###");
            ArrayList<Orders> listOrders = new ArrayList<Orders>();
            OrdersDAO ordersDAO = new OrdersDAO();
            UsersDAO usersDAO = new UsersDAO();
            CustomDataDAO customDataDAO = new CustomDataDAO();

            int total = 1;
            int pages = 1;
            String keyword = "";
            if (request.getParameter("pages") != null) {
                pages = Integer.parseInt(request.getParameter("pages"));
            }

            if (request.getParameter("keyword") != null) {
                keyword = request.getParameter("keyword");
            }

            listOrders = ordersDAO.getListOrderByNav(keyword, (pages - 1) * AllConstant.Paging_record_Admin, AllConstant.Paging_record_Admin);
            total = ordersDAO.countOrderByNav(keyword);
        %>

        <script>
            function bindData(Code) {
                openTab('orders-tab2');
                getOrders(Code);
                getDetailOrders(Code);
            }
            function getOrders(Code) {
                $.ajax({
                    type: "POST",
                    url: "${root}/getOrdersServlet",
                    data: "Code=" + Code,
                    success: function (data) {
                        $('input[name=ID]').val(data.orders.ID);
                        $('input[name=Code]').val(data.orders.Code);
                        $('input[name=ShipName]').val(data.orders.ShipName);
                        $('input[name=ShipAddress]').val(data.orders.ShipAddress);
                        $('input[name=ShipEmail]').val(data.orders.ShipEmail);
                        $('input[name=ShipMobile]').val(data.orders.ShipMobile);
                        $('input[name=CreatedDate]').val(data.orders.CreatedDate);
                        $('input[name=ModifiedDate]').val(data.orders.ModifiedDate);
                        $('input[name=ModifiedBy]').val(data.orders.ModifiedBy);
                        if (data.orders.Status === 1) {
                            $('.green').trigger('click');
                            $('#ModifiedDate').text('Ngày duyệt');
                            $('#ModifiedBy').text('Người duyệt');
                            $('#action').css('display', 'block');
                        } else if (data.orders.Status === 2) {
                            $('.blue').trigger('click');
                            $('#ModifiedDate').text('Ngày duyệt');
                            $('#ModifiedBy').text('Người duyệt');
                            $('#action').css('display', 'none');
                        } else {
                            $('.red').trigger('click');
                            $('#ModifiedDate').text('Ngày hủy');
                            $('#ModifiedBy').text('Người hủy');
                            $('#action').css('display', 'none');
                        }
                    }
                });
            }

            function getDetailOrders(Code) {
                $.ajax({
                    type: "POST",
                    url: "${root}/getOrdersDetailServlet",
                    data: "Code=" + Code,
                    success: function (data) {
                        var total = 0;
                        for (var i = 0; i < data.lstdetail.length; i++)
                        {
                            $("#table-detail").append("<tr><td>" + data.lstdetail[i].ProductCode + "</td>\n\
                                                            <td>" + data.lstdetail[i].ProductName + "</td>\n\
                                                            <td>" + parseFloat(data.lstdetail[i].Price, 10).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, "$1,").replace('.00', '').toString() + "</td>\n\
                                                            <td>" + data.lstdetail[i].Quantity + "</td>\n\
                                                            <td>" + parseFloat(data.lstdetail[i].Quantity * data.lstdetail[i].Price, 10).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, "$1,").replace('.00', '').toString() + "</td></tr>");
                            total += parseFloat(data.lstdetail[i].Quantity * data.lstdetail[i].Price);
                        }
                        $('#total-money').text('Tổng tiền: ' + parseFloat(total, 10).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, "$1,").replace('.00', '').toString() + '');
                    }
                });
            }

            function ChangeStatus(Status) {
                var url = window.location.href;
                var Code = $('input[name=Code]').val();
                if (Code.length > 0) {
                    $.ajax({
                        type: "POST",
                        url: "${root}/OrdersServlet",
                        data: "Code=" + Code + "&Status=" + Status + "&command=changestatus" + "&keyword=<%=keyword%>&pages=<%=pages%>",
                        success: function (data) {
                            window.location.href = url;
                        }
                    });
                }

            }

        </script>
        <script type="text/javascript">
            $(document).ready(function () {
                getUrlVars();
                function getUrlVars() {
                    for (var vObj = {}, i = 0, vArr = window.location.search.substring(1).split('&');
                            i < vArr.length; v = vArr[i++].split('='), vObj[v[0]] = v[1]) {
                    }
                    if (typeof vObj.pages === "undefined") {
                        $('#number1').css("background", "#ddd");
                    } else {
                        $('#number' + vObj.pages + '').css("background", "#ddd");
                    }
                }
            });

        </script>

        <style>
            #table-middle td {
                vertical-align: middle;
            }
        </style>

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
                                <li class="active">Đơn hàng</li>
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
                                            <a data-toggle="tab" href="#orders-tab1">Danh sách đơn hàng</a>
                                        </li>
                                        <li>
                                            <a data-toggle="tab" href="#orders-tab2">Thôn tin đơn hàng</a>
                                        </li>
                                    </ul>
                                </header>
                                <div class="panel-body">
                                    <div class="tab-content">
                                        <div id="orders-tab1" class="tab-pane active">
                                            <div class="row">
                                                <div class="col-xs-12">
                                                    <div class="panel">         
                                                        <div class="panel-body table-responsive">
                                                            <div class="box-tools m-b-15">
                                                                <form action="${root}/SearchServlet" method="POST">
                                                                    <div class="input-group">
                                                                        <input type="hidden" name="command" value="search">
                                                                        <input type="hidden" name="url" value="<%=request.getRequestURI()%>">
                                                                        <input type="text" name="keyword" class="form-control input-sm pull-right" style="width: 150px;" placeholder="Search"/>
                                                                        <div class="input-group-btn">
                                                                            <button class="btn btn-sm btn-default"><i class="fa fa-search" ></i></button>
                                                                        </div>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                            <%
                                                                if (total > 0) {
                                                            %> 
                                                            <table class="table table-bordered table-striped">
                                                                <tr>
                                                                    <th></th>
                                                                    <th>Mã đơn hàng</th>
                                                                    <th>Thông tin đặt hàng</th>
                                                                    <th>Thông tin nhận hàng</th>                                                                   
                                                                    <th>Trạng thái</th>
                                                                    <th></th>
                                                                </tr>

                                                                <%                                                                    for (Orders orders : listOrders) {
                                                                %>
                                                                <tr id="table-middle">
                                                                    <td>
                                                                        <a class='btn btn-xs btn-warning' onclick="bindData('<%=orders.getCode()%>')">
                                                                            <i class='fa fa-pencil-square-o' aria-hidden='true'></i>
                                                                        </a>
                                                                    </td>
                                                                    <td>
                                                                        <p>
                                                                            <strong class="text-blue">Mã đơn hàng: </strong>
                                                                            <%=orders.getCode() == null ? "" : orders.getCode()%>
                                                                        </p>
                                                                    </td>
                                                                    <td>
                                                                        <p>
                                                                            <strong class="text-blue">Tên người đặt: </strong>
                                                                            <%=usersDAO.getUser(orders.getCustomerID()).getName()%>
                                                                        </p>
                                                                        <p>
                                                                            <strong class="text-blue">SDT người đặt: </strong>
                                                                            <%=usersDAO.getUser(orders.getCustomerID()).getPhone() == null ? "" : usersDAO.getUser(orders.getCustomerID()).getPhone()%>
                                                                        </p>
                                                                        <p>
                                                                            <strong class="text-blue">Địa chỉ người đặt: </strong>
                                                                            <%=usersDAO.getUser(orders.getCustomerID()).getAddress() == null ? "" : usersDAO.getUser(orders.getCustomerID()).getAddress()%>-
                                                                            <%=customDataDAO.getDistrictByCode(usersDAO.getUser(orders.getCustomerID()).getDistrictCode()).getName()%>-
                                                                            <%=customDataDAO.getCityByCode(usersDAO.getUser(orders.getCustomerID()).getProvinceCode()).getName()%>
                                                                        </p>
                                                                    </td>
                                                                    <td>
                                                                        <p>
                                                                            <strong class="text-blue">Tên người nhận: </strong>
                                                                            <%=orders.getShipName() == null ? "" : orders.getShipName()%>
                                                                        </p>
                                                                        <p>
                                                                            <strong class="text-blue">SDT người nhận: </strong>
                                                                            <%=orders.getShipMobile() == null ? "" : orders.getShipMobile()%>
                                                                        </p>
                                                                        <p>
                                                                            <strong class="text-blue">Địa chỉ người nhận: </strong>
                                                                            <%=orders.getShipAddress() == null ? "" : orders.getShipAddress()%>
                                                                        </p>
                                                                    </td>
                                                                    <%
                                                                        if (orders.getStatus() == 1) {
                                                                    %>
                                                                    <td>
                                                                        <a class="btn btn-warning">
                                                                            <%=AllConstant.Order_Status_New%>
                                                                        </a>
                                                                    </td>
                                                                    <td>
                                                                        <a class='btn btn-xs btn-success' href="${root}/OrdersServlet?command=changestatus&Status=2&Code=<%=orders.getCode()%>&keyword=<%=keyword%>&pages=<%=pages%>">
                                                                            <i class="fa fa-check-circle" aria-hidden="true"> Duyệt</i>
                                                                        </a>
                                                                        <a class='btn btn-xs btn-danger' href="${root}/OrdersServlet?command=changestatus&Status=3&Code=<%=orders.getCode()%>&keyword=<%=keyword%>&pages=<%=pages%>">
                                                                            <i class="fa fa-times-circle-o" aria-hidden="true"> Hủy</i>
                                                                        </a>
                                                                    </td>
                                                                    <%
                                                                    } else if (orders.getStatus() == 2) {
                                                                    %>
                                                                    <td>
                                                                        <a class="btn btn-success">
                                                                            <%=AllConstant.Order_Status_Approved%>
                                                                        </a>
                                                                    </td>
                                                                    <td>
                                                                        <p>
                                                                            <strong class="text-blue">Ngày duyệt </strong>
                                                                            <%=orders.getModifiedDate() == null ? "" : dateformat.format(orders.getModifiedDate())%>
                                                                        </p>
                                                                        <p>
                                                                            <strong class="text-blue">Người duyệt: </strong>
                                                                            <%=usersDAO.getUserByUserName(orders.getModifiedBy()).getName()%>
                                                                        </p>
                                                                    </td>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <td>
                                                                        <a class="btn btn-danger">
                                                                            <%=AllConstant.Order_Status_Canceled%>
                                                                        </a>
                                                                    </td>
                                                                    <td>
                                                                        <p>
                                                                            <strong class="text-blue">Ngày hủy: </strong>
                                                                            <%=orders.getModifiedDate() == null ? "" : dateformat.format(orders.getModifiedDate())%>
                                                                        </p>
                                                                        <p>
                                                                            <strong class="text-blue">Người hủy: </strong>
                                                                            <%=usersDAO.getUserByUserName(orders.getModifiedBy()).getName()%>
                                                                        </p>
                                                                    </td>
                                                                    <%
                                                                        }
                                                                    %>

                                                                </tr>
                                                                <%
                                                                    }
                                                                %>
                                                            </table>
                                                            <div class="pagination pagination-sm">
                                                                <ul class="pagination">
                                                                    <%
                                                                        if (keyword.equals("")) {
                                                                    %>
                                                                    <li><a href="${root}/administrator/orders.jsp?pages=<%=pages == 1 ? pages : pages - 1%>">«</a></li>
                                                                        <%
                                                                            for (int i = 1; i <= (total % AllConstant.Paging_record_Admin != 0 ? total / AllConstant.Paging_record_Admin + 1 : total / AllConstant.Paging_record_Admin); i++) {
                                                                        %>
                                                                    <li><a id="number<%=i%>" href="${root}/administrator/orders.jsp?pages=<%=i%>"><%=i%></a></li>
                                                                        <%
                                                                            }
                                                                        %>
                                                                    <li><a href="${root}/administrator/orders.jsp?pages=<%=pages == ((total % AllConstant.Paging_record_Admin == 0) ? (total / AllConstant.Paging_record_Admin) : (total / AllConstant.Paging_record_Admin + 1)) ? pages : pages + 1%>">»</a></li>
                                                                        <%
                                                                        } else {
                                                                        %>
                                                                    <li><a href="${root}/administrator/orders.jsp?keyword=<%=keyword%>&pages=<%=pages == 1 ? pages : pages - 1%>">«</a></li>

                                                                    <%
                                                                        for (int i = 1; i <= (total % AllConstant.Paging_record_Admin != 0 ? total / AllConstant.Paging_record_Admin + 1 : total / AllConstant.Paging_record_Admin); i++) {
                                                                    %>
                                                                    <li><a id="number<%=i%>" href="${root}/administrator/orders.jsp?keyword=<%=keyword%>&pages=<%=i%>"><%=i%></a></li>
                                                                        <%
                                                                            }
                                                                        %>
                                                                    <li><a href="${root}/administrator/orders.jsp?keyword=<%=keyword%>&pages=<%=pages == (total / AllConstant.Paging_record_Admin + 1) ? pages : pages + 1%>">»</a></li>
                                                                        <%
                                                                            }
                                                                        %>
                                                                </ul>
                                                            </div>
                                                            <%
                                                            } else {
                                                            %>
                                                            <div class="text-danger text-center">
                                                                <strong style="font-size: 50px">Nothing to see here! </strong>
                                                            </div>
                                                            <%
                                                                }
                                                            %>
                                                        </div><!-- /.box-body -->
                                                    </div><!-- /.box -->
                                                </div>
                                            </div>
                                        </div>
                                        <div id="orders-tab2" class="tab-pane">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <section class="panel">
                                                        <form id="myform" class="form-horizontal tasi-form" >
                                                            <input type="hidden" name="ID">
                                                            <section class="panel">
                                                                <div class="panel-body">
                                                                    <div id="action" style="float:right;display: none;">
                                                                        <a onclick="ChangeStatus(2)" class="btn btn-success"><i class="fa fa-check-circle" aria-hidden="true"> Duyệt</i></a>
                                                                        <a onclick="ChangeStatus(3)" class="btn btn-danger"><i class="fa fa-times-circle-o" aria-hidden="true"> Hủy</i></a>
                                                                    </div>
                                                                </div>
                                                            </section>
                                                            <div class="panel-body">
                                                                <div class="col-md-12">
                                                                    <div class="row">
                                                                        <div class="col-md-4">
                                                                            <div class="form-group">
                                                                                <label class="col-sm-4 control-label">Mã đơn hàng</label>
                                                                                <div class="col-sm-8">
                                                                                    <input required type="text" name="Code" class="form-control" readonly>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <div class="form-group">
                                                                                <label class="col-sm-4 control-label">Tên người nhận</label>
                                                                                <div class="col-sm-8">
                                                                                    <input required type="text" name="ShipName" class="form-control" readonly>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <div class="form-group">
                                                                                <label class="col-sm-4 control-label">SDT người nhận</label>
                                                                                <div class="col-sm-8">
                                                                                    <input required type="text" name="ShipMobile" class="form-control" readonly>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="row">
                                                                        <div class="col-md-4">
                                                                            <div class="form-group">
                                                                                <label class="col-sm-4 control-label">Địa chỉ nhận</label>
                                                                                <div class="col-sm-8">
                                                                                    <input required type="text" name="ShipAddress" class="form-control" readonly>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <div class="form-group">
                                                                                <label class="col-sm-4 control-label">Email nhận</label>
                                                                                <div class="col-sm-8">
                                                                                    <input required type="text" name="ShipEmail" class="form-control" readonly>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <div class="form-group">
                                                                                <label class="col-sm-4 control-label">Trạng thái</label>
                                                                                <div class="col-sm-8">
                                                                                    <div class="btn-group btn-group-circle" data-toggle="buttons" style="pointer-events: none;">
                                                                                        <label class="btn green btn-sm btn-outline active">
                                                                                            <input type="radio" name="Status" value="true" class="toggle" readonly> Mới
                                                                                        </label>
                                                                                        <label class="btn blue btn-sm btn-outline ">
                                                                                            <input type="radio" name="Status" value="true" class="toggle" readonly> Đã duyệt
                                                                                        </label>
                                                                                        <label class="btn red btn-sm btn-outline ">
                                                                                            <input type="radio" name="Status" value="true" class="toggle" readonly> Đã hủy
                                                                                        </label>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="row">                                                                 
                                                                        <div class="col-md-4">
                                                                            <div class="form-group">
                                                                                <label class="col-sm-4 control-label">Ngày mua</label>
                                                                                <div class="col-sm-8">
                                                                                    <input required type="text" name="CreatedDate" class="form-control" readonly>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <div class="form-group">
                                                                                <label id="ModifiedDate" class="col-sm-4 control-label">Ngày duyệt</label>
                                                                                <div class="col-sm-8">
                                                                                    <input required type="text" name="ModifiedDate" class="form-control" readonly>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <div class="form-group">
                                                                                <label id="ModifiedBy" class="col-sm-4 control-label">Ngày duyệt</label>
                                                                                <div class="col-sm-8">
                                                                                    <input required type="text" name="ModifiedBy" class="form-control" readonly>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </form>
                                                    </section>
                                                    <section class="panel">
                                                        <header class="panel-heading">
                                                            Chi tiết đơn hàng
                                                        </header>
                                                        <div class="panel-body">
                                                            <table id="table-detail" class="table table-striped table-bordered">
                                                                <tr>
                                                                    <th>Mã sản phẩm</th>
                                                                    <th>Tên sản phẩm</th>
                                                                    <th>Đơn giá</th>
                                                                    <th>Số lượng</th>
                                                                    <th>Thành tiền</th>
                                                                </tr>
                                                            </table>
                                                            <div class="table-foot">
                                                                <strong class="pull-right">
                                                                    <spam id="total-money" class="text-blue">Tổng tiền: 0</spam>
                                                                </strong>
                                                            </div>
                                                        </div><!-- /.panel-body -->
                                                    </section><!-- /.panel -->
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
