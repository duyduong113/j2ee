<%-- 
    Document   : order
    Created on : May 19, 2017, 12:10:14 AM
    Author     : DUONG
--%>
<%@page import="model.ProductWarehouse"%>
<%@page import="dao.CheckInventoryDAO"%>
<%@page import="model.CheckInventory"%>
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
            ArrayList<CheckInventory> listCheckInventory = new ArrayList<CheckInventory>();
            CheckInventoryDAO checkInventoryDAO = new CheckInventoryDAO();
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

            listCheckInventory = checkInventoryDAO.getListCheckInventoryByNav(keyword, (pages - 1) * AllConstant.Paging_record_Admin, AllConstant.Paging_record_Admin);
            total = checkInventoryDAO.countCheckInventoryByNav(keyword);
        %>

        <script>
            function resetForm() {
                openTab('checkinventory-tab2');
                $('input[name=ID]').val('');
                $('#action').css('display', 'none');
                $('textarea[name=Description]').attr('readonly', false);
                $('#details').removeClass('disabled-customer');
                $('#save').css('display', 'block');
                $('#thStockOnHand').remove();
            }
            function addNewRow() {
                $("#table-detail").append("<tr><td><a class='btn btn-xs btn-danger' onclick='removeRow(this)'><i class='fa fa-trash-o'></i></a></td>\n\
                                                <td><select required class='form-control' name='ProductCode' id='ProductCode'>\n\
                                                    <option value=''>Sản phẩm</option>\n\
            <%for (Product product : productDAO.getListProduct(AllConstant.Product_ALL, 0l)) {%>\n\
                                                        <option value='<%=product.getCode()%>'><%=product.getName()%></option>\n\
            <%}%>\n\
                                                </select></td>\n\
            <td><input onkeypress='return event.charCode >= 48 && event.charCode <= 57' type='number' required min='0' name='Quantity' class='form-control'></td></tr>");
            }
            function removeRow(e) {
                $($(e).closest("tr")).remove();
            }
            function bindData(Code) {
                openTab('checkinventory-tab2');
                getCheckInventory(Code);
                getCheckInventoryDetail(Code);
                 $('#thStockOnHand').remove();
            }
            function getCheckInventory(Code) {
                $.ajax({
                    type: "POST",
                    url: "${root}/getCheckInventoryServlet",
                    data: "Code=" + Code,
                    success: function (data) {
                        $('input[name=ID]').val(data.checkinventory.ID);
                        $('input[name=Code]').val(data.checkinventory.Code);
                        $('textarea[name=Description]').val(data.checkinventory.Description);
                        $('input[name=CreatedDate]').val(data.checkinventory.CreatedDate);
                        $('input[name=CreatedBy]').val(data.checkinventory.CreatedBy);
                        $('input[name=ModifiedDate]').val(data.checkinventory.ModifiedDate);
                        $('input[name=ModifiedBy]').val(data.checkinventory.ModifiedBy);
                        $('input[name=Status]').val(data.checkinventory.Status);

                        if (data.checkinventory.Status === false) {
                            $('.green').trigger('click');
                            $('textarea[name=Description]').attr('readonly', false);
                            $('#save').css('display', 'block');
                            $('#cancel').css('display', 'block');
                            $('#details').removeClass('disabled-customer');
                            $('#action').css('display', 'block');
                        } else {
                            $('.blue').trigger('click');
                            $('textarea[name=Description]').attr('readonly', true);
                            $('#save').css('display', 'none');
                            $('#cancel').css('display', 'block');
                            $('#details').addClass('disabled-customer');
                            $('#action').css('display', 'none');
                        }
                    }
                });
            }
            function getCheckInventoryDetail(Code) {
                $.ajax({
                    type: "POST",
                    url: "${root}/getCheckInventoryDetailServlet",
                    data: "Code=" + Code,
                    success: function (data) {
                        $('#table-detail th:last-child').after('<th id="thStockOnHand">Số lượng thục tế</th>');
                        for (var i = 0; i < data.lstdetail.length; i++)
                        {
                            //addNewRow();------------sửa lại chỗ này thêm row tồn kho
                            $("#table-detail").append("<tr><td><a class='btn btn-xs btn-danger' onclick='removeRow(this)'><i class='fa fa-trash-o'></i></a></td>\n\
                                                <td><select required class='form-control' name='ProductCode' id='ProductCode'>\n\
                                                    <option value=''>Sản phẩm</option>\n\
                                                    <%for (Product product : productDAO.getListProduct(AllConstant.Product_ALL, 0l)) {%>\n\
                                                        <option value='<%=product.getCode()%>'><%=product.getName()%></option>\n\
                                                        <%}%>\n\
                                                </select></td>\n\
            <td><input onkeypress='return event.charCode >= 48 && event.charCode <= 57' type='number' name='StockOnhand' class='form-control'></td>\n\
            <td><input onkeypress='return event.charCode >= 48 && event.charCode <= 57' type='number' required min='0' name='Quantity' class='form-control'></td></tr>");

                            //set data
                            $("#table-detail").find('tr:eq(' + (i + 1) + ')').find('td:eq(1)').find('option[value=' + data.lstdetail[i].ProductCode + ']').attr('selected', 'selected');
                            $("#table-detail").find('tr:eq(' + (i + 1) + ')').find('td:eq(2)').find('input').val(data.lstdetail[i].StockOnhand);
                            $("#table-detail").find('tr:eq(' + (i + 1) + ')').find('td:eq(3)').find('input').val(data.lstdetail[i].Quantity);
                        }
                    }
                });
            }
            function ChangeStatus() {
                var url = window.location.href;
                var Code = $('input[name=Code]').val();
                if (Code.length > 0) {
                    $.ajax({
                        type: "POST",
                        url: "${root}/CheckInventoryServlet",
                        data: "Code=" + Code + "&Status=true&command=changestatus" + "&keyword=<%=keyword%>&pages=<%=pages%>",
                        success: function (data) {
                            window.location.href = url;
                        }
                    });
                }
            }
            function submitForm() {
                //var url = window.location.pathname;
                var listCheckInventoryDetail = getDataBeforeSubmit();
                $.ajax({
                    type: "POST",
                    url: "${root}/CheckInventoryServlet",
                    datatype: "json",
                    traditional: true,
                    data: {
                        listCheckInventoryDetail: JSON.stringify(listCheckInventoryDetail),
                        command: "insertupdate",
                        keyword: "<%=keyword%>",
                        pages: "<%=pages%>",
                        ID: $("input[name=ID]").val(),
                        Code: $("input[name=Code]").val(),
                        Description: $('textarea[name=Description]').val()
                    },
                    success: function (data) {
                        window.location.href = data.toString();
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
                    var colQuantity_value = currentRow.find("td:eq(2)").find("input").val();
                    var obj = {};
                    obj.ProductCode = colProductCode_value;
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
                                <li class="active">Kiểm kho</li>
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
                                            <a data-toggle="tab" href="#checkinventory-tab1">Danh sách phiếu kiểm kho</a>
                                        </li>
                                        <li>
                                            <a data-toggle="tab" href="#checkinventory-tab2">Thông tin phiếu kiểm kho</a>
                                        </li>
                                    </ul>
                                </header>
                                <div class="panel-body">
                                    <div class="tab-content">
                                        <div id="checkinventory-tab1" class="tab-pane active">
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
                                                                    <th>Mã phiếu kiểm kho</th>
                                                                    <th>Mô tả</th>
                                                                    <th>Trạng thái</th>                                                                   
                                                                    <th></th>
                                                                </tr>

                                                                <%                                                                    for (CheckInventory checkinventory : listCheckInventory) {
                                                                %>
                                                                <tr id="table-middle">
                                                                    <td>
                                                                        <a class='btn btn-xs btn-warning' onclick="bindData('<%=checkinventory.getCode()%>')">
                                                                            <i class='fa fa-pencil-square-o' aria-hidden='true'></i>
                                                                        </a>
                                                                    </td>
                                                                    <td>
                                                                        <%=checkinventory.getCode() == null ? "" : checkinventory.getCode()%>

                                                                    </td>
                                                                    <td>  
                                                                        <%=checkinventory.getDescription() == null ? "" : checkinventory.getDescription()%>
                                                                    </td>   
                                                                    <%
                                                                        if (checkinventory.isStatus() == false) {
                                                                    %>
                                                                    <td>
                                                                        <a class="btn btn-warning">
                                                                            <%=AllConstant.Order_Status_New%>
                                                                        </a>
                                                                    </td>
                                                                    <td>
                                                                        <a class='btn btn-xs btn-success' href="${root}/CheckInventoryServlet?command=changestatus&Status=true&Code=<%=checkinventory.getCode()%>&keyword=<%=keyword%>&pages=<%=pages%>">
                                                                            <i class="fa fa-check-circle" aria-hidden="true"> Duyệt</i>
                                                                        </a>
                                                                    </td>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <td>
                                                                        <a class="btn btn-success">
                                                                            <%=AllConstant.Order_Status_Approved%>
                                                                        </a>
                                                                    </td>
                                                                    <td>
                                                                        <p>
                                                                            <strong class="text-blue">Ngày duyệt </strong>
                                                                            <%=checkinventory.getModifiedDate() == null ? "" : dateformat.format(checkinventory.getModifiedDate())%>
                                                                        </p>
                                                                        <p>
                                                                            <strong class="text-blue">Người duyệt: </strong>
                                                                            <%=usersDAO.getUserByUserName(checkinventory.getModifiedBy()).getName()%>
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
                                                                    <li><a href="${root}/administrator/checkinventory.jsp?pages=<%=pages == 1 ? pages : pages - 1%>">«</a></li>
                                                                        <%
                                                                            for (int i = 1; i <= (total % AllConstant.Paging_record_Admin != 0 ? total / AllConstant.Paging_record_Admin + 1 : total / AllConstant.Paging_record_Admin); i++) {
                                                                        %>
                                                                    <li><a id="number<%=i%>" href="${root}/administrator/checkinventory.jsp?pages=<%=i%>"><%=i%></a></li>
                                                                        <%
                                                                            }
                                                                        %>
                                                                    <li><a href="${root}/administrator/checkinventory.jsp?pages=<%=pages == ((total % AllConstant.Paging_record_Admin == 0) ? (total / AllConstant.Paging_record_Admin) : (total / AllConstant.Paging_record_Admin + 1)) ? pages : pages + 1%>">»</a></li>
                                                                        <%
                                                                        } else {
                                                                        %>
                                                                    <li><a href="${root}/administrator/checkinventory.jsp?keyword=<%=keyword%>&pages=<%=pages == 1 ? pages : pages - 1%>">«</a></li>

                                                                    <%
                                                                        for (int i = 1; i <= (total % AllConstant.Paging_record_Admin != 0 ? total / AllConstant.Paging_record_Admin + 1 : total / AllConstant.Paging_record_Admin); i++) {
                                                                    %>
                                                                    <li><a id="number<%=i%>" href="${root}/administrator/checkinventory.jsp?keyword=<%=keyword%>&pages=<%=i%>"><%=i%></a></li>
                                                                        <%
                                                                            }
                                                                        %>
                                                                    <li><a href="${root}/administrator/checkinventory.jsp?keyword=<%=keyword%>&pages=<%=pages == (total / AllConstant.Paging_record_Admin + 1) ? pages : pages + 1%>">»</a></li>
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
                                        <div id="checkinventory-tab2" class="tab-pane">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <form id="myform" onsubmit="submitForm()" class="form-horizontal tasi-form" method="post" >
                                                        <input type="hidden" name="ID">
                                                        <input type="hidden" name="command" value="insertupdate">
                                                        <section class="panel">
                                                            <section class="panel">
                                                                <div class="panel-body">
                                                                    <div id="action" style="float:right;display: none;">
                                                                        <a onclick="ChangeStatus()" class="btn btn-success"><i class="fa fa-check-circle" aria-hidden="true"> Duyệt</i></a>
                                                                    </div>
                                                                </div>
                                                            </section>
                                                            <div class="panel-body">
                                                                <div class="col-md-12">
                                                                    <div class="row">
                                                                        <div class="col-md-4">
                                                                            <div class="form-group">
                                                                                <label class="col-sm-4 control-label">Phiếu kiểm kho</label>
                                                                                <div class="col-sm-8">
                                                                                    <input type="text" name="Code" class="form-control" readonly>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <div class="form-group">
                                                                                <label class="col-sm-4 control-label">Người kiểm</label>
                                                                                <div class="col-sm-8">
                                                                                    <input type="text" name="CreatedBy" class="form-control" readonly>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <div class="form-group">
                                                                                <label class="col-sm-4 control-label">Ngày kiểm</label>
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
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="row">
                                                                        <div class="form-group col-md-8">
                                                                            <label class="col-sm-2 control-label">Ghi chú</label>
                                                                            <div class="col-sm-10">
                                                                                <textarea class="form-control" name="Description" required="required" style="resize: vertical;"></textarea> 
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </section>
                                                        <section class="panel">
                                                            <header class="panel-heading">
                                                                Chi tiết phiếu kiểm kho
                                                                <button id="save" style="float:right;margin-left: 5px;" type="submit" class="btn btn-sm  btn-success"><i class="fa fa-floppy-o" aria-hidden="true"></i> Lưu</button>
                                                                <a  style="float:right;margin-left: 5px;" class="btn btn-sm btn-default" href="javascript:void(0)" onclick="resetForm()"><i class="fa fa-ban"></i> Hủy </a>
                                                                <div  style="float:right;margin-left: 5px;" class="btn-group">
                                                                    <a class="btn green btn-sm btn-outline dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true" aria-expanded="true">
                                                                        Import
                                                                        <span class="fa fa-angle-down"> </span>
                                                                    </a>
                                                                    <ul class="dropdown-menu">
                                                                        <li>
                                                                            <a role="button" class="btn green btn-sm " data-toggle="modal"><i class="fa fa-upload"></i> Import </a>
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
                                                                        <th style="width: 50%;">Sản phẩm</th>
                                                                        <th>Số lượng kiểm kho</th>
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
