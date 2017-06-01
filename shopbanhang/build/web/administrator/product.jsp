<%-- 
    Document   : product
    Created on : May 18, 2017, 9:00:32 AM
    Author     : DUONG
--%>

<%@page import="dao.ProductWarehouseDAO"%>
<%@page import="model.Users"%>
<%@page import="model.ProductAttribute"%>
<%@page import="dao.ProductAttributeDAO"%>
<%@page import="dao.ProductDetailDAO"%>
<%@page import="model.ProductCategory"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="dao.ProductCategoryDAO"%>
<%@page import="common.AllConstant"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.ProductDAO"%>
<%@page import="model.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản lý sản phẩm</title>
        <%@include file="/administrator/include/headtag.jsp" %>
        <script src="${root}/administrator/js/jquery.min.js" type="text/javascript"></script>
        <script src="${root}/administrator/js/utilitycommon.js" type="text/javascript"></script>
    </head>
    <body class="skin-black">
        <%
            Users usersCurrent = (Users) session.getAttribute("users");
            if (usersCurrent == null) {
                response.sendRedirect("/shopbanhang/administrator/login.jsp");
            }

            DecimalFormat df = new DecimalFormat("#,###");
            ProductCategoryDAO productCategoryDAO = new ProductCategoryDAO();
            ProductDAO productDAO = new ProductDAO();
            ProductDetailDAO productDetailDAO = new ProductDetailDAO();
            ProductAttributeDAO productAttributeDAO = new ProductAttributeDAO();
            ProductWarehouseDAO productWarehouseDAO = new ProductWarehouseDAO();
            Product product = null;
            ArrayList<Product> listProduct = new ArrayList<Product>();
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

            listProduct = productDAO.getListProductByAdminNavSearch(keyword, (pages - 1) * AllConstant.Paging_record_Admin, AllConstant.Paging_record_Admin);
            total = productDAO.countProductByAdminSearch(keyword);

        %>
        <script>
            function onFileSelected(event) {
                var selectedFile = event.target.files[0];
                var reader = new FileReader();
                var imgtag = document.getElementById("myimage");
                imgtag.title = selectedFile.name;
                reader.onload = function (event) {
                    imgtag.src = event.target.result;
                };
                reader.readAsDataURL(selectedFile);
                $('#cancel-image').css('display', '');
            }
            function resetForm() {
                openTab('product-tab2');
                $('input[name=ID]').val('');

                $('#myimage').attr("src", "${root}/<%=AllConstant.url_no_image_general%>");
                        $('#tab-productdetail').css('display', 'none');
                        $('a[href="#detail-tab1"]').tab('show');

                    }
                    function validation() {
                        var Price = $('input[name=Price]').val();
                        var PromotionPrice = $('input[name=PromotionPrice]').val();
                        if (currencyToNumber(Price) < currencyToNumber(PromotionPrice)) {
                            $('#PromotionPrice_err').text('Giá khuyến mãi phải nhỏ hơn giá bán');
                            return false;
                        } else {
                            $('#PromotionPrice_err').text('');
                            $('input[name=Price]').val(currencyToNumber(Price));
                            $('input[name=PromotionPrice]').val(currencyToNumber(PromotionPrice));
                            return true;
                        }
                        return false;
                    }

                    function changeValue(ele, e) {
                        switch (e.keyCode) {
                            case 16:
                            case 17:
                            case 35:
                            case 36:
                            case 37:
                            case 38:
                            case 39:
                            case 40:
                                break;
                            default:
                                num = $(ele).val(numberToCurrency(currencyToNumber($(ele).val())))
                                break;
                        }
                    }

                    function removeImage() {
                        $('#myimage').attr('src', '${root}/<%=AllConstant.url_no_image_general%>');
                                $('#cancel-image').css('display', 'none');
                            }

                            function bindData(Code) {
                                openTab('product-tab2');
                                getProduct(Code);
                                getDetailProduct(Code);
                                $('#tab-productdetail').css('display', 'block');
                            }

                            function getProduct(Code) {
                                $.ajax({
                                    type: "POST",
                                    url: "${root}/getProductServlet",
                                    //contentType: "application/json", // NOT dataType!
                                    data: "Code=" + Code,
                                    success: function (data) {
                                        $('input[name=ID]').val(data.product.ID);
                                        $('input[name=Code]').val(data.product.Code);
                                        $('input[name=Name]').val(data.product.Name);
                                        $('input[name=Price]').val(data.product.Price);
                                        $('input[name=PromotionPrice]').val(data.product.PromotionPrice);
                                        $('input[name=Warranty]').val(data.product.Warranty);
                                        $('select[name=CategoryID] option[value=' + data.product.CategoryID + ']').attr('selected', 'selected');
                                        $('textarea[name=Description]').val(data.product.Description);
                                        if (data.product.Status === false) {
                                            $('.red').trigger('click');
                                        } else {
                                            $('.green').trigger('click');
                                        }
                                        if (data.product.Image === '' || data.product.Image === null) {
                                            $('#myimage').attr('src', '${root}/<%=AllConstant.url_no_image_general%>');
                                                            } else {
                                                                $('#myimage').attr('src', '${root}/' + data.product.Image);
                                                            }
                                                        }
                                                    });
                                                }
                                                function getDetailProduct(Code) {
                                                    $.ajax({
                                                        type: "POST",
                                                        url: "${root}/getProductDetailServlet",
                                                        //contentType: "application/json", // NOT dataType!
                                                        data: "Code=" + Code,
                                                        success: function (data) {

                                                            for (var i = 0; i < data.lstdetail.length; i++) {

                                                                $("input[name*=" + data.lstdetail[i].AttributeCode + "]").val(data.lstdetail[i].Value);

                                                            }

                                                        }
                                                    });
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
                                <li class="active">Sản phẩm</li>
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
                                            <a data-toggle="tab" href="#product-tab1">Danh sách sản phẩm</a>
                                        </li>
                                        <li>
                                            <a data-toggle="tab" href="#product-tab2">Tạo & Chỉnh sửa</a>
                                        </li>
                                    </ul>
                                </header>
                                <div class="panel-body">
                                    <div class="tab-content">
                                        <div id="product-tab1" class="tab-pane active">
                                            <div class="row">
                                                <div class="col-xs-12">
                                                    <div class="panel">         
                                                        <div class="panel-body table-responsive">
                                                            <div class="box-tools m-b-15">
                                                                <div class="col-md-6">
                                                                    <a id="create-new" onclick="resetForm()" class="btn btn-primary" > Tạo mới</a>
                                                                    <a href="#" role="button" class="btn btn-warning" data-toggle="modal"><i class="fa fa-file-excel-o"></i> Xuất dữ liệu </a>
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
                                                            <table class="table table-hover">
                                                                <tr>
                                                                    <th style="width:5px;"></th>
                                                                    <th>Thông tin sản phẩm</th>
                                                                    <th>Ảnh sản phẩm</th>
                                                                    <th>Mô tả sản phẩm</th>
                                                                    <th>Thông tin giá</th>
                                                                    <th>Trạng thái sử dụng</th>
                                                                </tr>

                                                                <%                                                                    for (Product p : listProduct) {
                                                                %>
                                                                <tr>
                                                                    <td>
                                                                        <a class='btn btn-xs btn-warning'  onclick="bindData('<%=p.getCode()%>')" >
                                                                            <i class='fa fa-pencil-square-o' aria-hidden='true'></i>
                                                                        </a>
                                                                    </td>
                                                                    <td>
                                                                        <p>
                                                                            <strong class="text-blue">Mã sản phẩm: </strong>
                                                                            <%=p.getCode() == null ? "" : p.getCode()%>
                                                                        </p>
                                                                        <p>
                                                                            <strong class="text-blue">Tên sản phẩm: </strong>
                                                                            <%=p.getName() == null ? "" : p.getName()%>
                                                                        </p>
                                                                        <p>
                                                                            <strong class="text-blue">Danh mục: </strong>
                                                                            <%=productCategoryDAO.getProductCategoryByID(p.getCategoryID()).getName()%>
                                                                        </p>                                                                      
                                                                    </td>
                                                                    <td>
                                                                        <img src="${root}/<%=p.getImage() == null ? AllConstant.url_no_image : p.getImage()%>" width="80" height="80" >
                                                                    </td>
                                                                    <td>
                                                                        <p>
                                                                            <strong class="text-blue">Tồn kho: </strong>
                                                                            <%=productWarehouseDAO.getProductWarehouseByCode(p.getCode()).getStockOnhand()%>
                                                                        </p>
                                                                        <p>
                                                                            <strong class="text-blue">Thời gian bảo hành: </strong>
                                                                            <%=p.getWarranty()%> tháng
                                                                        </p>
                                                                        <p>
                                                                            <strong class="text-blue">Mô tả: </strong>
                                                                            <%=p.getDescription().length() > 30 ? p.getDescription().substring(0, 30) + "..." : p.getDescription()%>
                                                                        </p> 
                                                                    </td>
                                                                    <td>
                                                                        <p>
                                                                            <strong class="text-blue">Giá bán: </strong>
                                                                            <%=df.format(p.getPrice())%>
                                                                        </p> 
                                                                        <p>
                                                                            <strong class="text-blue">Giá khuyễn mãi: </strong>
                                                                            <%=df.format(p.getPromotionPrice())%>
                                                                        </p>  
                                                                    </td>                                                                 
                                                                    <td>
                                                                        <%
                                                                            if (p.isStatus()) {
                                                                        %>
                                                                        <a href="${root}/ProductServlet?command=changestatus&Status=<%=p.isStatus() ? false : true%>&Code=<%=p.getCode()%>&keyword=<%=keyword%>&pages=<%=pages%>" class="btn btn-success"><%=p.isStatus() ? AllConstant.Status_True : AllConstant.Status_False%></a>
                                                                        <%  } else {
                                                                        %>
                                                                        <a href="${root}/ProductServlet?command=changestatus&Status=<%=p.isStatus() ? false : true%>&Code=<%=p.getCode()%>&keyword=<%=keyword%>&pages=<%=pages%>" class="btn btn-danger"><%=p.isStatus() ? AllConstant.Status_True : AllConstant.Status_False%></a>
                                                                        <%}%>
                                                                    </td>
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
                                                                    <li><a href="${root}/administrator/product.jsp?pages=<%=pages == 1 ? pages : pages - 1%>">«</a></li>
                                                                        <%
                                                                            for (int i = 1; i <= (total % AllConstant.Paging_record_Admin != 0 ? total / AllConstant.Paging_record_Admin + 1 : total / AllConstant.Paging_record_Admin); i++) {
                                                                        %>
                                                                    <li><a id="number<%=i%>" href="${root}/administrator/product.jsp?pages=<%=i%>"><%=i%></a></li>
                                                                        <%
                                                                            }
                                                                        %>
                                                                    <li><a href="${root}/administrator/product.jsp?pages=<%=pages == ((total % AllConstant.Paging_record_Admin == 0) ? (total / AllConstant.Paging_record_Admin) : (total / AllConstant.Paging_record_Admin + 1)) ? pages : pages + 1%>">»</a></li>
                                                                        <%
                                                                        } else {
                                                                        %>
                                                                    <li><a href="${root}/administrator/product.jsp?keyword=<%=keyword%>&pages=<%=pages == 1 ? pages : pages - 1%>">«</a></li>

                                                                    <%
                                                                        for (int i = 1; i <= (total % AllConstant.Paging_record_Admin != 0 ? total / AllConstant.Paging_record_Admin + 1 : total / AllConstant.Paging_record_Admin); i++) {
                                                                    %>
                                                                    <li><a id="number<%=i%>" href="${root}/administrator/product.jsp?keyword=<%=keyword%>&pages=<%=i%>"><%=i%></a></li>
                                                                        <%
                                                                            }
                                                                        %>
                                                                    <li><a href="${root}/administrator/product.jsp?keyword=<%=keyword%>&pages=<%=pages == (total / AllConstant.Paging_record_Admin + 1) ? pages : pages + 1%>">»</a></li>
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
                                        <div id="product-tab2" class="tab-pane">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <form id="myform" class="form-horizontal tasi-form" onsubmit="return validation()" action="${root}/ProductServlet" method="POST"  enctype="multipart/form-data" >
                                                        <input type="hidden" name="ID" id="ID">
                                                        <input type="hidden" name="command" value="insertupdate">
                                                        <section class="panel general">
                                                            <header class="panel-heading tab-bg-dark-navy-blue">
                                                                <ul class="nav nav-tabs">
                                                                    <li class="active col-md-offset-2">
                                                                        <a data-toggle="tab" href="#detail-tab1">Thông tin sản phẩm</a>
                                                                    </li>
                                                                    <li id="tab-productdetail" style="display: none;">
                                                                        <a data-toggle="tab" href="#detail-tab2">Thông số kỹ thuật</a>
                                                                    </li>
                                                                    <li class="pull-right">
                                                                        <div style="padding: 5px;">   
                                                                            <a onclick="resetForm()" class="btn btn-default"><i class="fa fa-ban" aria-hidden="true"></i> Hủy</a>
                                                                            <button type="submit" class="btn btn-success"><i class="fa fa-floppy-o" aria-hidden="true"></i> Lưu</button>
                                                                        </div>
                                                                    </li>
                                                                </ul>	
                                                            </header>
                                                            <div class="panel-body">
                                                                <div class="tab-content">
                                                                    <div id="detail-tab1" class="tab-pane active">
                                                                        <div class="row">
                                                                            <div class="col-md-12">
                                                                                <section class="panel">
                                                                                    <div class="panel-body">
                                                                                        <div class="col-md-12">
                                                                                            <div class="col-md-6">
                                                                                                <div class="form-group">
                                                                                                    <label class="col-sm-3 control-label">Mã sản phẩm</label>
                                                                                                    <div class="col-sm-9">
                                                                                                        <input type="text" name="Code" class="form-control" readonly="true" >
                                                                                                    </div>
                                                                                                </div>
                                                                                                <div class="form-group">
                                                                                                    <label class="col-sm-3 control-label">Tên sản phẩm<span class="text-danger">*</span></label>
                                                                                                    <div class="col-sm-9">
                                                                                                        <input type="text" name="Name" class="form-control" required="required">              
                                                                                                    </div>
                                                                                                </div>
                                                                                                <div class="form-group">
                                                                                                    <label class="col-sm-3 control-label">Giá bán<span class="text-danger">*</span></label>
                                                                                                    <div class="col-sm-9">
                                                                                                        <input onkeyup="changeValue(this, event)" onkeypress='return event.charCode >= 48 && event.charCode <= 57' type="text" min="1" name="Price" value="0" class="form-control"  >
                                                                                                    </div>
                                                                                                </div>
                                                                                                <div class="form-group">
                                                                                                    <label class="col-sm-3 control-label">Giá khuyến mãi</label>
                                                                                                    <div class="col-sm-9">
                                                                                                        <input type="text" onkeyup="changeValue(this, event)" onkeypress='return event.charCode >= 48 && event.charCode <= 57' min="0" name="PromotionPrice" value="0" class="form-control" >
                                                                                                        <span class="text-danger" id="PromotionPrice_err"></span>
                                                                                                    </div>
                                                                                                </div>
                                                                                                <div class="form-group">
                                                                                                    <label class="col-sm-3 control-label">Bảo hành</label>
                                                                                                    <div class="col-sm-9">
                                                                                                        <input type="number" min="0" name="Warranty" value="0" class="form-control">
                                                                                                    </div>
                                                                                                </div>
                                                                                                <div class="form-group">			
                                                                                                    <label class="col-md-3 control-label">Danh mục<span class="text-danger">*</span></label>
                                                                                                    <div class="col-sm-9">
                                                                                                        <select class="form-control" name="CategoryID" id="CategoryID" value="" required>
                                                                                                            <option value="">Danh mục sản phẩm</option>
                                                                                                            <%
                                                                                                                for (ProductCategory productCategory : productCategoryDAO.getListProductCategory()) {
                                                                                                            %>
                                                                                                            <option value="<%=productCategory.getID()%>"><%=productCategory.getName()%></option>
                                                                                                            <%
                                                                                                                }
                                                                                                            %>
                                                                                                        </select>   
                                                                                                    </div>
                                                                                                </div>
                                                                                                <div class="form-group">
                                                                                                    <label class="col-sm-3 control-label">Mô tả</label>
                                                                                                    <div class="col-sm-9">
                                                                                                        <textarea class="form-control" name="Description" required="required" style="resize: vertical;"></textarea>                                            
                                                                                                    </div>
                                                                                                </div>
                                                                                                <div class="form-group">
                                                                                                    <label class="col-sm-3 control-label">Trạng thái</label>
                                                                                                    <div class="col-sm-9">
                                                                                                        <div class="btn-group btn-group-circle" data-toggle="buttons">
                                                                                                            <label class="btn green btn-sm btn-outline active">
                                                                                                                <input type="radio" name="Status" value="true" class="toggle"> Đang sử dụng
                                                                                                            </label>
                                                                                                            <label class="btn red btn-sm  btn-outline">
                                                                                                                <input type="radio" name="Status" value="false" class="toggle" > Không sử dụng
                                                                                                            </label>
                                                                                                        </div>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                            <div class="col-md-6">
                                                                                                <div class="form-group">
                                                                                                    <label class="col-sm-3 control-label">Ảnh sản phẩm</label>
                                                                                                    <div class="col-sm-9">
                                                                                                        <div class="fileinput-new thumbnail" style="max-width: 280px; ">
                                                                                                            <img id="myimage" src="${root}/<%=AllConstant.url_no_image_general%>" alt=""  />
                                                                                                        </div>
                                                                                                        <div style="margin-top: -15px;">
                                                                                                            <span class="btn default btn-file btn-sm" style="">
                                                                                                                <span> Chọn ảnh </span>
                                                                                                                <input type="file" name="file" onchange="onFileSelected(event)">
                                                                                                            </span>
                                                                                                            <span id="cancel-image" class="btn btn-danger" onclick="removeImage()" style="display: none;">
                                                                                                                Bỏ
                                                                                                            </span>
                                                                                                        </div>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                </section>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div id="detail-tab2" class="tab-pane">
                                                                        <div class="row">
                                                                            <div class="col-md-12">
                                                                                <section class="panel">
                                                                                    <div class="panel-body">
                                                                                        <div class="col-md-12">
                                                                                            <%
                                                                                                for (ProductAttribute productAttribute : productAttributeDAO.getListProductAttribute()) {
                                                                                            %>
                                                                                            <div class="col-md-6">
                                                                                                <div class="form-group">
                                                                                                    <label class="col-sm-4 control-label"><%=productAttribute.getName()%></label>
                                                                                                    <div class="col-sm-8">
                                                                                                        <input type="text" name="<%=productAttribute.getCode()%>" class="form-control">              
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                            <%
                                                                                                }
                                                                                            %>
                                                                                        </div>
                                                                                    </div>
                                                                                </section>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </section>
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
