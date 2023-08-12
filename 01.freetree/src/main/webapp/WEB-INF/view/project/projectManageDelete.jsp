<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>
</head>
<script>
    var urlpush = '/push?pushfilter=' + '거절';

    // push
    $.ajax({
        url: urlpush,
        type: "GET",
        contentType: "application/json",
        data: null,
        success: function(response) {


        },
        error: function(xhr, status, error) {

            alert("fail-push알림 전송 실패");
        }
    });
</script>
<body>
    <%
        Object obj = request.getAttribute("pnum");
        Object objp = request.getAttribute("pname");
    %>

    <form id="form" action="/projectManage" method="post" enctype="multipart/form-data">
        <input type="hidden" name="pnum" value="<%= obj %>">
        <input type="hidden" name="pname" value="<%= objp %>">
    </form>
<script>



    alert("거절완료");
    document.getElementById("form").submit();

</script>
</body>
</html>