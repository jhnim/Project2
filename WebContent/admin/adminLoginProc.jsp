<%@page import="Util.CookieUtil"%>
<%@page import="controller.MainDAO"%>
<%@page import="controller.MainDAO"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//폼값받기
String id = request.getParameter("id");
String pass = request.getParameter("pass");
String admin = request.getParameter("admin");

//DAO객체생성 및 DB연결
MainDAO dao = new MainDAO();

//폼값으로 받은 아이디, 패스워드를 통해 로그인 처리 함수 호출
Map<String, String> memberMap = dao.adminMemberMap(id, pass);

dao.close();
String getAdmin = memberMap.get("admin");



if(memberMap.isEmpty()==false){
	
		if(getAdmin.equals("T")){
			//로그인 성공시 세션영역에 아래 속성을 저장한다.
			session.setAttribute("ID", memberMap.get("id"));
			session.setAttribute("PASS", memberMap.get("pass"));
			session.setAttribute("NAME", memberMap.get("name"));
		
		 	//로그인 페이지로 이동
			response.sendRedirect("index.jsp");
		}else{ %>
			<head>
				<script>
					alert('회원이 아닙니다.');
					location.href="adminLogin.jsp";
				</script>
			</head>
		<%} 			
}
else{%>
		<head>
			<script>
				alert('회원이 아닙니다.');
				location.href="adminLogin.jsp";
			</script>
		</head>
<%}%>

	
 	
	

