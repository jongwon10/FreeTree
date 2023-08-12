<%@ page import="wearethe.freetree.mypage.vo.ResumeVO" %>
<%@ page import="java.util.List" %>
<%@ page import="wearethe.freetree.mypage.vo.MemMypageVO" %>
<%@ page import="wearethe.freetree.util.K_Session" %>
<%@ page import="wearethe.freetree.project.vo.ProjectSupportVO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%
    Object obj = request.getAttribute("rlist");
    if (obj == null) return;

    List<ResumeVO> list = (List<ResumeVO>)obj;
    int nCnt = list.size();

    ResumeVO rvo = list.get(0);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>resumeSelect.jsp</title>
    <!-- Google Material Icons 라이브러리 로드 -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="/css/resume/resumeSelect.css" type="text/css" rel="stylesheet">
    <script src="/js/resume/resume.js"></script>
    <link href="/css/reset.css" type="text/css" rel="stylesheet">

    <script>
        $(document).ready(function() {
            $(function () {
                $.ajax({
                    url: "/header", // 헤더를 반환하는 엔드포인트
                    success: function (data) {
                        $("#header").html(data);
                    }
                });

                $.ajax({
                    url: "/footer", // 푸터를 반환하는 엔드포인트
                    success: function (data) {
                        $("#footer").html(data);
                    }
                });
            });


            $(document).on("click", ".rupdate", function () {
                $("#resumeForm").attr({
                    "action": "resumeUpdateForm",
                    "method": "POST",
                    "enctype": "application/x-www-form-urlencoded"
                }).submit();
            });
        });
    </script>
</head>
<body>
<%
    K_Session ks = K_Session.getInstance();
    String userId = ks.getSession(request);

    System.out.println("세션 가져오기" + userId);
%>
<header id="header"></header>
<form name="resumeForm" id="resumeForm">
    <div id="top">
        <div id="pro">
            <img src="/img/mypage/profile.jpg">
        </div>

        <div>

            <div id="info">
                <%
                    Object _obj = request.getAttribute("mlist");
                    if (_obj == null) return;

                    List<MemMypageVO> mlist = (List<MemMypageVO>)_obj;

                    MemMypageVO mmvo = null;
                    mmvo = mlist.get(0);
                %>
                <form id="updateSelect">
                <input type="hidden" name="userId" value="<%= userId %>">
                <input type="hidden" name="mnum" value="<%= mmvo.getMnum()%>">
                </form>
                <h1 name="mname" value="<%= mmvo.getMname()%>"><%= mmvo.getMname()%></h1>
                <p name="memail" value="<%= mmvo.getMemail()%>"><% if (mmvo.getMemail() != null) { %><%=mmvo.getMemail()%><% }else{%> 이메일이 없습니다.<%}%></p>
                <p></p>
            </div>


            <div class="mpposition">
                <input type="button" name="mpposition" id="mpposition" value="<%= mmvo.getMpposition()%>" readonly>
            </div>

            <div class="sns">
                <img src="/img/mypage/github.png" style="cursor: pointer;" onclick="goGit()">
                <img src="/img/mypage/instar.png" style="cursor: pointer;" onclick="goInstar()">

