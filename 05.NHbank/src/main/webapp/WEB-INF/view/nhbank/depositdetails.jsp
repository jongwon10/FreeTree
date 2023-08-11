<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%
    String depos_istuno = "202308050035";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>depositdetails</title>
<link rel="stylesheet" href="/css/nhbank/depositdetails.css">
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>

    $(document).ready(function(){
        var date = new Date();
        var year = date.getFullYear();
        var month = ('0' + (date.getMonth() + 1)).slice(-2);
        var day = ('0' + date.getDate()).slice(-2);
        var currentDate = year + month + day;
        let d_istuno = '<%= depos_istuno%>';
        var requestData = {
            Header: {
                ApiNm: "VirtualAccountReceivedListInquiry",
                Tsymd: "",
                Trtm: "121414",
                Iscd: "001937",
                FintechApsno: "011",
                ApiSvcCd: "10B_001_00",
                IsTuno: d_istuno,
                AccessToken: "bc67e6e280d5794ea63352add9d8b6daab7766e9a7c22ecfb06bc35d3ec5744f"
            },
            Insymd: "20230710",
            Ineymd: "",
            Vran: "79000000000323",
            Lnsq: "DESC",
            PageNo: "1"
        };

        requestData.Header.Tsymd = currentDate;
        requestData.Ineymd = currentDate;

        $.ajax({
            url: "https://developers.nonghyup.com/VirtualAccountReceivedListInquiry.nh",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(requestData),
            success: function(response) {
                console.log(response);
                var data = JSON.stringify(response);
                $.ajax({
                    url: "/depositdetails",
                    type: "POST",
                    contentType: "application/json",
                    data: data,
                    success: function(data){
                        console.log(data);
                    }
                })

                // 테이블 생성
                var table = document.createElement("table");

                // 테이블 헤드 생성
                var thead = document.createElement("thead");
                var headerRow = document.createElement("tr");

                var customHeaders = ["계좌번호", "일련번호", "총건수", "입금일자", "입금시각", "확인시각","입금금액"];

             /*   Object.keys(response).forEach(function(key){
                    var th = document.createElement("th");
                    th.textContent = key;
                    headerRow.appendChild(th);
                });*/

                customHeaders.forEach(function(customHeader) {
                    var th = document.createElement("th");
                    th.textContent = customHeader;
                    headerRow.appendChild(th);
                });

                thead.appendChild(headerRow);
                table.appendChild(thead);

                // 테이블 바디 생성
                var tbody = document.createElement("tbody");
                if (response.REC && Array.isArray(response.REC)) {
                    response.REC.forEach(function(record){
                        var dataRow = document.createElement("tr");
                        Object.values(record).forEach(function(value){
                            var td = document.createElement("td");
                            td.textContent = value;
                            dataRow.appendChild(td);
                        });
                        tbody.appendChild(dataRow);
                    });
                }
                table.appendChild(tbody);

                document.body.appendChild(table);
                var button = document.createElement("button");
                button.textContent = "예치금 관리 홈";
                button.onclick = function() {
                    window.location.href = 'index.html';
                };
                document.body.appendChild(button);
            },
            error: function(error) {
                console.log(error);
            }
        });

    });
</script>
</head>
<body>
    <h1>가상계좌 입금내역 조회 납부</h1>
</body>
</html>