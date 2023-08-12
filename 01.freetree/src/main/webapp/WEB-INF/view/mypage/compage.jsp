<%@ page import="wearethe.freetree.mypage.vo.ComPageVO" %>
<%@ page import="java.util.List" %>
<%@ page import="wearethe.freetree.util.K_Session" %>
<%@ page import="wearethe.freetree.project.vo.ProjectVO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <style>
        body, html {
            margin: 0;
            padding: 0;
            height: 100%;
        }
        #background-main {
            background-size: 100% 100%; /* 배경 이미지를 컨테이너 전체를 덮도록 크기 조정 */
            background-position: center; /* 배경 이미지를 가운데로 정렬 */
            overflow: hidden;
            margin-top: 1px;
            width: 100%;
            height: 350px;
            border-bottom: 1px solid #979797;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        #companyprofile {
            width: 960px;
        }
        .profile{
            width: 250px;
            border-radius: 20px;
            border: 1px solid #979797;
            display: inline-block;
        }

        trcompanyname{
            display: inline-block;
            font-size: 45px;
            width: 60%;
            text-align: center;
        }

        .optionicon{
            height: 25px;
            width: 25px;

        }

        #comupgobtn{
            margin-bottom: 280px;
            border:none;
            cursor:pointer;
            background-color: white;
        }
        /*==========================================================================*/
        #background-hadan {
            width: 100%;

            background-color: #E8E8E8;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        #paper{
            width: 1000px;

            background-color: #ffffff;
        }
        #papertt{
            margin-top: 20px;
            margin-left: 50px;
            margin-bottom: 20px;
            width: 900px;

        }

        iframe{ /*구글맵*/
            margin-bottom: 20px;
            margin-left: 50px;
            width: 900px;
            height: 450px;
            border-radius: 5px;
            border: 1px solid #000
        }
        /*================================================================================*/
        tringpj{
            margin-left: 50px;
            font-size: 30px;
        }

        #paper > hr{
            width: 1000px;
            margin-bottom: 20px;
        }
        /*=================================================================================*/

        .sagack{
            float:left;
            width: 590px;
            height: 100px;
            background-color: #1DB088;
            border-radius: 5px;
            margin-bottom: 10px;
            margin-left: 20px;
            text-align: center;
            font-size: 2rem;
            border:none;
        }


        .option01{

            margin-left: 10px;
            margin-bottom: 10px;
            width: 300px;
            height: 45px;
            background-color: #757575;
            border-radius: 5px;
            border: none;
            font-size: 1.2rem;
            cursor: pointer;
        }

        .option02{
            margin-left: 10px;
            width: 300px;
            height: 45px;
            background-color: #757575;
            border-radius: 5px;
            border-radius: 5px;
            border: none;
            font-size: 1.2rem;
            cursor: pointer;
            margin-bottom: 10px;
        }

        .option02 > img {
            margin: 0 auto;
            float: left;
            margin-left: 5px;
        }

        .color-font{
            color:#20D5A4;
        }

        hr {
            width: 100%;
        }

        .else {
            width: 90%;
            font-size: 3rem;
            margin: 0 auto;
            margin-bottom: 15px;

        }
    </style>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.6/umd/popper.min.js"></script>
    <title>Document</title>
    <script src="https://cdn.quilljs.com/1.3.6/quill.js"></script>
    <link rel="stylesheet" type="text/css" href="/mypage/companymypage.css">

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
        })
    </script>
