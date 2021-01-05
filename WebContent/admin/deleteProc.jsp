<%@page import="controller.MainDAO"%>
<%@page import="controller.MainDTO"%>
<%@page import="Util.JavascriptUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--파일명 : DeleteProc.jsp--%>
<%@ include file="isLogin.jsp"%>
<%
//한글 처리를 하지않아도 상관없음.
request.setCharacterEncoding("UTF-8");
String id = request.getParameter("id");

MainDTO dto = new MainDTO();
MainDAO dao = new MainDAO();

//작성자 본인확인을 위해 기존 게시물의 내용을 가져온다.
dto = dao.memberView(id);

int affected = 0;

dto.setId(id);//dto에 일련번호를 저장한 후..
affected = dao.memberDelete(dto);//delete메소드 호출


if(affected==1){
	/*  
	삭제이후에는 기존 게시물이 사라지므로 리스트로  이동해서  삭제된 내역을 확인한다.
	*/
	JavascriptUtil.jsAlertLocation("삭제되었습니다.", "registTables.jsp", out);
}
else{
	out.println(JavascriptUtil.jsAlertBack("삭제실패하였습니다."));
}
%>