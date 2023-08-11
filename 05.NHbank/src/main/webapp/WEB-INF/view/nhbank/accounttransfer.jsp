<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%
    String depos_istuno = "202308050002";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>accounttransfer</title>
    <link rel="stylesheet" href="/css/nhbank/depositdetails.css">
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
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
                    ApiNm: "PaymentPayoutAccountTransfer",
                    Tsymd: "",
                    Trtm: "094210",
                    Iscd: "001937",
                    FintechApsno: "011",
                    ApiSvcCd: "10B_002_00",
                    IsTuno: d_istuno,
                    AccessToken: "bc67e6e280d5794ea63352add9d8b6daab7766e9a7c22ecfb06bc35d3ec5744f"
                },
                Tram: "84299000",
                Acno: "3020000008448"
            };

            requestData.Header.Tsymd = currentDate;
            console.log(currentDate);
            $.ajax({
                url: "https://developers.nonghyup.com/PaymentPayoutAccountTransfer.nh",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify(requestData),
                success: function(response) {
                    console.log(response);
                    var data = JSON.stringify(response);
                    alert("asdas"+data);
                    $.ajax({
                        url: "/accounttransfer",
                        type: "POST",
                        contentType: "application/json",
                        data: data,
                        success: function(data){
                            console.log(data);
                        }
                    })
                },
                error: function(error) {
                    console.log(error);
                }
            });
        });

    </script>
</head>
<body>
<h1>결제대금 지급계좌 이체요청</h1>
<button onclick="window.location.href='index.html'">예치금 관리 홈</button>

</body>
</html>