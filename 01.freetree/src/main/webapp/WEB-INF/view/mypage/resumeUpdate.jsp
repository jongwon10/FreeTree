<%@ page import="wearethe.freetree.mypage.vo.ResumeVO" %>
<%@ page import="java.util.List" %>
<%@ page import="wearethe.freetree.mypage.vo.MemMypageVO" %>
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
        $(document).ready(function(){

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

            // update
            $(document).on("click", "#rupdate", function() {
                $("#resumeForm").attr({
                    "action":"/resumeUpdate",
                    "method":"POST",
                    "enctype":"application/x-www-form-urlencoded"
                }).submit();
            });

            // 학력사항 / 클릭 시 행 추가
            $(document).on("click", "#plus-btn1", function() {

                $("#education").append(
                    "<tr><td class='bb2'><input type='text' class='text'  name='rperiod'></td>" +
                    "<td class='bb2'><input type='text' class='text'  name='rschname'></td>" +
                    "<td class='bb3'><input type='text' class='text' name='rmajor'></td></tr>"
                );
            })

            // 학력사항 / 클릭 시 삭제 2개 이상일 때
            $(document).on("click", "#delete-btn1", function() {
                if ($("#education tr").length > 2) {
                    // 행이 2개 이상인 경우에만 삭제 처리
                    $("#education tr:last-child").remove();
                }
            });

            // 경력사항 / 클릭 시 행 추가
            $(document).on("click", "#plus-btn2", function() {

                $("#career").append(
                    "<tr><td class='bb2'><input type='text' class='text' name='rtenure'></td>" +
                    "<td class='bb2'><input type='text' class='text' name='rrespons'></td>" +
                    "<td class='bb3'><input type='text' class='text' name='rworkname'></td></tr>"
                );
            })

            // 경력사항 / 클릭 시 삭제 2개 이상일 때
            $(document).on("click", "#delete-btn2", function() {
                if ($("#career tr").length > 2) {
                    // 행이 2개 이상인 경우에만 삭제 처리
                    $("#career tr:last-child").remove();
                }
            });

            // 자격증, 특기사항 / 클릭 시 행 추가
            $(document).on("click", "#plus-btn3", function() {

                $("#license").append(
                    "<tr><td class='bb2'><input type='text' class='text' name='racqui'></td>" +
                    "<td class='bb2'><input type='text' class='text' name='rlicense'></td>" +
                    "<td class='bb3'><input type='text' class='text' name='rpublisher'></td></tr>"
                );
            })

            // 자격증, 특기사항 / 버튼 클릭 시 삭제 2개 이상일 때
            $(document).on("click", "#delete-btn3", function() {
                if ($("#license tr").length > 2) {
                    // 행이 2개 이상인 경우에만 삭제 처리
                    $("#license tr:last-child").remove();
                }
            });
        });
    </script>
</head>
<body>
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

                <input type="hidden" name="mnum" value="<%= mmvo.getMnum()%>">
                <h1 name="mname" value="<%= mmvo.getMname()%>"><%= mmvo.getMname()%></h1>
                <p name="memail" value="<%= mmvo.getMemail()%>"><%= mmvo.getMemail()%></p>
                <p></p>
            </div>

            <div class="mpposition">
                <input type="button" name="mpposition" id="mpposition" value="<%= mmvo.getMpposition()%>" readonly>
            </div>

            <div class="sns">
                <img src="/img/mypage/github.png" style="cursor: pointer;" onclick="goGit()">
                <img src="/img/mypage/instar.png" style="cursor: pointer;" onclick="goInstar()">

                <%--<button type="button" id="mupdate">내 정보 수정</button>--%>
            </div>
        </div>
    </div><hr>

    <div class="container">
        <div>
            <input type="hidden" name="rnum" value="<%= rvo.getRnum()%>">
            <p class="update">등록일 : <input type="button" name="insertdate" value="<%= rvo.getInsertdate() %>" readonly /></p>
            <p class="update">수정일 : <input type="button" name="updatedate" value="<%= rvo.getUpdatedate() %>" readonly /></p>
        </div>


        <div class="basic">
            <p class="p"><span>기</span>본 정보</p>
            <button type="button" class="rupdate" id="rupdate">확인</button>
        </div>
        <table class="t">
            <tr>
                <th class="b">성 명</th>
                <td><input type="text" class="text" name="rname" value="<%= rvo.getRname()%>"  placeholder="홍길동"></td>
                <th class="b1">영 문</th>
                <td><input type="text" class="text" name="rengname" value="<%= rvo.getRengname()%>" placeholder="Hong Gil Dong"></td>
            </tr>
            <tr>
                <th class="b">생년월일</th>
                <td><input type="text" class="text" name="rbirth" value="<%= rvo.getRbirth()%>" placeholder="xxxx-xx-xx"></td>
                <th class="b1">휴대폰</th>
                <td><input type="text" class="text" name="rhp" value="<%= rvo.getRhp()%>" placeholder="xxx-xxxx-xxxx"></td>
            </tr>
            <tr>
                <th class="b">주소</th>
                <td colspan="3"><input type="text" class="text" name="raddr" value="<%= rvo.getRaddr()%>"></td>
            </tr>
        </table>

        <div class="basic1">
            <p class="p"><span>학</span>력 사항</p>
            <button type="button" class="btn2" id="delete-btn1"></button>
            <button type="button" class="btn1" id="plus-btn1"></button>
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
                    <input type="text" class="text" name="rperiod" value="<%= rperiod %>"  placeholder="xx.xx.xx~xx.xx.xx">
                </td>
                <td class="bb2">
                    <input type="text" class="text" name="rschname" value="<%= rschname %>" placeholder="xx학교">
                </td>
                <td class="bb3">
                    <input type="text" class="text" name="rmajor" value="<%= rmajor %>"  placeholder="xx학과">
                </td>
            </tr>
            <%
                }
            %>
        </table>

        <div class="basic1">
            <p class="p"><span>경</span>력 사항</p>
            <button type="button" class="btn2" id="delete-btn2"></button>
            <button type="button" class="btn1" id="plus-btn2"></button>
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
                    <input type="text" class="text" name="rtenure" value="<%= rtenure %>" placeholder="xx.xx.xx~xx.xx.xx">
                </td>
                <td class="bb2">
                    <input type="text" class="text" name="rrespons" value="<%= rrespons %>">
                </td>
                <td class="bb3">
                    <input type="text" class="text" name="rworkname" value="<%= rworkname %>">
                </td>
            </tr>
            <%
                }
            %>
        </table>

        <div class="basic1">
            <p class="p"><span>자</span>격증 및 특기사항</p>
            <button type="button" class="btn2" id="delete-btn3"></button>
            <button type="button" class="btn1" id="plus-btn3"></button>
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
                    <input type="text" class="text" name="racqui" value="<%= racqui %>" placeholder="xxxx.xx.xx">
                </td>
                <td class="bb2">
                    <input type="text" class="text" name="rlicense" value="<%= rlicense %>">
                </td>
                <td class="bb3">
                    <input type="text" class="text" name="rpublisher" value="<%= rpublisher %>">
                </td>
            </tr>
            <%
                }
            %>
        </table>
    </div>
</form>
<footer id="footer"></footer>
</body>
</html>