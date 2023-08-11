<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String vran = "79000000000323";
    String amount = "";
%>
<!DOCTYPE html>
<html>
<head>
    <title>팝업 창</title>
    <script>
        var date = new Date();
        date.setDate(date.getDate() + 3); // 현재 날짜에 3일을 더함
        var year = date.getFullYear();
        var month = ('0' + (date.getMonth() + 1)).slice(-2);
        var day = ('0' + date.getDate()).slice(-2);
        var currentDate = year + '.' + month + '.' + day; // yyyy.MM.dd 형식으로 표현
    </script>
</head>
<body>
<h1>예치금 계좌</h1>
<p>가상 계좌 번호: <%= vran %> </p>
<p>총 예치 금액: <%= amount %> </p>
<p>입금 기한: <span id="depositDate"></span></p>

<script>
    document.getElementById("depositDate").innerText = currentDate;
</script>

</body>
</html>
