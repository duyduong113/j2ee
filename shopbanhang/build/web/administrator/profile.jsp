<%-- 
    Document   : profile
    Created on : May 25, 2017, 2:37:43 PM
    Author     : DUONG
--%>

<%@page import="com.sun.xml.ws.config.metro.parser.jsr109.UrlPatternType"%>
<%@page import="common.*"%>
<%@page import="dao.*"%>
<%@page import="model.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tài khoản</title>
        <%@include file="/administrator/include/headtag.jsp" %>
        <script src="${root}/administrator/js/jquery.min.js" type="text/javascript"></script>
    </head>
    <body class="skin-black">

        <%
            Users usersCurrent = (Users) session.getAttribute("users");
            if (usersCurrent == null) {
                response.sendRedirect("/shopbanhang/administrator/login.jsp");
            }

            String url = "";
            if (request.getQueryString() == null) {
                url = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getRequestURI();
            } else {
                url = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getRequestURI() + "?" + request.getQueryString();
            }

            CustomDataDAO customDataDAO = new CustomDataDAO();
            String Phone_err = "", Email_err = "",
                    Name = "", Address = "", Email = "", Phone = "", Image = "", ProvinceCode = "", DistrictCode = "";

            //get data
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

            //Get data error
            if (request.getAttribute("Email_err") != null) {
                Email_err = (String) request.getAttribute("Email_err");
            }
            if (request.getAttribute("Phone_err") != null) {
                Phone_err = (String) request.getAttribute("Phone_err");
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
                        //$('#myform')[0].reset();
                        $('#myimage').attr("src", "${root}/<%=usersCurrent != null ? usersCurrent.getImage().replace("\\", "/") : AllConstant.url_no_image_general%>");

                                $('input[name=Name]').val('<%=usersCurrent != null ? usersCurrent.getName() : ""%>');
                                $('input[name=Phone]').val('<%=usersCurrent != null ? usersCurrent.getPhone() : ""%>');
                                $('input[name=Email]').val('<%=usersCurrent != null ? usersCurrent.getEmail() : ""%>');
                                $('input[name=Address]').val('<%=usersCurrent != null ? usersCurrent.getAddress() : ""%>');
                                $('select[name=ProvinceCode] option[value=<%=usersCurrent != null ? usersCurrent.getProvinceCode() : ""%>]').attr('selected', 'selected');
                                getListDistrictByCityAndSelect('<%=usersCurrent != null ? usersCurrent.getProvinceCode() : ""%>', '<%=usersCurrent != null ? usersCurrent.getDistrictCode() : ""%>');
                                $('#Phone_err').text('');
                                $('#Email_err').text('');
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
                                debugger
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
        </script>

        <script type="text/javascript">
            $(document).ready(function () {
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
                                <li class="active">Tài khoản</li>
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
                                            <a data-toggle="tab" href="#profile-tab1">Thông tin tài khoản</a>
                                        </li>
                                    </ul>
                                </header>
                                <div class="panel-body">
                                    <div class="tab-content">    
                                        <div id="profile-tab1" class="tab-pane active">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <section class="panel">
                                                        <form id="myform" class="form-horizontal tasi-form" action="${root}/UsersManageServlet" method="Post" enctype="multipart/form-data" >
                                                            <input type="hidden" name="ID" value="<%=usersCurrent == null ? "" : usersCurrent.getID()%>">
                                                            <input type="hidden" name="command" value="insertupdate">
                                                            <input type="hidden" name="command_profile" value="insertupdate">
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
                                                                                <label class="col-sm-3 control-label">Tên người dùng<span class="text-danger"> *</span></label>
                                                                                <div class="col-sm-9">
                                                                                    <input style="max-width: 95%" required type="text" name="Name" value="<%=Name == "" ? (usersCurrent == null ? "" : usersCurrent.getName()) : Name%>" class="form-control">
                                                                                </div>
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <label class="col-sm-3 control-label">Số điện thoại<span class="text-danger"> *</span></label>
                                                                                <div class="col-sm-9">
                                                                                    <input  style="max-width: 95%" onkeypress='return event.charCode >= 48 && event.charCode <= 57' required min="0" type="number" value="<%=Phone == "" ? (usersCurrent == null ? "" : usersCurrent.getPhone()) : Phone%>" name="Phone" class="form-control">
                                                                                    <div class="clearfix"></div>
                                                                                    <span class="text-danger" id="Phone_err"><%=Phone_err%></span>
                                                                                </div>
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <label class="col-sm-3 control-label">Email<span class="text-danger"> *</span></label>
                                                                                <div class="col-sm-9">
                                                                                    <input style="max-width: 95%;float: left;" required value="<%=Email == "" ? (usersCurrent == null ? "" : usersCurrent.getEmail()) : Email%>" type="text" id="Email" name="Email" class="form-control">
                                                                                    <span style="max-width: 5%;float: left;margin-left: 2px;margin-top: 5px;"  id="email-result"></span>
                                                                                    <div class="clearfix"></div>
                                                                                    <span class="text-danger" id="Email_err"><%=Email_err%></span>
                                                                                </div>
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <label class="col-sm-3 control-label">Địa chỉ<span class="text-danger"> *</span></label>
                                                                                <div class="col-sm-9">
                                                                                    <input style="max-width: 95%" required type="text" value="<%=Address == "" ? (usersCurrent == null ? "" : usersCurrent.getAddress()) : Address%>" name="Address" class="form-control">
                                                                                </div>
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <label class="col-sm-3 control-label">Tỉnh-TP<span class="text-danger"> *</span></label>
                                                                                <div class="col-sm-9">
                                                                                    <select style="max-width: 95%" onchange="changeProvince($(this).val())" required class="form-control" name="ProvinceCode" id="ProvinceCode">
                                                                                        <option value="">Tỉnh-Thành phố</option>
                                                                                        <%
                                                                                            for (City c : customDataDAO.getListCity()) {
                                                                                                if ((ProvinceCode.length() > 0 ? ProvinceCode : (usersCurrent == null ? "" : usersCurrent.getProvinceCode())).equals(c.getCode())) {
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
                                                                                            for (District c : customDataDAO.getListDistrictByCity((ProvinceCode.length() > 0 ? ProvinceCode : (usersCurrent == null ? "" : usersCurrent.getProvinceCode())))) {
                                                                                                if ((DistrictCode.length() > 0 ? DistrictCode : (usersCurrent == null ? "" : usersCurrent.getDistrictCode())).equals(c.getCode())) {
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
                                                                                    <input readonly style="max-width: 95%" required type="text" value="<%=usersCurrent == null ? "" : usersCurrent.getUserName()%>" name="UserName" class="form-control">
                                                                                </div>
                                                                            </div>

                                                                        </div>
                                                                        <div class="col-md-6">
                                                                            <div class="form-group">
                                                                                <label class="col-sm-3 control-label">Ảnh đại diện</label>
                                                                                <div class="col-sm-9">
                                                                                    <div class="fileinput-new thumbnail" style="max-width: 280px; ">
                                                                                        <img id="myimage" src="${root}/<%=Image == "" ? (usersCurrent == null ? AllConstant.url_no_image_general : usersCurrent.getImage()) : Image%>" alt=""  />
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
