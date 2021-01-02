<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="top" style="border:0px solid #000;"> 
	<a href="../main/main.jsp"><img src="../images/logo.gif" alt="마포구립장애인 직업재활센터" id="top_logo" /></a>

	<ul id="lnb">
	<!-- return이 빠지면 submit하면서 그냥 check()를 실행하는 것 뿐이고, -->
	<!--  return이 있어야 callback받아서 check의 결과값을 submit에 리턴해주게 됩니다. -->
	<form action="../member/LoginProcMap.jsp" name="MainForm" id="MainForm" method="post" onsubmit="return fnLogin(this);">
<% 
//로그인이 되었는지 확인하기 위해 세션영역에서 속성을 가져온다.
if(session.getAttribute("ID")==null){ //로그인전 상태..
%>	
		<!-- 로그인전 -->
		<li><a href="../member/login.jsp"><img src="../images/lnb01.gif" alt="LOGIN" /></a></li>
		<li><a href="../member/join01.jsp"><img src="../images/lnb02.gif" alt="JOIN" /></a></li>
<%}else{ //로그인 후%>		
		<!-- 로그인후 -->
		<li><a href="../member/Logout.jsp"><img src="../images/lnb05.gif" alt="LOG OUT" /></a></li>
		<li><a href="../center/sub07.jsp"><img src="../images/lnb06.gif" alt="MODIFY" /></a></li>
		<li><a href="../member/sitemap.jsp"><img src="../images/lnb03.gif" alt="SITEMAP" /></a></li>
		<li><a href="../center/sub06.jsp"><img src="../images/lnb04.gif" alt="CONTACT US" /></a></li>
<%} %>
	</form>		
	</ul>	 
	
	<!-- <a href="../center/sub01.jsp"><img src="../images/navi.jpg" id="navigation" /></a> -->
	<img src="../images/gnb.jpg" id="navigation"  width="753" height="65" usemap="#GNB"/>
	<map name="GNB">
		<area shape="rect" alt="" title="" coords="0,0,80,33" href="../center/sub01.jsp" target="" />
		<area shape="rect" alt="" title="" coords="86,0,188,33" href="../business/sub01.jsp" target="" />
		<area shape="rect" alt="" title="" coords="193,0,316,33" href="../product/sub01.jsp" target="" />
		<area shape="rect" alt="" title="" coords="321,0,420,33" href="../market/sub01.jsp" target="" />
		<area shape="rect" alt="" title="" coords="428,0,529,33" href="../space/sub01.jsp" target="" />
		<area shape="rect" alt="" title="" coords="536,0,638,33" href="../community/sub01.jsp" target="" />
		<area shape="rect" alt="" title="" coords="641,0,749,33" href="../volunteer/sub01.jsp" target="" />
	</map>
	
	<!--  <div style="position:absolute; margin:-25px 0 0 200px;  border:0px solid #000;">	
		<object type="application/x-shockwave-flash" data="../swf/navi.swf" width="753" height="65">
			<param name="wmode" value="transparent" />
		</object>		
	</div>  -->
</div>