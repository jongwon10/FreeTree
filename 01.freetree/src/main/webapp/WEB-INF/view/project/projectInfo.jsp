<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="wearethe.freetree.project.vo.ProjectVO" %>
<%@ page import="wearethe.freetree.util.K_Session" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="/css/project/projectInfo.css" type="text/css" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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

        $(document).on("click", "#btn_5", function() {

            var userId = "<%= (userId != null) ? userId : "" %>";

            if (userId.startsWith("M")) {
                $("#projectsupportgo").attr({
                    "action":"/projectSupport",
                    "method":"POST",
                    "enctype":"application/x-www-form-urlencoded"
                }).submit();
            } else if (userId.startsWith("C")) {
                alert("프리랜서 아닙니다");
            } else {
                alert("회원가입을 하세요");
            }

        });


    });
  </script>
</head>

<body>

<header id="header"></header>

<!--===================================================================-->

<%
      Object obj = request.getAttribute("list");
      if(obj == null) {return;}

      List<ProjectVO> list = (List<ProjectVO>)obj;
      if (list.size() > 0) {
        for (int i=0; i < list.size(); i++) {
          ProjectVO pvo = list.get(i);
%>
<section id="section_1">
    <div id="sec1_top">
        <div id="sec1_title"><%= pvo.getPname()%></div>
        <form id="projectsupportgo">
            <input type="hidden" name="pnum" value="<%=pvo.getPnum()%>">
            <input type="hidden" name="cnum" value="<%=pvo.getCnum()%>">
        </form>
    </div>
    <!--sec1_top end-->
    <div id="sec1_bottom">
        <div id="bottom_container">
            <ul id="bottom_content01">
                <%
                    String pstatus = pvo.getPstatus();
                    String buttonText = "";

                    if (pstatus.equals("0")){
                      buttonText = "모집중";
                    }
                    if (pstatus.equals("1")){
                      buttonText = "모집완료";
                    }
                    if (pstatus.equals("2")){
                      buttonText = "진행중";
                    }
                    if (pstatus.equals("3")){
                      buttonText = "종료";
                    }
                %>
                <li><button class="btn_2"><%= buttonText %></button></li>
                <li>
                    <button class="btn_3">
                    <%
                        String preside = pvo.getPreside();
                        String presideText = "";

                        if (preside.equals("0")){
                          presideText  = "상주근무";
                        }
                        if (preside.equals("1")){
                          presideText  = "원격근무";
                        }
                    %>

                        <div class="sub_title"><%= presideText%></div>
                        <img src="/img/project/house.png" alt="img" />
                    </button>
                </li>

                <%
                    String pskill = pvo.getPskill();

                    String[] skills = pskill.split(", ");

                    for(String skill : skills) {
                %>

                <li><button class="btn_4"><%= skill %></button></li>

                <%
                    };
                %>

                </ul>
                <li >
                    <% if(userId == null || userId.isEmpty()) {%>
                        <button id="btn_5">지원하기</button>
                    <%}else if(userId.startsWith("M")) {%>
                    <button id="btn_5">지원하기</button>
                    <%}else if(userId.startsWith("C")){ };%>
                </li>

                <!--bottom_content end-->

                <div id="bottom_content02">
                <div class="bottom_content">
                    <div class="bottom_sub">
                        <ul class="b1">
                            <li class="b1_content">
                                <img src="/img/project/money.png">
                                <div class="bottom_name">예상 금액</div>
                            </li>
                            <li class="bottom_con1"><%= pvo.getPpaymin()%>만원 ~ <%= pvo.getPpaymax()%>만원</li>
                        </ul>

                        <ul class="b1">
                            <li class="b1_content">
                                <img src="/img/project/calender.png" >
                                <div class="bottom_name">시작 예정일</div>
                            </li>
                            <li class="bottom_con1"><%= pvo.getPstartdate()%></li>
                        </ul>

                        <%--<ul class="b1">
                            <li class="b1_content">
                                <img src="#" alt="$">
                                <div class="bottom_name">직군/직무</div>
                            </li>
                            <li class="bottom_con1">소프트웨어 개발</li>
                        </ul> 컬럼이 존재하지 않음 --%>

                    </div>
                    <!--bottom_sub end -->

                    <div class="bottom_sub2">
                        <%--<ul class="b1">
                            <li class="b1_content">
                                <img src="#" alt="$">
                                <div class="bottom_name">미팅 방식</div>
                            </li>
                            <li class="bottom_con1">오프라인</li>
                        </ul>컬럼이 존재하지 않음 --%>

                        <ul class="b1">
                            <li class="b1_content">
                                <img src="/img/project/calender.png">
                                <div class="bottom_name">예상 종료일</div>
                            </li>
                            <li class="bottom_con1"><%= pvo.getPenddate()%></li>
                        </ul>

                        <ul class="b1">
                            <li class="b1_content">
                                <img src="/img/project/map.png" >
                                <div class="bottom_name">근무 위치</div>
                            </li>
                            <li class="bottom_con1"><%= pvo.getCaddr()%> &nbsp<%= pvo.getCroaddetail()%> </li>
                        </ul>
                    </div>
                  <!--bottom_sub2 end-->
                </div>
              <!-- bottom_content end -->
            </div>
          <!-- bottom_content02 end-->
        </div>
      <!-- bottom_container end -->
    </div>
</section>
<!--section_1 end-->

<section id="section_2">
    <div id="sec2_container">
        <div class="sec2-box">
        <div class="sec2_title">팀소개</div>
        <div class="sec2_content"><%=pvo.getPintroduction()%></div>
        </div>
        <hr>
        <div class="sec2-box">
        <div class="sec2_title">주요 업무</div>
        <div class="sec2_content"><%=pvo.getPwork()%></div>
        </div>
        <hr>
        <div class="sec2-box">
        <div class="sec2_title">지원 조건</div>
        <div class="sec2_content"><%=pvo.getPcondition()%></div>
        </div>
        <hr>
        <div class="sec2-box">
        <div class="sec2_title">우대 조건</div>
        <div class="sec2_content"><%=pvo.getPdemand()%></div>
        </div>
        <hr>
        <div class="sec2-box">
        <div class="sec2_title">혜택 및 복지</div>
        <div class="sec2_content"><%=pvo.getPbenefit()%></div>
        </div>
    </div>
<%

       }
    }

%>

</section>


<!--section_2 end-->

<footer id="footer"></footer>

</body>
</html>