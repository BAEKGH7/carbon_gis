<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
<%-- <script type="text/javascript" src="<c:url value='/js/ol.js' />"></script> --%>
<!-- OpenLayer 라이브러리 -->
<%-- <link href="<c:url value='/'/>css/ol.css" rel="stylesheet"
	type="text/css"> --%>
<!-- OpenLayer css -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.4.3/css/ol.css">
<script src="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.4.3/build/ol.js"></script> 
<script type="text/javascript" src="<c:url value='/js/mapTest.js' />"></script>
<!-- 지도 맵객체 생성을 위한 js-->
<!-- 지도 크기 설정을 위한 css -->
<style>
.map {
	height: 1060px;
	width: 100%;
}

.olControlAttribution {
	right: 20px;
}

.olControlLayerSwitcher {
	right: 20px;
	top: 20px;
}
</style>

<script type="text/javascript">
	var sd, sgg, bjd; //시도, 시군구, 법정동

	var container = document.getElementById('popup'); //팝업이 담길 컨테이너 요소
	var content1 = document.getElementById('popup-content'); //팝업 내용 요소
	var map; //맵 변수 선언 : 지도 객체

	/* var mapLayer; //맵 레이어 선언 : 지도 그림(타일) 설정 */
	var mapOverlay; //맵 오버레이 선언 : 지도 위에 팝업 옵션을 사용할 때
	var mapView; //맵 뷰 선언 : 보여지는 지도 부분 설정
	var hover = null; //마우스 이벤트에 사용될 변수
	/* https://blog.naver.com/mango_tree_/222285880138 참고 */

	$(document).ready(function() {
		map = new ol.Map(
		{ // OpenLayer의 맵 객체를 생성한다.
			target : 'map', // 맵 객체를 연결하기 위한 target으로 <div>의 id값을 지정해준다.
			layers : [ // 지도에서 사용 할 레이어의 목록을 정의하는 공간
			new ol.layer.Tile(
					{
						source : new ol.source.XYZ(
								{ //vworld api 사용
									// url: 'https://maps.wikimedia.org/osm-intl/{z}/{x}/{y}.png' // vworld 지도
									//url: 'http://xdworld.vworld.kr:8080/2d/base/202002/{z}/{x}/{y}.png' // 이건 유효하지 않은 잘못된 주소라고 함...
									url : 'http://api.vworld.kr/req/wmts/1.0.0/A44472C1-4836-3414-9FD3-C7C332CDD46B/Base/{z}/{y}/{x}.png' // vworld지도-api키로 가져오기
								})
					}) ],
			view : new ol.View({ // 지도가 보여 줄 중심좌표, 축소, 확대 등을 설정한다. 보통은 줌, 중심좌표를 설정하는 경우가 많다.
				center : ol.proj
						.fromLonLat([ 127, 37.5 ]), //위도, 경도 였구먼
				zoom : 10,
				
			}),
			controls : ol.control.defaults().extend([ 
						new ol.control.Zoom() // Zoom 컨트롤 추가

					])
			
		});
				/* mapOverlay = new ol.Overlay(({ element: container })); //Overlay 생성, 요소는 컨테이너 */

				$('#sdselect').on('change',	function() {
					//var sd = $('#sd option:selected').text();
					var sd = $("option:selected", this).attr("value");
					
			/* var sgg = $('#sgg option:selected').val();
				var bjd = $('#bjd option:selected').val(); */
				console.log(sd);
				/* var jsonData = JSON.parse(sd);  // 받아온 데이터를 JavaScript 객체로 변환  */
	
					 $.ajax({
						url : '/selectSgg.do', // 컨트롤러의 URL
						type : 'post', // HTTP 메소드
						dataType : 'json', // 응답 데이터 타입
						data :{"sd" : sd},
						success : function(data) {
							 $("#sgg").empty();
				               var sgg = "<option>시군구 선택</option>";
				               
				               for(var i=0;i<data.length;i++){
				                  sgg += "<option value='"+data[i].sgg_cd+"'>"+data[i].sgg_nm+"</option>"
				               }
				               
				               $("#sgg").append(sgg);
				            },
				            error : function() {
				               alert("실패");
				            }
				         })
				      }); 
				
				
				/* 	 $("#sdselect").on("change", function() {
				 var test = $("#sdselect option:checked").text();
				 $.ajax({
				 url : "/selectSgg.do",
				 type : "post",
				 dataType : "json",
				 data : {"test" : test},
				 success : function(result) {
				 $("#sgg").empty();
				 var sgg = "<option>시군구 선택</option>";
				
				 for(var i=0;i<result.length;i++){
				 sgg += "<option value='"+result[i].sgg_cd+"'>"+result[i].sgg_nm+"</option>"
				 }
				 $("#sgg").append(sgg);
				 },
				 error : function() {
				 alert("실패");
				 }
				 })
				 });

				 $(".insertbtn").click(function() {

				 map.removeLayer(sd);
				 map.removeLayer(sgg);
				 map.removeLayer(bjd);
				
				 var sd_CQL = "sd_cd="+$("#sdselect").val();
				 var sgg_CQL = "sgg_cd="+$("#sgg").val(); */

				var wmssd = new ol.layer.Tile(
						{
							source : new ol.source.TileWMS(
									{
										url : 'http://localhost/geoserver/baek1/wms?service=WMS', // 1. 레이어 URL
										params : {
											'VERSION' : '1.1.0', // 2. 버전
											'LAYERS' : 'baek1:tl_sd', // 3. 작업공간:레이어 명
											'BBOX' : [
													1.386872E7,
													3906626.5,
													1.4680011171788167E7,
													4670269.5 ],
											'CQL_FILTER' : "id=17",
											'SRS' : 'EPSG:3857', // SRID
											'FORMAT' : 'image/png' // 포맷

										},
										serverType : 'geoserver',
									})
						});
				map.addLayer(wmssd); // 맵 객체에 레이어를 추가함

				var wmssgg = new ol.layer.Tile(
						{
							source : new ol.source.TileWMS(
									{
										url : 'http://localhost/geoserver/baek1/wms?service=WMS', // 1. 레이어 URL
										params : {
											'VERSION' : '1.1.0', // 2. 버전
											'LAYERS' : 'baek1:tl_sgg', // 3. 작업공간:레이어 명
											'BBOX' : [ 1.386872E7,
													3906626.5,
													1.4428071E7,
													4670269.5 ],
											'CQL_FILTER' : "sgg_cd=11590",
											'SRS' : 'EPSG:3857', // SRID
											'FORMAT' : 'image/png' // 포맷

										},
										serverType : 'geoserver',
									})
						});
				map.addLayer(wmssgg); // 맵 객체에 레이어를 추가함	

				var wmsbjd = new ol.layer.Tile(
						{
							source : new ol.source.TileWMS(
									{
										url : 'http://localhost/geoserver/baek1/wms?service=WMS', // 1. 레이어 URL
										params : {
											'VERSION' : '1.1.0', // 2. 버전
											'LAYERS' : 'baek1:tl_bjd', // 3. 작업공간:레이어 명
											'BBOX' : [ 1.3873946E7,
													3906626.5,
													1.4428045E7,
													4670269.5 ],
											'CQL_FILTER' : "bjd_cd=11590101",
											'SRS' : 'EPSG:3857', // SRID
											'FORMAT' : 'image/png' // 포맷

										},
										serverType : 'geoserver',
									})
						});
				map.addLayer(wmsbjd); // 맵 객체에 레이어를 추가함 

			});

	/* var myFullScreenControl = new ol.control.FullScreen();
	 map.addControl(myFullScreenControl); */
</script>

</head>
<body>
	<div id="map" class="map">
	<div id="popup">
		<!-- 실제 지도가 표출 될 영역 -->
		<%-- <select id="loc" name="loc">
         <c:forEach items="${list }" var="row">
            <option value="${row.sidonm}" ${row.sidonm eq param.loc ? 'selected' : ''}>${row.sidonm}</option>
         </c:forEach>
         </select>
         <button type="submit">선택</button> --%>

		<div class="container">
			<div class="main">
				<div class="btncon">
					<select id="sdselect">
						<option>시도 선택</option>
						<c:forEach items="${sdlist }" var="sd">
							<option class="sd" value="${sd.sd_cd }">${sd.sd_nm}</option>
						</c:forEach>
					</select> <select id="sggselect">
						<option value="">시군구 선택</option>
					</select> <select id="bjdselect">
						<option value="">법정동 선택</option>
					</select> <select>
						<option selected="selected">범례 선택</option>
					</select>

					<button class="insertbtn">입력하기</button>

					<form id="uploadForm">
						<input type="file" accept=".txt" id="txtfile" name="txtfile">
					</form>
				</div>

			</div>
		</div>
		
	</div>
	</div>
	
	
	
	
</body>
</html>