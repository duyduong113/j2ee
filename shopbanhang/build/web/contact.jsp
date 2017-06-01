<%-- 
    Document   : contact
    Created on : May 10, 2017, 1:13:41 PM
    Author     : DUONG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Liên hệ</title>
        <%@include file="include/headtag.jsp" %>
    </head>
    <body>

        <%
            String Name_err = "", Phone_err = "", Address_err = "", Email_err = "", Content_err = "",
                    Name = "",Phone = "",Address = "",Email = "",Content = "";
            
            if (request.getAttribute("Name_err") != null) {
                Name_err = (String) request.getAttribute("Name_err");
            }
            if (request.getAttribute("Phone_err") != null) {
                Phone_err = (String) request.getAttribute("Phone_err");
            }
            if (request.getAttribute("Address_err") != null) {
                Address_err = (String) request.getAttribute("Address_err");
            }
            if (request.getAttribute("Email_err") != null) {
                Email_err = (String) request.getAttribute("Email_err");
            }
            if (request.getAttribute("Content_err") != null) {
                Content_err = (String) request.getAttribute("Content_err");
            }
            if (request.getAttribute("Name") != null) {
                Name = (String) request.getAttribute("Name");
            }
            if (request.getAttribute("Phone") != null) {
                Phone = (String) request.getAttribute("Phone");
            }
            if (request.getAttribute("Address") != null) {
                Address = (String) request.getAttribute("Address");
            }
            if (request.getAttribute("Email") != null) {
                Email = (String) request.getAttribute("Email");
            }
            if (request.getAttribute("Content") != null) {
                Content = (String) request.getAttribute("Content");
            }
            

        %>

        <jsp:include page="header.jsp"></jsp:include>

            <div class="container">
                <div class="contact">
                    <h2 class=" contact-in">Liên hệ</h2>

                    <div class="col-md-6 contact-top">
                        <h3>Bản đồ</h3>
                        <div class="map">
                            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d5541.209643811381!2d106.80031599093795!3d10.870338256592023!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x317527587ba04377%3A0x4ea5c6ca79f1ff59!2sUniversity+Of+Information+Technology!5e0!3m2!1sen!2s!4v1494653206514" width="600" height="450" frameborder="0" style="border:0" allowfullscreen></iframe>
                        </div>

                        <p>At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas </p>
                        <p>Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id </p>				
                        <ul class="social ">
                            <li><span><i > </i>Linh Xuân, Thủ Đức, Tp Hồ Chí Minh </span></li>
                            <li><span><i class="down"> </i>+ 00 123 456 7890</span></li>
                            <li><a href="mailto:info@example.com"><i class="mes"> </i>info@example.com</a></li>
                        </ul>
                    </div>
                    <div class="col-md-6 contact-top">
                        <form action="FeedbackServlet" method="POST">
                            <h3>Phản hồi với chúng tôi?</h3>
                            <div>
                                <span>Họ và tên </span>		
                                <input type="text" value="<%=Name%>" name="Name" >
                                <div class="text-danger"><%=Name_err%></div>
                        </div>

                        <div>
                            <span>Phone</span>		
                            <input type="text" value="<%=Phone%>" name="Phone" >	
                            <div class="text-danger"><%=Phone_err%></div>
                        </div>
                        <!--                            <div>
                                                        <span>Địa chỉ </span>		
                                                        <input type="text" value="" name="Address" >						
                                                    </div>-->
                        <div>
                            <span>Email </span>		
                            <input type="text" value="<%=Email%>" name="Email" >
                            <span  id="email-result"></span>
                            <div class="text-danger"><%=Email_err%></div>
                        </div>
                        <div>
                            <span>Nội dung</span>		
                            <textarea name="Content"><%=Content%></textarea>	
                            <div class="text-danger"><%=Content_err%></div>
                        </div>
                        <input type="submit" value="Gửi" >	
                    </form>

                </div>
                <div class="clearfix"> </div>
            </div>
        </div>

        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>
