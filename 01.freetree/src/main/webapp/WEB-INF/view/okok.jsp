<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.ArrayList" %>
<!-- 페이지 디렉티브 : 페이지에 대한 설정들 -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
</head>
<body>
<h3> 나의 정보 </h3>
<dl>
    <ol>
        <li>이름 : 박민우</li>
        <li>거주지 : 노원</li>
        <li>직업 : 백수</li>
    </ol>

    <%
        List<String> hobbies = new ArrayList<>();
        hobbies.add("자전거 타기");
        hobbies.add("야구장 가기");
        hobbies.add("헌혈");
    %>
    <h3>취미</h3>
    <ol>
        <%
            // Scriptlet
            // HTML 문서 중간에 JAVA Code를 작성할 수 있는 영역
            // 클래스가 없이 사용 가능하다.
            for(String hobbie : hobbies){
        %>
        <li><%=hobbie%></li> <!-- %= 를 통해 해당 객체 값 문자열로 출력 가능
			out.println(hobbie)로 사용해야 하는 번거로움을 줄여준다. -->
        <%
                // 다음과 같이 for문의 괄호도 나눌 수 있다.
                // 그 사이에 html 파일이 올 수도 있다.
            }
        %>
    </ol>
</dl>

</body>
</html>