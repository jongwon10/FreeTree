<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>resumeInsert.jsp</title>
</head>
<body>
<h3>resumeInsert.jsp</h3>
<hr>
<%
    String mnum = request.getParameter("mnum");
%>

<form id="form" action="/resumeSelect" method="post">
    <input type="hidden" name="mnum" value="<%= mnum %>">
</form>

<script>
    document.getElementById("form").submit();
</script>
</body>
</html>