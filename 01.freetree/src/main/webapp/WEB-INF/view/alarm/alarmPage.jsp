<%@ page import="wearethe.freetree.alarm.vo.AlarmVO" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <script src="/js/alarm/alarm.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>

<style>
    .alarm-div{
        position:fixed;
        top: 45px;
        z-index: 20;
        text-align: center;
        max-height: 500px;
        overflow: auto;
        border-radius: 10px;
    }
    .alarm-div::-webkit-scrollbar{
        width: 0;
        background-color: transparent;
    }

    .alarm-box {
        background-color: white;
        width: 300px;
        border-radius: 10px;
        border: 5px solid #1ad6a6;
        padding-top: 10px;
        padding-bottom: 10px;

    }
    .weather {
        display: inline-block;
        width: 250px;
        height: 100px;
    }

    .alarm-content {
        display: inline-block;
        border: 2px solid #1ad6a6;
        border-radius: 4px;
        background-color: white;
        width: 250px;
        margin-bottom: 8px;
        font-size: .875rem;
        text-align: left;

    }
    #weatherIcon > img {
        width: 50px;
        height: 50px;
        display: inline-block;
    }

    .text1 {
        display: none;
    }

    .text2 {
        display: inline-block;
        text-align: left;
        font-size: 18px;
        color:black;
    }

    .seebtn {
        text-align: center;

    }

    .see {
        cursor:pointer;
        text-align:center;
        margin-top: 5px;
        margin-bottom: 5px;
        width: 120px;
        border: none;
        background-color: #1ad6a6;
        border-radius: 3px;

    }

    .see:hover {
        background-color: #059770;
    }

    hr{
        border: 1px solid #1ad6a6;
    }

    .send {
        margin-bottom: 2px;
        margin-top: 2px;
        margin-left: 5px;
    }
    .senddate{
        font-size: 0.7rem;
        float:left;
        margin-left: 30px;
        opacity: 0.7;
    }
    .sendcon {
        margin-bottom: 2px;
        margin-top: 2px;
        margin-left: 5px;
    }

</style>
<body>
    <div class="alarm-div">
        <div class="alarm-box">
            <div class="weather">
                <div id="weatherInfo">
                    <div id="weatherIcon" ></div>
                    <div id="weatherText" class="text1"></div>
                    <div id="temperature" class="text2"></div>
                </div>
            </div>
<%
    Object obj = request.getAttribute("list");
    if(obj == null) {return;}

    List<AlarmVO> list = (List<AlarmVO>)obj;
    if (list.size() > 0) {
        for(int i=0; i < list.size(); i++) {
            AlarmVO avo = list.get(i);
%>
            <script>
                $(document).ready(function () {

                    $(document).on("click", "#see<%=i%>", function () {


                        var alnum = '<%= list.get(i).getAlnum() %>';
                        $.ajax({
                            type: "POST",
                            url: "/deletealarm",
                            data: {
                                alnum: alnum
                            },
                            success: function (response) {
                                // Handle the success response here if needed
                                // For example, you can remove the alarm content from the DOM after successful deletion.
                                $('#deletealarm<%=i%>').remove();
                            },
                            error: function (xhr, status, error) {
                                // Handle the error response here if needed
                                console.error(error);
                            }
                        });
                    });

                });
            </script>
        <form id="deletealarm<%=i%>">

            <div class="senddate"><%=avo.getAlsend()%></div>
            <div class="alarm-content">
                <%
                    String sender = null;
                    if (avo.getCname() != null && avo.getMname() != null) {
                        sender = avo.getCname() + avo.getMname();
                    } else if (avo.getCname() != null) {
                        sender = avo.getCname();
                    } else if (avo.getMname() != null) {
                        sender = avo.getMname();
                    }

                    if (sender != null) {
                %>
                <div class="send">발신: <%= sender %></div>

                <% } %>

                <hr>
                <div class="sendcon"><%= avo.getAlcontent()%></div>
                <input type="hidden" name="alnum" value="<%=avo.getAlnum()%>">
                <br>
                <div class="seebtn">
                <button type="button" class="see" id="see<%=i%>">확인</button>
                </div>
            </div>

        </form>

<%
        }

    }
%>

        </div>
    </div>

</body>
</html>