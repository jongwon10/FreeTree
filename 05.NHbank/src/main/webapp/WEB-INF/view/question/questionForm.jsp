<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Q&A</title>
    <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
    <link href="/css/question/questionForm.css" type="text/css" rel="stylesheet">
    <link href="/css/reset.css" type="text/css" rel="stylesheet">
    <script type="text/javascript">
      $(function() {
          $.ajax({
              url: "/header", // 헤더를 반환하는 엔드포인트
              success: function(data) {
                  $("#header").html(data);
              }
          });
          $.ajax({
              url: "/footer", // 푸터를 반환하는 엔드포인트
              success: function(data) {
                  $("#footer").html(data);
              }
          });
      });
        $(document).ready(function(){
            $(document).on("click", "#qBtn", function(){
                console.log("qBtn >>> : ");
                $('#questionForm').attr({
                    'action':'/questionInsert',
                    'method':'POST',
                    'enctype':'multipart/form-data'
                }).submit();
            });
        });
    </script>
</head>
<body>
<header id="header"></header>
<div class="container">
<form name="questionForm" id="questionForm">
    <h1>Q&A 글 작성</h1>
    <table id="formtable">
        <tr>
            <td>글번호</td>
            <td><input type="text" class="qt" name="qnum" id="qnum" size="53" readonly></td>
        </tr>
        <tr>
            <td>제목</td>
            <td><input type="text" class="qt" name="qname" id="qname" size="53"></td>
        </tr>
        <tr>
            <td>이름</td>
            <td><input type="text" class="qt" name="fnum" id="fnum" size="53"></td>
        </tr>
        <tr>
            <td>내용</td>
            <td>
                <textarea name="qcontent" class="qt" id="qcontent" cols="50" rows="10"></textarea>
            </td>
        </tr>
        <tr>
            <td>사진</td>
            <td><input type="file" name="qfile" id="qfile"></td>
        </tr>
        <tr>
            <td colspan="2">
                <input type="button" value="글쓰기" class="btn" id="qBtn">
            </td>
        </tr>
    </table>
</form></div>
<footer id="footer"></footer>
</body>
</html>