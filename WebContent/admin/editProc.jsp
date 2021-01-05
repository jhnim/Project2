<%@page import="controller.MainDAO"%>
<%@page import="controller.MainDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="isLogin.jsp" %>
<%
//한글처리
request.setCharacterEncoding("UTF-8");

//폼값받기
String id = request.getParameter("id");
String pass = request.getParameter("pass");
String tel = request.getParameter("tel");
String mobile = request.getParameter("mobile");
String email = request.getParameter("email");
String address = request.getParameter("address");

//DTO객체 생성
MainDTO dto = new MainDTO();

dto.setId(id);//특정게시물에 대한 수정이므로 일련번호 추가됨.
dto.setPass(pass);
dto.setTel(tel);
dto.setMobile(mobile);
dto.setEmail(email);
dto.setAddress(address);

//DAO객체 생성
MainDAO dao = new MainDAO();

//수정메소드 호출
int affected = dao.memberEdit(dto);

if(affected==1){
	/* 
	기존의 게시물을 수정하였으므로, 수정된 내용을 확인하기 위해 상세보기 페이지로 이동해야 한다.
	*/
	response.sendRedirect("memberView.jsp?id="+dto.getId());
}
else{
%>
	<script>
		alert("수정하기에 실패하였습니다.");
		history.go(-1);
	</script>
<%} %>