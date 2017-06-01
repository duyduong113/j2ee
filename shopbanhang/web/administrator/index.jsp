<%-- 
    Document   : index
    Created on : May 15, 2017, 5:07:35 PM
    Author     : DUONG
--%>

<%@page import="model.Users"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Trang Quản trị</title>
        <%@include file="/administrator/include/headtag.jsp" %>
        
    </head>
    <body class="skin-black">
        <%
            Users users = (Users) session.getAttribute("users");
            if (users == null) {
                response.sendRedirect("/shopbanhang/administrator/login.jsp");
            }
        %>
        <jsp:include page="header.jsp"></jsp:include>

            <div class="wrapper row-offcanvas row-offcanvas-left">
            <jsp:include page="menu.jsp"></jsp:include>

                <aside class="right-side">
                    <!-- Main content -->
                    <section class="content">

                        <div class="row" style="margin-bottom:5px;">


                            
                        </div>  


                    <!--<jsp:include page="footer.jsp"></jsp:include>-->


                    </section>
                </aside>
            </div>

        <%@include file="/administrator/include/foottag.jsp" %>
    </body>
</html>
