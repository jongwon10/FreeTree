<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%
    String depos_istuno = "202308050003";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>receivedtransfer</title>
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
                    ApiNm: "PaymentPayoutReceivedTransfer",
                    Tsymd: "",
                    Trtm: "112428",
                    Iscd: "001937",
                    FintechApsno: "011",
                    ApiSvcCd: "10B_003_00",
                    IsTuno: d_istuno,
                    AccessToken: "bc67e6e280d5794ea63352add9d8b6daab7766e9a7c22ecfb06bc35d3ec5744f"
                },
                Rgno: "NO_2308050002316",
                Tram: "84299000",
                Bncd: "011",
                Acno: "3020000008450",
                DractOtlt: "프리트리 프리랜서 8월 월급",
                MractOtlt: "프리트리 프리랜서 8월 월급"
            };
            requestData.Header.Tsymd = currentDate;
            console.log(currentDate);
            $.ajax({
                url: "https://developers.nonghyup.com/PaymentPayoutReceivedTransfer.nh",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify(requestData),
                success: function(response) {
                    console.log(response);
                },
                error: function(error) {
                    console.log(error);
                }
            });
        });

    </script>
</head>
<body>
<h1>결제대금 지급 요청</h1>
<button onclick="window.location.href='index.html'">예치금 관리 홈</button>
</body>
</html>