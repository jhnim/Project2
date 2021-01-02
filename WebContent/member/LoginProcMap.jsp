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

//DAO객체생성 및 DB연결
MainDAO dao = new MainDAO();

/*  
checkbox의 경우 여러 항목이 존재할 수 있으므로 getParameterValues()를통해 배열로 받는것이 기본이지만,
항목이 하나만 있는 경우에는 아래와 같이 처리가능하다.
*/
String id_save = request.getParameter("id_save");


//폼값으로 받은 아이디, 패스워드를 통해 로그인 처리 함수 호출
Map<String, String> memberMap = dao.getMemberMap(id, pass);

dao.close();
	/*  
		해당 함수는 count()를 사용하므로 로그인시 사용한 아이디, 패스워드 외의 정보를 얻어올 수 없다.
	*/
	if(memberMap.isEmpty()==false){
	//로그인 성공시 세션영역에 아래 속성을 저장한다.
	session.setAttribute("ID", memberMap.get("id"));
	session.setAttribute("PASS", memberMap.get("pass"));
	session.setAttribute("NAME", memberMap.get("name"));
	
	//로그인 성공시 회원 아이디를 쿠키로 생성한다.
	//CookieUtil.makeCookie(request, response, "Id", "checkbox", 60*60*24);

	
	if(id_save == null){
		//체크해제하면 쿠키를 삭제한다.
		CookieUtil.makeCookie(request, response, "ID", "", 0);
		System.out.println("저장첵박체크안함!" + id_save);
	}
	else{
		//체크하면 쿠키를 생성한다.
		CookieUtil.makeCookie(request, response, "ID", id , 60*60*24);
		System.out.println("저장첵박체크함!" + id_save);
	}
	
 	//로그인 페이지로 이동
	response.sendRedirect("../main/main.jsp");
 	
}else{ %>
	<head>
		<script>
			alert('회원이 아닙니다.');
			location.href="../main/main.jsp";
		</script>
	</head>
	
<% } %>

