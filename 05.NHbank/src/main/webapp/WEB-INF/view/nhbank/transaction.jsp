<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%
    String depos_istuno = "202308050029";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>transaction</title>
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
                     ApiNm: "InquireTransactionHistory",
                        Tsymd: "",
                        Trtm: "121414",
                        Iscd: "001937",
                        FintechApsno: "011",
                    ApiSvcCd: "ReceivedTransferA",
                    IsTuno: d_istuno,
                    AccessToken: "bc67e6e280d5794ea63352add9d8b6daab7766e9a7c22ecfb06bc35d3ec5744f"
            },
                Bncd: "011",
                Acno: "3020000008448",
                Insymd: "20230805",
                Ineymd: "",
                TrnsDsnc: "D",
                Lnsq: "DESC",
                PageNo: "2",
                Dmcnt: "1"
            };
            requestData.Header.Tsymd = currentDate;
            requestData.Ineymd = currentDate;
            $.ajax({
                url: "https://developers.nonghyup.com/InquireTransactionHistory.nh",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify(requestData),
                success: function(response) {
                    console.log(response);
                    var data = JSON.stringify(response);
                    $.ajax({
                        url: "/transaction",
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
                    var customHeaders = ["거래 후 잔액"," 통장 인자 내용 ", "거래 시각","거래 일자","     ", "    거래 금액"];

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
                            Object.entries(record).forEach(function([key, value]){
                                if (key !== "TrnsAfAcntBlncSmblCd" && key !== "Tuno" &&key !== "Ccyn" && key !== "MnrcDrotDsnc" && key !== "HnisCd"&& key !== "HnbrCd") {
                                    var td = document.createElement("td");
                                    td.textContent = value;
                                    dataRow.appendChild(td);
                                }
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
<h1>프리랜서 계좌로 출금한 내역</h1>
</body>
</html>