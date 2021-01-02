<%@page import="controller.MainDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/idchk_head.jsp" %>
<script>
function no() {
	
	opener.document.registFrm.id.value = "";
	//셀프로 창닫음.
	self.close();
}

function ok() {
	
	//부모객체의 form에 id인 registFrm, 폼안의 input태그의 name이 id인 value값에 넣겠다.
	opener.document.registFrm.id.value = 
		//id가 retype_id2인 태그안의 innerHTML인 ${id } 값을 가져옴.
		document.getElementById("retype_id2").innerHTML;
		
	//셀프로 창닫음.
	self.close();
}
</script>
<body>
	<div class="container" style="text-align: center; margin: 5px;
		border: 2px solid rgb(54, 54, 86); border-radius: 10px;" > 
		<br>
		<h1>아이디 중복체크</h1>
		<!-- 
		아이디, 패스워드를 입력후 submit 한후 EL식을 통해 파라미터로 받은후
		"kosmo", "1234" 인 경우에는 "kosmo님 하이룽~" 이라고 출력한다. 
		만약 틀렸다면 "아이디와 비번을 확인하세요" 를 출력한다. 
		EL과 JSTL의 if태그만을 이용해서 구현하시오.
		 -->
		
		<c:if test="${ID_PASS==1 }">
			<div style="background: rgb(236, 211, 21); color: black; border: 1px solid rgb(54, 54, 86); border-radius: 10px;">
				<h6><span id="retype_id1" >${id }</span>이미 사용중인 아이디 입니다.<input type="button" style="border-radius: 10px; background: rgb(5, 159, 236); border: 1px solid rgb(54, 54, 86);" value="다시입력" class="cancel" onclick="no()" /></h6>
			</div>
		</c:if>
		<c:if test="${ID_PASS==0 }">
			<div style="background: rgb(111, 178, 202); color: black; border: 1px solid rgb(54, 54, 86); border-radius: 10px;">
				<h6><span id="retype_id2" >${id }</span>사용 가능한 아이디 입니다.<input type="button" style="border-radius: 10px; background: rgb(5, 159, 236); border: 1px solid rgb(54, 54, 86);" value="사용" class="cancel" onclick="ok()" /></h6>
			</div>
		</c:if>
		<br>
	</div>
</body>
</html>