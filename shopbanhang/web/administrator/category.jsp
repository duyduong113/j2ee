<%-- 
    Document   : category
    Created on : May 15, 2017, 6:47:54 PM
    Author     : DUONG
--%>

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
        <title>Quản lý danh mục sản phẩm</title>
        <%@include file="/administrator/include/headtag.jsp" %>
        <script src="${root}/administrator/js/jquery.min.js" type="text/javascript"></script>
    </head>
    <body class="skin-black">
        <%
            Users usersCurrent = (Users) session.getAttribute("users");
            if (usersCurrent == null) {
                response.sendRedirect("/shopbanhang/administrator/login.jsp");
            }

            ProductCategoryDAO productCategoryDAO = new ProductCategoryDAO();
            ProductCategory productCategory = null;
            ArrayList<ProductCategory> listCategory = new ArrayList<ProductCategory>();

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

            listCategory = productCategoryDAO.getListProductCategoryByNav(keyword, (pages - 1) * AllConstant.Paging_record_Admin, AllConstant.Paging_record_Admin);
            total = productCategoryDAO.countProductCategory(keyword);

            //get attribute error data
            String ID = "", Name = "", Status = "", Image = "", Name_err = "";
            //get data
            if (request.getAttribute("ID") != null) {
                ID = (String) request.getAttribute("ID");
            }
            if (request.getAttribute("Name") != null) {
                Name = (String) request.getAttribute("Name");
            }
            if (request.getAttribute("Status") != null) {
                Status = (String) request.getAttribute("Status");
            }
            if (request.getAttribute("Image") != null) {
                Image = (String) request.getAttribute("Image");
            }
            //get data error
            if (request.getAttribute("Name_err") != null) {
                Name_err = (String) request.getAttribute("Name_err");
            }

            // kiểm tra lỗi trả về
            if (Name_err.length() > 0) {
        %>
        <script>
            $(document).ready(function () {
                openTab('category-tab2');
            });
        </script>
        <%
        } else {
        %>
        <script>
            $(document).ready(function () {
                openTab('category-tab1');
            });
        </script>
        <%
            }
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
                openTab('category-tab2');
                $('input[name=ID]').val('');

                $('input[name=Name]').val('');
                $('#Name_err').text('');
                $('#myimage').attr("src", "${root}/<%=AllConstant.url_no_image_general%>");

                    }

                    function removeImage() {
                        $('#myimage').attr('src', '${root}/<%=AllConstant.url_no_image_general%>');
                                $('#cancel-image').css('display', 'none');
                            }

                            function bindData(categoryID) {
                                getProductCategory(categoryID);
                                openTab('category-tab2');
                            }

                            function getProductCategory(categoryID) {
                                $.ajax({
                                    type: "POST",
                                    url: "${root}/getProductCategoryServlet",
                                    data: "categoryID=" + categoryID,
                                    success: function (data) {
                                        $('input[name=ID]').val(data.category.ID);
                                        $('input[name=Name]').val(data.category.Name);
                                        if (data.category.Status === false) {
                                            $('.red').trigger('click');
                                        } else {
                                            $('.green').trigger('click');
                                        }
                                        if (data.category.Image === '' || data.category.Image === null) {
                                            $('#myimage').attr('src', '${root}/' +<%=AllConstant.url_no_image_general%>);
                                        } else {
                                            $('#myimage').attr('src', '${root}/' + data.category.Image);
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
                                <li class="active">Danh mục</li>
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
                                            <a data-toggle="tab" href="#category-tab1">Danh sách danh mục</a>
                                        </li>
                                        <li>
                                            <a data-toggle="tab" href="#category-tab2">Tạo & Chỉnh sửa</a>
                                        </li>
                                    </ul>
                                </header>
                                <div class="panel-body">
                                    <div class="tab-content">
                                        <div id="category-tab1" class="tab-pane active">
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
                                                            <table class="table table-hover">
                                                                <tr>
                                                                    <th></th>
                                                                    <th>Tên danh mục</th>
                                                                    <th>Ảnh danh mục</th>
                                                                    <th>Trạng thái</th>
                                                                </tr>
                                                                <%                                                                    for (ProductCategory category : listCategory) {
                                                                %>
                                                                <tr>
                                                                    <td>
                                                                        <a class='btn btn-xs btn-warning'  onclick="bindData(<%=category.getID()%>)" >
                                                                            <i class='fa fa-pencil-square-o' aria-hidden='true'></i>
                                                                        </a>
                                                                    </td>
                                                                    <td><%=category.getName()%></td>
                                                                    <td>
                                                                        <img src="${root}/<%=category.getImage() == null ? AllConstant.url_no_image : category.getImage()%>" width="40" height="40" ></td>
                                                                    <td>
                                                                        <%
                                                                            if (category.isStatus()) {
                                                                        %>
                                                                        <a href="${root}/ProductCategoryServlet?command=changestatus&Status=<%=category.isStatus() ? false : true%>&ID=<%=category.getID()%>&keyword=<%=keyword%>&pages=<%=pages%>" class="btn btn-success"><%=category.isStatus() ? AllConstant.Status_True : AllConstant.Status_False%></a>
                                                                        <%  } else {
                                                                        %>
                                                                        <a href="${root}/ProductCategoryServlet?command=changestatus&Status=<%=category.isStatus() ? false : true%>&ID=<%=category.getID()%>&keyword=<%=keyword%>&pages=<%=pages%>" class="btn btn-danger"><%=category.isStatus() ? AllConstant.Status_True : AllConstant.Status_False%></a>
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
                                                                    <li><a href="${root}/administrator/category.jsp?pages=<%=pages == 1 ? pages : pages - 1%>">«</a></li>
                                                                        <%
                                                                            for (int i = 1; i <= (total % AllConstant.Paging_record_Admin != 0 ? total / AllConstant.Paging_record_Admin + 1 : total / AllConstant.Paging_record_Admin); i++) {
                                                                        %>
                                                                    <li><a id="number<%=i%>" href="${root}/administrator/category.jsp?pages=<%=i%>"><%=i%></a></li>
                                                                        <%
                                                                            }
                                                                        %>
                                                                    <li><a href="${root}/administrator/category.jsp?pages=<%=pages == ((total % AllConstant.Paging_record_Admin == 0) ? (total / AllConstant.Paging_record_Admin) : (total / AllConstant.Paging_record_Admin + 1)) ? pages : pages + 1%>">»</a></li>
                                                                        <%
                                                                        } else {
                                                                        %>
                                                                    <li><a href="${root}/administrator/category.jsp?keyword=<%=keyword%>&pages=<%=pages == 1 ? pages : pages - 1%>">«</a></li>

                                                                    <%
                                                                        for (int i = 1; i <= (total % AllConstant.Paging_record_Admin != 0 ? total / AllConstant.Paging_record_Admin + 1 : total / AllConstant.Paging_record_Admin); i++) {
                                                                    %>
                                                                    <li><a id="number<%=i%>" href="${root}/administrator/category.jsp?keyword=<%=keyword%>&pages=<%=i%>"><%=i%></a></li>
                                                                        <%
                                                                            }
                                                                        %>
                                                                    <li><a href="${root}/administrator/category.jsp?keyword=<%=keyword%>&pages=<%=pages == (total / AllConstant.Paging_record_Admin + 1) ? pages : pages + 1%>">»</a></li>
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
                                        <div id="category-tab2" class="tab-pane">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <section class="panel">
                                                        <form id="myform" class="form-horizontal tasi-form" action="${root}/ProductCategoryServlet" method="POST"  enctype="multipart/form-data" >
                                                            <input type="hidden" name="ID">
                                                            <input type="hidden" name="command" value="insertupdate">
                                                            <input type="hidden" name="url" value="<%=url%>">
                                                            <section class="panel">
                                                                <div class="panel-body">
                                                                    <div style="float:right">
                                                                        <a onclick="resetForm()" class="btn btn-default"><i class="fa fa-ban" aria-hidden="true"></i> Hủy</a>
                                                                        <button type="submit" class="btn btn-success"><i class="fa fa-floppy-o" aria-hidden="true"></i> Lưu</button>
                                                                    </div>
                                                                </div>
                                                            </section>
                                                            <div class="panel-body">
                                                                <div class="col-md-12">
                                                                    <div class="col-md-3"></div>
                                                                    <div class="col-md-6">
                                                                        <div class="form-group">
                                                                            <label class="col-sm-3 control-label">Tên danh mục<span class="text-danger">*</span></label>
                                                                            <div class="col-sm-9">
                                                                                <input value="<%=Name.length() > 0 ? Name : ""%>" required type="text" name="Name" class="form-control">
                                                                                <span class="text-danger" id="Name_err"><%=Name_err%></span>
                                                                            </div>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label class="col-sm-3 control-label">Ảnh danh mục</label>
                                                                            <div class="col-sm-9">
                                                                                <div class="fileinput-new thumbnail" style="max-width: 280px; ">
                                                                                    <img id="myimage" src="${root}/<%=Image.length() > 0 ? Image : AllConstant.url_no_image_general%>" alt="" />
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
                                                                </div>
                                                            </div>
                                                        </form>
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
