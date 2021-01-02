<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%String NAME = (String)session.getAttribute("NAME"); %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Login</title>

  <!-- Custom fonts for this template-->
  <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

  <!-- Custom styles for this template-->
  <link href="css/sb-admin.css" rel="stylesheet">
  
  
<script type="text/javascript">
function fnLogin(frm){
	
	//////////아이디체크 - * 4자 이상 12자 이내의 영문/숫자 조합하여 공백 없이 기입
	//아이디 빈값 체크.
	if(frm.id.value==''){
		alert('아이디를 입력하세요.');
		frm.id.focus();
		return false;
	}
	//비밀번호 빈값인지 검사//
	if(frm.pass.value==''){
		alert('비밀번호를 입력하세요.');
		frm.pass.focus();
		return false;
	}
}
</script>
</head>
<body class="bg-dark">

  <div class="container">
    <div class="card card-login mx-auto mt-5">
      <div class="card-header">로그인</div>
      <div class="card-body">
	<% 
	//로그인이 되었는지 확인하기 위해 세션영역에서 속성을 가져온다.
	if(session.getAttribute("ID")==null){ //로그인전 상태..
	%>
        <form action="adminLoginProc.jsp" name="MainForm" id="MainForm" method="post" onsubmit="return fnLogin(this);">
          <div class="form-group">
            <div class="form-label-group">
              <input name="id" type="id" id="inputEmail" class="form-control" >
              <label for="inputEmail">아이디</label>
            </div>
          </div>
          <div class="form-group">
            <div class="form-label-group">
              <input name="pass" type="password" id="inputPassword" class="form-control" >
              <label for="inputPassword">비밀번호</label>
            </div>
          </div>
          <button type="submit" class="btn btn-primary btn-block">로그인</button>
          
        </form>
        
<%}else{ //로그인 후%>
		<form action="adminLogout.jsp">
			<button type="submit" class="btn btn-primary btn-block">로그아웃</button>
		</form>
<%} %>
		</div>
      </div>
    </div>
  </div>

  <!-- Bootstrap core JavaScript-->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

</body>
</html>