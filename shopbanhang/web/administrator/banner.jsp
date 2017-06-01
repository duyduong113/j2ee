<%-- 
    Document   : category
    Created on : May 15, 2017, 6:47:54 PM
    Author     : DUONG
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="model.Product"%>
<%@page import="dao.ProductDAO"%>
<%@page import="dao.BannerDAO"%>
<%@page import="model.Banner"%>
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
        <title>Quản lý banner</title>
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
            BannerDAO bannerDAO = new BannerDAO();
            ProductDAO productDAO = new ProductDAO();
            ArrayList<Banner> listBanner = new ArrayList<Banner>();

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

            listBanner = bannerDAO.getListBannerByNav(keyword, (pages - 1) * AllConstant.Paging_record_Admin, AllConstant.Paging_record_Admin);
            total = bannerDAO.countBanner(keyword);
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

            function validation() {
                var check = 0;
                var now = new Date();
                var today = new Date(now.getFullYear().toString() + "-" + (now.getMonth() + 1).toString() + "-" + now.getDate().toString());
                var StartDate = new Date($('input[name=StartDate]').val());
                var EndDate = new Date($('input[name=EndDate]').val());
                if (StartDate < today) {
                    $('#StartDate_err').text('Ngày bắt đầu phải lớn hơn ngày hiện tại');
                    check += 1;
                } else {
                    $('#StartDate_err').text('');
                }
                if (EndDate < today) {
                    $('#EndDate_err').text('Ngày kết thúc phải lớn hơn ngày hiện tại');
                    check += 1;
                } else {
                    $('#EndDate_err').text('');
                }
                if (StartDate > EndDate) {
                    $('#StartDate_err').text('Ngày bắt đầu phải nhỏ hơn ngày kết thúc');
                    $('#EndDate_err').text('Ngày kết thúc phải lớn hơn ngày bắt đầu');
                    check += 1;
                }
                if (check > 0) {
                    return false;
                } else {
                    return true;
                }
            }
            function resetForm() {
                openTab('banner-tab2');
                $('input[name=ID]').val('');

                $('#StartDate_err').text('');
                $('#EndDate_err').text('');
                $('#myimage').attr("src", "${root}/<%=AllConstant.url_no_image_general%>");
                    }
                    function removeImage() {
                        $('#myimage').attr('src', '${root}/<%=AllConstant.url_no_image_general%>');
                                $('#cancel-image').css('display', 'none');
                            }

                            function bindData(ID) {
                                getBanner(ID);
                                openTab('banner-tab2');
                            }

                            function getBanner(ID) {
                                $.ajax({
                                    type: "POST",
                                    url: "${root}/getBannerServlet",
                                    data: "ID=" + ID,
                                    success: function (data) {
                                        $('input[name=ID]').val(data.banner.ID);
                                        //$('input[name=ProductCode]').val(data.ProductCode.Name);
                                        $('input[name=Advertisement_Name]').val(data.banner.Advertisement_Name);
                                        $('input[name=StartDate]').val(data.banner.StartDate);
                                        $('input[name=EndDate]').val(data.banner.EndDate);

                                        if (data.banner.Status === false) {
                                            $('.red').trigger('click');
                                        } else {
                                            $('.green').trigger('click');
                                        }
                                        if (data.banner.Image === '' || data.banner.Image === null) {
                                            $('#myimage').attr('src', '${root}/' +<%=AllConstant.url_no_image_general%>);
                                        } else {
                                            $('#myimage').attr('src', '${root}/' + data.banner.Image);
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
                                <li class="active">Banner</li>
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
                                            <a data-toggle="tab" href="#banner-tab1">Danh sách banner</a>
                                        </li>
                                        <li>
                                            <a data-toggle="tab" href="#banner-tab2">Tạo & Chỉnh sửa</a>
                                        </li>
                                    </ul>
                                </header>
                                <div class="panel-body">
                                    <div class="tab-content">
                                        <div id="banner-tab1" class="tab-pane active">
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
                                                            <table class="table table-hover">
                                                                <tr>
                                                                    <th style="width:5px;"></th>
                                                                    <th>Chủ sở hữu</th>
                                                                    <th>Sản phẩm</th>
                                                                    <th>Hình ảnh</th>
                                                                    <th>Thời gian</th>
                                                                    <th>Trạng thái sử dụng</th>
                                                                </tr>
                                                                <%                                                                    for (Banner banner : listBanner) {
                                                                %>
                                                                <tr>
                                                                    <td>
                                                                        <a class='btn btn-xs btn-warning'  onclick="bindData(<%=banner.getID()%>)" >
                                                                            <i class='fa fa-pencil-square-o' aria-hidden='true'></i>
                                                                        </a>
                                                                    </td>
                                                                    <td>
                                                                        <%=banner.getAdvertisement_Name() == null ? "" : banner.getAdvertisement_Name()%>
                                                                    </td>
                                                                    <td>
                                                                        <%=productDAO.getProductByCode(banner.getProductCode()).getName()%>
                                                                    </td>
                                                                    <td>
                                                                        <img src="${root}/<%=banner.getImage() == null ? AllConstant.url_no_image : banner.getImage()%>" width="150" height="50" >
                                                                    </td>
                                                                    <td>
                                                                        <p>
                                                                            <strong class="text-blue">Ngày bắt đầu: </strong>
                                                                            <%=banner.getStartDate() == null ? "" : dateformat.format(banner.getStartDate())%>
                                                                        </p>
                                                                        <p>
                                                                            <strong class="text-blue">Ngày kết thúc: </strong>
                                                                            <%=banner.getEndDate() == null ? "" : dateformat.format(banner.getEndDate())%>
                                                                        </p>
                                                                    </td>
                                                                    <td>
                                                                        <%
                                                                            if (banner.isStatus()) {
                                                                        %>
                                                                        <a href="${root}/BannerServlet?command=changestatus&Status=<%=banner.isStatus() ? false : true%>&ID=<%=banner.getID()%>&keyword=<%=keyword%>&pages=<%=pages%>" class="btn btn-success"><%=banner.isStatus() ? AllConstant.Status_True : AllConstant.Status_False%></a>
                                                                        <%  } else {
                                                                        %>
                                                                        <a href="${root}/BannerServlet?command=changestatus&Status=<%=banner.isStatus() ? false : true%>&ID=<%=banner.getID()%>&keyword=<%=keyword%>&pages=<%=pages%>" class="btn btn-danger"><%=banner.isStatus() ? AllConstant.Status_True : AllConstant.Status_False%></a>
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
                                                                    <li><a href="${root}/administrator/banner.jsp?pages=<%=pages == 1 ? pages : pages - 1%>">«</a></li>
                                                                        <%
                                                                            for (int i = 1; i <= (total % AllConstant.Paging_record_Admin != 0 ? total / AllConstant.Paging_record_Admin + 1 : total / AllConstant.Paging_record_Admin); i++) {
                                                                        %>
                                                                    <li><a id="number<%=i%>" href="${root}/administrator/banner.jsp?pages=<%=i%>"><%=i%></a></li>
                                                                        <%
                                                                            }
                                                                        %>
                                                                    <li><a href="${root}/administrator/banner.jsp?pages=<%=pages == ((total % AllConstant.Paging_record_Admin == 0) ? (total / AllConstant.Paging_record_Admin) : (total / AllConstant.Paging_record_Admin + 1)) ? pages : pages + 1%>">»</a></li>
                                                                        <%
                                                                        } else {
                                                                        %>
                                                                    <li><a href="${root}/administrator/banner.jsp?keyword=<%=keyword%>&pages=<%=pages == 1 ? pages : pages - 1%>">«</a></li>

                                                                    <%
                                                                        for (int i = 1; i <= (total % AllConstant.Paging_record_Admin != 0 ? total / AllConstant.Paging_record_Admin + 1 : total / AllConstant.Paging_record_Admin); i++) {
                                                                    %>
                                                                    <li><a id="number<%=i%>" href="${root}/administrator/banner.jsp?keyword=<%=keyword%>&pages=<%=i%>"><%=i%></a></li>
                                                                        <%
                                                                            }
                                                                        %>
                                                                    <li><a href="${root}/administrator/banner.jsp?keyword=<%=keyword%>&pages=<%=pages == (total / AllConstant.Paging_record_Admin + 1) ? pages : pages + 1%>">»</a></li>
                                                                        <%
                                                                            }
                                                                        %>
                                                                </ul>
                                                            </div>

                                                        </div><!-- /.box-body -->
                                                    </div><!-- /.box -->
                                                </div>
                                            </div>
                                        </div>
                                        <div id="banner-tab2" class="tab-pane">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <section class="panel">
                                                        <form id="myform" onsubmit="return validation()" class="form-horizontal tasi-form" action="${root}/BannerServlet" method="POST"  enctype="multipart/form-data" >
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
                                                                    <div class="col-md-6 col-md-offset-3">
                                                                        <div class="form-group">
                                                                            <label class="col-sm-3 control-label">Chủ sở hữu<span class="text-danger">*</span></label>
                                                                            <div class="col-sm-9">
                                                                                <input required type="text" name="Advertisement_Name" class="form-control">
                                                                            </div>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label class="col-sm-3 control-label">Sản phẩm<span class="text-danger">*</span></label>
                                                                            <div class="col-sm-9">
                                                                                <select required class='form-control' name='ProductCode' id='ProductCode'>
                                                                                    <option value=''>Sản phẩm</option>
                                                                                    <%for (Product product : productDAO.getListProduct(AllConstant.Product_ALL, 0l)) {%>
                                                                                    <option value='<%=product.getCode()%>'><%=product.getName()%></option>
                                                                                    <%}%>
                                                                                </select>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-12">

                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label class="col-sm-3 control-label">Ngày bắt đầu<span class="text-danger">*</span></label>
                                                                            <div class="col-sm-9">
                                                                                <input required type="date" name="StartDate" class="form-control">
                                                                                <span class="text-danger" id="StartDate_err"></span>
                                                                            </div>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label class="col-sm-3 control-label">Ngày kết thúc<span class="text-danger">*</span></label>
                                                                            <div class="col-sm-9">
                                                                                <input required type="date" name="EndDate" class="form-control">
                                                                                <span class="text-danger" id="EndDate_err"></span>
                                                                            </div>
                                                                        </div>

                                                                        <div class="form-group">
                                                                            <label class="col-sm-3 control-label">Ảnh danh mục</label>
                                                                            <div class="col-sm-9">
                                                                                <div class="fileinput-new thumbnail" style="max-width: 280px; ">
                                                                                    <img id="myimage" src="${root}/<%=AllConstant.url_no_image_general%>" alt="" />
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