<%--                <% if (userId.equals(mmvo.getMnum())) { %>
                <button type="button" id="mupdate">내 정보 수정</button>
                <% } %>--%>
            </div>

        </div>
    </div><hr>

    <div class="container">
        <div>
            <p class="update">등록일 : <input type="button" name="insertdate" value="<%= rvo.getInsertdate() %>" readonly /></p>
            <p class="update">수정일 : <input type="button" name="updatedate" value="<%= rvo.getUpdatedate() %>" readonly /></p>
        </div>


        <div class="basic">
            <p class="p"><span>기</span>본 정보</p>
            <% if (userId.equals(mmvo.getMnum())) { %>
            <button type="button" class="rupdate">이력서 수정</button>
            <% } %>
        </div>
        <table class="t">
            <tr>
                <th class="b">성 명</th>
                <td><input type="text" class="text" name="rname" value="<%= rvo.getRname()%>" readonly></td>
                <th class="b1">영 문</th>
                <td><input type="text" class="text" name="rengname" value="<%= rvo.getRengname()%>" readonly></td>
            </tr>
            <tr>
                <th class="b">생년월일</th>
                <td><input type="text" class="text" name="rbirth" value="<%= rvo.getRbirth()%>" readonly></td>
                <th class="b1">휴대폰</th>
                <td><input type="text" class="text" name="rhp" value="<%= rvo.getRhp()%>" readonly></td>
            </tr>
            <tr>
                <th class="b">주소</th>
                <td colspan="3"><input type="text" class="text" name="raddr" value="<%= rvo.getRaddr()%>" readonly></td>
            </tr>
        </table>

        <div class="basic1">
            <p class="p"><span>학</span>력 사항</p>
        </div>
        <table class="tt" id="education">
            <tr>
                <th class="bb">재학기간</th>
                <th class="bb">학교명</th>
                <th class="bb1">전공명</th>
            </tr>

            <%
                String[] rperiodArray = rvo.getRperiod().split(",");
                String[] rschnameArray = rvo.getRschname().split(",");
                String[] rmajorArray = rvo.getRmajor().split(",");

                for (int i = 0; i < rperiodArray.length; i++) {
                    String rperiod = rperiodArray[i];
                    String rschname = rschnameArray[i];
                    String rmajor = rmajorArray[i];
            %>
            <tr>
                <td class="bb2">
                    <input type="text" class="text" name="rperiod" value="<%= rperiod %>" readonly>
                </td>
                <td class="bb2">
                    <input type="text" class="text" name="rschname" value="<%= rschname %>" readonly>
                </td>
                <td class="bb3">
                    <input type="text" class="text" name="rmajor" value="<%= rmajor %>" readonly>
                </td>
            </tr>
            <%
                }
            %>
        </table>

        <div class="basic1">
            <p class="p"><span>경</span>력 사항</p>
        </div>
        <table class="tt" id="career">
            <tr>
                <th class="bb">근무 기간</th>
                <th class="bb">담당 업무</th>
                <th class="bb1">직장명</th>
            </tr>
            <%
                String[] rtenureArray = rvo.getRtenure().split(",");
                String[] rresponsArray = rvo.getRrespons().split(",");
                String[] rworknameArray = rvo.getRworkname().split(",");

                for (int i = 0; i < rtenureArray.length; i++) {
                    String rtenure = rtenureArray[i];
                    String rrespons = rresponsArray[i];
                    String rworkname = rworknameArray[i];
            %>
            <tr>
                <td class="bb2">
                    <input type="text" class="text" name="rtenure" value="<%= rtenure %>" readonly>
                </td>
                <td class="bb2">
                    <input type="text" class="text" name="rrespons" value="<%= rrespons %>" readonly>
                </td>
                <td class="bb3">
                    <input type="text" class="text" name="rworkname" value="<%= rworkname %>" readonly>
                </td>
            </tr>
            <%
                }
            %>
        </table>

        <div class="basic1">
            <p class="p"><span>자</span>격증 및 특기사항</p>
        </div>
        <table class="tt" id="license">
            <tr>
                <th class="bb">취득일</th>
                <th class="bb">자격증 / 면허증</th>
                <th class="bb1">발행처</th>
            </tr>
            <%
                String[] racquiArray = rvo.getRacqui().split(",");
                String[] rlicenseArray = rvo.getRlicense().split(",");
                String[] rpublisherArray = rvo.getRpublisher().split(",");

                for (int i = 0; i < racquiArray.length; i++) {
                    String racqui = racquiArray[i];
                    String rlicense = rlicenseArray[i];
                    String rpublisher = rpublisherArray[i];
            %>
            <tr>
                <td class="bb2">
                    <input type="text" class="text" name="racqui" value="<%= racqui %>" readonly>
                </td>
                <td class="bb2">
                    <input type="text" class="text" name="rlicense" value="<%= rlicense %>" readonly>
                </td>
                <td class="bb3">
                    <input type="text" class="text" name="rpublisher" value="<%= rpublisher %>" readonly>
                </td>
            </tr>
            <%
                }
            %>
        </table>
    </div>

    <div class="pro-section">
        <div class="pro accordion">
            <div class="project-wrapper">
                <div class="div-pro">
                        <span class="project-ing">
                            진행중인 프로젝트
                        </span>
                    <i class="material-icons drop">expand_more</i>
                </div>
                <div class="proj-wrapper" style="display: none;">
                    <%
                        Object objp = request.getAttribute("plist");
                        List<ProjectSupportVO> plist = (List<ProjectSupportVO>)objp;
                        for(int i=0; i<plist.size(); i++) {
                            ProjectSupportVO psvo = plist.get(i);
                    %>
                    <p class="proj" name="pname" value="<%= psvo.getPname()%>">
                        제목 : <%= psvo.getPname()%> | 시작일 : <%= psvo.getPstartdate()%>   종료일 : <%= psvo.getPenddate()%></p>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>
    </div>

    <hr>
    <div class="pro-section">
        <div class="pro accordion">
            <div class="project-wrapper">
                <div class="div-pro">
                <span class="project-ing">
                    참여 기록
                </span>
                    <i class="material-icons drop">expand_more</i>
                </div>
                <div class="proj-wrapper" style="display: none;">
                    <%
                        Object obje = request.getAttribute("elist");
                        List<ProjectSupportVO> elist = (List<ProjectSupportVO>)obje;
                        for(int i=0; i<elist.size(); i++) {
                            ProjectSupportVO psvo = elist.get(i);
                    %>
                    <p class="proj" name="pname" value="<%= psvo.getPname()%>">
                        제목 : <%= psvo.getPname()%></p>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>
    </div>
    <hr>
</form>
<footer id="footer"></footer>
</body>
</html>