</head>
<%

    Object obj = request.getAttribute("compageList");

    List<ComPageVO> list = (List<ComPageVO>)obj;

    K_Session ks = K_Session.getInstance();
    String userId = ks.getSession(request);

    System.out.println("세션 가져오기" + userId);

    if (list.size() > 0) {
        ComPageVO cpvo = list.get(0);

%>

<body>
<header id="header"></header>
<div id="header-load"></div><!--헤더-->

<% if(cpvo.getCbackimg() != null) {%>
<div id="background-main" style="background-image:url('/upload/<%= cpvo.getCbackimg()%>')">
        <%}else {%>
<div id="background-main" style="background-image:url('/img/mypage/2.png')">
    <%}%>

    <div id="companyprofile">
        <!-- 프로필 이미지 -->



        <!-- 회원이 프로필 이미지를 업로드한 경우 -->
        <img src="/img/mypage/cpf.png" class="profile">
        <%--기본 프로필 이미지--%>

        <trcompanyname><%= cpvo.getCname()%></trcompanyname>
    </div>
            <button id="comupgobtn">
                <img class="optionicon" src="img/mypage/optionicon.png"/>
            </button>
</div>
<div id="background-hadan"><!--회색 배경-->
    <div id="paper"><!--흰색 배경-->
        <div id="papertt">
            <!-- 기업 소개글 -->
            <trbonmoon>
                <% if(cpvo.getCinfo() != null){%>
                <%= cpvo.getCinfo()%>
                <%}else{%>
                소개 내용이 없습니다.
                <%};%>
            </trbonmoon>
        </div>
        <!--구글맵-->
        <tringpj><span class="color-font">기</span>업주소_</tringpj><%= cpvo.getCaddr()%><br/></h3>
        &nbsp;
        <div id="map" style="width:100%;height:350px;"></div>

        <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=33d570517691ad000206554e2b361941&libraries=services"></script>
        <script>
            var mapContainer = document.getElementById('map'), // 지도를 표시할 div
                mapOption = {
                    center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
                    level: 3 // 지도의 확대 레벨
                };

            // 지도를 생성합니다
            var map = new kakao.maps.Map(mapContainer, mapOption);

            // 주소-좌표 변환 객체를 생성합니다
            var geocoder = new kakao.maps.services.Geocoder();

            // 주소로 좌표를 검색합니다
            geocoder.addressSearch('<%= cpvo.getCaddr()%>>', function(result, status) {

                // 정상적으로 검색이 완료됐으면
                if (status === kakao.maps.services.Status.OK) {

                    var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

                    // 결과값으로 받은 위치를 마커로 표시합니다
                    var marker = new kakao.maps.Marker({
                        map: map,
                        position: coords
                    });

                    // 인포윈도우로 장소에 대한 설명을 표시합니다
                    var infowindow = new kakao.maps.InfoWindow({
                        content: '<div style="width:150px;text-align:center;padding:6px 0;"><%= cpvo.getCname()%></div>'
                    });
                    infowindow.open(map, marker);

                    // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
                    map.setCenter(coords);
                }
            });
        </script>
        <br>
        <tringpj><span class="color-font">진</span>행중인 프로젝트</tringpj>
        <hr>

<%
    Object pobj = request.getAttribute("prolist");

    List<ProjectVO> prolist = (List<ProjectVO>)pobj;
    if(prolist != null && prolist.size() > 0) {
        for(int i=0; i < prolist.size(); i++) {
            ProjectVO pvo = prolist.get(i);
%>
        <script>
            $(document).on("click", "#projectgobtn<%=i %>", function() {
                $("#pnumform<%=i%>").attr({
                    "action":"/projectselect",
                    "method":"POST",
                    "enctype":"application/x-www-form-urlencoded"
                }).submit();
            });

            $(document).on("click", "#projectsupgobtn<%=i %>", function() {
                $("#pnumform<%=i%>").attr({
                    "action":"/projectManage",
                    "method":"POST",
                    "enctype":"application/x-www-form-urlencoded"
                }).submit();
            });

        </script>
        <div id="pjlist">
            <form id="pnumform<%=i%>">
                <input type="hidden" name="pnum" value="<%=pvo.getPnum()%>">
                <input type="hidden" name="cnum" value="<%=userId%>">
                <input type="hidden" name="pname" value="<%=pvo.getPname()%>">
            </form>
            <button class="sagack" name="pname" value="<%=pvo.getPname()%>"><%=pvo.getPname()%></button>
            <div id="btn">
                <button class="option01" id="projectgobtn<%=i%>">
                    상세 페이지
                </button>
                <button class="option02" id="projectsupgobtn<%=i%>">
                    <img src="img/mypage/optionicon.png"  width="30px;"
                         height="30px;" >관리 페이지
                </button>
            </div>
        </div>

<%
        }
    }else{
%>
      <p class="else">진행중인 프로젝트가 없습니다.</p>
<%
    };
%>

    </div>

</div>
</div>
<footer id="footer"></footer>
<%
    }
%>
</body>
</html>