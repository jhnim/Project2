<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="smtp.SMTPAuth"%>
<%@page import="controller.MainDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../include/global_head.jsp" %>
<%
request.setCharacterEncoding("UTF-8");

//폼값받기
String id = request.getParameter("id");
String name = request.getParameter("name1");
String email = request.getParameter("email1");

System.out.println("아이디:"+id);
System.out.println("이름:"+name);
System.out.println("이메일:"+email);

//DAO객체생성 및 DB연결
MainDAO dao = new MainDAO();

//폼값으로 받은 아이디, 패스워드를 통해 로그인 처리 함수 호출(디비에서 가져옴)
String pass = dao.passSearch(id, name, email); 

dao.close();

//메일발송을 위한 객체생성
SMTPAuth smtp = new SMTPAuth();

String mailContents = name+"님의 비밀번호는 "+pass+" 입니다.";

//비번찾기
if(pass!=null){
	System.out.println("디비에서 나온 pass가 널이 아닐때:"+pass);
	
	//메일을 보내기 위한 여러가지 폼값을 Map컬렉션에 저장
	Map<String,String> emailContent = new HashMap<String, String>();
	
	emailContent.put("from", "ji940806@naver.com");
	emailContent.put("to", email);
	emailContent.put("subject", name+"님의 비밀번호입니다.");
	//emailContent.put("content", request.getParameter("content"));
	emailContent.put("content", mailContents);
	
	
	//내용이 null값이 아니라면 이메일 발송
	if(mailContents!=null){
		boolean emailResult = smtp.emailSending(emailContent);
		if(emailResult==true){
			System.out.print("메일발송성공");
%>
		<script type="text/javascript">
			alert('메일이 성공적으로 발송되었습니다.');
			location.href = 'login.jsp';
		</script>
<% 
}else{
			System.out.print("메일발송실패");
%>
		<script>
			alert('메일발송실패');
			history.go(-1);
		</script>
<%		
		}
		
		return;
	}	
}
%>
	

