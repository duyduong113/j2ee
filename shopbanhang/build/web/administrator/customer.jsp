<%-- 
    Document   : customer.jsp
    Created on : May 22, 2017, 9:21:26 PM
    Author     : DUONG
--%>

<%@page import="model.District"%>
<%@page import="model.City"%>
<%@page import="dao.CustomDataDAO"%>
<%@page import="common.AllConstant"%>
<%@page import="model.Users"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.UsersDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản lý khách hàng</title>
        <%@include file="/administrator/include/headtag.jsp" %>
        <script src="${root}/administrator/js/jquery.min.js" type="text/javascript"></script>


    </head>
    <body class="skin-black">
        <%
            Users usersCurrent = (Users) session.getAttribute("users");
            if (usersCurrent == null) {
                response.sendRedirect("/shopbanhang/administrator/login.jsp");
            }

            ArrayList<Users> listUsers = new ArrayList<Users>();
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
            String url = "";
            if (request.getQueryString() == null) {
                url = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getRequestURI();
            } else {
                url = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getRequestURI() + "?" + request.getQueryString();
            }
            listUsers = usersDAO.getListUserByGroupIDNav(AllConstant.Group_MEMBER, keyword, (pages - 1) * AllConstant.Paging_record_Admin, AllConstant.Paging_record_Admin);
            total = usersDAO.countUsersByGroupIDNav(AllConstant.Group_MEMBER, keyword);

            //get attribute error data
            String Email_err = "", Phone_err = "", UserName_err = "",
                    ID = "", Name = "", Phone = "", Email = "", Address = "", Image = "", ProvinceCode = "", DistrictCode = "", UserName = "";

            //get data
            if (request.getAttribute("ID") != null) {
                ID = (String) request.getAttribute("ID");
            }
            if (request.getAttribute("Name") != null) {
                Name = (String) request.getAttribute("Name");
            }
            if (request.getAttribute("Phone") != null) {
                Phone = (String) request.getAttribute("Phone");
            }
            if (request.getAttribute("Email") != null) {
                Email = (String) request.getAttribute("Email");
            }
            if (request.getAttribute("Address") != null) {
                Address = (String) request.getAttribute("Address");
            }
            if (request.getAttribute("Image") != null) {
                Image = (String) request.getAttribute("Image");
            }
            if (request.getAttribute("ProvinceCode") != null) {
                ProvinceCode = (String) request.getAttribute("ProvinceCode");
            }
            if (request.getAttribute("DistrictCode") != null) {
                DistrictCode = (String) request.getAttribute("DistrictCode");
            }
            if (request.getAttribute("UserName") != null) {
                UserName = (String) request.getAttribute("UserName");
            }

            //Get data error
            if (request.getAttribute("Email_err") != null) {
                Email_err = (String) request.getAttribute("Email_err");
            }
            if (request.getAttribute("Phone_err") != null) {
                Phone_err = (String) request.getAttribute("Phone_err");
            }
            if (request.getAttribute("UserName_err") != null) {
                UserName_err = (String) request.getAttribute("UserName_err");
            }

            // kiểm tra lỗi trả về
            if (Email_err.length() > 0 || Phone_err.length() > 0 || UserName_err.length() > 0) {
        %>
        <script>

            $(document).ready(function () {
                $('a[href="#customer-tab2"]').tab('show');
            });
        </script>
        <%
        } else {
        %>
        <script>
            $(document).ready(function () {
                openTab('customer-tab1');
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
            function removeImage() {
                $('#myimage').attr('src', '${root}/<%=AllConstant.url_no_image_general%>');
                        $('#cancel-image').css('display', 'none');
                    }
                    function resetForm() {
                        openTab('customer-tab2');
                        $('input[name=ID]').val('');

                        $('#Phone_err').text('');
                        $('#Email_err').text('');
                        $('#UserName_err').text('');

                        $('#myimage').attr("src", "${root}/<%=AllConstant.url_no_image_general%>");
                                $('input[name=Name]').val('');
                                $('input[name=Phone]').val('');
                                $('input[name=Email]').val('');
                                $('input[name=Address]').val('');
                                $('input[name=UserName]').val('');
                            }
                            function bindData(ID) {
                                openTab('customer-tab2');
                                getUsers(ID);
                            }
                            function getUsers(ID) {
                                $.ajax({
                                    type: "POST",
                                    url: "${root}/getUsersServlet",
                                    //async: false,
                                    //contentType: "application/json", // NOT dataType!
                                    data: "ID=" + ID,
                                    success: function (data) {
                                        getListDistrictByCityAndSelect(data.users.ProvinceCode, data.users.DistrictCode);
                                        $('input[name=ID]').val(data.users.ID);
                                        $('input[name=Name]').val(data.users.Name);
                                        $('input[name=Address]').val(data.users.Address);
                                        $('select[name=ProvinceCode] option[value=' + data.users.ProvinceCode + ']').attr('selected', 'selected');
                                        $('input[name=Phone]').val(data.users.Phone);
                                        $('input[name=UserName]').val(data.users.UserName);
                                        $('input[name=Email]').val(data.users.Email);
                                        if (data.users.Status === false) {
                                            $('.red').trigger('click');
                                        } else {
                                            $('.green').trigger('click');
                                        }
                                        if (data.users.Image === '' || data.users.Image === null) {
                                            $('#myimage').attr('src', '${root}/<%=AllConstant.url_no_image_general%>');
                                                            } else {
                                                                $('#myimage').attr('src', '${root}/' + data.users.Image);
                                                            }

                                                            $('input[name=UserName]').attr('readonly', true);
                                                        }
                                                    });
                                                }
                                                function changeProvince(Code) {
                                                    $('#DistrictCode').find('option').not(':first').remove();
                                                    var CityCode = Code;
                                                    getListDistrictByCity(CityCode);
                                                }
                                                function getListDistrictByCity(CityCode) {
                                                    $.ajax({
                                                        type: "POST",
                                                        url: "${root}/GetListDistrictByCityServlet",
                                                        data: "CityCode=" + CityCode,
                                                        success: function (data) {
                                                            var html = '<option value="">Quận-Huyện</option>';
                                                            for (var i = 0; i < data.lstdistrict.length; i++) {
                                                                html += '<option value="' + data.lstdistrict[i].Code + '">'
                                                                        + data.lstdistrict[i].Name + '</option>';
                                                            }
                                                            html += '</option>';
                                                            $('#DistrictCode').html(html);
                                                        }
                                                    });
                                                }
                                                function getListDistrictByCityAndSelect(CityCode, districtCode) {
                                                    $.ajax({
                                                        type: "POST",
                                                        url: "${root}/GetListDistrictByCityServlet",
                                                        data: "CityCode=" + CityCode,
                                                        success: function (data) {
                                                            var html = '<option value="">Quận-Huyện</option>';
                                                            for (var i = 0; i < data.lstdistrict.length; i++) {
                                                                if (data.lstdistrict[i].Code === districtCode) {
                                                                    html += '<option selected value="' + data.lstdistrict[i].Code + '">'
                                                                            + data.lstdistrict[i].Name + '</option>';
                                                                } else {
                                                                    html += '<option value="' + data.lstdistrict[i].Code + '">'
                                                                            + data.lstdistrict[i].Name + '</option>';
                                                                }
                                                            }
                                                            html += '</option>';
                                                            $('#DistrictCode').html(html);
                                                        }
                                                    });
                                                }
                                                function resetPassword() {
                                                    var url = window.location.href;
                                                    var ID = $('input[name=ID]').val();
                                                    if (ID.length > 0) {
                                                        $.ajax({
                                                            type: "POST",
                                                            url: "${root}/UsersManageServlet",
                                                            data: "ID=" + ID + "&command=resetpass" + "&keyword=<%=keyword%>&pages=<%=pages%>",
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

                var x_timer;
                $("#Email").keyup(function (e) {
                    clearTimeout(x_timer);
                    var email = $(this).val();
                    x_timer = setTimeout(function () {
                        check_email_ajax(email);
                    }, 1000);
                });

                function check_email_ajax(email) {

                    $("#email-result").html('<img src="ajax-loader.gif" />');
                    $.post('${root}/CheckEmailServlet', {'email': email}, function (data) {
                        $("#email-result").html((new XMLSerializer()).serializeToString(data));
                    });
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
                                <li class="active">Khách hàng</li>
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
                                            <a data-toggle="tab" href="#customer-tab1">Danh sách khách hàng</a>
                                        </li>
                                        <li>
                                            <a data-toggle="tab" href="#customer-tab2">Thôn tin khách hàng</a>
                                        </li>
                                    </ul>
                                </header>
                                <div class="panel-body">
                                    <div class="tab-content">
                                        <div id="customer-tab1" class="tab-pane active">
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
                                                                    <th></th>
                                                                    <th>Tên khách hàng</th>
                                                                    <th>Địa chỉ</th>
                                                                    <th>Số điện thoại</th>                                                                   
                                                                    <th>Email</th>
                                                                    <th>Trạng thái</th>
                                                                </tr>
                                                                <%                                                                    for (Users users : listUsers) {
                                                                %>
                                                                <tr id="table-middle">
                                                                    <td>
                                                                        <a class='btn btn-xs btn-warning' onclick="bindData('<%=users.getID()%>')">
                                                                            <i class='fa fa-pencil-square-o' aria-hidden='true'></i>
                                                                        </a>
                                                                    </td>
                                                                    <td>      
                                                                        <%=users.getName() == null ? "" : users.getName()%>
                                                                    </td>
                                                                    <td>                                                                     
                                                                        <%=users.getAddress() == null ? "" : users.getAddress()%>-<%=users.getDistrictCode() == null ? "" : customDataDAO.getDistrictByCode(users.getDistrictCode()).getName()%>-<%=users.getProvinceCode() == null ? "" : customDataDAO.getCityByCode(users.getProvinceCode()).getName()%>
                                                                    </td>
                                                                    <td>
                                                                        <%=users.getPhone() == null ? "" : users.getPhone()%>
                                                                    </td>

                                                                    <td>
                                                                        <%=users.getEmail() == null ? "" : users.getEmail()%>
                                                                    </td>
                                                                    <td>
                                                                        <%
                                                                            if (users.isStatus()) {
                                                                        %>
                                                                        <a href="${root}/CustomerServlet?command=changestatus&Status=<%=users.isStatus() ? false : true%>&ID=<%=users.getID()%>&keyword=<%=keyword%>&pages=<%=pages%>" class="btn btn-success"><%=users.isStatus() ? AllConstant.Status_True : AllConstant.Status_False%></a>
                                                                        <%  } else {
                                                                        %>
                                                                        <a href="${root}/CustomerServlet?command=changestatus&Status=<%=users.isStatus() ? false : true%>&ID=<%=users.getID()%>&keyword=<%=keyword%>&pages=<%=pages%>" class="btn btn-danger"><%=users.isStatus() ? AllConstant.Status_True : AllConstant.Status_False%></a>
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
                                                                    <li><a href="${root}/administrator/customer.jsp?pages=<%=pages == 1 ? pages : pages - 1%>">«</a></li>
                                                                        <%
                                                                            for (int i = 1; i <= (total % AllConstant.Paging_record_Admin != 0 ? total / AllConstant.Paging_record_Admin + 1 : total / AllConstant.Paging_record_Admin); i++) {
                                                                        %>
                                                                    <li><a id="number<%=i%>" href="${root}/administrator/customer.jsp?pages=<%=i%>"><%=i%></a></li>
                                                                        <%
                                                                            }
                                                                        %>
                                                                    <li><a href="${root}/administrator/customer.jsp?pages=<%=pages == ((total % AllConstant.Paging_record_Admin == 0) ? (total / AllConstant.Paging_record_Admin) : (total / AllConstant.Paging_record_Admin + 1)) ? pages : pages + 1%>">»</a></li>
                                                                        <%
                                                                        } else {
                                                                        %>
                                                                    <li><a href="${root}/administrator/customer.jsp?keyword=<%=keyword%>&pages=<%=pages == 1 ? pages : pages - 1%>">«</a></li>
                                                                        <%
                                                                            for (int i = 1; i <= (total % AllConstant.Paging_record_Admin != 0 ? total / AllConstant.Paging_record_Admin + 1 : total / AllConstant.Paging_record_Admin); i++) {
                                                                        %>
                                                                    <li><a id="number<%=i%>" href="${root}/administrator/customer.jsp?keyword=<%=keyword%>&pages=<%=i%>"><%=i%></a></li>
                                                                        <%
                                                                            }
                                                                        %>
                                                                    <li><a href="${root}/administrator/customer.jsp?keyword=<%=keyword%>&pages=<%=pages == (total / AllConstant.Paging_record_Admin + 1) ? pages : pages + 1%>">»</a></li>
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
                                        <div id="customer-tab2" class="tab-pane">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <section class="panel">
                                                        <form id="myform" class="form-horizontal tasi-form" action="${root}/CustomerServlet" method="Post" enctype="multipart/form-data" >
                                                            <input type="hidden" name="ID" value="<%=ID%>">
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
                                                                    <div class="row">
                                                                        <div class="col-md-6">
                                                                            <div class="form-group">
                                                                                <label class="col-sm-3 control-label">Tên khách hàng<span class="text-danger"> *</span></label>
                                                                                <div class="col-sm-9">
                                                                                    <input style="max-width: 95%" required type="text" name="Name" value="<%=Name.length() > 0 ? Name : ""%>" class="form-control">
                                                                                </div>
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <label class="col-sm-3 control-label">Số điện thoại<span class="text-danger"> *</span></label>
                                                                                <div class="col-sm-9">
                                                                                    <input  style="max-width: 95%" onkeypress='return event.charCode >= 48 && event.charCode <= 57' required min="0" type="text" value="<%=Phone.length() > 0 ? Phone : ""%>" name="Phone" class="form-control">
                                                                                    <div class="clearfix"></div>
                                                                                    <span class="text-danger" id="Phone_err"><%=Phone_err%></span>
                                                                                </div>
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <label class="col-sm-3 control-label">Email<span class="text-danger"> *</span></label>
                                                                                <div class="col-sm-9">
                                                                                    <input style="max-width: 95%;float: left;" required value="<%=Email.length() > 0 ? Email : ""%>" type="text" id="Email" name="Email" class="form-control">
                                                                                    <span style="max-width: 5%;float: left;margin-left: 2px;margin-top: 5px;"  id="email-result"></span>
                                                                                    <div class="clearfix"></div>
                                                                                    <span class="text-danger" id="Email_err"><%=Email_err%></span>
                                                                                </div>
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <label class="col-sm-3 control-label">Địa chỉ<span class="text-danger"> *</span></label>
                                                                                <div class="col-sm-9">
                                                                                    <input style="max-width: 95%" required type="text" value="<%=Address.length() > 0 ? Address : ""%>" name="Address" class="form-control">
                                                                                </div>
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <label class="col-sm-3 control-label">Tỉnh-TP<span class="text-danger"> *</span></label>
                                                                                <div class="col-sm-9">
                                                                                    <select style="max-width: 95%" onchange="changeProvince($(this).val())" required class="form-control" name="ProvinceCode" id="ProvinceCode">
                                                                                        <option value="">Tỉnh-Thành phố</option>
                                                                                        <%
                                                                                            for (City c : customDataDAO.getListCity()) {
                                                                                                if ((ProvinceCode.length() > 0 ? ProvinceCode : "").equals(c.getCode())) {
                                                                                        %>
                                                                                        <option selected value="<%=c.getCode()%>">
                                                                                            <%=c.getName()%>
                                                                                        </option>
                                                                                        <%
                                                                                        } else {
                                                                                        %>
                                                                                        <option value="<%=c.getCode()%>">
                                                                                            <%=c.getName()%>
                                                                                        </option>
                                                                                        <%
                                                                                                }
                                                                                            }
                                                                                        %>
                                                                                    </select> 
                                                                                </div>
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <label class="col-sm-3 control-label">Quận-Huyện<span class="text-danger"> *</span></label>
                                                                                <div class="col-sm-9">
                                                                                    <select style="max-width: 95%" required class="form-control" name="DistrictCode" id="DistrictCode" >
                                                                                        <option value="">Quận-Huyện</option>
                                                                                        <%
                                                                                            for (District c : customDataDAO.getListDistrictByCity((ProvinceCode.length() > 0 ? ProvinceCode : ""))) {
                                                                                                if ((DistrictCode.length() > 0 ? DistrictCode : "").equals(c.getCode())) {
                                                                                        %>
                                                                                        <option selected value="<%=c.getCode()%>">
                                                                                            <%=c.getName()%>
                                                                                        </option>
                                                                                        <%
                                                                                        } else {
                                                                                        %>
                                                                                        <option value="<%=c.getCode()%>">
                                                                                            <%=c.getName()%>
                                                                                        </option>
                                                                                        <%
                                                                                                }
                                                                                            }
                                                                                        %>
                                                                                    </select>
                                                                                </div>
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <label class="col-sm-3 control-label">Tài khoản<span class="text-danger"> *</span></label>
                                                                                <div class="col-sm-9">
                                                                                    <input style="max-width: 95%" required type="text" value="<%=UserName.length() > 0 ? UserName : ""%>" name="UserName" class="form-control">
                                                                                    <div class="clearfix"></div>
                                                                                    <span class="text-danger" id="UserName_err"><%=UserName_err%></span>
                                                                                </div>
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <label class="col-sm-3 control-label">Mật khẩu<span class="text-danger"> *</span></label>
                                                                                <div class="col-sm-9" >
                                                                                    <input readonly style="max-width: 80%; float: left;margin-right: 3px;" type="password" name="Password" class="form-control">
                                                                                    <a style="width:15%;float: left;" onclick="resetPassword()" class="btn btn-danger"><i class="fa fa-refresh" aria-hidden="true"></i> Reset</a>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-6">

                                                                            <div class="form-group">
                                                                                <label class="col-sm-3 control-label">Ảnh đại diện</label>
                                                                                <div class="col-sm-9">
                                                                                    <div class="fileinput-new thumbnail" style="max-width: 280px; ">
                                                                                        <img id="myimage" src="${root}/<%=Image.length() > 0 ? Image : AllConstant.url_no_image_general%>" alt=""  />
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
                                                                                    <div style="max-width: 95%" class="btn-group btn-group-circle" data-toggle="buttons">
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
