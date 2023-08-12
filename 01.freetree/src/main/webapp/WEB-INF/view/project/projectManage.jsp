<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@page import="wearethe.freetree.project.vo.ProjectSupportVO"%>
<%@ page import="java.util.List" %>
<%@ page import="wearethe.freetree.util.K_Session" %>
<% request.setCharacterEncoding("UTF-8"); %>


<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
    <link href="/css/project/projectManage.css" type="text/css" rel="stylesheet">
   <script src="/js/jquery-1.12.3/jquery-1.12.3.js"></script>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="/js/project/projectManage.js"></script>
    <title>index</title>

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
        });


        function check() {
            var buttonText = $(this).find('.buttonText');
            var button = buttonText.parent();
            buttonText.text("계약서 작성중");
            button.css("background-color", "#757575");
            localStorage.setItem("buttonText", "계약서 작성중");
            localStorage.setItem("buttonBackgroundColor", "#929292");



        }


        // 수락 버튼효과
        $(document).on('click', '.buttonContainer2', function (){
            var button = $(this);
            var buttonText = button.find('.buttonText');
            var panum = $(this).data('panum');
            check(panum);

            button.removeClass("buttonContainer2").addClass("buttonContainer3");
            buttonText.text("계약서 작성중");
            button.css("background-color", "#757575");

            localStorage.setItem("buttonText", "계약서 작성중");
            localStorage.setItem("buttonBackgroundColor", "#929292");

            var popupWidth = 1100;
            var popupHeight = 600;

            // 팝업 창 위치를 위한 좌표 계산
            var left = (window.innerWidth - popupWidth) / 2;
            var top = (window.innerHeight - popupHeight) / 2;


            var urlpush = '/push?pushfilter=' + '근로계약서';

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
            window.open('http://192.168.0.57:3000/', '근로계약서 작성', 'width=' + popupWidth + ',height=' + popupHeight + ',left=' + left + ',top=' + top);

        });


        $(document).on("click", "#moneygobtn", function(){

            var cnumValue = $('#cnum').val();
            var pnumValue = $('#pnum').val();

            // 팝업 창 크기
            var popupWidth = 800;
            var popupHeight = 800;

            // 팝업 창 위치를 위한 좌표 계산
            var left = (window.innerWidth - popupWidth) / 2;
            var top = (window.innerHeight - popupHeight) / 2;

            // 팝업 창 열기 (중앙에 위치)
            window.open('/ftossWidgetMain?cnum=' + cnumValue + '&pnum=' + pnumValue, '수수료 결제하기', 'width=' + popupWidth + ',height=' + popupHeight + ',left=' + left + ',top=' + top);


        });

        $(document).on("click", "#projectstart", function(){
            alert("프로젝트를 시작했습니다.")

            var urlpush = '/push?pushfilter=' + '프로젝트시작';

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

        });

        $(document).on("click", "#projectfix", function(){

            alert("프로젝트가 확정되었습니다.")
            var urlpush = '/push?pushfilter=' + '프로젝트확정';
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

        });


        function pprroceeding(button) {
            var value = button.value;
            var projectCon = document.querySelector('.project-con');

            switch (value) {
                case "중단":
                    projectCon.style.color = "gray";
                    projectCon.innerText = "중단";
                    break;
                case "마감":
                    projectCon.style.color = "red";
                    projectCon.innerText = "마감";
                    break;
                case "모집중":
                    projectCon.style.color = "blue";
                    projectCon.innerText = "모집중";
                    break;
                case "진행중":
                    projectCon.style.color = "#EACD37";
                    projectCon.innerText = "진행중";
                    break;
                default:
                    break;
            }


        }

        // 프로젝트 현황
        function pproceeding(button) {
            var value = button.value;
            var projectCon = document.querySelector('.project-con');

            switch (value) {
                case "중단":
                    projectCon.style.color = "gray";
                    projectCon.innerText = "중단";
                    break;
                case "마감":
                    projectCon.style.color = "red";
                    projectCon.innerText = "마감";
                    break;
                case "모집중":
                    projectCon.style.color = "blue";
                    projectCon.innerText = "모집중";
                    break;
                case "진행중":
                    projectCon.style.color = "#EACD37";
                    projectCon.innerText = "진행중";
                    break;
                default:
                    break;
            }

            toggleContent();
        }

        function openmoney() {
            // 팝업 창을 띄울 URL
            var url = "/popup";

            // 팝업 창의 속성 설정
            var options = "width=500,height=300,top=100,left=100,scrollbars=yes";

            // window.open 메서드를 사용하여 팝업 창 띄우기
            window.open(url, "팝업 창 제목", options);
        }

    </script>


