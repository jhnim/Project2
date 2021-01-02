<%@page import="Util.CookieUtil"%>
<%@page import="controller.MainDAO"%>
<%@page import="controller.MainDAO"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

//폼값받기
String name = request.getParameter("name");
String email = request.getParameter("email");

System.out.println("이름:"+name);
System.out.println("이메일:"+email);

//DAO객체생성 및 DB연결
MainDAO dao = new MainDAO();

//폼값으로 받은 아이디, 패스워드를 통해 로그인 처리 함수 호출(디비에서 가져옴)
String idSearch = dao.idSearch(name, email);
//Map<String, String> idSearch = dao.idSearch(name, email);
dao.close();


//request.setAttribute("ID", idSearch.get("id"));
//request.setAttribute("NAME", idSearch.get("name"));



/*  
	해당 함수는 count()를 사용하므로 로그인시 사용한 아이디, 패스워드 외의 정보를 얻어올 수 없다.
*/
//아이디 찾기 성공
 if(idSearch!=null){  
	System.out.println("디비에서 나온 id가 널이 아닐때:"+idSearch);
%> 
 
	
<!-- 	//로그인 성공시 세션영역에 아래 속성을 저장한다. -->
<!--  	request.setAttribute("ID", idSearch.get("id")); -->
	<input type="hidden" id="idSearch" value="<%=idSearch%>" />
	<input type="hidden" id="name" value="<%=name%>" />
	<script>
	var idSearch = document.getElementById('idSearch').value; 
 	var username = document.getElementById('name').value;  
	
	alert(username+'님의 아이디는 '+ idSearch + ' 입니다.');
	location.href="login.jsp";
	</script>

<%}else{ %>
	
		<script>
			alert('회원이 아닙니다.');
			history.go(-1);
		</script>
	
	
<% } %>
	
</body>	




<!--  	//로그인 페이지로 이동 -->
<!-- 	//영역에 저장된 데이터를 View로 전달하기 위해 포워드한다. -->
<!-- 	request.getRequestDispatcher("id_pw.jsp").forward(request, response); -->
<!-- 	//response.sendRedirect("id_pw.jsp"); -->
 	


