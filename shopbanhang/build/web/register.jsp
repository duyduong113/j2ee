<%-- 
    Document   : register
    Created on : May 10, 2017, 8:32:11 AM
    Author     : DUONG
--%>

<%@page import="model.District"%>
<%@page import="model.City"%>
<%@page import="dao.CustomDataDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đăng ký</title>
        <%@include file="include/headtag.jsp" %>

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
                    $("#email-result").html('<img src="img/ajax-loader.gif" />');
                    $.post('CheckEmailServlet', {'email': email}, function (data) {
                        $("#email-result").html(data);
                    });
                }
            });
        </script>
        <script type="text/javascript">
            $(document).ready(function () {
                var x_timer;
                $("#UserName").keyup(function (e) {
                    clearTimeout(x_timer);
                    var username = $(this).val();
                    x_timer = setTimeout(function () {
                        check_username_ajax(username);
                    }, 1000);
                });

                function check_username_ajax(username) {
                    $("#username-result").html('<img src="img/ajax-loader.gif" />');
                    $.post('CheckUserNameServlet', {'username': username}, function (data) {
                        $("#username-result").html(data);
                    });
                }
            });
        </script>
        <script type="text/javascript">
            $(document).ready(function () {
                $("#ProvinceCode").change(function (e) {
                    //xóa tất cả option hiện tại
                    $('#DistrictCode').find('option').not(':first').remove();
                    var CityCode = $(this).val();
                    getListDistrictByCity(CityCode);
                });

                function getListDistrictByCity(CityCode) {
                    $.post('GetListDistrictByCityServlet', {'CityCode': CityCode}, function (data) {
                        var html = '<option value="">Quận - Huyện</option>';
                        for (var i = 0; i < data.lstdistrict.length; i++) {
                            html += '<option value="' + data.lstdistrict[i].Code + '">'
                                    + data.lstdistrict[i].Name + '</option>';
                        }
                        html += '</option>';
                        $('#DistrictCode').html(html);

                    });
                }
            });
        </script>


    </head>
    <body>

        <%
            CustomDataDAO customDataDAO = new CustomDataDAO();

            String UserName_err = "", Email_err = "", Phone_err = "",
                    UserName = "", Name = "", Address = "", Email = "", Phone = "", ProvinceCode = "", DistrictCode = "";
            if (request.getAttribute("UserName_err") != null) {
                UserName_err = (String) request.getAttribute("UserName_err");
            }
            if (request.getAttribute("Email_err") != null) {
                Email_err = (String) request.getAttribute("Email_err");
            }
            if (request.getAttribute("Phone_err") != null) {
                Phone_err = (String) request.getAttribute("Phone_err");
            }
            if (request.getAttribute("UserName") != null) {
                UserName = (String) request.getAttribute("UserName");
            }
            if (request.getAttribute("Name") != null) {
                Name = (String) request.getAttribute("Name");
            }
            if (request.getAttribute("Address") != null) {
                Address = (String) request.getAttribute("Address");
            }
            if (request.getAttribute("Email") != null) {
                Email = (String) request.getAttribute("Email");
            }
            if (request.getAttribute("Phone") != null) {
                Phone = (String) request.getAttribute("Phone");
            }
            if (request.getAttribute("ProvinceCode") != null) {
                ProvinceCode = (String) request.getAttribute("ProvinceCode");
            }
            if (request.getAttribute("DistrictCode") != null) {
                DistrictCode = (String) request.getAttribute("DistrictCode");
            }


        %>

        <jsp:include page="header.jsp"></jsp:include>

            <div class="container">
                <div class="account">
                    <h2 class="account-in">Tài khoản</h2>
                    <form action="UsersServlet" method="POST" >
                        <input type="hidden" value="insertupdate" name="command">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-inline">			
                                    <label class="col-md-3">Họ tên*</label>
                                    <input class="form-control" type="text" name="Name" value="<%=Name%>" required> 
                            </div>			
                            <div class="form-inline"> 	
                                <label class="col-md-3">Email*</label>
                                <input class="form-control" type="text" name="Email" id="Email" value="<%=Email%>" required> 
                                <span  id="email-result"></span>
                                <p class="col-md-offset-3 text-danger"><%=Email_err%></p>
                            </div>
                            <div class="form-inline">			
                                <label class="col-md-3">Số điện thoại*</label>
                                <input class="form-control" type="text" onkeypress='return event.charCode >= 48 && event.charCode <= 57' name="Phone" value="<%=Phone%>" id="Phone" required> 
                                <p class="col-md-offset-3 text-danger"><%=Phone_err%></p>
                            </div>
                            <div class="form-inline">			
                                <label class="col-md-3">Địa chỉ*</label>
                                <input class="form-control" type="text" name="Address" value="<%=Address%>" required> 
                            </div>
                            <div class="form-inline">			
                                <label class="col-md-3">Tỉnh-Thành phố*</label>
                                <select  style="width: 60%" required class="form-control" name="ProvinceCode" id="ProvinceCode" required>
                                    <option value="">Tỉnh - Thành phố</option>
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
                            <div class="form-inline">			
                                <label class="col-md-3">Quận-Huyện*</label>
                                <select style="width: 60%" required class="form-control" name="DistrictCode" id="DistrictCode" >
                                    <option value="">Quận - Huyện</option>
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
                        <div class="col-md-6">
                            <div class="form-inline"> 	
                                <label class="col-md-3">Tên đăng nhập*</label>
                                <input class="form-control" type="text" name="UserName" id="UserName" value="<%=UserName%>" required> 
                                <span  id="username-result"></span>
                                <p class="col-md-offset-3 text-danger"><%=UserName_err%></p>
                            </div>
                            <div class="form-inline"> 
                                <label class="col-md-3">Mật khẩu*</label>
                                <input class="form-control" type="password" name="Password" required>
                            </div>

                        </div>
                            <input  class="col-md-1 col-md-push-1"  type="submit" value="Đăng ký"> 
                    </div>
                   
                </form>
            </div>
        </div>

        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>
