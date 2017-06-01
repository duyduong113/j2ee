
<%@page import="common.AllConstant"%>
<%@page import="model.Users"%>
<%@page import="model.District"%>
<%@page import="model.City"%>
<%@page import="dao.CustomDataDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tài khoản</title>
        <%@include file="include/headtag.jsp" %>
    </head>
    <body>

        <%
            Users usersCurrent = (Users) session.getAttribute("user");
//            if (usersCurrent == null) {
//                response.sendRedirect("/shopbanhang/login.jsp");
//            }

            CustomDataDAO customDataDAO = new CustomDataDAO();

            String Email_err = "", Phone_err = "",
                    Name = "", Address = "", Email = "", Phone = "", Image = "", ProvinceCode = "", DistrictCode = "";
            //get data eror

            if (request.getAttribute("Email_err") != null) {
                Email_err = (String) request.getAttribute("Email_err");
            }
            if (request.getAttribute("Phone_err") != null) {
                Phone_err = (String) request.getAttribute("Phone_err");
            }

            //get data
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
            if (request.getAttribute("Image") != null) {
                Image = (String) request.getAttribute("Image");
            }
            if (request.getAttribute("ProvinceCode") != null) {
                ProvinceCode = (String) request.getAttribute("ProvinceCode");
            }
            if (request.getAttribute("DistrictCode") != null) {
                DistrictCode = (String) request.getAttribute("DistrictCode");
            }

        %>
        <script>
            function changePassword() {
                var pass = $('input[name=Password]').val();
                var comfirmpass = $('input[name=ComfirmPassword]').val()
                debugger
                if (pass === comfirmpass) {
                    return true;
                }
                $('#popup_err').text('Xác nhận mật khẩu không trung khớp!');
                $('input[name=Password]').val('');
                $('input[name=ComfirmPassword]').val('');
                return false;
            }

            function closePopup() {
                $('input[name=Password]').val('');
                $('input[name=ComfirmPassword]').val('');
            }
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
                $('#myimage').attr('src', '<%=AllConstant.url_no_image_general%>');
                $('#cancel-image').css('display', 'none');
            }
            function resetForm() {
                //$('#myform')[0].reset();
                $('#myimage').attr('src','<%= AllConstant.url_no_image_general%>')
                $('#myimage').attr("src", "<%=usersCurrent != null ? (usersCurrent.getImage() == null ? AllConstant.url_no_image_general : usersCurrent.getImage().replace("\\", "/")) : AllConstant.url_no_image_general%>");
                $('input[name=Name]').val('<%=usersCurrent != null ? usersCurrent.getName() : ""%>');
                $('input[name=Phone]').val('<%=usersCurrent != null ? usersCurrent.getPhone() : ""%>');
                $('input[name=Email]').val('<%=usersCurrent != null ? usersCurrent.getEmail() : ""%>');
                $('input[name=Address]').val('<%=usersCurrent != null ? usersCurrent.getAddress() : ""%>');

                $('select[name=ProvinceCode] option[value=<%=usersCurrent != null ? usersCurrent.getProvinceCode() : ""%>]').prop("selected", "selected");
                $('select[name=ProvinceCode] option[value=<%=usersCurrent != null ? usersCurrent.getProvinceCode() : ""%>]').attr("selected", "selected");

                getListDistrictByCityAndSelect('<%=usersCurrent != null ? usersCurrent.getProvinceCode() : ""%>', '<%=usersCurrent != null ? usersCurrent.getDistrictCode() : ""%>');
                $('#Phone_err').text('');
                $('#Email_err').text('');
            }
            function getListDistrictByCityAndSelect(CityCode, districtCode) {
                $.ajax({
                    type: "POST",
                    url: "GetListDistrictByCityServlet",
                    data: "CityCode=" + CityCode,
                    success: function (data) {
                        var html = '<option value="">Quận - Huyện</option>';
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
            function changeProvince(Code) {
                $('#DistrictCode').find('option').not(':first').remove();
                var CityCode = Code;
                getListDistrictByCity(CityCode);
            }
            function getListDistrictByCity(CityCode) {
                $.ajax({
                    type: "POST",
                    url: "GetListDistrictByCityServlet",
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
                    $("#email-result").html('<img src="img/ajax-loader.gif" />');
                    $.post('CheckEmailServlet', {'email': email}, function (data) {
                        $("#email-result").html(data);
                    });
                }
            });
        </script>

        <jsp:include page="header.jsp"></jsp:include>

            <div class="container">
                <div class="account">
                    <h2 class="account-in">Tài khoản</h2>
                    <form action="UsersServlet" method="POST" enctype="multipart/form-data" >
                        <input type="hidden" value="insertupdate" name="command">
                        <input type="hidden" name="ID" value="<%=usersCurrent == null ? "" : usersCurrent.getID()%>">
                    <div class="row">


                        <div class="col-md-6">
                            <div class="form-inline">			
                                <label class="col-md-3">Họ tên*</label>
                                <input class="form-control" type="text" name="Name" value="<%=Name.length() == 0 ? (usersCurrent == null ? "" : usersCurrent.getName()) : Name%>" required> 
                            </div>			
                            <div class="form-inline"> 	
                                <label class="col-md-3">Email*</label>
                                <input class="form-control" type="text" name="Email" id="Email" value="<%=Email.length() == 0 ? (usersCurrent == null ? "" : usersCurrent.getEmail()) : Email%>" required> 
                                <span  id="email-result"></span>
                                <p class="col-md-offset-3 text-danger"><%=Email_err%></p>
                            </div>
                            <div class="form-inline">			
                                <label class="col-md-3">Số điện thoại*</label>
                                <input class="form-control" type="text" onkeypress='return event.charCode >= 48 && event.charCode <= 57' name="Phone" value="<%=Phone.length() == 0 ? (usersCurrent == null ? "" : usersCurrent.getPhone()) : Phone%>" id="Phone" required> 
                                <p class="col-md-offset-3 text-danger"><%=Phone_err%></p>
                            </div>
                            <div class="form-inline">			
                                <label class="col-md-3">Địa chỉ*</label>
                                <input class="form-control" type="text" name="Address" value="<%=Address == "" ? (usersCurrent == null ? "" : usersCurrent.getAddress()) : Address%>" required> 
                            </div>
                            <div class="form-inline">			
                                <label class="col-md-3">Tỉnh-Thành phố*</label>
                                <select style="width: 60%" onchange="changeProvince($(this).val())" required class="form-control" name="ProvinceCode" id="ProvinceCode">
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
                            <div class="form-inline">			
                                <label class="col-md-3">Quận-Huyện*</label>
                                <select style="width: 60%" required class="form-control" name="DistrictCode" id="DistrictCode" >
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

                            <div class="form-inline"> 	
                                <label class="col-md-3">Tên đăng nhập*</label>
                                <input readonly class="form-control" type="text" name="UserName" id="UserName" value="<%=usersCurrent == null ? "" : usersCurrent.getUserName()%>" required> 
                            </div>

                        </div>
                        <div class="col-md-6">
                            <div class="form-inline">
                                <label class="col-sm-3">Ảnh đại diện</label>
                                <div class="col-sm-9">
                                    <img id="myimage" src="<%=Image.length() == 0 ? (usersCurrent == null ? AllConstant.url_no_image_general : (usersCurrent.getImage() == null  ? AllConstant.url_no_image_general : usersCurrent.getImage())) : Image%>" alt="" width="280" height="180" />
                                    <div class="clearfix"></div>
                                    <span class="btn btn-default btn-file btn-sm">
                                        <input style="opacity: 0;overflow: hidden;position: absolute;" type="file" name="file" onchange="onFileSelected(event)">
                                        <label style="" for="file">Chọn ảnh</label>
                                    </span>
                                </div>
                            </div>
                        </div>


                    </div>
                    <div class="col-md-offset-3">
                        <a style="margin-right: 5px;" onclick="resetForm()" class="btn btn-default"><i class="fa fa-ban" aria-hidden="true"></i> Làm mới</a>
                        <button type="submit" class="btn btn-success"><i class="fa fa-floppy-o" aria-hidden="true"></i> Cập nhật</button>
                        <a class="btn btn-danger" data-toggle="modal" href="#myModal-1">
                            <i class="fa fa-refresh fa-fw pull-right"></i>
                            Đổi mật khẩu
                        </a>
                    </div>
                </form>
            </div>
        </div>
        <jsp:include page="footer.jsp"></jsp:include>
        <!-- Modal -->
        <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="myModal-1" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button onclick="closePopup()" aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
                        <h4 class="modal-title">Đổi mật khẩu</h4>
                    </div>
                    <div class="modal-body">
                        <form  onsubmit="return changePassword()" class="form-horizontal" role="form" action="UsersServlet" method="POST">
                            <input type="hidden" name="command" value="changepassword">
                            <div class="form-group">
                                <div class="col-lg-offset-4 col-lg-10">
                                    <span id="popup_err" class="text-danger"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputEmail1" class="col-lg-4 col-sm-2 control-label">Mật khẩu</label>
                                <div class="col-lg-8">
                                    <input required type="password" name="Password" class="form-control" id="inputEmail4" placeholder="Password">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputPassword1" class="col-lg-4 col-sm-2 control-label">Xác nhận mật khẩu</label>
                                <div class="col-lg-8">
                                    <input required type="password" name="ComfirmPassword" class="form-control" id="inputPassword4" placeholder="Password">
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-lg-offset-4 col-lg-10">
                                    <button  type="submit" class="btn btn-default">Đồng ý</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!-- modal --> 
    </body>
</html>
