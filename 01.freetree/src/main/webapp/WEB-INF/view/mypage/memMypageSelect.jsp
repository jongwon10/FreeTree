<%@ page import="wearethe.freetree.mypage.vo.MemMypageVO" %>
<%@ page import="java.util.List" %>
<%@ page import="wearethe.freetree.util.K_Session" %>
<%@ page import="wearethe.freetree.mypage.vo.ResumeVO" %>
<%@ page import="wearethe.freetree.project.vo.ProjectVO" %>
<%@ page import="wearethe.freetree.project.vo.ProjectSupportVO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Google Material Icons 라이브러리 로드 -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="/css/reset.css" type="text/css" rel="stylesheet">
    <link href="/css/mypage/memMypageSelect.css" type="text/css" rel="stylesheet">
    <script src="/js/mypage/memMypageSelect.js"></script>

    <title>MyPage</title>
    <script>

        $(document).ready(function() {
            $(document).on("click", "#btn", function() {
                $("#updateSelect").attr({
                    "action":"/memMypageForm",
                    "method":"POST",
                    "enctype":"multipart/form-data"
                }).submit();
            });

            $(document).on("click", "#btn1", function() {
                $("#updateSelect").attr({
                    "action":"/resumeForm",
                    "method":"POST",
                    "enctype":"multipart/form-data"
                }).submit();
            });

            $(function() {
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
        });
    </script>

</head>
<%
    K_Session ks = K_Session.getInstance();
    String userId = ks.getSession(request);

    System.out.println("세션 가져오기" + userId);
%>
<header id="header"></header>
<body>
<div class="all">
<div id="top">
    <div id="pro">
        <img src="/img/mypage/profile.jpg">
    </div>
    <div>
        <div id="info">
            <%
                Object obj = request.getAttribute("ulist");
                if (obj == null) return;

                List<MemMypageVO> list = (List<MemMypageVO>)obj;

                MemMypageVO mmvo = null;
                mmvo = list.get(0);

                Object objr = request.getAttribute("rlist");
                List<ResumeVO> rlist = (List<ResumeVO>)objr;
            %>
            <form id="updateSelect">
            <input type="hidden" name="userId" value="<%= userId %>">
            <input type="hidden" name="mnum" value="<%= mmvo.getMnum() %>">
            </form>
            <h1 name="mname" value="<%= mmvo.getMname()%>"><%= mmvo.getMname()%></h1>
            <p name="memail" value="<%= mmvo.getMemail()%>"><% if (mmvo.getMemail() != null) { %><%=mmvo.getMemail()%><% }else{%> 이메일이 없습니다.<%}%></p>
            <p></p>
        </div>
        <div class="mpposition">
            <input type="button" name="mpposition" id="mpposition" value="<%= mmvo.getMpposition()%>" readonly>
        </div>
        <div class="sns">
            <a href="https://github.com/<%= mmvo.getMpgit()%>" target="_blank" rel="noopener noreferrer">
                <img src="/img/mypage/github.png" style="cursor: pointer;">
            </a>
            <a href="https://www.instagram.com/<%= mmvo.getMpinstar()%>" target="_blank" rel="noopener noreferrer">
                <img src="/img/mypage/instar.png" style="cursor: pointer;">
            </a>
            <% if(userId.equals(mmvo.getMnum())) { %>
            <button type="button" id="btn">내 정보 수정</button>
            <% }%>
        </div>
    </div>
</div><hr>

<div id="con1">
    <h2>소개서</h2>
<% if(rlist != null && rlist.size() > 0) { %>
    <button type="button" id="btn1">이력서 확인</button>
<% }else if(userId.equals(mmvo.getMnum())){%>
    <button type="button" id="btn1">이력서 확인</button>
<%}else {%>
    <p class="soge">이력서가 없습니다.</p>
<%}%>
</div>
<hr>
<div class="con2">
    <table>
        <tr>
            <td name="mpinfo" class="mpinfo" value="<%= mmvo.getMpinfo()%>"><%= mmvo.getMpinfo()%></td>
        </tr>
    </table>
</div><br>
<div class="file">
    <p>첨부파일</p>
    <% if(mmvo.getMpfileup() != null && !mmvo.getMpfileup().equals("")) { %>
    <a href="/upload/<%= mmvo.getMpfileup()%>" download><%= mmvo.getMpfileup()%></a>
    <% } else { %>
    파일이 없습니다
    <% } %>
</div>

<hr>
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
</div>
<footer id="footer"></footer>
</body>
</html>