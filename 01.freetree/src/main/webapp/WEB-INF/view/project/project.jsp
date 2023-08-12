<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="wearethe.freetree.project.vo.ProjectVO" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="wearethe.freetree.util.K_Session" %>
<%

    String searchParam = request.getParameter("search");

    K_Session ks = K_Session.getInstance();
    String userId = ks.getSession(request);

    System.out.println("세션 가져오기" + userId);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="/css/project/project.css" type="text/css" rel="stylesheet">
    <link href="/css/reset.css" type="text/css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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

            $(document).on("click", "#pjinsertform", function(){
                $('#insertformgo').attr({
                    'action':'/projectinsertform',
                    'method':'POST',
                    'enctype':'application/x-www-form-urlencoded'
                }).submit();
            });

            $(document).on("click", "#mymempro", function(){
                $('#mymemprojectform').attr({
                    'action':'/memMypageSelect',
                    'method':'POST',
                    'enctype':'application/x-www-form-urlencoded'
                }).submit();
            });

            $(document).on("click", "#mycompro", function(){
                $('#mycomprojectform').attr({
                    'action':'/compage',
                    'method':'POST',
                    'enctype':'application/x-www-form-urlencoded'
                }).submit();
            });



        });


    </script>

    <style>
        .page-link-container{
            text-align: center;

        }

        .page-link-button {
            display: inline-block;
            padding: 10px 15px;
            background-color: #1ad6a6;
            color: white;
            text-decoration: none;
            border-radius: 4px;
        }

        .page-link-button:hover {
            background-color: #1ad6a6;
        }

        .current-page {
            display: inline-block;
            padding: 10px 15px;
            background-color: #555;
            color: white;
            border-radius: 4px;

        }

        .no-results-message {
            display: flex;
            justify-content: center;
            align-items: center;
            font-weight: bold;
            font-size: 3rem;
            margin-top: 300px;
        }
        #img_sec > img{
            width: 100%;
            height: 100%;
        }
        .proinfo {
            margin-left:10px;
        }
    </style>
</head>

<body>

<header id="header"></header>

<!--===================================================================-->


<section id="section_1">
    <div id="img_sec">
    <img src="/img/project/프로젝트1.png">
    </div>

    <div id="sec1_bottom">
        <div id="sec1_container">
            <ul id="sec1_btn">

                    <%
                        if (userId != null) {

                            if (userId.startsWith("M")) {
                    %>
                        <form id="mymemprojectform">
                            <input type="hidden" name="mnum" value="<%=userId%>">
                        </form>
                        <li><input type="button" value="나의 프로젝트" id="mymempro"></li>

                    <%
                            }else if (userId.startsWith("C")){
                    %>
                        <form id="insertformgo">
                         <input type="hidden" name="cnum" value="<%=userId %>">
                        </form>

                        <form id="mycomprojectform">
                            <input type="hidden" name="cnum" value="<%=userId%>">
                        </form>
                        <li><input type="button" value="나의 프로젝트" id="mycompro"></li>
                        <li><input type="button" value="프로젝트 등록" id="pjinsertform"></li>
                    <%
                            };

                    };
                    %>
            </ul>
            <!--sec1_btn end-->
        </div>
        <!--sec1_container end-->
    </div>
    <!--sec1_bottom end-->
</section>
<!-- section_1 end-===================================================================-->



<section id="section_2">
    <div id="sec2_container">
<%
            int currentPage = 1; // 현재 페이지 번호
            int resultsPerPage = 5; // 페이지당 결과 수
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

            List<ProjectVO> list = (List<ProjectVO>)obj;
            if (list != null && list.size() > 0) {
                for(int i=0; i < list.size(); i++) {
                    ProjectVO pvo = list.get(i);


%>
            <script>
                $(document).on("click", "#selectbtn<%= i %>", function(){
                    console.log("selectbtn >>> : ");
                    console.log("i >>> " + <%= i %>);



                    $('#projectselectform<%= i %>').attr({
                        'action':'/projectselect',
                        'method':'POST',
                        'enctype':'application/x-www-form-urlencoded'
                    }).submit();
                });

            </script>
                <div class="pro">
                    <div class="pro_content01">
                        <form id="projectselectform<%= i %>">
                <input type="hidden" name="pnum" value="<%= pvo.getPnum() %>" >
                <input type="hidden" name="cnum" value="<%= pvo.getCnum() %>" >


                <div class="title"><%= pvo.getPname() %></div>

                <div class="proinfo"> 시작일 : <%= pvo.getPstartdate()%></div><br/>
                <div class="proinfo"> 급여 : <%= pvo.getPpaymin()%>만원 ~ <%= pvo.getPpaymax()%>만원</div>
<%
                System.out.println("cnum"+ pvo.getCnum());
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
                <ul class="content_btn">
                    <li><input type="button" value="<%= buttonText %>" class="btn_1"></li>

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


                    <li>
                        <button class="btn_2">
                            <div class="sub_title"><%= presideText%></div>
                            <img src="/img/project/house.png" alt="img" />
                        </button>
                    </li>
<%
                    String pskill = pvo.getPskill();

                    String[] skills = pskill.split(", ");

                    for(String skill : skills) {

%>
                    <li><input type = "button" value = "<%= skill%>" class="btn_4" ></li>
<%
                        }
%>

                </ul>

            </div>
            <!--pro_content01 end-->

            <div class="pro_content02">
                <input type="button" class="pro_img" id="selectbtn<%= i %>" value="상세보기">
            </div>
            </form>
            </div>
    <!--pro end-->
<%

                }

            }else{
%>
            <div class="no-results-message">프로젝트 검색 결과가 없습니다</div>
<%
            }
 %>

        <%-- 페이지 링크 출력 --%>
        <% if (totalPages > 1) { %>
        <div class="page-link-container">
            <%-- 이전 페이지 링크 --%>
            <% if (currentPage > 1) { %>
            <a class="page-link-button" href="/projectmain?currentPage=<%= currentPage - 1 %>&search=<%= (searchParam != null) ? searchParam : "" %>">&lt; 이전</a>
            <% } %>
            <%-- 페이지 번호 링크 --%>
            <% for (int pageNumber = startPage; pageNumber <= endPage; pageNumber++) { %>
            <% if (pageNumber == currentPage) { %>
            <span class="current-page"><%= pageNumber %></span>
            <% } else { %>
            <a class="page-link-button" href="/projectmain?currentPage=<%= pageNumber %>&search=<%= (searchParam != null) ? searchParam : "" %>"><%= pageNumber %></a>
            <% } %>
            <% } %>
            <%-- 다음 페이지 링크 --%>
            <% if (currentPage < totalPages) { %>
            <a class="page-link-button" href="/projectmain?currentPage=<%= currentPage + 1 %>&search=<%= (searchParam != null) ? searchParam : "" %>">다음 &gt;</a>
            <% } %>
        </div>
        <% } %>

    </div>
    <!-- sec2_container end-->


</section>
<!-- section_2 end -->




<footer id="footer"></footer>

</body>
</html>