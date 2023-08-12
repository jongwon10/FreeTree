<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@page import="wearethe.freetree.project.vo.ProjectSupportVO"%>
<%--<%@page import="java.util.ArrayList"%>--%>
<%@ page import="java.util.List" %>
<%@ page import="wearethe.freetree.util.K_Session" %>


<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
    <link href="/css/project/projectSupport.css" type="text/css" rel="stylesheet">
    <link rel="stylesheet" href="/css/datepicker/code.jquery.com_ui_1.12.1_themes_base_jquery-ui.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="/js/datepicker/code.jquery.com_ui_1.12.1_jquery-ui.js"></script>
    <script src="/js/project/projectSupport.js"></script>
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


                // 캘린더
                // Attach calendar functionality
                $(".calender").on("click", function(event) {
                    event.preventDefault();
                    $(".pj-insert-date").datepicker("show");
                    $(".pj-insert-date").val(""); // 값이 비워질 때 z-index 초기화
                });

                // Attach input focus event
                $(".pj-insert-date").on("focus", function() {
                    if ($(".pj-insert-date").val() === "") {
                        $(this).css("z-index", "5");
                    }
                });

                // Attach datepicker onSelect event
                $(".pj-insert-date").datepicker({
                    onSelect: function(dateText) {
                        $(".pj-insert-date").val(dateText);
                    },
                    dateFormat: "yy-mm-dd",
                    onClose: function(dateText) {
                        if (dateText === "") {
                            $(".pj-insert-date").css("z-index", ""); // 날짜가 선택되지 않으면 z-index 초기화
                        }
                    }
                });

            /*프로젝트 지원하기 등록 버튼*/
            $(document).on("click", "#support-btn", function(){
                console.log("support-btn >>> : ");
                let mnum = $('#mnum').val();

                $('#projectSupport').attr({
                    'action':'/projectSupportInsert',
                    'method':'post',
                    'enctype':'multipart/form-data'
                }).submit();
            });

        });

        function Todownload() {

        };

    </script>

</head>

<body>



<header id="header"></header>
<%
    K_Session ks = K_Session.getInstance();
    String userId = ks.getSession(request);

    System.out.println("세션 가져오기" + userId);
%>

