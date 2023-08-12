<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import='java.net.*, java.io.*' %>
<%@ page import='org.json.simple.*' %>

<%
    String AUTH_KEY_FCM = "AAAAp2MJvkQ:APA91bHCoK5L7XkIF51_RPGUCAHwn8PUS-8mYpYlfI5no46xcaJXFSWubEXs6BhoQYtYEXV1h7_bRWEfmfb8nUyzYoz3KHlPGFPp7cFQayimwitns-0czqYLHwelEEN4cMQXW5pFTdkC";
    String API_URL_FCM = "https://fcm.googleapis.com/fcm/send";

    String userDeviceIdKey = "dDl9fk94RpKKYolAnfxHPL:APA91bEkYMhWuL6nadnuftJbK0RjVxtsUXD6n67ZErZQxMAPQKdpxcg9IuKOpZ82N7_07Atx3YBzTuLRtX4Q4h2tLCTN1f0TLIry_G_UgpMbaBw5-bq9KiDLRuUMzAtrJtjVFa3REr4n";
    String authKey = AUTH_KEY_FCM;   // Your FCM AUTH key
    String FMCurl = API_URL_FCM;

    URL url = new URL(FMCurl);
    HttpURLConnection conn = (HttpURLConnection) url.openConnection();

    conn.setUseCaches(false);
    conn.setDoInput(true);
    conn.setDoOutput(true);

    conn.setRequestMethod("POST");
    conn.setRequestProperty("Authorization","key="+authKey);
    conn.setRequestProperty("Content-Type","application/json");

    JSONObject json = new JSONObject();
    json.put("to",userDeviceIdKey.trim());
    JSONObject info = new JSONObject();

    // 필터
    String pushfilter = (String) request.getAttribute("pushfilter");

    // 푸시 로직
    if(pushfilter.equals("결제")){
        info.put("title", "결제 완료");   // Notification title
        info.put("body", "결제가 성공적으로 완료되었습니다"); // Notification body
    } else if (pushfilter.equals("가입승인")) {
        info.put("title", "가입 승인");   // Notification title
        info.put("body", "기업회원 가입이 승인되었습니다"); // Notification body
    } else if (pushfilter.equals("지원자")) {
        info.put("title", "새지원자");   // Notification title
        info.put("body", "프로젝트에 새로운 지원자가 있습니다!"); // Notification body
    } else if (pushfilter.equals("근로계약서")) {
        info.put("title", "근로계약서");   // Notification title
        info.put("body", "지원하신 프로젝트에서 승인하셨습니다. 근로계약서 작성 해주세요."); // Notification body
    } else if (pushfilter.equals("프로젝트시작")) {
        info.put("title", "프로젝트 개시");   // Notification title
        info.put("body", "프로젝트가 시작 되었습니다."); // Notification body
    } else if (pushfilter.equals("알림")) {
        info.put("title", "새 메시지");   // Notification title
        info.put("body", "새로운 알림이 도착 하였습니다. 알림함을 확인 해 주세요."); // Notification body
    } else if (pushfilter.equals("거절")) {
        info.put("title", "신청이 거절되었습니다");   // Notification title
        info.put("body", "지원하신 프로젝트에서 거절당하셨습니다.");
    } else if (pushfilter.equals("프로젝트확정")) {
        info.put("title", "프로젝트 확정");   // Notification title
        info.put("body", "지원하신 프로젝트가 시작되길 기다려주세요.");
    }


    json.put("notification", info);

    OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
    System.out.println(">" + json.toString());
    wr.write(json.toString());
    wr.flush();
    conn.getInputStream();
%>