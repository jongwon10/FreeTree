<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ page import="wearethe.freetree.question.vo.QuestionVO" %>
<%@ page import="java.util.List" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%

    Object obj = request.getAttribute("listAll");
    List<QuestionVO> list = (List<QuestionVO>)obj;

    int nCnt = list.size();
    String nCntS = " 전체 Q&A 수 : " + nCnt + " 건";

%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="/css/question/questionSelectAll.css" type="text/css" rel="stylesheet">
    <link href="/css/reset.css" type="text/css" rel="stylesheet">
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

        alert("자바스크립트 블럭 진입 >>> : ");

        $(document).ready(function(){
            alert("jQuery ready() 함수 블럭 진입 >>> : ");

            // chkAll 체크박스 체크 확인하기
            $(document).on("click", "#chkAll", function(){

                if($(this).prop('checked')){
                    $('.qnum').prop('checked',false);
                }
            });
            // qnum 체크박스 체크 확인하기
            $(document).on("click", "#qnum", function(){

                if($(this).prop('checked')){
                    $('.qnum').prop('checked',false);
                    $(this).prop('checked',true);
                }
            });

            //  I
            $(document).on("click", "#insertBtn", function(){
                location.href="questionForm";
            });

            // SALL
            $(document).on("click", "#selectAllBtn", function(){
                $("#questionList").attr({"method":"GET", "action":"questionSelectAll"}).submit();
            });

            //  S
            $(document).on("click", "#contentsBtn", function(){
                if ($('.qnum:checked').length == 0){
                    alert("글번호 하나를 선택하세요!!");
                    return;
                }
                $("#questionList").attr({ "method":"GET","action":"questionSelect"}).submit();
            });

            //  D
            $(document).on("click", "#deletetBtn", function(){
                if ($('.qnum:checked').length == 0){
                    alert("삭제할 글번호 하나를 선택하세요!!");
                    return;
                }
                $("#questionList").attr({ "method":"GET","action":"questionDelete"}).submit();
            });
        });
    </script>

</head>
<body>
<header id="header"></header>


<div class="container">
    <form name="questionList" id="questionList">
        <table class="qnatable">
            <thead>
            <tr>
                <td colspan="7">
                    <h1>Q&A 게시판</h1>
                    <h3><%= nCntS %></h3><hr>
                </td>
            </tr>
            <tr>
                <th>
                    <input type="checkbox" class="chkAll" name="chkAll" id="chkAll">
                </th>
                <th>글번호</th>
                <th>글제목</th>
                <th>이름</th>
                <th>사진</th>
                <th>날짜</th>
            </tr><hr>
            </thead>
              <%
                for(int i=0; i<nCnt; i++){
                    QuestionVO qvo = list.get(i);%>
            <tbody>
            <tr>
                <td>
                    <input type="checkbox" id="qnum" name="qnum" class="qnum" value=<%= qvo.getQnum() %> >
                </td>
                <td><%= qvo.getQnum() %> </td>
                <td><%= qvo.getQname() %> </td>
                <td><%= qvo.getFnum() %> </td>
                <td><img src="/static/upload<%= qvo.getQfile() %>" alt="image"></td>
                <td><%= qvo.getUpdatedate() %></td>
                </tr>
            <%
                }//end of for
            %>
            <tr>
                <td colspan="7">
                    <button type="button" class="btn" id="insertBtn">글쓰기</button>
                    <button type="button" class="btn" id="selectAllBtn">글목록</button>
                    <button type="button" class="btn" id="contentsBtn">글내용보기</button>
                    <button type="button" class="btn" id="deletetBtn">글삭제</button>
                </td>
            </tr>
            </tbody>
        </table>
    </form>
</div>
<footer id="footer"></footer>
</body>
</html>