<%
    Object obj = request.getAttribute("listAll");
    if(obj == null) return;

    List<ProjectSupportVO> aList = (List<ProjectSupportVO>) obj;
    if(aList.size() > 0){
            ProjectSupportVO psvo = aList.get(0);
%>


<section id="section_1">
    <form id="projectSupport" name="projectSupport" >

        <!--프로젝트 타이틀명-->
        <div id="head">
            <div id="back">〈</div>
            <div id="title">프로젝트 지원</div>
        </div>
        <!-- head end -->
        <%
            Object objp = request.getAttribute("pnum");
            Object objc = request.getAttribute("cnum");

        %>
        <input type="hidden" name="rnum" value="<%= psvo.getRnum()%>">
        <input type="hidden" name="mnum" id="mnum" value="<%=userId%>">
        <input type="hidden" name="pnum" value="<%= objp %>">
        <input type="hidden" name="cnum" value="<%= objc %>">
        <!--프로젝트 명-->
        <div id="pj-insert-name">
            <input type="text" class="name-i" id="name-i" name="paintro">
            <div class="pj-name">한줄 소개</div>
            <div class="star">*</div>
            <div class="count" id="count">0/30</div>
        </div>
        <!--pj-insert-name end-->

        <div id="pj-insert-all">
            <div id="pj-insert-left">
                <div class="pj-insert-wrap">
                    <div class="pj-insert-cal">
                        <input type="text" class="pj-insert-date" id="pj-insert-date" name="pastartdate" readonly>
                        <button class="calender">
                            <img src="/img/project/calender.png" alt="캘린더"/>
                        </button>
                        <div class="calender-name">프로젝트 시작 가능일</div>
                        <div class="star">*</div>
                    </div>
                    <!-- pj-insert-cal end -->
                </div>
                <!-- pj-insert-wrap end -->

                <div id="pj-work-type">
                    <select class="work-type-bar type-bar01" id="pj-work" name="patypework">
                        <option>근무형태</option>
                        <option>임시근로자</option>
                        <option>파트타임</option>
                        <option>원격근로자</option>
                        <option>프리랜서</option>
                    </select>

                </div>
                <!--pj-work-type end-->

            </div>
            <!-- pj-insert-left end-->

            <div id="pj-insert-right">

                <div class="pj-people-wrap">
                    <div class="pj-people-all">
                        <select class="work-type-bar type-bar01" name="pajob">
                            <option>직무 선택</option>
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

                        <div class="carrer-wrap">
                            <input type="text" class="carrer" id="carrer" name="pacarrer" oninput="validateInput(this)">
                            <div class="carrer-text">경력</div>
                            <div class="star">*</div>
                        </div>
                    </div>
                    <%--pj-people-all end--%>
                </div>
                <!--pj-people-wrap end-->
                <div class="pj-pay-wrap">
                    <div class="pj-pay-title-wrap">
                        <div class="pj-pay-title">
                            <p>희망급여</p>
                            <span>월 단위</span>
                        </div>
                        <div class="pj-pay">
                            <input type="text" class="min-money" id="ppaymin" name="paminpay" oninput="validateInput(this)"  placeholder="최소 금액">
                            <div class="money-unit1">(만)</div>
                            <div class="pj-pay-button">-</div>
                            <input type="text" class="max-money" id="ppaymax" name="pamaxpay" oninput="validateInput(this)" placeholder="최대 금액">
                            <div class="money-unit2">(만)</div>
                        </div>
                    </div>
                </div>
                <!--pj-pay end-->
            </div>
            <!--pj-insert-right end-->
        </div>
        <!--pj-insert-all end-->

        <div class="pj-center-wrap">
            <div class="pj-center">
                <div class="pj-center-title"><span>소</span>개서</div>
                <div class="pj-text-wrap">
                    <table>
                        <tr>
                            <td class="pj-text" name="mpinfo"  value="<%=psvo.getMpinfo() %>"/><%=psvo.getMpinfo() %>
                        </tr>
                    </table>

                </div>
            </div>
        </div>
        <!--sec1_center end-->

        <div id="pj-center-warp2">
            <div class="sec1_con">
                <div class="sec1-title-wrap">
                  <div class="sec1-title">
                      <p><span>첨</span>부 파일</p>
                  </div>
                </div>
                <!--sec1-title-wrap end-->
                <div class="con_wrap">
                    <div class="con">
                        <a id="downloadLink" href="/upload/<%=psvo.getMpfileup()%>" download onclick="return false"><p name="mpfileup" value="<%=psvo.getMpfileup()%>"></p><%=psvo.getMpfileup()%></a>
                       <!-- <p>공공기업 프로젝트 참여 포트폴리오01</p>-->
                        <div class="con_img"><img src="img/project/download.png" alt="이미지" onclick="Todownload()"></div>
                    </div>

                </div>
                <!-- con_wrap end -->
            </div>
            <!--sec1_con end-->
        </div>
        <!--sec1_center2 end-->


        <div id="sec1_center3">
            <div class="sec2_con" id="sec2_con1">
                <div class="sec2_title">
                    <p><span>기</span>본 정보</p>
                    <!-- <input type="button" value="수정" class="sec2_btn">-->
                </div>
                <!--sec2_title end-->
            </div>
            <!--sec2_con end-->
            <table class="t">

                <tr class="t1 first">
                    <th class="name">성명</th>

                    <td><input type="text" class="text" name="rname" value="<%=psvo.getRname()%>"readonly>

                    <th class="en">영문</th>
                    <td><input type="text" class="text" name="rengname" value="<%= psvo.getRengname()%>"readonly></td>
                </tr>
                <tr class="t1 first">
                    <th class="birth">생년월일</th>
                    <td><input type="text" class="text" name="rbirth" value="<%= psvo.getRbirth()%>"readonly>
                    <th class="phone">휴대폰</th>
                    <td><input type="text" class="text" name="rhp" value="<%= psvo.getRhp()%>"readonly></td>
                </tr>
                <tr class="t1 first">
                <th class="addr" rowspan="2">주소</th>
                    <td><input type="text" class="text" id="raddr" name="raddr" value="<%= psvo.getRaddr() %>" readonly></td>
                </tr>


            </table>

        </div>
        <!--sec1_center3 end-->

        <div id="sec1_content4">
            <div class="sec2_con">
                <div class="sec2_title">
                    <p><span>학</span>력 사항</p>
                </div>
                <!--sec2_title end-->
            </div>
            <!--sec2_con end-->
            <table class="t">
                <tr class="t1">
                    <th class="second">기간</th>
                    <th class="second">학교명</th>
                    <th>학과</th>

                </tr>
                <tr class="t1 bottom">
                    <td><input type="text" class="text" name="rperiod" value="<%= psvo.getRperiod()%>" readonly></td>
                    <td><input type="text" class="text" name="rschname" value="<%= psvo.getRschname()%>"readonly></td>
                    <td><input type="text" class="text" name="rmajor" value="<%=psvo.getRmajor()%>"readonly></td>

                </tr>
                <tr class="t1">
                    <td><input type="text" class="text" readonly></td>
                </tr>
            </table>
        </div>
        <!--sec1_content4 end-->


        <div id="sec1_content5">
            <div class="sec2_con">
                <div class="sec2_title">
                    <p><span>경</span>력 사항</p>
                </div>
                <!--sec2_title end-->
            </div>
            <!--sec2_con end-->
            <table class="t">
                <tr class="t1">
                    <th class="second">근무 기간</th>
                    <th class="second">업무 내용</th>
                    <th>근무처</th>
                </tr>
                <tr class="t1 bottom">
                    <td><input type="text" class="text" name="rtenure" value="<%= psvo.getRtenure() %>" readonly></td>
                    <td><input type="text" class="text" name="rrespons" value="<%=psvo.getRrespons()%>" readonly></td>
                    <td><input type="text" class="text" name="rworkname" value="<%=psvo.getRworkname()%>" readonly></td>
                </tr>
                <tr class="t1">
                    <td><input type="text" class="text"></td>
                </tr>
            </table>
        </div>
        <!--sec1_content5 end-->


        <div id="sec1_content6">
            <div class="sec2_con">
                <div class="sec2_title">
                    <p><span>자</span>격증 및 특기사항</p>
                </div>
                <!--sec2_title end-->
            </div>
            <!--sec2_con end-->
            <table class="t">
                <tr class="t1">
                    <th class="second">취득년 월일</th>
                    <th class="second">자격증 및 특기사항 내용</th>
                    <th>발령청</th>
                </tr>
                <tr class="t1 bottom">
                    <td><input type="text" class="text" name="racqui" value="<%= psvo.getRacqui()%>"readonly></td>
                    <td><input type="text" class="text" name="rlicense" value="<%= psvo.getRlicense()%>" readonly></td>
                    <td><input type="text" class="text" name="rpublisher" value="<%= psvo.getRpublisher()%>"readonly></td>
                </tr>
                <tr class="t1">
                    <td><input type="text" class="text"></td>
                </tr>
            </table>
        </div>
        <!--sec1_content6 end-->

        <div class="insert_btn">
            <input type="button" value="지원하기" id="support-btn">
        </div>

    </form>
    <!--project-insert end-->
    <%

        }
    %>

</section>
<!--section_1 end -->

<footer id="footer"></footer>
<!-- footer end-->

</body>
</html>