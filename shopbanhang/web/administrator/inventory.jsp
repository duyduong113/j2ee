<%-- 
    Document   : product
    Created on : May 18, 2017, 9:00:32 AM
    Author     : DUONG
--%>

<%@page import="dao.UnitDAO"%>
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
        <title>Quản lý tồn kho</title>
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
            UnitDAO unitDAO = new UnitDAO();
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
                                <li class="active">Tồn kho</li>
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
                                            <a data-toggle="tab" href="#inventory-tab1">Tồn kho sản phẩm</a>
                                        </li>
                                    </ul>
                                </header>
                                <div class="panel-body">
                                    <div class="tab-content">
                                        <div id="inventory-tab1" class="tab-pane active">
                                            <div class="row">
                                                <div class="col-xs-12">
                                                    <div class="panel">         
                                                        <div class="panel-body table-responsive">
                                                            <div class="box-tools m-b-15">
                                                                <div class="col-md-6">
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
                                                                    <th>Mã sản phẩm</th>
                                                                    <th>Tên sản phẩm</th>
                                                                    <th>Số lượng tồn kho</th>
                                                                    <th>Giá bán</th>
                                                                    <th>Trạng thái</th>
                                                                </tr>

                                                                <%                                                                    for (Product p : listProduct) {
                                                                %>
                                                                <tr>
                                                                    <td>
                                                                        <%=p.getCode() == null ? "" : p.getCode()%>                                                           
                                                                    </td>
                                                                    <td>
                                                                        <%=p.getName() == null ? "" : p.getName()%>
                                                                    </td>
                                                                    <td>
                                                                        <%=productWarehouseDAO.getProductWarehouseByCode(p.getCode()).getStockOnhand()%>
                                                                    </td>
                                                                    <td>
                                                                        <%=df.format(p.getPrice())%>
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
