<%-- 
    Document   : foottag
    Created on : May 15, 2017, 5:15:40 PM
    Author     : DUONG
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!-- jQuery 2.0.2 -->
<!--<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>-->
<script src="${root}/administrator/js/jquery.min.js" type="text/javascript"></script>

<!-- jQuery UI 1.10.3 -->
<script src="${root}/administrator/js/jquery-ui-1.10.3.min.js" type="text/javascript"></script>
<!-- Bootstrap -->
<script src="${root}/administrator/js/bootstrap.min.js" type="text/javascript"></script>
<!-- daterangepicker -->
<script src="${root}/administrator/js/plugins/daterangepicker/daterangepicker.js" type="text/javascript"></script>

<script src="${root}/administrator/js/plugins/chart.js" type="text/javascript"></script>

<!-- datepicker-->
<!--<script src="${root}/administrator/js/plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>-->
<!-- datepicker NEW-->
<script src="${root}/administrator/js/plugins/Datepicker-new/bootstrap-datepicker.js" type="text/javascript"></script>
<!-- datetimepicker-->
<script src="${root}/administrator/js/plugins/bs-datetimepicker/bootstrap-datetimepicker.js" type="text/javascript"></script>
<!-- Bootstrap WYSIHTML5-->
<script src="${root}/administrator/js/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js" type="text/javascript"></script>
<!-- iCheck -->
<script src="${root}/administrator/js/plugins/iCheck/icheck.min.js" type="text/javascript"></script>
<!-- calendar -->
<script src="${root}/administrator/js/plugins/fullcalendar/fullcalendar.js" type="text/javascript"></script>

<!-- Director App -->
<script src="${root}/administrator/js/Director/app.js" type="text/javascript"></script>

<!-- Director dashboard demo (This is only for demo purposes) -->
<script src="${root}/administrator/js/Director/dashboard.js" type="text/javascript"></script>

<!-- Director for demo purposes -->
<script type="text/javascript">
    $('input').on('ifChecked', function (event) {
        // var element = $(this).parent().find('input:checkbox:first');
        // element.parent().parent().parent().addClass('highlight');
        $(this).parents('li').addClass("task-done");
        console.log('ok');
    });
    $('input').on('ifUnchecked', function (event) {
        // var element = $(this).parent().find('input:checkbox:first');
        // element.parent().parent().parent().removeClass('highlight');
        $(this).parents('li').removeClass("task-done");
        console.log('not');
    });

</script>
<script>

    $('#noti-box').slimScroll({
        height: '400px',
        size: '5px',
        BorderRadius: '5px'
    });

    $('input[type="checkbox"].flat-grey, input[type="radio"].flat-grey').iCheck({
        checkboxClass: 'icheckbox_flat-grey',
        radioClass: 'iradio_flat-grey'
    });
</script>
<script type="text/javascript">
    $(function () {
        "use strict";
        //BAR CHART
        var data = {
            labels: ["January", "February", "March", "April", "May", "June", "July"],
            datasets: [
                {
                    label: "My First dataset",
                    fillColor: "rgba(220,220,220,0.2)",
                    strokeColor: "rgba(220,220,220,1)",
                    pointColor: "rgba(220,220,220,1)",
                    pointStrokeColor: "#fff",
                    pointHighlightFill: "#fff",
                    pointHighlightStroke: "rgba(220,220,220,1)",
                    data: [65, 59, 80, 81, 56, 55, 40]
                },
                {
                    label: "My Second dataset",
                    fillColor: "rgba(151,187,205,0.2)",
                    strokeColor: "rgba(151,187,205,1)",
                    pointColor: "rgba(151,187,205,1)",
                    pointStrokeColor: "#fff",
                    pointHighlightFill: "#fff",
                    pointHighlightStroke: "rgba(151,187,205,1)",
                    data: [28, 48, 40, 19, 86, 27, 90]
                }
            ]
        };
        new Chart(document.getElementById("linechart").getContext("2d")).Line(data, {
            responsive: true,
            maintainAspectRatio: false,
        });

    });
    // Chart.defaults.global.responsive = true;
</script>

<!--Set Menu current-->
<script type="text/javascript">
    window.onload = function () {
        var pageCurrent = location.pathname.substring(location.pathname.lastIndexOf("/") + 1).split('.')[0];
        if (pageCurrent.length > 0) {
            if (pageCurrent === "CustomerServlet") {
                document.getElementById('customer').className += " active";
            } else if (pageCurrent === "UsersManageServlet") {
                document.getElementById('users').className += " active";
            } else if(pageCurrent==="ProductCategoryServlet"){
                document.getElementById('category').className += " active";
            }else if(pageCurrent === "StatisticsServlet"){
                document.getElementById('statistics').className += " active";
            }else {
                document.getElementById(pageCurrent).className += " active";
            }
        } else {
            document.getElementById('index').className += " active";
        }
    };

</script>

<script type="text/javascript">
    //open tab new
    function openTab(tabName) {
        //reset form
        $('#myform')[0].reset();
        //$('input[name=ID]').val('');
        $("option:first").attr('selected', 'selected');
        //$('#myimage').attr('src', 'http://www.placehold.it/280x160/EFEFEF/AAAAAA&amp;text=no+image');
        $('.green').trigger('click');
        $('#table-detail td').parent().remove();
        $('#DistrictCode').find('option').not(':first').remove();
        $('input[name=UserName]').attr('readonly', false);

        // show tab 2
        $('a[href="#' + tabName + '"]').tab('show');

    }

</script>


