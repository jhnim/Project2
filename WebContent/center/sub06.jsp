<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>

 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>
		
		<img src="../images/center/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<img src="../images/center/left_title.gif" alt="센터소개 Center Introduction" class="left_title" />
				<%@ include file="../include/center_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/center/sub07_title.gif" alt="오시는길" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;센터소개&nbsp;>&nbsp;오시는길<p>
				</div>
				<div class="con_box">
					<p class="con_tit"><img src="../images/center/sub07_tit01.gif" alt="오시는길" /></p>
					<!-- 오시는길 kaokao mapAPI 설정 -->
					<div id="map" style="width:500px;height:400px;"></div>
					<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4abd31b058813147a302eb7ae1c0ab44"></script>
					<script>
					var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
					
					mapOption = { 
					    center: new kakao.maps.LatLng(37.465436593935536, 126.87931174001456), // 지도의 중심좌표
					    level: 3 // 지도의 확대 레벨
					};
					
					var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
					
					//마커가 표시될 위치입니다 
					var markerPosition  = new kakao.maps.LatLng(37.465436593935536, 126.87931174001456); 
					
					//마커를 생성합니다
					var marker = new kakao.maps.Marker({
					position: markerPosition
					});
					
					//마커가 지도 위에 표시되도록 설정합니다
					marker.setMap(map);
					
					// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
					// marker.setMap(null);    
					</script>
					<!-- 오시는길 API 설정 끝 -->
					<br /><br />
					<p class="con_tit"><img src="../images/center/sub07_tit03.gif" alt="대중교통 이용시" /></p>
					<div class="in_box">
						<p class="dot_tit">버스</p>
						<p style="margin-bottom:15px;">12, 22, 101, 11-2, 5714, 503, 6635, 5535, 27 하안4동주민센터 앞 하차
						<br /> 75, 102, 5534 광명농협 앞 하차</p>
						<p class="dot_tit">지하철</p>
						<p style="margin-bottom:15px;">1호선 독산역 하차 후 75, 102번 환승 후 광명농협 앞 하차<br />1호선 독산역 하차 후 27번 환승 후 하안4동주민센터 앞 하차 </p>
						<p class="dot_tit">마을버스</p>
						<p>금천 05번</p>
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
