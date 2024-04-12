<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- jQuery -->
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

<!-- Bootstrap -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

<!-- <script src="https://cdn.jsdelivr.net/npm/ol@v9.1.0/dist/ol.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/ol@v9.1.0/ol.css"> -->
<%-- <script type="text/javascript" src="<c:url value='/js/mapTest.js' />"></script> --%>
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

/* 스낵바 스타일 */
.toast1 {
    position: fixed;
    bottom: 20px; /* 원하는 위치에 배치합니다 */
    left: 50%;
    transform: translateX(-50%);
    background-color: #333;
    color: #fff;
    padding: 15px;
    border-radius: 5px;
    z-index: 999; /* 다른 요소 위에 표시될 수 있도록 z-index 설정 */
}

/* progress bar 스타일 */
.progress {
    height: 20px; /* 원하는 높이로 조정합니다 */
    margin-top: 10px; /* progress bar 위 간격 조정 */
}

.progress-bar {
    background-color: #007bff; /* progress bar 색상 */
    text-align: center; /* 텍스트 가운데 정렬 */
    line-height: 20px; /* 텍스트 수직 가운데 정렬 */
    font-size: 14px; /* 텍스트 크기 */
    border-radius: 5px; /* progress bar 둥근 모서리 */
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
						.fromLonLat([ 127, 36.5 ]), //위도, 경도 였구먼
				zoom : 8,
				
			}),
			controls : ol.control.defaults().extend([ 
						new ol.control.Zoom() // Zoom 컨트롤 추가

					])
			
		});
				/* mapOverlay = new ol.Overlay(({ element: container })); //Overlay 생성, 요소는 컨테이너 */

				var wmssgg;
				var wmsbjd;
				$('#sdselect').on('change',	function() {
					//var sd = $('#sd option:selected').text();
					var sdcdparam = $("option:selected", this).attr("value");

					console.log(sdcdparam);
					
					
					/* var sd_CQL = "sd_nm="+$("option:selected", this).text(); */

					/* console.log(sd_CQL); */
					
					
			/* var sgg = $('#sgg option:selected').val();
				var bjd = $('#bjd option:selected').val(); */
				/* var jsonData = JSON.parse(sd);  // 받아온 데이터를 JavaScript 객체로 변환  */
						
		
				
					 $.ajax({
						url : '/selectedSD.do', // 컨트롤러의 URL
						type : 'post', // HTTP 메소드
						dataType : 'json', // 응답 데이터 타입
						data :{"sdcdparam" : sdcdparam},
						success : function(data) {
							
							
							
							// 서버로부터 받은 데이터 중 sgg_cd 값만 추출하여 sd_CQL에 할당
				            var sgg_cd_values = data.map(function(item) {
				                return "'" + item.sgg_cd + "'";
				            });
							
				            sd_CQL = "sgg_cd IN (" + sgg_cd_values.join(",") + ")";
							

				            map.removeLayer(wmssgg);
				            map.removeLayer(wmsbjd);
							 wmssgg = new ol.layer.Tile(
										{	
											properties: { name: 'wmssgg' },
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
															'CQL_FILTER' : sd_CQL,
															'SRS' : 'EPSG:3857', // SRID
															'FORMAT' : 'image/png' // 포맷

														},
														serverType : 'geoserver',
													})
										});
								
								map.addLayer(wmssgg); // 맵 객체에 레이어를 추가함	
								
								
							
								console.log(sd_CQL);
							
							
							
							console.log(data);
							console.log(data[0]);
							var sgg = $("#sggselect");
							$("#sggselect").empty();
				              sgg.html("<option>시군구 선택</option>");
				               /* var jsonData = JSON.parse(data); */
				               for(var i=0;i<data.length;i++){
				                  sgg.append("<option value='"+data[i].sgg_cd+"'>"+data[i].sgg_nm+"</option>");
				               }
				               
				               $("#sggselect").append(sgg);
				               
				               $.ajax({
									url : '/ZoomSd.do', // 컨트롤러의 URL
									type : 'post', // HTTP 메소드
									dataType : 'json', // 응답 데이터 타입
									data :{"sdcdparam" : sdcdparam},
									success : function(data) {
										//시도 선택 시 좌표 이동을 위해
										const sdExtent = data.sdExtent;
							            console.log(sdExtent);
										map.getView().fit([sdExtent.xmin, sdExtent.ymin, sdExtent.xmax, sdExtent.ymax], {duration : 700});
									},error: function(error) {
										alert("SD zoom 실패: " + error);
									}
							   });
				               
				               
				               var sggcdparam;
				               $('#sggselect').on('change',	function() {
									sggcdparam = $("option:selected", this).attr("value");

									console.log(sggcdparam);
									
									
									
						            
						            
						            map.removeLayer(wmsbjd);
									
								
									 $.ajax({
										url : '/selectedSgg.do', // 컨트롤러의 URL
										type : 'post', // HTTP 메소드
										dataType : 'json', // 응답 데이터 타입
										data :{"sggcdparam" : sggcdparam},
										success : function(data) {
								            console.log(data);
								            
								            
											
											// 서버로부터 받은 데이터 중 bjd_cd 값만 추출하여 sd_CQL에 할당
								            var bjd_cd_values = data.map(function(item) {
								                return "'" + item.bjd_cd + "'";
								            });
											
								            sgg_CQL = "bjd_cd IN (" + bjd_cd_values.join(",") + ")";

								            console.log(sgg_CQL);
								            
								            
								            $.ajax({
												url : '/ZoomSgg.do', // 컨트롤러의 URL
												type : 'post', // HTTP 메소드
												dataType : 'json', // 응답 데이터 타입
												data :{"sggcdparam" : sggcdparam},
												success : function(data) {
													//시도 선택 시 좌표 이동을 위해
													const sggExtent = data.sggExtent;
										            console.log(sggExtent);
										            map.getView().fit([sggExtent.xmin, sggExtent.ymin, sggExtent.xmax, sggExtent.ymax], {duration : 700});
										            
												},error: function(error) {
													alert("Sgg zoom 실패: " + error);
												}
										   });
								            
								            
								            map.removeLayer(wmsbjd);
											wmsbjd = new ol.layer.Tile(
														{	
															properties: { name: 'wmsbjd' },
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
																			'CQL_FILTER' : sgg_CQL,
																			'SRS' : 'EPSG:3857', // SRID
																			'FORMAT' : 'image/png' // 포맷

																		},
																		serverType : 'geoserver',
																	})
														});
												
												map.addLayer(wmsbjd); // 맵 객체에 레이어를 추가함	
				               
				               
				            },
				            error : function() {
				               alert("실패");
				            }
				         });
						});

			            }
			         });      

		         }); 
	 
	 //메시지~
		 let toastBox = document.getElementById('toastBox');
		//let loadingMsg = '로딩 중';
		let successMsg = '<i class="fa-solid fa-circle-check"></i> 파일 업로드 성공';
		let failMsg = '<i class="fa-solid fa-circle-xmark"></i> 파일 업로드 실패';
		let loadingToast = $("#loadingToast");
		loadingToast.hide();
	 
	 
		function showResultToast(msg) {
		    let toast = document.createElement('div');
		    toast.classList.add('toast1');
		    toast.innerHTML = msg;
		    
		    let toastBox = document.getElementById('toastBox'); // toastBox 요소를 가져옴
		    
		    if (toastBox) { // toastBox가 존재하는 경우에만 실행
		        toastBox.appendChild(toast);
		        
		        if (msg.includes('실패')) {
		            toast.classList.add('fail');
		        } else if (msg.includes('성공')) {
		            toast.classList.add('success');
		        }
		        
		        setTimeout(function() {
		            toast.remove();
		        }, 3000);
		    } else {
		        console.error('Toast container not found.'); // toastBox가 존재하지 않는 경우 콘솔에 오류 메시지 출력
		    }
		}
				
	// 파일 업로드
		$("#uploadBtn").on("click", function() {
			
			let fileName = $('#txtfile').val();
			let extension =  fileName.slice((fileName.lastIndexOf('.') - 1 >>> 0) + 2).toLowerCase();
			console.log(fileName);
			console.log(extension);
		
			
			if (extension == 'txt') {

		        // 업로드 시작 시 메시지 표시
		        loadingToast.show();
				
				// FormData 객체 생성
				let formData = new FormData(document.getElementById('uploadForm'));
		        let file = $('#txtfile')[0].files[0]; // 파일 객체 가져오기
		        
		        if (file) {
		        formData.append('file', file); // 파일 추가
				
		        let progressBar = $('#progressBar');
				progressBar.css('width', '0%'); // 초기 너비 설정
	            progressBar.text('0%'); // 초기 텍스트 설정
				
				$.ajax({
					url: "/uploadTxt.do", 
					type: "post", 
					enctype: "multipart/form-data", //폼 데이터가 파일 업로드와 함께 전송되는 것을 지정
					data: formData, 
					cache: false, 
					processData: false, 
					contentType: false, 
					xhr: function() {
		                let xhr = new window.XMLHttpRequest();
		                
		             // progress 이벤트 리스너 등록
		                xhr.upload.addEventListener('progress', function(evt) {
		                    if (evt.lengthComputable) {
		                        let percentComplete = evt.loaded / evt.total * 100;
		                        progressBar.css('width', percentComplete + '%'); // progressBar 업데이트
	                            progressBar.text(percentComplete.toFixed(0) + '%'); // 텍스트 업데이트
	                        }
		                }, false);
		                return xhr;
		            },
					
					
					success: function(data) {
						let result = JSON.parse(data);
						console.log(result);
						showResultToast(successMsg + '(' + result.result + ' lines)<br>경과 시간: ' + result.timeElapsed + '초');
						
						 $('#uploadTime').text('업로드 시간: ' + result.timeElapsed + '밀리초'); // 업로드 시간을 progress bar 아래에 표시
					}, 
					error: function(xhr, status, error) {
		                console.error(xhr.responseText); //서버에서 전달된 오류메시지
		                alert("통신 실패: " + error);
		                showResultToast(failMsg);
					},
					complete: function() {
	                    // 업로드가 완료되면 메시지 숨기기
	                    loadingToast.hide();
	                }
		        });
	            } else {
		            alert("파일을 선택해주세요.");
		        }
			} else if (!extension) {
				return false; 
			} else {
				alert("txt 파일만 업로드 가능합니다.");
			}
			
		});
		
    }); 
	 
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
		<div id="loadingToast" class="toast1">
            <i class="fa-solid fa-circle-arrow-up"></i> 업로드 진행 중...
            <!-- 파일 업로드 진행 상태를 나타내는 progress bar -->
            <div class="progress">
                <div id="progressBar" class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%;">0%</div>
            </div>
             <div id="uploadTime"></div>
        </div>
        <div id="toastBox"></div>
		<div class="container">
			<div class="main">
				<div class="btncon">
					<select id="sdselect">
						<option>시도 선택</option>
						<c:forEach items="${sdlist }" var="sd">
							<option class="sd" value="${sd.sd_cd }">${sd.sd_nm}</option>
						</c:forEach>
					</select>
					 <select id="sggselect">
						<option value="">시군구 선택</option>
					</select> 
					 <select>
						<option selected="selected">범례 선택</option>
					</select>

					<button class="insertbtn">입력하기</button>
					

					<!-- <form id="uploadForm">
						<input type="file" accept=".txt" id="txtfile" name="txtfile">
					</form> -->
					<div>
					<form id="uploadForm">
						<input type="file" id="txtfile" name="file" accept="text" placeholder="txt 파일 업로드" required>
					</form>
						<button type="button" id="uploadBtn">파일 업로드</button>
			</div>
				</div>

			</div>
			
			<!-- <div id="toastBox">
				<div class="toast1" id="loadingToast"><i class="fa-solid fa-circle-arrow-up"></i> 업로드 진행 중...</div>
			</div> -->
		</div>
		
	</div>
	</div>
	
	
	
	
</body>
</html>