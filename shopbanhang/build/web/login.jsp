<%-- 
    Document   : register
    Created on : May 10, 2017, 8:32:11 AM
    Author     : DUONG
--%>

<%@page import="model.Users"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đăng nhập</title>
        <%@include file="include/headtag.jsp" %>
    </head>
    <body>
        <%
            Users users = (Users) session.getAttribute("user");
            if (users != null) {
                response.sendRedirect("/shopbanhang/index.jsp");
            }
        %>
        <jsp:include page="header.jsp"></jsp:include>

        <div class="container">
            <div class="account">
                <h2 class="account-in">Account</h2>
                <form action="UsersServlet" method="POST" >
                    <input type="hidden" value="login" name="command">
                    <div class="row">
                        <div class="col-md-6">
                            <%
                                if(request.getAttribute("login_err") != null){
                            %>
                            <p>
                                <span class="text-danger"><%=request.getAttribute("login_err")%></span>
                            </p>
                            <%
                                }
                            %>
                            <div class="form-group"> 	
                                <label class="mail">Tên đăng nhập*</label>
                                <input class="form-control" type="text" name="UserName"> 
                            </div>
                            <div class="form-group"> 
                                <label class="word">Mật khẩu*</label>
                                <input class="form-control" type="password" name="Password">
                            </div>
                            <div class="col-md-12">
                                <label><a href="#">Quên mật khẩu?</a> </label>
                                <input type="submit" value="Đăng nhập"> 
                                
                            </div>
                            
                           
                        </div>
                        <div class="col-md-6">
                            <h3> Khách hàng mới</h3>
                            <p>
                                Bằng cách tạo một tài khoản với cửa hàng của chúng tôi,
                                bạn sẽ có thể di chuyển qua các quy trình kiểm tra nhanh hơn, 
                                lưu trữ nhiều địa chỉ vận chuyển, xem và theo dõi đơn đặt hàng
                                của bạn trong tài khoản của bạn và nhiều hơn nữa.
                            </p></br>
                            <a class="btn btn-primary" href="register.jsp">Đăng ký</a>
                        </div>
                       
                    </div>
                                  
                </form>
            </div>
        </div>

        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>
