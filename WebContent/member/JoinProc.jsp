<%@page import="controller.MainDAO"%>
<%@page import="controller.MainDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
<c:choose>
	<c:when test="${JoinMsg == 1}">
		alert("회원가입 성공");
		location.href="../main/main.jsp";
	</c:when>
	<c:otherwise>
		alert("회원가입 실패. 뒤로이동");
		history.back();
		//history.go(-1); 위와 동일
	</c:otherwise>
</c:choose>
</script>
<body>	

</body>
</html>

