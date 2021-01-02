<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<script>
// 아이디 찾기버튼
function idSearch(frm){
	var frm = document.idfindscreen;
	if(frm.name.value.length < 1){
		alert("이름을 입력해주세요.");
		frm.name.focus();
		return false;
	}
	if(frm.email.value.length < 1){
		alert("이메일을 입력해주세요.");
		frm.email.focus();
		return false;
	}
	frm.action = "idsearch.jsp"; //넘어간화면
	frm.submit();
}
// 비번찾기 버튼
function passSearch(frm){
	var frm = document.passfindscreen;
	if(frm.id.value.length < 1){
		alert("아이디를 입력해주세요.");
		frm.id.focus();
		return false;
	}
	if(frm.name1.value.length < 1){
		alert("이름을 입력해주세요.");
		frm.name1.focus();
		return false;
	}
	if(frm.email1.value.length < 1){
		alert("이메일을 입력해주세요.");
		frm.email1.focus();
		return false;
	}
	frm.action = "passsearch.jsp";
	frm.submit();
}
</script>
 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/member/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/member_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/member/id_pw_title.gif" alt="" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;아이디/비밀번호찾기<p>
				</div>
				<div class="idpw_box">
					<div class="id_box">
					<form onsubmit="return idSearch(this);" name="idfindscreen" method="post" ">
						<ul> 
							<li><input type="text" name="name" value="" class="login_input01" /></li>
							<li><input type="text" name="email" value="" class="login_input01" /></li>
						</ul>
						<input type="image" src="../images/member/id_btn01.gif" class="id_btn" />
					</form>
						<a href="../member/join01.jsp"><input type="image" src="../images/login_btn03.gif" class="id_btn02" /></a>

					</div>
					<div class="pw_box">
						<form onsubmit="return passSearch(this);" name="passfindscreen" method="post">
						<ul>
							<li><input type="text" name="id" value="" class="login_input01" /></li>
							<li><input type="text" name="name1" value="" class="login_input01" /></li>
							<li><input type="text" name="email1" value="" class="login_input01" /></li>
						</ul>
						<input type="image" src="../images/member/id_btn01.gif" class="pw_btn" />
						</form>
					</div>
				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
