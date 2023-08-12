<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ page import="wearethe.freetree.question.vo.QuestionVO" %>
<%@ page import="java.util.List" %>

<% request.setCharacterEncoding("UTF-8");%>

<%
    Object obj = request.getAttribute("listS");
    if (obj == null) return;
    List<QuestionVO> list = (List<QuestionVO>)obj;
    int nCnt = list.size();
    QuestionVO qvo = null;
    if (nCnt == 1){
        qvo = list.get(0);
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <link href="/css/question/questionSelect.css" type="text/css" rel="stylesheet">
    <link href="/css/reset.css" type="text/css" rel="stylesheet">
    <script type="text/javascript">
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
        $(document).ready(function(){

            //  I
            $(document).on("click", "#insertBtn", function(){
                location.href="questionForm";
            });
            // SALL
            $(document).on("click", "#selectAllBtn", function(){
                location.href="questionSelectAll";
            });
        });

    </script>

</head>
<body>
<header id="header"></header>
<div class="container">


    <form name="questionSelectF" id="questionSelectF">
        <table class="seltable">
            <tr>
                <td>제목</td>
                <td colspan="4">
                    <%= qvo.getQname() %>
                    <input type="hidden" name="qnum" id="qnum" value="<%= qvo.getQnum() %>" />
                    <input type="hidden" name="fnum" id="fnum" value="<%= qvo.getFnum() %>" />
                </td>
            </tr>
            <tr>
                <td>작성자</td>
                <td><%=  qvo.getFnum() %></td>
                <td>카테고리</td><td class="td_1"><%= "업체 후기" %></td>
                <td>상세</td><td class="td_1"><%= "아" %></td>
            </tr>
            <tr>
                <td colspan="6" style="text-align:left">
                    <img src="/upload/<%= qvo.getQfile() %> " width="1000" height="800" alt="image"><br>
                </td>
            </tr>
            <tr>
                <td colspan="6" style="text-align:left">
                    <textarea name="qcontent" id="qcontent" rows="5" cols="100" readonly><%= qvo.getQcontent() %></textarea>
                </td>

            </tr>
            <tr>
                <td colspan="4" style="text-align:left">
                    <p>관리자 답변 :</p>
                    <%if(qvo.getQanswer() != null) {%>

                    <textarea name="qanswer" id="admincontent" rows="5" cols="100" readonly><%= qvo.getQanswer()%></textarea>
                    <%}else {%>
                    답변이 없습니다.
                    <%}%>
                </td>
            </tr>
            <tr>
                <td colspan="6">
                    <button type="button" class="btn" id="insertBtn">글쓰기</button>
                    <button type="button" class="btn" id="selectAllBtn">글목록</button>
                </td>
            </tr>
        </table>
    </form>
</div>
<!-- 댓글 처리 하는 루틴  -->
<%--<jsp:include page="/rboardForm.c">
    <jsp:param value="<%=qvo.getQnum()%>" name="qnum"/>
</jsp:include>--%>
<footer id="footer"></footer>
</body>
</html>