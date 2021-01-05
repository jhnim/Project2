<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="controller.MainDTO"%>
<%@page import="java.util.List"%>
<%@page import="controller.MainDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

//파라미터로 전송된 게시물의 일련번호를 받음
String id = request.getParameter("id");

//DAO객체생성 및 DB커넥션
MainDAO dao = new MainDAO();
 
List<MainDTO> msd = dao.membershipData();//페이지처리ㅇ+회원이름 검색

//DB자원해제
dao.close();

%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>관리자게시판</title>

<!-- Custom fonts for this template-->
<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

<!-- Page level plugin CSS-->
<link href="vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">

<!-- Custom styles for this template-->
<link href="css/sb-admin.css" rel="stylesheet">

</head>

<body id="page-top">

  <nav class="navbar navbar-expand navbar-dark bg-dark static-top">

    <a class="navbar-brand mr-1" href="">관리자게시판</a>

    <button class="btn btn-link btn-sm text-white order-1 order-sm-0" id="sidebarToggle" href="#">
      <i class="fas fa-bars"></i>
    </button>

    <!-- Navbar Search -->
    <form class="d-none d-md-inline-block form-inline ml-auto mr-0 mr-md-3 my-2 my-md-0">
      <div class="input-group">
        <input type="text" class="form-control" placeholder="검색" aria-label="Search" aria-describedby="basic-addon2">
        <div class="input-group-append">
          <button class="btn btn-primary" type="button">
            <i class="fas fa-search"></i>
          </button>
        </div>
      </div>
    </form>

    <!-- Navbar -->
	<ul class="navbar-nav ml-auto ml-md-0">
      <li class="nav-item dropdown no-arrow">
        <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          <i class="fas fa-user-circle fa-fw"></i>
        </a>
        <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
          <a class="dropdown-item" href="adminLogout.jsp" data-toggle="modal" data-target="#logoutModal">로그아웃</a>
        </div>
      </li>
    </ul>

  </nav>

  <div id="wrapper">

    <!-- Sidebar -->
    <ul class="sidebar navbar-nav">
      <li class="nav-item active">
        <a class="nav-link" href="registTables.jsp">
          <i class="fas fa-fw fa-tachometer-alt"></i>
          <span>회원게시판</span>
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="tables.jsp?flag=notice" >
          <i class="fas fa-fw fa-folder"></i>
          <span>공지사항</span>
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="tables.jsp?flag=free">
          <i class="fas fa-fw fa-chart-area"></i>
          <span>자유게시판</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="tables.jsp?flag=photo">
          <i class="fas fa-fw fa-table"></i>
          <span>사진게시판</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="tables.jsp?flag=dataroom" >
          <i class="fas fa-fw fa-folder"></i>
          <span>정보자료실</span>
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="tables.jsp?flag=admin" >
          <i class="fas fa-fw fa-folder"></i>
          <span>직원자료실</span>
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="tables.jsp?flag=parents" >
          <i class="fas fa-fw fa-folder"></i>
          <span>보호자게시판</span>
        </a>
      </li>
    </ul>

    <div id="content-wrapper">

      <div class="container-fluid">
      
        <!-- DataTables Example -->
        <div class="card mb-3">
          <div class="card-header">
            <i class="fas fa-table"></i>
            회원정보 수정/삭제</div>
          <div class="card-body">
            <div class="table-responsive">
              <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                <thead>
                  <tr>
                    <th class="text-center">이름</th>
                    <th class="text-center">아이디</th>
                    <th class="text-center">핸드폰번호</th>
                    <th class="text-center">이메일</th>
                    <th class="text-center">수정</th>
                    <th class="text-center">삭제</th>
                  </tr>
                </thead>
                <tfoot>
                   <tr>
                    <th class="text-center">이름</th>
                    <th class="text-center">아이디</th>
                    <th class="text-center">핸드폰번호</th>
                    <th class="text-center">이메일</th>
                    <th class="text-center">수정</th>
                    <th class="text-center">삭제</th>
                  </tr>
                </tfoot>
                <tbody>
                				 <%
				 /*  
				 List컬렉션에 입력된 데이터가 없을때 true를 반환
				 */
				 if(msd.isEmpty()){
					 //게시물이 없는 경우
				 %>
				 	<tr>
				 		<td colspan="5" align="center">
				 			등록된 게시물이 없습니다^^*
				 		</td>
				 	</tr>
				 <%}else {
				 
				 /*
				 컬렉션에 입력된 데이터가 있다면 저장된 BbsDTO의 갯수만큼 
				 즉, DB가 반환해준 레코드의 갯수만큼 반복하면서 출력한다. (페이지 처리 없을때의 방식)
				 */
				for(MainDTO dto : msd){
					 
				 %>
				 <!-- 리스트반복 start -->
                <tr>				 	
				 	<td class="text-center"><%=dto.getName()%></td>
				 	<td class="text-center"><a href="memberView.jsp?id=<%=dto.getId()%>"><%=dto.getId() %></a></td>
				 	<td class="text-center"><%=dto.getMobile() %></td>
				 	<td class="text-center"><%=dto.getEmail() %></td>
				 	<td class="text-center"><button class="btn btn-info"
				 		onclick="location.href='memberEdit.jsp?id=<%=dto.getId() %>';">수정</button></td>
				 	<td class="text-center"><button class="btn btn-secondary" onclick="location.href='deleteProc.jsp?id=<%=dto.getId() %>'">삭제</button></td>
				 </tr>
				 
				 <!-- 리스트반복 -->
				<%} //for-each문 끝
				} //if문 끝
				 %>
              </table>
                </tbody>
            </div>
          </div>
        </div>
      </div>
      <!-- /.container-fluid -->

      <!-- Sticky Footer -->
      <footer class="sticky-footer">
        <div class="container my-auto">
          <div class="copyright text-center my-auto">
            <span>Copyright Â© Your Website 2019</span>
          </div>
        </div>
      </footer>

    </div>
    <!-- /.content-wrapper -->

  </div>
  <!-- /#wrapper -->

  <!-- Scroll to Top Button-->
  <a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
  </a>

  <!-- Logout Modal-->
  <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
          <button class="close" type="button" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">Ã</span>
          </button>
        </div>
        <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
        <div class="modal-footer">
          <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
          <a class="btn btn-primary" href="login.html">Logout</a>
        </div>
      </div>
    </div>
  </div>

  <!-- Bootstrap core JavaScript-->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Page level plugin JavaScript-->
  <script src="vendor/datatables/jquery.dataTables.js"></script>
  <script src="vendor/datatables/dataTables.bootstrap4.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="js/sb-admin.min.js"></script>

  <!-- Demo scripts for this page-->
  <script src="js/demo/datatables-demo.js"></script>

</body>

</html>