</head>

<%
    K_Session ks = K_Session.getInstance();
    String userId = ks.getSession(request);

    System.out.println("세션 가져오기" + userId);

    Object obj = request.getAttribute("listAll");
    List<ProjectSupportVO> aList = (List<ProjectSupportVO>) obj;

    int nCnt = (aList != null) ? aList.size() : 0;
    System.out.println("조회건수 nCnt >>> : " + nCnt);

    Object obj2 = request.getAttribute("partListAll");
    List<ProjectSupportVO> aList2 = (List<ProjectSupportVO>) obj2;

    int nCnt2 = (aList2 != null) ? aList2.size() : 0;;
    System.out.println("조회건수 nCnt >>> : " + nCnt2);

    Object objn = request.getAttribute("pname");


%>

<body>

<header id="header"></header>

<section id="section_1">
    <div id="sec1_top">
        <div id="sec1_title"><%= objn %></div>
    </div>
    <!--sec1_top end-->
    <div id="sec1_btn">
        <ul id="btn_wrap">
            <li>
                <button type="button" class="hal" id="projectfix" value="마감" onclick="pprroceeding(this)">
                    <img src="/img/project/게시물확인.png" alt="검색" >
                    <p>프로젝트 확정</p>
                </button>
            </li>
            <li>
                <button type="button" onclick="openmoney()">
                    <img src="/img/project/수정.png" alt="설정">
                    <p>예치금</p>
                </button>
            </li>
            <li>
                <button type="button" id="moneygobtn">
                    <img src="/img/project/수정.png" alt="설정">
                    <p>수수료 결제</p>
                </button>
            </li>
            <li>

                <button type="button" value="진행중" id="projectstart" onclick="pprroceeding(this)">
                    <img src="/img/project/삭제.png" alt="휴지통" >
                    <p>프로젝트 개시</p>
                </button>
            </li>
        </ul>
    </div>
    <!--sec1_btn end-->

    <div class="sec1_content2">
        <h5 class="project-con">모집중 </h5>
        <button id="toggleButton" onclick="toggleContent()">▼</button>
    </div>
    <ul id="hiddenList">
        <li><input type="button" id="stop" value="중단" onclick="pproceeding(this)"></li>
        <li><input type="button" id="deadline" value="마감" onclick="pproceeding(this)"></li>
        <li><input type="button" id="recrui"value="모집중"  onclick="pproceeding(this)"></li>
        <li><input type="button" id="proceeding" value="진행중"onclick="pproceeding(this)"></li>


    </ul>

    <!--sec1_content2 end-->


    <div class="sub_title01">

        <p><span>신</span>청자 목록(<%= nCnt %>)</p>
        <%
            if(aList != null && aList.size() > 0) {
                for(int i=0; i < aList.size(); i++){
                    ProjectSupportVO psvo = aList.get(i);
        %>


        <script>
            // 글 내용보기
            $(document).on("click", "#contentsBtn<%=i%>", function(){
                $("#conList<%=i%>").attr({
                    "method":"POST",
                    "action":"/projectManageContents",
                    'enctype':'multipart/form-data'
                }).submit();
            });


           /* // 수락
            $(document).on("click", "#yesbtn2<%=i%>", function(){
                $("#conList<%=i%>").attr({
                    "method":"POST",
                    "action":"/prjectSupportUpdate",
                    'enctype':'multipart/form-data'
                }).submit();
            });*/




            // 거절
            $(document).on("click", "#nobtn<%=i%>", function (){
               $("#conList<%=i%>").attr({
                   "method":"GET",
                   "action":"/projectManageDelete",
                   "enctype":"application/x-www-form-urlencoded"
               }).submit();
            });


        </script>
        <div id="sec1_center">
            <div id="container">
                <form id="moneygo">
                    <% Object objp = request.getAttribute("pnum");
                        String abc = (String)objp;
                    %>
                    <input type="hidden" name="pnum" id="pnum" value="<%= abc %>">
                    <input type="hidden" name="cnum" id="cnum" value="<%= userId %>">
                </form>
                <form id="conList<%=i%>" name="conList">
                    <input type="hidden" name="panum" value="<%=psvo.getPanum()%>">
                    <input type="hidden" name="pname" value="<%= objn %>">
                    <input type="hidden" name="pnum" value="<%= abc %>">
                    <input type="hidden" name="mnum" value="<%=psvo.getMnum()%>">
                    <input type="hidden" name="cnum" value="<%= userId %>">
                    <div class="con">

                        <ul class="con_top">
                            <li>
                                <div class="a_container">
                                   <%-- <%
                                        for(int i=0; i<nCnt2; i++){

                                            ProjectSupportVO psvo2 = bList.get(i);

                                    %>--%>
                                    <div class="c1">
                                        <div class="g"></div>
                                        <div class="info">

                                            <input type="text" class="info_text" value="<%= psvo.getRname()%>" readonly>
                                            <input type="text" class="info_text" value="<%= psvo.getRengname()%>" readonly>
                                        </div>
                                    </div>
                                    <%--<%
                                        }
                                    %>--%>

                                    <!--c1 end-->
                                    <div class="c2">
                                       <%-- <%
                                            for(int i=0; i<nCnt; i++){

                                                ProjectSupportVO psvo = aList.get(i);

                                        %>--%>
                                        <input type="text" class="c2_text" value="<%=psvo.getPajob()%>" readonly>
                                        <input type="text" class="c2_text" value="<%=psvo.getPacarrer()%>년"  readonly>
                                    </div>
                                    <!--c2 end-->
                                </div>
                                <!--a_container end-->
                            </li>
                            <li id="con_w">
                               <div id="con_left">
                                   <p>한줄 소개</p>
                                   <p>프로젝트 시작 날짜</p>
                                   <p>근무 형태</p>
                                   <p>희망 급여</p>
                               </div>
                                <div id="con_right">
                                    <input type="text" class="con_right_text" value="<%=psvo.getPaintro()%>" readonly>
                                    <input type="text" class="con_right_text" value="<%=psvo.getPastartdate()%>" readonly>
                                    <input type="text" class="con_right_text" value="<%=psvo.getPatypework()%>" readonly>
                                    <input type="text" class="con_right_text" value="<%=psvo.getPaminpay() + '~' + psvo.getPamaxpay()%>" readonly>
                                </div>
                            </li>
                            <%--con_w end--%>
                        </ul>
                        <%--con_top end--%>
                        <div class="con_bottom">
                            <ul class="con_b">
                                <li>
                                    <button type="button" id="contentsBtn<%=i%>" class="buttonContainer1">
                                        <img src="/img/project/이력서열람.png" alt="담당자">
                                        <p>지원/이력서 열람</p>
                                    </button>

                                </li>
                                <li>
                                    <%--<%if(psvo.getPinyes().equals("1")) {%>
                                   <button type="button" class="buttonContainer2" id="yesbtn<%=i%>" onclick="check()">
                                        <img src="/img/project/수락.png" alt="담당자">
                                        <p class="buttonText">수락</p>
                                    </button>
                                    <%}else if(psvo.getPinyes().equals("2")) { %>
                                    <button type="button" class="buttonContainer3" id="yesbtn2<%=i%>">
                                        <img src="/img/project/계약서작성중.png" alt="담당자">
                                        <p class="buttonText">계약서 작성 중</p>
                                    </button>
                                    <%}%>--%>


                    <% if (psvo.getPinyes().equals("1")) { %>
                    <button type="button" class="buttonContainer2" id="yesbtn<%= i %>" >
                        <img src="/img/project/수락.png" alt="담당자">
                        <p class="buttonText">수락</p>
                    </button>
                    <% } else if (psvo.getPinyes().equals("2")) { %>
                    <button type="button" class="buttonContainer3" id="yesbtn<%= i %>">
                        <img src="/img/project/계약서작성중.png" alt="담당자">
                        <p class="buttonText">계약서 작성 중</p>
                    </button>
                    <% } %>


                    </li>
                    <li class="con_x_1">
                        <button type="button" class="buttonContainer4" id="nobtn<%=i%>">
                            <img src="/img/project/거절.png" alt="담당자">
                            <p>거절</p>
                        </button>

                    </li>
                            </ul>
                            <!--con_b end-->
                        </div>
                    </div>
                    <%--con end--%>

                </form>
                <%
                        }// end of for
                    }else{%>
                <br><br><br><br>
                <p>지원자가 없습니다</p>
                <br><br><br><br>
                <%}%>
            </div>
            <!--container end-->
        </div>
        <!--sec1_center end-->
    </div>
    <!--sub_title01 end-->
<%--   <%
           }// end of for
        }//end of if
    %>--%>

    <div class="sub_title02">





        <p><span>참</span>여중인 프리랜서(<%=nCnt2%>)</p>

        <%
            if(aList2 != null && aList2.size() > 0){
                for(int i=0; i<aList2.size(); i++){
                    ProjectSupportVO ypsvo = aList2.get(i);

        %>

        <input type="hidden" name="panum" id="panum">
        <div id="sec2_center">
            <div id="container2">
                <form id="conList2" name="conList2">
                    <div class="con">

                        <ul class="con_top">
                            <li>
                                <div class="a_container">

                                    <div class="c1">
                                        <div class="g"></div>
                                        <div class="info">

                                            <input type="text" class="info_text" value="<%=ypsvo.getRname()%>" readonly>
                                            <input type="text" class="info_text" value="<%=ypsvo.getRengname()%>" readonly>
                                        </div>
                                    </div>


                                    <!--c1 end-->
                                    <div class="c2">

                                        <input type="text" class="c2_text" value="<%=ypsvo.getPajob()%>" readonly>
                                        <input type="text" class="c2_text" value="<%=ypsvo.getPacarrer()%>년" readonly>
                                    </div>
                                    <!--c2 end-->
                                </div>
                                <!--a_container end-->
                            </li>
                            <li id="con_w">
                                <div id="con_left2">
                                    <p>한줄 소개</p>
                                    <p>프로젝트 시작 날짜</p>
                                    <p>근무 형태</p>
                                    <p>희망 급여</p>
                                </div>
                                <div id="con_right2">
                                    <input type="text" class="con_right_text"  value="<%=ypsvo.getPaintro()%>" readonly>
                                    <input type="text" class="con_right_text"  value="<%=ypsvo.getPastartdate()%>" readonly>
                                    <input type="text" class="con_right_text" value="<%=ypsvo.getPatypework()%>" readonly>
                                    <input type="text" class="con_right_text" value="<%=ypsvo.getPaminpay() + '~' + ypsvo.getPamaxpay()%>" readonly>
                                </div>
                            </li>
                            <%--con_w end--%>
                        </ul>
                        <%--con_top end--%>
                        <div class="con_bottom">
                            <ul class="con_b">
                                <li>
                                    <button type="button" id="contentsBtn2" class="buttonContainer8">
                                        <img src="/img/project/이력서열람.png" alt="담당자">
                                        <p>지원/이력서 열람</p>
                                    </button>
                                </li>
                                <%--<li>
                                    <button type="button" class="buttonContainer1">
                                        <img src="/img/project/이력서열람.png" alt="담당자">
                                        <p>마이페이지 열람</p>
                                    </button>
                                </li>
                                <li class="con_x_2">
                                    <button type="button" class="buttonContainer1">
                                        <img src="/img/project/이력서열람.png" alt="담당자">
                                        <p>쪽지 보내기</p>
                                    </button>
                                </li>--%>
                            </ul>
                           <!--con_b end-->
                        </div>
                    </div>
                  <%--  con end--%>
                </form>
            </div>
        </div>


    <%
            }
        }else {
    %>
            <br><br><br><br>
            <p>참여중인 지원자가 없습니다.</p>
            <br><br><br><br>
    <%
        };
    %>
    </div>
   <%-- <!--sub_title02 end-->--%>

</section>
<!--section_1 end-->

<footer id="footer"></footer>

</body>
</html>