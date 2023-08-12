<%@ page import="wearethe.freetree.util.K_Session" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<%
	K_Session ks = K_Session.getInstance();
	String userId = ks.getSession(request);

	System.out.println("세션 가져오기" + userId);
%>
<head>
	<meta charset="UTF-8">
	<link href="/css/reset.css" type="text/css" rel="stylesheet">
	<link href="/css/common/header.css" type="text/css" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="/js/common/header.js"></script>
	<title>Title</title>
	<script>
	slideload();
	</script>

	<script>
		function ToProject() {
			window.location.href = "/projectmain";
		}


	</script>
	<script>
		var alarmLoaded = false;

		function ToAlarm() {
			if (!alarmLoaded) {
				var formData = {
					mnum: $("#mnum").val(),
					cnum: $("#cnum").val()
				};

				$.ajax({
					type: "POST",
					url: "/alarm",
					data: formData,
					success: function(data) {
						$("#alarm").html(data);
						alarmLoaded = true;
					},
					error: function(xhr, status, error) {
						console.log("오류 발생 : " + error);
					}
				});
			} else {
				$("#alarm").empty();
				alarmLoaded = false;
			}
		}

		function GoChatbot() {

			// 팝업 창 크기
			var popupWidth = 500;
			var popupHeight = 458;

			// 팝업 창 위치를 위한 좌표 계산
			var left = (window.innerWidth - popupWidth) / 2;
			var top = (window.innerHeight - popupHeight) / 2;


			window.open('http://192.168.0.5:8081', '챗봇', 'width=' + popupWidth + ',height=' + popupHeight + ',left=' + left + ',top=' + top);
			;
		}
		function Tofree() {
			location.href = "/memMypageSelectAll"
		}

		function Tologout() {
			location.href = "/logoutForm";
		}

		function Tologin() {
			location.href = "/loginform1";
		}


		function ToFAQ() {
			location.href = "/faquestion";
		}

		function ToQNA() {
			location.href = "/questionSelectAll";
		}

		function Tomain() {
			location.href = "/main";
		}

		function Tomypage() {
			var userId = "<%= (userId != null) ? userId : "" %>";

			if (userId.startsWith("C")) {
				$('#freelancerform').attr({

					'action':'/compage',
					'method':'POST',
					'enctype':'application/x-www-form-urlencoded'
				}).submit();

			} else if (userId.startsWith("M")) {

				$('#freelancerform').attr({
					'action':'/memMypageSelect',// <<< 이부분 받아오면 해결하기
					'method':'POST',
					'enctype':'application/x-www-form-urlencoded'
				}).submit();
			}
		}

	</script>

<script>

	function performSearch() {
		let searchOption = $("#searchOption").val();

		if (searchOption === 'project') {
			$("#searchForm").attr({
				'action': '/projectmain',
				'method': 'POST',
				'enctype':'application/x-www-form-urlencoded'
			}).submit();
		} else if (searchOption === 'freelancer') {
			$("#searchForm").attr({
				'action': '/memMypageSelectAll',
				'method': 'POST',
				'enctype':'application/x-www-form-urlencoded'
			}).submit();
		}

		return false; // 폼 제출을 자동으로 막습니다.
	}

	document.getElementById('searchButton').addEventListener('click', performSearch);

	$("#searchInput").on('keypress', function(event) {
		// Check if the pressed key is the Enter key (keyCode 13)
		if (event.which === 13) {
			performSearch();
		}
	});


</script>

</head>
<body>
<form id="freelancerform">
	<input type="hidden" name="mnum" value="<%=userId%>">
	<input type="hidden" name="cnum" value="<%=userId%>">
</form>
<header>
	<div id="main_header">
		<div id="sticky">
			<div id="top_header">
				<div id="search_wrap">
					<div id="search_bar">
						<form id="searchForm">
							<select id="searchOption" class="bar">
								<option value="project">프로젝트</option>
								<option value="freelancer">프리랜서</option>
							</select>
							<input type="text" id="searchInput" name="search" class="input" placeholder="검색어를 입력해주세요">
							<span class="img-Search">
								<button type="button" class="searchButton" id="searchButton">
									<img src="/img/main/search.png" alt="검색 로고">
								</button>
		  					</span>
						</form>
					</div>
					<!-- search_bar end -->
					<div class="login_warp">
						<form id="logoutForm">
							<%
								if(userId != null) {
									String mnumValue = null;
									String cnumValue = null;

									if (userId.startsWith("M")) {
										mnumValue = userId;
									} else if (userId.startsWith("C")) {
										cnumValue = userId;
									}

							%>

							<input type="hidden" name="mnum" id="mnum" value="<%= mnumValue %>">
							<input type="hidden" name="cnum" id="cnum" value="<%= cnumValue %>">
							<button type="button" class="login_button" onclick="ToAlarm()">
								<img src="/img/main/alarm.png" alt="알림아이콘"/>
							</button>
							<button type="button" class="login_button">
								<img src="/img/main/myPage.png" alt="알림아이콘" onclick="Tomypage()"/>
							</button>
							<button type="button" id="logoutBtn" class="login_button" onclick="Tologout()">
								<img src="/img/main/logout.png" alt="알림아이콘" />
							</button>
							<div id="alarm"></div>
							<%
							}else{

							%>

							<input type="button" id="login" value="로그인" class="account" onclick="Tologin()">

							<%
							};
							%>
						</form>
					</div>
				</div>
				<!-- search_wrap end -->

			</div>
			<!-- top_header end -->

			<div id="bottom_header">
				<div id="logo_wrap">
					<div id="main_logo">
						<img src="/img/main/main_logo.png" alt="메인 로고" onclick="Tomain()"/>
					</div>

					<div id="nav_wrap">
						<input type="button" value="프리랜서" class="menu" onclick="Tofree()">
						<input type="button" value="프로젝트" class="menu" onclick="ToProject()">

						<input type="button" value="고객센터" class="menu" onclick="ToFAQ()">
					</div>


					<div class="hamburger" id="hamburger">
						<span></span>
						<span></span>
						<span></span>
						<span></span>
					</div>

				</div>
				<!-- logo_wrap end -->
			</div>
			<!-- bottom_header end -->
		</div>
	</div>
</header>

<div id="slide_menu">
	<div id="all_menu">

		<ul class="menu_btn">
			<li><input type="button" value="프리랜서" class="bold" onclick="Tofree()"></li>
			<li><input type="button" value="프리랜서 등록"></li>
			<li><input type="button" value="프리랜서 검색"></li>

		</ul>

		<ul class="menu_btn">
			<li><input type="button" value="프로젝트" class="bold" onclick="ToProject()"></li>
			<li><input type="button" value="프로젝트 등록"></li>
			<li><input type="button" value="프로젝트 검색"></li>
		</ul>

		<ul class="menu_btn">
			<li><input type="button" value="고객센터" class="bold" onclick="ToFAQ()"></li>
			<li><input type="button" value="Q&A" onclick="ToQNA()"></li>
			<li><input type="button" value="FAQ" onclick="ToFAQ()"></li>
			<li><input type="button" value="CHAT BOT" onclick="GoChatbot()"></li>

		</ul>
	</div>
</div>
<!--slide_menu end-->

</body>
</html>