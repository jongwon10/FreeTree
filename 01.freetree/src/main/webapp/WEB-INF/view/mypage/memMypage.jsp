<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="wearethe.freetree.member.vo.MemberVO" %>
<%@ page import="java.util.List" %>
<%@ page import="wearethe.freetree.mypage.vo.MemMypageVO" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="/css/reset.css" type="text/css" rel="stylesheet">
  <link href="/css/mypage/memMypage.css" type="text/css" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <!-- Load the Quill library -->
  <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
  <script src="https://cdn.quilljs.com/1.3.6/quill.js"></script>


  <title>마이페이지 폼</title>

  <script type="text/javascript">
    $(document).ready(function(){

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

      $(document).on("click", "#btn", function() {

        console.log("btn >>> : ");


        // Get the HTML content from the Quill editor
        var editorContent = $("#editor .ql-editor").html();
        // Set the content to the hidden input field
        $("#quill_html").val(editorContent);

        $("#memMypageForm").attr({
          "action": "/memmypage",
          "method": "POST",
          "enctype": "multipart/form-data"
        }).submit();
      });

      // Initialize Quill editor when the document is fully loaded
      var quill = new Quill('#editor', {
        theme: 'snow',
        modules: {
          toolbar: [
            ['bold', 'italic', 'underline', 'strike'],
            ['link', 'image'],
            [{ 'list': 'ordered' }, { 'list': 'bullet' }],
            [{ 'header': [1, 2] }]
          ]
        }
      });
    });

  </script>
</head>

<body>
<header id="header"></header>

<form name="memMypageForm" id="memMypageForm" >

<div id="top">
  <div id="pro">
    <div id="pro-div">
    <img id="profileImage" src="/img/mypage/profile.jpg">
      <div id="info">
        <%
          Object obj = request.getAttribute("list");
          if (obj == null) return;

          List<MemberVO> aList = (List<MemberVO>)obj;
          if (aList.size() > 0) {
            for(int i=0; i<aList.size(); i++){
              MemberVO mvo = aList.get(i);
        %>
        <input type="hidden" name="mnum" value="<%= mvo.getMnum()%>"><br>
        <input type="hidden" name="mname" value="<%= mvo.getMname()%>"><h1><%= mvo.getMname()%></h1><br>
        <input type="hidden" name="memail" value="<%= mvo.getMemail()%>"><p><%= mvo.getMemail()%></p>
        <p></p>
        <%
            }
          }
        %>
        <select class="drop"  name="mpposition">
          <option>웹 개발자</option>
          <option>서버 개발자</option>
          <option>소프트웨어 엔지니어</option>
          <option>프론트엔드 개발자</option>
          <option>자바 개발자</option>
          <option>안드로이드 개발자</option>
          <option>C/ C++ 개발자</option>
          <option>Node.js 개발자</option>
          <option>임베디드 개발자</option>
          <option>PHP 개발자</option>
          <option>데이터 엔지니어</option>
          <option>IOS 개발자</option>
          <option>시스템/ 네트워크 관리자</option>
          <option>파이썬 개발자</option>
          <option>DBA</option>
          <option>크로스플랫폼 앱 개발자</option>
          <option>머신러닝 엔지니어</option>
          <option>개발 매니저</option>
          <option>프로덕트 매니저</option>
          <option>빅데이터 엔지니어</option>
          <option>그래픽스 엔지니어</option>
          <option>BI 엔지니어</option>
          <option>VR 엔지니어</option>
          <option>QA/ 테스트 엔지니어</option>
          <option>보안 엔지니어</option>
          <option>하드웨어 엔지니어</option>
          <option>웹 퍼블리셔</option>
          <option>.NET 개발자</option>
        </select>


        <select class="bank" name="bankname">
          <option>한국은행</option>
          <option>KB국민은행</option>
          <option>신한은행</option>
          <option>우리은행</option>
          <option>하나은행</option>
          <option>SC제일은행</option>
          <option>한국씨티은행</option>
          <option>케이뱅크</option>
          <option>카카오뱅크</option>
          <option>토스뱅크</option>
          <option>NH농협은행</option>
          <option>농축협은행</option>
          <option>수협은행</option>
          <option>대구은행</option>
          <option>부산은행</option>
          <option>경남은행</option>
          <option>광주은행</option>
          <option>전북은행</option>
          <option>제주은행</option>
        </select>

        <input type="text" class="bankan" name="bankan" placeholder="계좌번호">



        <div class="sns">
          <img src="/img/mypage/github.png">
          <input type="text" name="mpgit" placeholder="깃허브">
          <img src="/img/mypage/instar.png">
          <input type="text" name="mpinstar" placeholder="인스타">
          <button type="button" id="btn">확인</button>
        </div>
      </div>
  </div>
  </div>
</div><hr>

<!--텍스트 편집기------------------------------------------------------------->
  <div id="e-d1">
    <div id="e-d2">
      <!-- Create the editor container -->
      <div id="editor" class="initial-size">

      </div>
    </div>
    <!-- Hidden input to hold the Quill editor's content -->
    <input type="hidden" id="quill_html" name="mpinfo">
  </div><br>
<script src="/js/mypage/memMypage.js"></script>
<!--텍스트 편집기------------------------------------------------------------->

<br><br><br>
<div class="att">
  <p>첨부파일</p>
  <input type="file" name="mpfileup" id="mpfileup"/>
</div><br><br><br>

</form>
<footer id="footer"></footer>
</body>
</html>