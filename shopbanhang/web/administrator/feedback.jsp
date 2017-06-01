

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="model.Feedback"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.District"%>
<%@page import="com.sun.xml.ws.config.metro.parser.jsr109.UrlPatternType"%>
<%@page import="common.AllConstant"%>
<%@page import="dao.CustomDataDAO"%>
<%@page import="dao.FeedbackDAO"%>
<%@page import="model.Users"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Phản hồi</title>
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
            ArrayList<Feedback> listFeedback = new ArrayList<Feedback>();
            FeedbackDAO feedbackDAO = new FeedbackDAO();

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
            listFeedback = feedbackDAO.getListFeedback(keyword, (pages - 1) * AllConstant.Paging_record_Admin, AllConstant.Paging_record_Admin);
            total = feedbackDAO.countFeedback(keyword);


        %>

        <script>

            function bindData(ID, e) {
                getFeedback(ID);
                openTab('feedback-tab2');
                $($(e).closest("tr")).find("td:eq(3)").find("span").remove();
                $($(e).closest("tr")).find("td:eq(3)").append("<span id='status-approved' class='btn btn-success'><%=AllConstant.Feedback_Status_Approved%></span>");
            }

            function getFeedback(ID) {
                $.ajax({
                    type: "POST",
                    url: "${root}/getFeedbackServlet",
                    data: "ID=" + ID,
                    success: function (data) {
                        $('input[name=ID]').val(data.feedback.ID);
                        $('input[name=Name]').val(data.feedback.Name);
                        $('input[name=Address]').val(data.feedback.Address);
                        $('input[name=Phone]').val(data.feedback.Phone);
                        $('input[name=Email]').val(data.feedback.Email);
                        $('textarea[name=Content]').val(data.feedback.Content);
                        $('input[name=CreatedDate]').val(data.feedback.CreatedDate);
                        if (data.feedback.Status === false) {
                            $('.red').trigger('click');
                        } else {
                            $('.green').trigger('click');
                        }
                    }
                });
            }


        </script>

        <script type="text/javascript">

            $(document).ready(function () {
                $(".date-picker").datepicker({
                    autoclose: !0,
                });
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
                                <li class="active">Phản hồi</li>
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
                                            <a data-toggle="tab" href="#feedback-tab1">Danh sách phản hồi</a>
                                        </li>
                                        <li>
                                            <a data-toggle="tab" href="#feedback-tab2">Thông tin phản hồi</a>
                                        </li>
                                    </ul>
                                </header>
                                <div class="panel-body">
                                    <div class="tab-content">    
                                        <div id="feedback-tab1" class="tab-pane active">
                                            <div class="row">
                                                <div class="col-xs-12">
                                                    <div class="panel">         
                                                        <div class="panel-body table-responsive">
                                                            <div class="box-tools m-b-15">
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
                                                                    <th style="width:50px;"></th>
                                                                    <th>Người phản hồi</th>
                                                                    <th>Nội dung</th>
                                                                    <th>Trạng thái</th>                                                                   
                                                                </tr>

                                                                <%                                                                    for (Feedback feedback : listFeedback) {
                                                                %>
                                                                <tr id="table-middle">
                                                                    <td style="vertical-align: middle;">
                                                                        <a class='btn btn-xs btn-success' onclick="bindData('<%=feedback.getID()%>', this)">
                                                                            <i class="fa fa-eye" aria-hidden="true"></i> Xem
                                                                        </a>
                                                                    </td>
                                                                    <td>
                                                                        <p>
                                                                            <strong class="text-blue">Họ tên: </strong>
                                                                            <%=feedback.getName() != null ? feedback.getName() : ""%>
                                                                        </p>
                                                                        <p>
                                                                            <strong class="text-blue">Số điện thoại: </strong>
                                                                            <%=feedback.getPhone() != null ? feedback.getPhone() : ""%>
                                                                        </p>
                                                                        <p style="display: none;">
                                                                            <strong class="text-blue">Địa chỉ: </strong>
                                                                            <%=feedback.getAddress() != null ? feedback.getAddress() : ""%>
                                                                        </p>
                                                                        <p>
                                                                            <strong class="text-blue">Email: </strong>
                                                                            <%=feedback.getEmail() != null ? feedback.getEmail() : ""%>
                                                                        </p>
                                                                    </td>
                                                                    <td>
                                                                        <p>
                                                                            <%=feedback.getContent().length() > 30 ? feedback.getContent().substring(0, 30) + "..." : "..."%>
                                                                        </p>
                                                                    </td>  
                                                                    <td>
                                                                        <%
                                                                            if (feedback.isStatus() == false) {
                                                                        %>
                                                                        <span class="btn btn-warning">
                                                                            <%=AllConstant.Feedback_Status_New%>
                                                                        </span>
                                                                        <%
                                                                        } else {
                                                                        %>
                                                                        <span class="btn btn-success">
                                                                            <%=AllConstant.Feedback_Status_Approved%>
                                                                        </span>
                                                                        <%
                                                                            }
                                                                        %>
                                                                        <p>
                                                                            <strong class="text-blue">Ngày phản hồi: </strong>
                                                                            <%=feedback.getCreatedDate()==null?"":dateformat.format(feedback.getCreatedDate())%>
                                                                        </p>
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
                                                                    <li><a href="${root}/administrator/feedback.jsp?pages=<%=pages == 1 ? pages : pages - 1%>">«</a></li>
                                                                        <%
                                                                            for (int i = 1; i <= (total % AllConstant.Paging_record_Admin != 0 ? total / AllConstant.Paging_record_Admin + 1 : total / AllConstant.Paging_record_Admin); i++) {
                                                                        %>
                                                                    <li><a id="number<%=i%>" href="${root}/administrator/feedback.jsp?pages=<%=i%>"><%=i%></a></li>
                                                                        <%
                                                                            }
                                                                        %>
                                                                    <li><a href="${root}/administrator/feedback.jsp?pages=<%=pages == ((total % AllConstant.Paging_record_Admin == 0) ? (total / AllConstant.Paging_record_Admin) : (total / AllConstant.Paging_record_Admin + 1)) ? pages : pages + 1%>">»</a></li>
                                                                        <%
                                                                        } else {
                                                                        %>
                                                                    <li><a href="${root}/administrator/feedback.jsp?keyword=<%=keyword%>&pages=<%=pages == 1 ? pages : pages - 1%>">«</a></li>

                                                                    <%
                                                                        for (int i = 1; i <= (total % AllConstant.Paging_record_Admin != 0 ? total / AllConstant.Paging_record_Admin + 1 : total / AllConstant.Paging_record_Admin); i++) {
                                                                    %>
                                                                    <li><a id="number<%=i%>" href="${root}/administrator/feedback.jsp?keyword=<%=keyword%>&pages=<%=i%>"><%=i%></a></li>
                                                                        <%
                                                                            }
                                                                        %>
                                                                    <li><a href="${root}/administrator/feedback.jsp?keyword=<%=keyword%>&pages=<%=pages == (total / AllConstant.Paging_record_Admin + 1) ? pages : pages + 1%>">»</a></li>
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

                                        <div id="feedback-tab2" class="tab-pane">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <section class="panel">
                                                        <form id="myform" class="form-horizontal tasi-form" >

                                                            <div class="panel-body">
                                                                <div class="col-md-12">
                                                                    <div class="row">
                                                                        <div class="col-md-8 col-md-offset-2">
                                                                            <div class="form-group">
                                                                                <label class="col-sm-3 control-label">Họ tên<span class="text-danger"> *</span></label>
                                                                                <div class="col-sm-9">
                                                                                    <input readonly required type="text" name="Name" class="form-control">
                                                                                </div>
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <label class="col-sm-3 control-label">Số điện thoại<span class="text-danger"> *</span></label>
                                                                                <div class="col-sm-9">
                                                                                    <input readonly onkeypress='return event.charCode >= 48 && event.charCode <= 57' required min="0" type="number" name="Phone" class="form-control">
                                                                                </div>
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <label class="col-sm-3 control-label">Email<span class="text-danger"> *</span></label>
                                                                                <div class="col-sm-9">
                                                                                    <input readonly required type="text" id="Email" name="Email" class="form-control">
                                                                                </div>
                                                                            </div>
                                                                            <div class="form-group" style="display: none;">
                                                                                <label class="col-sm-3 control-label">Địa chỉ<span class="text-danger"> *</span></label>
                                                                                <div class="col-sm-9">
                                                                                    <input readonly required type="text" name="Address" class="form-control">
                                                                                </div>
                                                                            </div>
                                                                            <!-- Date -->
                                                                            <div class="form-group">
                                                                                <label class="col-sm-3 control-label">Ngày phản hôi</label>
                                                                                <div class="col-sm-9 disabled-customer">
                                                                                    <div class="input-group date" data-provide="datepicker">
                                                                                        <input type="text" readonly class="form-control" name="CreatedDate">
                                                                                        <div class="input-group-addon">
                                                                                            <span class="glyphicon glyphicon-th"></span>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                                <!-- /.input group -->
                                                                            </div>
                                                                            <!-- /.form group -->
                                                                            <div class="form-group">
                                                                                <label class="col-sm-3 control-label">Nội dung<span class="text-danger"> *</span></label>
                                                                                <div class="col-sm-9">
                                                                                    <textarea readonly="" class="form-control" name="Content" rows="5" required="required" style="resize: vertical;"></textarea> 
                                                                                </div>
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <label class="col-sm-3 control-label">Trạng thái</label>
                                                                                <div class="col-sm-9 disabled-customer">
                                                                                    <div class="btn-group btn-group-circle" data-toggle="buttons">
                                                                                        <label class="btn green btn-sm btn-outline active">
                                                                                            <input type="radio" name="Status" value="true" class="toggle"> Đã xem
                                                                                        </label>
                                                                                        <label class="btn red btn-sm  btn-outline">
                                                                                            <input type="radio" name="Status" value="false" class="toggle" > Chưa xem
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
