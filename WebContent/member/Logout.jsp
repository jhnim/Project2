<%@page import="Util.CookieUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
CookieUtil.makeCookie(request, response, "LoginId", "", 0);
//response.sendRedirect("CookieLoginMain.jsp");
%>

<script>
	alert("로그아웃 되었습니다");
	location.href="../main/main.jsp";
</script>
<!DOCTYPE html>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	//속성을 개별적으로 삭제
	session.removeAttribute("id");
	session.removeAttribute("pass");
	
	//세션영역 전체를 한꺼번에 삭제
	session.invalidate();
	
	response.sendRedirect("../main/main.jsp");
%>
</body>
