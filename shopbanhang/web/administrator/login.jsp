<%-- 
    Document   : login
    Created on : May 15, 2017, 5:49:46 PM
    Author     : DUONG
--%>

<%@page import="model.Users"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đăng nhập trang quản trị</title>
        <%@include file="include/headtag.jsp" %>
    </head>
    <body class="skin-black">
        <%
            Users users = (Users) session.getAttribute("users");
            if (users != null) {
                response.sendRedirect("/shopbanhang/administrator/index.jsp");
            }
            
            String err = "";
            if (request.getAttribute("err") != null) {
                err = (String) request.getAttribute("err");
            }
            
        %>
        <div class="wrapper">
            <div class="col-md-4 col-md-offset-4" style="margin-top: 100px;"  >
                <section class="panel">
                    <header class="panel-heading text-center">
                        Đăng nhập hệ thống
                    </header>
                    <div class="panel-body">
                        <form class="form-horizontal" role="form" action="${root}/UsersManageServlet" method="POST">
                            <input type="hidden" name="command" value="login">
                            <div class="form-group">
                                <div class="col-lg-offset-3 col-lg-10">
                                    <span class="text-danger"><%=err%></span>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="inputEmail1" class="col-lg-3 col-sm-2 control-label">Tên đăng nhập</label>
                                <div class="col-lg-9">
                                    <input required name="UserName" type="text" class="form-control" id="inputEmail1" placeholder="Email">
<!--                                    <p class="help-block">Example block-level help text here.</p>-->
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputPassword1" class="col-lg-3 col-sm-2 control-label">Mật khẩu</label>
                                <div class="col-lg-9">
                                    <input required name="Password" type="password" class="form-control" id="inputPassword1" placeholder="Password">
                                </div>
                            </div>
<!--                            <div class="form-group">
                                <div class="col-lg-offset-3 col-lg-10">
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox"> Ghi nhớ tài khoản
                                        </label>
                                    </div>
                                </div>
                            </div>-->
                            <div class="form-group">
                                <div class="col-lg-offset-3 col-lg-10">
                                    <button type="submit" class="btn btn-danger">Đăng nhập</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </section>

            </div> 
        </div>
        <%@include file="include/foottag.jsp" %>
    </body>
</html>
