<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="wearethe.freetree.util.K_Session" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="/css/common/main.css" type="text/css" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="/js/common/main.js"></script>

  <title>index</title>
  <%
    K_Session ks = K_Session.getInstance();
    String userId = ks.getSession(request);

    System.out.println("세션 가져오기" + userId);
  %>
  <script>
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

      $(document).on("click", "#btn2", function(){
        var userId = "<%= (userId != null) ? userId : "" %>";

        if (userId.startsWith("M")) {
          alert("기업이 아닙니다");
        } else if (userId.startsWith("C")) {
          $('#projectinsertform').attr({
            'action':'/projectinsertform',
            'method':'POST',
            'enctype':'application/x-www-form-urlencoded'
          }).submit();
        } else {
          alert("기업이 아닙니다");
        }
      });

      $(document).on("click", "#btn1", function(){
        var userId = "<%= (userId != null) ? userId : "" %>";

        if (userId.startsWith("C")) {
          alert("프리랜서가 아닙니다");
        } else if (userId.startsWith("M")) {

          $('#freelancerins').attr({
            'action':'/memMypageForm',// <<< 이부분 받아오면 해결하기
            'method':'POST',
            'enctype':'application/x-www-form-urlencoded'
          }).submit();

        } else {
          alert("로그인해 주세요");
        }
      });

    });

    function GoOpenChat(){
      // 팝업 창 크기
      var popupWidth = 600;
      var popupHeight = 800;

      // 팝업 창 위치를 위한 좌표 계산
      var left = (window.innerWidth - popupWidth) / 2;
      var top = (window.innerHeight - popupHeight) / 2;


      window.open('http://pf.kakao.com/_ebxjIG/chat', '챗봇', 'width=' + popupWidth + ',height=' + popupHeight + ',left=' + left + ',top=' + top);
      ;
    }

  </script>

</head>

<body>
<form id="projectinsertform">
  <input type="hidden" name="cnum" value="<%= (userId != null) ? userId : "" %>">
</form>
<form id="freelancerins">
  <input type="hidden" name="userId" value="<%= userId%>">
</form>
<header id="header"></header>

<section id="section_1">

  <div id="slide">
    <div class="img_wrap">
      <img src="/img/main/mainimg2.png" alt="메인이미지1" />
      <input type="button" value="프리랜서 등록하기" class="btn" id="btn1">
    </div>
    <div class="img_wrap">
      <img src="/img/main/mainimg1.png" alt="메인이미지2" />
      <input type="button" value="프로젝트 등록하기" class="btn" id="btn2">
    </div>
  </div>

  <div id="slide_prev_button" class="slide_button">
    <img src="/img/main/left.png" alt="왼쪽화살표">
  </div>
  <div id="slide_next_button" class="slide_button">
    <img src="/img/main/right.png" alt="오른쪽화살표">
  </div>

  <ul id="dot-list">
    <li class="on" id="on1"></li>
    <li id="on2"></li>
  </ul>

</section>
<!--section_1 end-->

<section id="section_2">
  <img src="/img/main/section.png" onclick="GoChatbot()">
</section>
<!--section_2 end-->
<section id="section_3">
  <img src="/img/main/openChat.png" onclick="GoOpenChat()">
</section>

<!--section_3 end-->

<footer id="footer"></footer>

</body>
</html>