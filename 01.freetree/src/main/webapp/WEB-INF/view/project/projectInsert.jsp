<%@ page import="wearethe.freetree.util.K_Session" %>
<%@ page import="wearethe.freetree.company.vo.CompanyVO" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link href="/css/project/project_insert.css" type="text/css" rel="stylesheet">
	<script src="/js/project/project_insert.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="/js/datepicker/code.jquery.com_ui_1.12.1_jquery-ui.js"></script>
	<link rel="stylesheet" href="/css/datepicker/code.jquery.com_ui_1.12.1_themes_base_jquery-ui.css">
</head>
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

		// 원격 / 상주 버튼
		$(function() {
			// Function to handle button click
			function handleButtonClick(buttonId) {
				// Reset background color of both buttons
				$("#job-po-button1").css("background-color", "");
				$("#job-po-button2").css("background-color", "");

				// Set background color of the selected button
				$("#" + buttonId).css("background-color", "#20D5A4");
			}

			// Attach click event to the buttons
			$("#job-po-button1").on("click", function(event) {
				event.preventDefault();
				handleButtonClick("job-po-button1");
			});

			$("#job-po-button2").on("click", function(event) {
				event.preventDefault();
				handleButtonClick("job-po-button2");
			});
		});

		// 캘린더
		$(function() {
			// Attach datepicker onSelect event
			$(".pj-insert-date").datepicker({
				onSelect: function(dateText) {
					console.log("Selected date: ", dateText);
					$(".pj-insert-date").val(dateText);
				},
				dateFormat: "yy-mm-dd",
				onClose: function(dateText) {

					if (dateText === "") {
						console.log("Datepicker closed with date: ", dateText);
						$(".pj-insert-date").css("z-index", ""); // 날짜가 선택되지 않으면 z-index 초기화
					}
				}
			});

			// Attach calendar functionality
			$("#calender").on("click", function(event) {
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
		});


		$(document).on("click", "#all-insert-btn", function(){
			console.log("all-insert-btn >>> : ");

			$('#project-insert').attr({
				'action':'/projectinsert',
				'method':'POST',
				'enctype':'application/x-www-form-urlencoded'
			}).submit();

		});

	});
</script>
<%
	K_Session ks = K_Session.getInstance();
	String userId = ks.getSession(request);

	System.out.println("세션 가져오기" + userId);


%>
<body>

<header id="header"></header>
<div id="all">
	<form id="project-insert" >
		<div id="head">
			<div id="back">〈</div>
			<div id="title">프로젝트 등록</div>
		</div>
		<input type="hidden" name="cnum" id="cnum" value="<%= userId %>">
		<%
			Object obj = request.getAttribute("list");
			if(obj == null) {return;}

			List<CompanyVO> list = (List<CompanyVO>)obj;
			if (list.size() > 0) {
				for (int i = 0; i < list.size(); i++) {
					CompanyVO cvo = list.get(i);
					System.out.println("chp>> " + cvo.getChp());
		%>
		<input type="hidden" name="chp" value="<%=cvo.getChp() %>">
<%

		}
	};
%>
		<div id="pj-insert-name">
			<input type="text" class="name-i" id="name-i" name="pname">
			<div class="pj-name">프로젝트명</div>
			<div class="star">*</div>
			<div class="count">0/30</div>
		</div>
		<div id="pj-insert-all">
			<div id="pj-insert-left">
				<div class="pj-insert-cal">
					<input type="text" class="pj-insert-date" id="pj-insert-date" name="pstartdate" readonly>
					<button class="calender" id="calender">
						<img src="/img/project/calender.png"/>
					</button>
					<div class="calender-name">프로젝트 시작 희망일</div>
					<div class="star">*</div>
				</div>
				<div class="pj-insert-when">
					<div class="when-when">
						<input type="text" oninput="validateInput(this)" class="when-insert" id="when-insert" name="when-insert">
						<div class="when-name">프로젝트 예상 기간</div>
						<div class="star">*</div>
					</div>
					<div class="when-bar-div">
						<select class="when-bar" id="pj-when" name="day">
							<option >주</option>
							<option >개월</option>
						</select>
					</div>
				</div>
				<div class="job-po">
					<div class="name">근무형태</div>
					<div class="star">*</div>
				</div>
				<div class="job-po-button">
					<button id="job-po-button1" value="1" onclick="setPresideValue(this.value)">원격근무</button>
					<button id="job-po-button2" value="0" onclick="setPresideValue(this.value)">상주근무</button>
					<input type="hidden" id="preside" name="preside">
				</div>
				<div class="pj-money-div">
					<div class="name">프로젝트 예산</div>
					<div class="star">*</div>
					<div class="vat">VAT 별도</div>
				</div>
				<div class="pj-money-all-div">
					<div class="pj-money-insert-div">
						<input type="text" class="min-money" name="ppaymin" oninput="validateInput(this)" placeholder="최소 금액">
						-
						<input type="text" class="max-money" name="ppaymax" oninput="validateInput(this)" placeholder="최대 금액">
					</div>
					<div class="money-unit1">(만)</div>
					<div class="money-unit2">(만)</div>
				</div>
			</div>
			<div id="pj-insert-right">
				<div class="skill">
					<select class="skill-bar" onchange="addSkill()">
						<option>직무 선택*</option>
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
					<div class="name">직무 선택</div>
					<div class="star">*</div>
				</div>
				<div class="skill-insert">
					<textarea type="text" class="skill-insert-box" name="pskill" readonly></textarea>
				</div>
				<div class="pj-people-all">
					<div class="pj-people-div">
						<input type="text" class="people-count" oninput="validateInput(this)" name="plimit" >
						<input type="text" class="like-year" oninput="validateInput(this)" name="pannual">
					</div>
					<div class="p-count">명</div>
					<div class="name1">필요 인력</div>
					<div class="star1">*</div>
					<div class="p-year">년차 이상</div>
					<div class="name2">희망연차</div>
					<div class="star2">*</div>
				</div>
			</div>
		</div>
		<div class="memo-all-div">
			<div class="team-intro-div">
				<div class="team-name">팀소개</div>
				<div class="team-star">*</div>
				<textarea class="team-text" name="pintroduction"></textarea>
			</div>
			<div class="main-work-div">
				<div class="work-name">주요 업무</div>
				<div class="work-star">*</div>
				<textarea class="main-work-text" name="pwork"></textarea>
			</div>
			<div class="support-div">
				<div class="support-name">지원 조건</div>
				<div class="support-star">*</div>
				<textarea class="support-text" name="pcondition"></textarea>
			</div>
			<div class="condition-div">
				<div class="condition-name">우대 조건</div>
				<div class="condition-star">*</div>
				<textarea class="condition-text" name="pdemand"></textarea>
			</div>
			<div class="benefit-div">
				<div class="benefit-name">혜택 및 복지</div>
				<div class="benefit-star">*</div>
				<textarea class="benefit-text" name="pbenefit"></textarea>
			</div>
			<button id="all-insert-btn" class="all-insert" >등록 하기</button>
		</div>
	</form>
</div>
<footer id="footer"></footer>
</body>
</html>