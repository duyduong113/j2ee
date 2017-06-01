<%-- 
    Document   : order
    Created on : May 19, 2017, 12:10:14 AM
    Author     : DUONG
--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="model.Users"%>
<%@page import="model.Product"%>
<%@page import="dao.ProductDAO"%>
<%@page import="model.Unit"%>
<%@page import="dao.UnitDAO"%>
<%@page import="dao.StockInDAO"%>
<%@page import="model.StockIn"%>
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
        <title>Quản lý nhập kho</title>
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
            ArrayList<StockIn> listStockIn = new ArrayList<StockIn>();
            StockInDAO stockinDAO = new StockInDAO();
            UnitDAO unitDAO = new UnitDAO();
            ProductDAO productDAO = new ProductDAO();
            UsersDAO usersDAO = new UsersDAO();

            int total = 1;
            int pages = 1;
            String keyword = "", url = "";
            if (request.getParameter("pages") != null) {
                pages = Integer.parseInt(request.getParameter("pages"));
            }
            if (request.getParameter("keyword") != null) {
                keyword = request.getParameter("keyword");
            }
            if (request.getQueryString() == null) {
                url = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getRequestURI();
            } else {
                url = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getRequestURI() + "?" + request.getQueryString();
            }

            listStockIn = stockinDAO.getListStockInByNav(keyword, (pages - 1) * AllConstant.Paging_record_Admin, AllConstant.Paging_record_Admin);
            total = stockinDAO.countStockInByNav(keyword);
        %>

        <script>
            function resetForm() {
                openTab('stockin-tab2');
                $('input[name=ID]').val('');
                $('#ModifiedDate').text('Ngày duyệt');
                $('#ModifiedBy').text('Người duyệt');
                $('#action').css('display', 'none');
                $('textarea[name=Note]').attr('readonly', false);
                $('#details').removeClass('disabled-customer');
                $('#save').css('display', 'block');
            }
            function addNewRow() {
                $("#table-detail").append("<tr><td><a class='btn btn-xs btn-danger' onclick='removeRow(this)'><i class='fa fa-trash-o'></i></a></td>\n\
                                                <td><select required class='form-control' name='ProductCode' id='ProductCode'>\n\
                                                    <option value=''>Sản phẩm</option>\n\
            <%for (Product product : productDAO.getListProduct(AllConstant.Product_ALL, 0l)) {%>\n\
                                                        <option value='<%=product.getCode()%>'><%=product.getName()%></option>\n\
            <%}%>\n\
                                                </select></td>\n\
                                                <td><select required class='form-control' name='UnitCode' id='UnitCode'>\n\
                                                     <option value=''>Đơn vị tính</option>\n\
            <%for (Unit unit : unitDAO.getListUnit()) {%>\n\
                                                     <option value='<%=unit.getCode()%>'><%=unit.getName()%></option>\n\
            <%}%>\n\
                                                </select></td>\n\
                                                <td><input onkeypress='return event.charCode >= 48 && event.charCode <= 57' type='number' required min='0' name='Quantity' class='form-control'></td></tr>");
            }
            function removeRow(e) {
                $($(e).closest("tr")).remove();
            }
            function bindData(Code) {
                openTab('stockin-tab2');
                getStockIn(Code);
                getStockInDetail(Code);
            }
            function getStockIn(Code) {
                $.ajax({
                    type: "POST",
                    url: "${root}/getStockInServlet",
                    data: "Code=" + Code,
                    success: function (data) {
                        $('input[name=ID]').val(data.stockin.ID);
                        $('input[name=Code]').val(data.stockin.Code);
                        $('input[name=CreatedDate]').val(data.stockin.CreatedDate);
                        $('input[name=CreatedBy]').val(data.stockin.CreatedBy);
                        $('input[name=ModifiedDate]').val(data.stockin.ModifiedDate);
                        $('input[name=ModifiedBy]').val(data.stockin.ModifiedBy);
                        $('input[name=Status]').val(data.stockin.Status);
                        $('textarea[name=Note]').val(data.stockin.Note);
                        if (data.stockin.Status === 1) {
                            $('.green').trigger('click');
                            $('#ModifiedDate').text('Ngày duyệt');
                            $('#ModifiedBy').text('Người duyệt');
                            $('textarea[name=Note]').attr('readonly', false);
                            $('#save').css('display', 'block');
                            $('#cancel').css('display', 'block');
                            $('#details').removeClass('disabled-customer');
                            $('#action').css('display', 'block');
                        } else if (data.stockin.Status === 2) {
                            $('.blue').trigger('click');
                            $('#ModifiedDate').text('Ngày duyệt');
                            $('#ModifiedBy').text('Người duyệt');
                            $('textarea[name=Note]').attr('readonly', true);
                            $('#save').css('display', 'none');
                            $('#cancel').css('display', 'block');
                            $('#details').addClass('disabled-customer');
                            $('#action').css('display', 'none');
                        } else {
                            $('.red').trigger('click');
                            $('#ModifiedDate').text('Ngày hủy');
                            $('#ModifiedBy').text('Người hủy');
                            $('textarea[name=Note]').attr('readonly', true);
                            $('#save').css('display', 'none');
                            $('#cancel').css('display', 'block');
                            $('#details').addClass('disabled-customer');
                            $('#action').css('display', 'none');
                        }
                    }
                });
            }
            function getStockInDetail(Code) {
                $.ajax({
                    type: "POST",
                    url: "${root}/getStockInDetailServlet",
                    data: "Code=" + Code,
                    success: function (data) {
                        for (var i = 0; i < data.lstdetail.length; i++)
                        {
                            addNewRow();
                            //set data
                            $("#table-detail").find('tr:eq(' + (i + 1) + ')').find('td:eq(1)').find('option[value=' + data.lstdetail[i].ProductCode + ']').attr('selected', 'selected');
                            $("#table-detail").find('tr:eq(' + (i + 1) + ')').find('td:eq(2)').find('option[value=' + data.lstdetail[i].UnitCode + ']').attr('selected', 'selected');
                            $("#table-detail").find('tr:eq(' + (i + 1) + ')').find('td:eq(3)').find('input').val(data.lstdetail[i].Quantity);
                        }
                    }
                });
            }
            function ChangeStatus(Status) {
                var url = window.location.href;
                var Code = $('input[name=Code]').val();
                if (Code.length > 0) {
                    $.ajax({
                        type: "POST",
                        url: "${root}/StockInServlet",
                        data: "Code=" + Code + "&Status=" + Status + "&command=changestatus" + "&keyword=<%=keyword%>&pages=<%=pages%>",
                        success: function (data) {
                            window.location.href = url;
                        }
                    });
                }
            }
            function submitForm() {
                //var url = window.location.pathname;
                var listStockInDetail = getDataBeforeSubmit();
                $.ajax({
                    type: "POST",
                    url: "${root}/StockInServlet",
                    datatype: "json",
                    traditional: true,
                    data: {
                        listStockInDetail: JSON.stringify(listStockInDetail),
                        command: "insertupdate",
                        keyword: "<%=keyword%>",
                        pages: "<%=pages%>",
                        ID: $("input[name=ID]").val(),
                        Code: $("input[name=Code]").val(),
                        Note: $('textarea[name=Note]').val()
                    },
                    success: function (data) {
                        window.location.href = data.toString();
//                        windown.window.location.reload();
                        $('#table-detail').TableSorter();
                    }
                });
            }
            function getDataBeforeSubmit() {
                var arrData = [];
                // loop over each table row (tr)
                $("#table-detail tr").not(':first').each(function () {
                    var currentRow = $(this);
                    //var col0_value = currentRow.find("td:eq(0)").text();
                    var colProductCode_value = currentRow.find("td:eq(1)").find(":selected").val();
                    var colUnitCode_value = currentRow.find("td:eq(2)").find(":selected").val();
                    var colQuantity_value = currentRow.find("td:eq(3)").find("input").val();
                    var obj = {};
                    //obj.col0 = col0_value;
                    obj.ProductCode = colProductCode_value;
                    obj.UnitCode = colUnitCode_value;
                    obj.Quantity = colQuantity_value;
                    arrData.push(obj);
                });
                return arrData;
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
                                <li class="active">Nhập kho</li>
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
                                            <a data-toggle="tab" href="#stockin-tab1">Danh sách phiếu nhập kho</a>
                                        </li>
                                        <li>
                                            <a data-toggle="tab" href="#stockin-tab2">Thông tin phiếu nhập kho</a>
                                        </li>
                                    </ul>
                                </header>
                                <div class="panel-body">
                                    <div class="tab-content">
                                        <div id="stockin-tab1" class="tab-pane active">
                                            <div class="row">
                                                <div class="col-xs-12">
                                                    <div class="panel">         
                                                        <div class="panel-body table-responsive">
                                                            <div class="box-tools m-b-15">
                                                                <div class="col-md-6">
                                                                    <a id="create-new" onclick="resetForm()" class="btn btn-primary" > Tạo mới</a>
                                                                </div>
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
                                                                    <th style="width:5px;"></th>
                                                                    <th>Mã phiếu nhập</th>
                                                                    <th>Thông tin nhập</th>
                                                                    <th>Trạng thái</th>                                                                   
                                                                    <th></th>
                                                                </tr>

                                                                <%                                                                    for (StockIn stockin : listStockIn) {
                                                                %>
                                                                <tr id="table-middle">
                                                                    <td>
                                                                        <a class='btn btn-xs btn-warning' onclick="bindData('<%=stockin.getCode()%>')">
                                                                            <i class='fa fa-pencil-square-o' aria-hidden='true'></i>
                                                                        </a>
                                                                    </td>
                                                                    <td>
                                                                        <p>
                                                                            <strong class="text-blue">Mã phiếu nhập: </strong>
                                                                            <%=stockin.getCode() == null ? "" : stockin.getCode()%>
                                                                        </p>
                                                                    </td>
                                                                    <td>
                                                                        <p>
                                                                            <strong class="text-blue">Ngày nhập: </strong>
                                                                            <%=stockin.getCreatedDate() == null ? "" : dateformat.format(stockin.getCreatedDate())%>
                                                                        </p>
                                                                        <p>
                                                                            <strong class="text-blue">Tên người nhâp: </strong>
                                                                            <%=usersDAO.getUserByUserName(stockin.getCreatedBy()).getName()%>
                                                                        </p>
                                                                    </td>   
                                                                    <%
                                                                        if (stockin.getStatus() == 1) {
                                                                    %>
                                                                    <td>
                                                                        <a class="btn btn-warning">
                                                                            <%=AllConstant.Order_Status_New%>
                                                                        </a>
                                                                    </td>
                                                                    <td>
                                                                        <a class='btn btn-xs btn-success' href="${root}/StockInServlet?command=changestatus&Status=2&Code=<%=stockin.getCode()%>&keyword=<%=keyword%>&pages=<%=pages%>">
                                                                            <i class="fa fa-check-circle" aria-hidden="true"> Duyệt</i>
                                                                        </a>
                                                                        <a class='btn btn-xs btn-danger' href="${root}/StockInServlet?command=changestatus&Status=3&Code=<%=stockin.getCode()%>&keyword=<%=keyword%>&pages=<%=pages%>">
                                                                            <i class="fa fa-times-circle-o" aria-hidden="true"> Hủy</i>
                                                                        </a>
                                                                    </td>
                                                                    <%
                                                                    } else if (stockin.getStatus() == 2) {
                                                                    %>
                                                                    <td>
                                                                        <a class="btn btn-success">
                                                                            <%=AllConstant.Order_Status_Approved%>
                                                                        </a>
                                                                    </td>
                                                                    <td>
                                                                        <p>
                                                                            <strong class="text-blue">Ngày duyệt </strong>
                                                                            <%=stockin.getModifiedDate() == null ? "" : dateformat.format(stockin.getModifiedDate())%>
                                                                        </p>
                                                                        <p>
                                                                            <strong class="text-blue">Người duyệt: </strong>
                                                                            <%=usersDAO.getUserByUserName(stockin.getModifiedBy()).getName()%>
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
                                                                            <%=stockin.getModifiedDate() == null ? "" : dateformat.format(stockin.getModifiedDate())%>
                                                                        </p>
                                                                        <p>
                                                                            <strong class="text-blue">Người hủy: </strong>
                                                                            <%=usersDAO.getUserByUserName(stockin.getModifiedBy()).getName()%>
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
                                                                    <li><a href="${root}/administrator/stockin.jsp?pages=<%=pages == 1 ? pages : pages - 1%>">«</a></li>
                                                                        <%
                                                                            for (int i = 1; i <= (total % AllConstant.Paging_record_Admin != 0 ? total / AllConstant.Paging_record_Admin + 1 : total / AllConstant.Paging_record_Admin); i++) {
                                                                        %>
                                                                    <li><a id="number<%=i%>" href="${root}/administrator/stockin.jsp?pages=<%=i%>"><%=i%></a></li>
                                                                        <%
                                                                            }
                                                                        %>
                                                                    <li><a href="${root}/administrator/stockin.jsp?pages=<%=pages == ((total % AllConstant.Paging_record_Admin == 0) ? (total / AllConstant.Paging_record_Admin) : (total / AllConstant.Paging_record_Admin + 1)) ? pages : pages + 1%>">»</a></li>
                                                                        <%
                                                                        } else {
                                                                        %>
                                                                    <li><a href="${root}/administrator/stockin.jsp?keyword=<%=keyword%>&pages=<%=pages == 1 ? pages : pages - 1%>">«</a></li>

                                                                    <%
                                                                        for (int i = 1; i <= (total % AllConstant.Paging_record_Admin != 0 ? total / AllConstant.Paging_record_Admin + 1 : total / AllConstant.Paging_record_Admin); i++) {
                                                                    %>
                                                                    <li><a id="number<%=i%>" href="${root}/administrator/stockin.jsp?keyword=<%=keyword%>&pages=<%=i%>"><%=i%></a></li>
                                                                        <%
                                                                            }
                                                                        %>
                                                                    <li><a href="${root}/administrator/stockin.jsp?keyword=<%=keyword%>&pages=<%=pages == (total / AllConstant.Paging_record_Admin + 1) ? pages : pages + 1%>">»</a></li>
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
                                        <div id="stockin-tab2" class="tab-pane">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <form id="myform" onsubmit="submitForm()" class="form-horizontal tasi-form" method="post" >
                                                        <input type="hidden" name="ID">
                                                        <input type="hidden" name="command" value="insertupdate">
                                                        <section class="panel">
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
                                                                                <label class="col-sm-4 control-label">Mã phiếu nhập</label>
                                                                                <div class="col-sm-8">
                                                                                    <input type="text" name="Code" class="form-control" readonly>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <div class="form-group">
                                                                                <label class="col-sm-4 control-label">Tên người nhập</label>
                                                                                <div class="col-sm-8">
                                                                                    <input type="text" name="CreatedBy" class="form-control" readonly>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <div class="form-group">
                                                                                <label class="col-sm-4 control-label">Ngày nhập</label>
                                                                                <div class="col-sm-8">
                                                                                    <input type="text" name="CreatedDate" class="form-control" readonly>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="row">
                                                                        <div class="col-md-4">
                                                                            <div class="form-group">
                                                                                <label id="ModifiedDate" class="col-sm-4 control-label">Ngày duyệt</label>
                                                                                <div class="col-sm-8">
                                                                                    <input type="text" name="ModifiedDate" class="form-control" readonly>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <div class="form-group">
                                                                                <label id="ModifiedBy" class="col-sm-4 control-label">Người duyệt</label>
                                                                                <div class="col-sm-8">
                                                                                    <input type="text" name="ModifiedBy" class="form-control" readonly>
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
                                                                        <div class="form-group col-md-8">
                                                                            <label class="col-sm-2 control-label">Ghi chú</label>
                                                                            <div class="col-sm-10">
                                                                                <textarea class="form-control" name="Note" required="required" style="resize: vertical;"></textarea> 
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </section>
                                                        <section class="panel">
                                                            <header class="panel-heading">
                                                                Chi tiết phiếu nhập
                                                                <button id="save" style="float:right;margin-left: 5px;" type="submit" class="btn btn-sm  btn-success"><i class="fa fa-floppy-o" aria-hidden="true"></i> Lưu</button>
                                                                <a  style="float:right;margin-left: 5px;" class="btn btn-sm btn-default" href="javascript:void(0)" onclick="resetForm()"><i class="fa fa-ban"></i> Hủy </a>
                                                                <div  style="float:right;margin-left: 5px;" class="btn-group">
                                                                    <a class="btn green btn-sm btn-outline dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true" aria-expanded="true">
                                                                        Import
                                                                        <span class="fa fa-angle-down"> </span>
                                                                    </a>
                                                                    <ul class="dropdown-menu">
                                                                        <li>
                                                                            <a role="button" class="btn green btn-sm " data-toggle="modal"><i class="fa fa-upload"></i> Import sản phẩm </a>
                                                                        </li>
                                                                        <li>
                                                                            <a href="#" role="button" class="btn green btn-sm " data-toggle="modal"><i class="fa fa-file-excel-o"></i> Dowload template </a>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                                <div class="clearfix"></div>
                                                            </header>
                                                            <div id="details" class="panel-body">
                                                                <table id="table-detail" class="table table-striped table-bordered">
                                                                    <tr>
                                                                        <th style="width: 5px;">
                                                                            <a class='btn btn-xs btn-primary' onclick="addNewRow()">
                                                                                <i class='fa fa-plus'></i>
                                                                            </a>
                                                                        </th>
                                                                        <th>Sản phẩm</th>
                                                                        <th>Đơn vị tính</th>
                                                                        <th>Số lượng</th>
                                                                    </tr>
                                                                </table>
                                                            </div><!-- /.panel-body -->
                                                        </section><!-- /.panel -->
                                                    </form>
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
