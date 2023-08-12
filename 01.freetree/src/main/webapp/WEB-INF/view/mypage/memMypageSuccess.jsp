<%@ page import="wearethe.freetree.mypage.vo.MemMypageVO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="wearethe.freetree.mypage.vo.MemMypageVO" %>
<%@ page import="wearethe.freetree.member.vo.MemberVO" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
<%
    String mnum = request.getParameter("mnum");
%>

<form id="form" action="/memMypageSelect" method="post" enctype="multipart/form-data">
    <input type="hidden" name="mnum" value="<%= mnum %>">
</form>

<script>
    document.getElementById("form").submit();
</script>
</body>
</html>