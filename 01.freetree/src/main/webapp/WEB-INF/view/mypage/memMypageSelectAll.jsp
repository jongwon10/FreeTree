<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="wearethe.freetree.mypage.vo.MemMypageVO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="wearethe.freetree.util.K_Session" %>

<% request.setCharacterEncoding("UTF-8");%>
<%

    String searchParam = request.getParameter("search");

    K_Session ks = K_Session.getInstance();
    String userId = ks.getSession(request);

    System.out.println("세션 가져오기" + userId);
%>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="/css/reset.css" type="text/css" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <title>Freelancer Page</title>
        <link rel="stylesheet" type="text/css" href="/css/mypage/memMypageSelectAll.css">
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

            function Tofreeinsert() {
                var userId = "<%= (userId != null) ? userId : "" %>";

                if(userId.startsWith("M")) {
                    $('#freelancego').attr({
                        'action':'/memMypageForm',
                        'method':'POST',
                        'enctype':'application/x-www-form-urlencoded'
                    }).submit();
                }else if (userId.startsWith("C")) {
                    alert("기업회원 입니다");
                }else {
                    alert("회원가입을 해주세요");
                    location.href="/maccount";
                }
            }

        </script>

    </head>

    <body>
    <header id="header"></header>
    <div id="background-main"></div>
        <div id="freelancer-container">
            <form id="freelancego">
                <input type="hidden" name="userId" value="<%= userId %>">
            </form>
            <div id="button">
                <button type="button" id="btn" onclick="Tofreeinsert()">프리랜서 등록</button>
            </div>
            <div id="free-div">
                <ul>

                    <%

                        int currentPage = 1; // 현재 페이지 번호
                        int resultsPerPage = 9; // 페이지당 결과 수
                        int totalResults = (int)request.getAttribute("totalResults"); // 전체 결과 수
                        int pageRange = 5; // 페이지 범위 (페이지 번호를 몇 개씩 보여줄지)

                        if (request.getParameter("currentPage") != null) {
                            currentPage = Integer.parseInt(request.getParameter("currentPage"));
                        }

                        int totalPages = (int) Math.ceil((double) totalResults / resultsPerPage); // 전체 페이지 수
                        int startPage = ((currentPage - 1) / pageRange) * pageRange + 1; // 시작 페이지 번호
                        int endPage = Math.min(startPage + pageRange - 1, totalPages); // 끝 페이지 번호

                        int offset = (currentPage - 1) * resultsPerPage; // offset 값 계산

                        Map<String, Object> params = new HashMap<>();
                        params.put("offset", offset);

                        Object obj = request.getAttribute("listAll");


                        List<MemMypageVO> aList = (List<MemMypageVO>)obj;
                        if (aList != null && aList.size() > 0) {
                            for(int i=0; i<aList.size(); i++){
                                MemMypageVO mmvo = aList.get(i);
                    %>

                    <script>
                        $(document).on("click", "#select-btn<%=i %>", function() {
                            console.log("select-btn <%=i %> 들어왔냐");


                            $("#memMypageFormAll<%= i %>").attr({
                                "action":"memMypageSelect",
                                "method":"POST",
                                "enctype":"application/x-www-form-urlencoded"
                            }).submit();
                        });
                    </script>

                    <form name="memMypageFormAll" id="memMypageFormAll<%= i %>">
                        <input type="hidden" name="mnum" value="<%= mmvo.getMnum()%>"/>
                        <li class="li">
                            <%= mmvo.getMname()%><br><%= mmvo.getMpposition()%><br>
                            <button type="button" id="select-btn<%=i %>">상세 보기</button>
                        </li>

                    </form>
                    <%

                            }
                        }else{
                    %>
                        <div class="no-results-message">프리랜서 검색 결과가 없습니다</div>
                    <%
                        }
                    %>
                <%-- 페이지 링크 출력 --%>
                    <li class="page-content">
                        <div class="page-div-real">
                        <% if (totalPages > 1) { %>
                        <div class="page-link-container">
                            <%-- 이전 페이지 링크 --%>
                            <% if (currentPage > 1) { %>
                            <a class="page-link-button" href="/memMypageSelectAll?currentPage=<%= currentPage - 1 %>&search=<%= (searchParam != null) ? searchParam : "" %>">&lt; 이전</a>
                            <% } %>
                            <%-- 페이지 번호 링크 --%>
                            <% for (int pageNumber = startPage; pageNumber <= endPage; pageNumber++) { %>
                            <% if (pageNumber == currentPage) { %>
                            <span class="current-page"><%= pageNumber %></span>
                            <% } else { %>
                            <a class="page-link-button" href="/memMypageSelectAll?currentPage=<%= pageNumber %>&search=<%= (searchParam != null) ? searchParam : "" %>"><%= pageNumber %></a>
                            <% } %>
                            <% } %>
                            <%-- 다음 페이지 링크 --%>
                            <% if (currentPage < totalPages) { %>
                            <a class="page-link-button" href="/memMypageSelectAll?currentPage=<%= currentPage + 1 %>&search=<%= (searchParam != null) ? searchParam : "" %>">다음 &gt;</a>
                            <% } %>
                        </div>
                        <% } %>
                        </div>

                    </li>

                </ul>
            </div>

        </div>

    <footer id="footer"></footer>
    </body>
</html>