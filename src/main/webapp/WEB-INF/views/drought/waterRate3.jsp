<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DIMAS 재난안전종합상황실</title>
    
    <%@include file="/WEB-INF/views/tile/default/PageScript.jsp"%>
	<%@include file="/resources/wrms/inc/jsgrid.inc"%>
	
	<link rel="stylesheet" href="<c:url value='/resources/sass/css/main.css?v=01'/>" /> 
    <!-- icon- font awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css" integrity="sha512-SzlrxWUlpfuzQ+pcUCosxcglQRNAq/DZjVsC0lE40xsADsfeQoEypE+enwcOiGjk/bSuGGKHEyjSoQ1zVisanQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
 	
 	<!-- proj4js 라이브러리를 로드합니다. -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/proj4js/2.8.0/proj4.js"></script>
	
 	<style>
         #windy {
             width: 100%;
             height: 100%;
         }
         
         #windy #bottom {
		   	width: 900px;
   			left: 440px;
		}
		
		
		.progress-line {
		    width: 850px;
		}

		.select_date {
		   	color: #706868;
		}
		
		.coordinate {
            position: absolute;
            bottom: 10px;
            right: 50%;
        }
        
		#windy #map-container .leaflet-control-container {
		    display: block;
		}
		
		 .leaflet-top {
		    left: 1000px;
   			top: 60px;
		}
		
		#windy .leaflet-container a.leaflet-popup-close-button {
		  font-size: 22px;
		  padding: 7px 23px 0 0;
		}

		.blank-div-icon {
		    opacity: 0;
		  }
		  
		.leaflet-popup.center {
								  margin-left: -100px !important;
								  margin-top: -50px !important;
								  left: 50% !important;
								  top: 50% !important;
								  transform: none !important;
								};

     </style>
     
     <script type="text/javascript">
		var lineJson = { "type": "FeatureCollection", "features": [{ "type": "Feature", "properties": {}, "geometry": { "type": "LineString", "coordinates": [[82.5732421875, 29.233683670282787], [84.4573974609375, 28.401064827220896], [82.4139404296875, 28.28019589809702]] } }] }
		var pointJson = { "type": "FeatureCollection", "features": [{ "type": "Feature", "properties": {}, "geometry": { "type": "Point", "coordinates": [80.92529296875, 29.209713225868185] } }, { "type": "Feature", "properties": {}, "geometry": { "type": "Point", "coordinates": [82.15576171875, 29.554345125748267] } }, { "type": "Feature", "properties": {}, "geometry": { "type": "Point", "coordinates": [82.210693359375, 28.748396571187406] } }, { "type": "Feature", "properties": {}, "geometry": { "type": "Point", "coordinates": [83.64990234375, 28.468691297348148] } }, { "type": "Feature", "properties": {}, "geometry": { "type": "Point", "coordinates": [85.53955078125, 27.488781168937997] } }, { "type": "Feature", "properties": {}, "geometry": { "type": "Point", "coordinates": [87.20947265625, 27.235094607795503] } }] }
		var polygonJson = { "type": "FeatureCollection", "features": [{ "type": "Feature", "properties": { "stroke": "#555555", "stroke-width": 2, "stroke-opacity": 1, "fill": "#555555", "fill-opacity": 0.5, "name": "rectangle" }, "geometry": { "type": "Polygon", "coordinates": [[[81.7987060546875, 28.86872905602898], [82.21618652343749, 28.86872905602898], [82.21618652343749, 29.176145182559758], [81.7987060546875, 29.176145182559758], [81.7987060546875, 28.86872905602898]]] } }, { "type": "Feature", "properties": { "stroke": "#555555", "stroke-width": 2, "stroke-opacity": 1, "fill": "#555555", "fill-opacity": 0.5, "name": "polygon" }, "geometry": { "type": "Polygon", "coordinates": [[[82.8973388671875, 28.753212537990336], [82.8094482421875, 28.51696944040106], [83.07861328125, 28.101057958669447], [83.86962890625, 28.41555985166584], [83.4686279296875, 28.99372720461893], [82.8973388671875, 28.753212537990336]]] } }] }

		var searchConditionObj 	= {
				s_kind_time : 'minute'
			,	uBcd		: '${details.level_buseo_code}'
			,	uBlvl		: Number('${details.buseo_level}')
			,	uBorg		: '${details.orgin_buseo_code}'
	   		,	db_type		: 'rims'
	    };
	    
	    var betweenDate		= {
	    		minute		: {key: 'D', view: 30,	max: 14		}
			,	daily		: {key: 'D', view: 30, 	max: 31		}
			,	chkChange	: 'B'
			,	chkStat		: true
	    };
	    
	    var sqlMapper = "rawris.krc.rawris.";
	    
		$(document).ready(function(){ 
			
			var today = new Date();   

			var year = today.getFullYear(); // 년도
			var month = today.getMonth() + 1;  // 월
			var date = today.getDate();  // 날짜
			
			var format = year+"-"+(("00"+month.toString()).slice(-2))+"-"+(("00"+date.toString()).slice(-2));
			
			
			 $("#toDay").text(format);
			 
			 
			searchData();
	   		$("#btn_search").click(function () {
				 searchData();
	   		});
	   		
	   		$("#common_pop").css('display','none');
	   		
	   		

		});
		
		function searchConditionValidate(){return  true}
		 
		function searchData() {

			searchConditionObj.sql = sqlMapper + "get_water_Rate_fac";
			searchConditionObj.base_dt = "20230405";
			searchConditionObj.db_type = "rawris";  
			searchConditionObj.rscType = null; 
			searchConditionObj.facName = null;

			load_data(true);
		} 

		//기타
		proj4.defs("EPSG:5186","+proj=tmerc +lat_0=38 +lon_0=127 +k=1 +x_0=200000 +y_0=600000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs");
		proj4.defs("EPSG:4326", "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs");


		function load_data(need_init) {

			var param = $.extend({}, searchConditionObj);
			
			param.successFn	= function (data){

				windyInit(options, windyAPI => {

					var { map } = windyAPI;
					var markerLayer = L.layerGroup().addTo(map); 
				 
		    	         var width = '70px';
				    	          
		    	      	for(key in data){
							//console.log(data[key].OBSNM, data[key].OBSNM.length)

							/* const label = labelContent(data[key].PREPARE_RVOW, data[key].LABEL);

	    	                const myIcon = L.divIcon({
									    	      		// 텍스트 레이블을 포함하는 HTML 요소 생성
											    	      html: label,
											    	      // 요소의 크기 및 위치 설정
											    	      iconSize: [100, 40],
											    	      iconAnchor: [0, 0],
											    	      popupAnchor: [0, 0],
										    	     });      */   
		    				//console.log(data[key].PREPARE_RVOW, data[key].LABEL);

							
							var markerPoint = proj4('EPSG:5186', 'EPSG:4326', [data[key].LON, data[key].LAT]);
							//console.log(markerPoint)
		    				/* var marker = L.marker(markerPoint.reverse(), {
					    	    // 아이콘을 DivIcon으로 생성
					    	    icon: myIcon
					    	  });
		    	      		marker.addTo(markerLayer); */
		    	      		
		    	      		var P_RVOW =  data[key].PREPARE_RVOW;
		    	      		var fillColor = '#0DA6FD';
		    	      		if(P_RVOW > 60 )  						fillColor = '#0DA6FD';
		    	      		else if(P_RVOW > 50 && P_RVOW <= 60 )  	fillColor = '#FFC700';
		    	      		else if(P_RVOW > 40 && P_RVOW <= 50 )  	fillColor = '#FF7A00';
		    	      		else   									fillColor = '#FF3D00';

		    	      		/* var circle = L.circleMarker(markerPoint.reverse(), {
											    	      		  radius: 5,
											    	      		  color: 'white',
											    	      		  fillColor: fillColor,
											    	      		  fillOpacity: 1,
											    	      		  weight : 1
											    	      	}).addTo(markerLayer); */

		    	      		var circle = L.marker(markerPoint.reverse()).addTo(markerLayer);
		    	      		

		    	      		circle.bindPopup(  popupContent('20', '10') , {
		    	      	        maxWidth: 800,
		    	      	        offset: [0, 0], // 앞이 좌우 , 뒤가 위아래 -값이면 위로 올라감
		    	      	        keepInView : true,
		    	      	      	zoomAnimation: true, //지도 확대
		    	      	        //pane: 'myPopupPane', //팝업에 팝업 추가
	    	      	        	//closeButton: false , //false시 닫기 버튼 표시 되지않음.
	    	      	        	autoClose: true, //지도 클릭시 자동 닫힘
	    	      	        	//closeOnEscapeKey : false  // false일떄 esc눌러도 팝업이 닫히지 않음 
		    	      	       //, className: 'my-popup',
	    	      	        	// autoPan: false ,  //팝업의 자동이동 
	    	      	        	autoPanPadding: [-20, 200],  //지도밖에 팝업일때 팝업의 이동할 거리 표현 기본값 : [50, 50] [x, y]이며 가로 세로임
	    	      	        	autoPanSpeed: 1 //지도밖에 팝업일때 지도를 이동하는 속도 기본 값 : 10
	    	      	        	//,className: 'center-popup' 
		    	      	    })
		    	      		
		    	      		// 맵의 중앙 좌표를 계산합니다.
		    	      		var center = map.getCenter();
	
		    	      		
		    	      		map.on('zoomend', function () {
		    	      		   var zoomLevel = map.getZoom();
		    	      		   if (zoomLevel < 8) 
		    	      			  map.removeLayer(markerLayer);
		    	      		   else 
		    	      			  markerLayer.addTo(map); 
		    	      		});  
		    	      	}
				});
				
				$(".leaflet-left").css('left','1000px');
				$(".leaflet-left").css('top','60px');		
			};
			
			param.failFn	= function (){
				console.log("error");
			};

			ajaxPost(param);

		}

		
		  const popupContent = ( test, test2 ) => {
          	
			   return '<div>'+
              '<div class="popup_common" id="common_pop" >' +

                  <!-- pop_con -->
                  '<div class="pop_con">' +
                      '<div class="pop_con__info">' +
                          '<h4>금계</h4>' +
                          '<div class="info_wrap">' +
                              '<dl>' +
                                  '<dt>전일 저수율(%)</dt>' +
                                  '<dd>'+ test +'</dd>' +
                              '</dl>' +
                              '<dl>' +
                                  '<dt>금일 저수율(%)</dt>' +
                                  '<dd>'+ test2 +'</dd>' +
                              '</dl>' +
                              '<dl>' +
                                  '<dt>관할지사</dt>' +
                                  '<dd>경북 영주, 봉화</dd>' +
                              '</dl>' +
                              '<dl>' +
                                  '<dt>관할지사</dt>' +
                                  '<dd>경북 영주, 봉화</dd>' +
                              '</dl>' +
                          '</div>' +
                          '<div class="img"><img src="../resources/sass/images/common/img_sample.png"></div>' +
                      '</div>' +
                      '<hr>' +                 
                      '<div class="pop_con__list">' +
                          '<div class="tab_type1">' +
                              '<ul>' +
                                  '<li><a href="" class="on">수위</a></li>' +
                                  '<li><a href="">수질</a></li>' +
                                  '<li><a href="">가동</a></li>' +
                                  '<li><a href="">변위</a></li>' +
                                  '<li><a href="">누수</a></li>' +
                                  '<li><a href="">지진</a></li>' +
                              '</ul>' +
                          '</div>' +
                          '<div class="table_type_pop1">' +
                              '<table>' +
                                  '<colgroup>' +
                                  '<col width="28%">' +
                                  '<col>' +
                                  '</colgroup>' +
                                  '<tbody><tr>' +
                                      '<th>홍수위 (EL.m)</th>' +
                                      '<td>307.80</td>' +
                                  '</tr>' +
                                  '<tr>' +
                                      '<th>만수위 (EL.m)</th>' +
                                      '<td>307.80</td>' +
                                  '</tr>' +
                                  '<tr>' +
                                      '<th>사수위 (EL.m)</th>' +
                                      '<td>307.80</td>' +
                                  '</tr>' +
                                  '<tr>' +
                                      '<th>총저수량</th>' +
                                      '<td>5,293</td>' +
                                  '</tr>' +
                                  '<tr>' +
                                      '<th>유효저수량</th>' +
                                      '<td>5,271</td>' +
                                  '</tr>' +
                              '</tbody></table>' +

                              '<table>' +
                                  '<colgroup>' +
                                  '<col width="28%">' +
                                  '<col>' +
                                  '</colgroup>' +
                                  '<tbody><tr>' +
                                      '<th>기준일시</th>' +
                                      '<td>2022-06-20</td>' +
                                      '<td>2022-06-21 11:20</td>' +
                                  '</tr>' +
                                  '<tr>' +
                                      '<th>저수량</th>' +
                                      '<td>2,799</td>' +
                                      '<td>2,760</td>' +
                                  '</tr>' +
                                  '<tr>' +
                                      '<th>수위(EL.m)</th>' +
                                      '<td>299.28</td>' +
                                      '<td>299.14</td>' +
                                  '</tr>' +
                              '</tbody></table>' +
                          '</div>' +
                      '<hr>' +  
                  '</div>' +    '</div>' +
              '</div>';
		   }

		function pop_close2(){
			$("#map_popup2").hide();
		}

		const options = {
			    // Required: API key
       	    key: 'iFsNmn4OAAxQjl0PKyVylkGjF6jxxYvN', // REPLACE WITH YOUR KEY !!!
       	    // Optional: Initial state of the map
       	    lat: 36.4703327,
       	    lon: 128.0149211,
       	    zoom: 8,
       	 	crs: L.CRS.EPSG3857
		};

	    
	</script>
	
	
</head>
<body>
    <!-- header -->
    <header id="header">
       <div class="header__wrap">
            <h1><a href=""><img src="<c:url value='/resources/sass/images/common/logo.png'/>" alt="DIMAS 재난안전종합상황실"></a></h1>
            <nav id="nav">
                <ul class="main-menu">
                    <li><a href="" class="on">가뭄</a></li>
                    <li><a href="">홍수</a></li>
                    <li><a href="">태풍/지진</a></li>
                    <li><a href="">평상시</a></li>
                    <li><a href="">사회재난</a></li>
                </ul>
            </nav>
            <div class="sub-menu">
                <ul class="menu">
                    <li><a href="" class="news"><span class="new">1</span><i class="fa-sharp fa-solid fa-bell"><span class="hidden">알람</span></i></a></li>
                    <li><a href="" class="settings"><i class="fa-sharp fa-solid fa-gear"><span class="hidden">설정</span></i></a></li>
                    <li><a href="" class="user"><i class="fa-solid fa-user"></i><span class="hidden">정보수정</span></a></li>                  
                </ul>
                <a href="" class="logout">로그아웃</a>
            </div>
       </div>
    </header> 
    <hr>
    <div id="dashboard_wrap">
          <!-- container -->
    <section id="main_container">
        <!-- map -->
        <!-- map -->
        <div id="windy"> </div>
        <div class="inner_map">
            <!-- 지도상단검색바 -->
            <div class="search_bar_sub">                     
                 <label for=""><span class="label_tit">기준일자 : <span id="toDay"> </span> </span></label>                      
            </div>
            <hr>       
            <!-- sub_menu -->
            <div class="sub_menu">
                <ul>
                    <li><a href="<c:url value='/drought/rain'/>" >누적강수현황</a></li>
                    <li><a href="<c:url value='/drought/waterRate'/>" class="on">평년대비저수율</a></li>
                    <li><a href="">수질</a></li>
                    <li><a href="">염도</a></li>
                    <li><a href="">담수호</a></li>
                    <li><a href="">ADMS가뭄분석</a></li>
                </ul>
            </div>
            <hr>
            <hr>
            <hr>
            <!-- 팝업에서 지역 마우스클릭시 -->
            <div class="map_popup2" id="map_popup2">
                <a href="javascript:pop_close2()" class="btn_close" ><i class="fa-sharp fa-solid fa-xmark"></i></a>
                <div class="map_popup2_title">
                    <h3>고창
                        <span class="color_step1 point_step point_step1">경고</span>
                        <span class="asos">ASOS</span>
                    </h3>
                   
                </div>  
                <ul>
                    <li><span class="tit">누적강수량</span><span class="con">1,549.7mm</span></li>
                    <li><span class="tit">평년강수량</span><span class="con">1,007.8mm</span></li>
                    <li><span class="tit">평년대비</span><span class="con">154%</span></li>
                </ul>
            </div>
            <hr>
            <!-- 범례 -->
            <div class="legend_box">
                <h5>평년대비 저수율(%)</h5>
                <ul class="legend__type1">
                    <li><span class="step_point2 bgcolor_step1"><em class="hidden">관심</em></span>60초과</li>
                    <li><span class="step_point2 bgcolor_step2"><em class="hidden">주의</em></span>50초과 ~ 60 이하</li>
                    <li><span class="step_point2 bgcolor_step3"><em class="hidden">경계</em></span>40초과 ~ 50 이하</li>
                    <li><span class="step_point2 bgcolor_step4"><em class="hidden">심각</em></span>40이하</li>
                </ul>
            </div>
            <hr>  
        </div>
    </section>    
    <hr>
    <!-- lnb -->
    <section id="lnb">
        <!-- 현재시간,단계 -->
        <div class="current">
            <div class="current__time">
                <p class="date">2022년 06월 22일 수요일</p>
                <p class="time">20:03:12</p>
            </div>     
            <dl class="current__status">
                <dt>홍수단계</dt>
                <dd><span class="step1">관심</span></dd> <!-- step1 - step4 단계별 클래스적용 -->
            </dl>  
        </div>
        <hr>
        <!-- 검색바 -->
        <div class="search_container">
            <input type="text" placeholder="위치를 검색하세요">
            <button type="button"><i class="fa fa-search"></i></button>
        </div>
        <hr>
        <!-- 날씨정보 -->
        <div class="weather_container">
            <div class="today">
                <h3>24.9°</h3>
                <div class="weather_wrap">
                    <span class="weather_icons_small cloud2"></span><span class="txt">흐림</span><span class="wind">1M/S</span>
                </div>
            </div>
            <!-- 1 -->
            <dl class="day_weather">
                <dt class="day">수</dt>
                <dd><span class="weather_icons cloud"></span></dd>
                <dd class="temp">26°</dd>
            </dl>
            <!-- 1 -->
            <dl class="day_weather">
                <dt class="day">목</dt>
                <dd><span class="weather_icons cloud2"></span></dd>
                <dd class="temp">21°</dd>
            </dl>
            <!-- 1 -->
            <dl class="day_weather">
                <dt class="day">금</dt>
                <dd><span class="weather_icons sun"></span></dd>
                <dd class="temp">26°</dd>
            </dl>
            <!-- 1 -->
            <dl class="day_weather">
                <dt class="day">토</dt>
                <dd><span class="weather_icons rain"></span></dd>
                <dd class="temp">26°</dd>
            </dl>
            <!-- 1 -->
            <dl class="day_weather">
                <dt class="day">일</dt>
                <dd><span class="weather_icons snow"></span></dd>
                <dd class="temp">26°</dd>
            </dl>
        </div>
        <hr>
        <!-- 실시간레이더 -->
        <div data-v-667d9d7e="" id="radar" class="rader_wrap">
            <img data-v-667d9d7e="" src="http://radar.kma.go.kr/cgi-bin/center/nph-rdr_cmp_img?aws=0&amp;cmp=HSP&amp;qcd=HSL&amp;obs=ECHO&amp;map=HR&amp;color=C4&amp;legend=1&amp;size=380&amp;lonlat=0&amp;tm=202207262100&amp;xp=589.51&amp;yp=565.34&amp;zoom=2.0000" alt="레이더 HSR" class="w-full radar-img shadow-xl opacity-90 mt-5"><img data-v-667d9d7e="" src="http://radar.kma.go.kr/cgi-bin/center/nph-rdr_cmp_img?aws=1&amp;cmp=HSP&amp;qcd=HSL&amp;obs=ECHO&amp;map=HR&amp;color=C4&amp;legend=1&amp;size=380&amp;lonlat=0&amp;tm=202207262100&amp;xp=528.5&amp;yp=546.7&amp;zoom=9.0000" alt="레이더 HSR" class="w-full radar-img shadow-xl opacity-90  mt-5" style="display: none;"><div data-v-667d9d7e="" class="radar__grid"><div data-v-667d9d7e=""></div><div data-v-667d9d7e=""></div><div data-v-667d9d7e=""></div><div data-v-667d9d7e=""></div></div>
            <div data-v-667d9d7e="" class="pannel_bg">
              <div class="live_datetime">2022년 07월 26일 21시 00분 </div> 
            </div>                 
        </div>
        <hr>
        <!-- 기상특보 알리미 -->
        <div class="alarm_news">   
            <h3>기상특보 알리미</h3>         
            <!-- 1 -->
            <dl class="on">
                <dt>
                    <p class="day">22</p>
                    <p class="year">2023.01</p>
                </dt>
                <dd>
                    <p class="con">강풍주의보가 해제되었습니다.</p>
                    <a href="" class="detail_view">자세히보기</a>
                </dd>
            </dl>
            <!-- 2 -->
            <dl>
                <dt>
                    <p class="day">11</p>
                    <p class="year">2023.01</p>
                </dt>
                <dd>
                    <p class="con">강풍주의보가 해제되었습니다.</p>
                    <a href="" class="detail_view">자세히보기</a>
                </dd>
            </dl>
            <!-- 3 -->
            <dl>
                <dt>
                    <p class="day">05</p>
                    <p class="year">2023.01</p>
                </dt>
                <dd>
                    <p class="con">강풍주의보 풍량주의보가 발표되었습니다.</p>
                    <a href="" class="detail_view">자세히보기</a>
                </dd>
            </dl>
        </div>  
    </section>
    <hr>
    <section id="rnb">
        <!-- 전국평균강수량 -->
        <div class="average_data">
            <!-- 1 -->
            <dl class="average_data_all">
                <dt>전국 누적 평균강수(mm)</dt>
                <dd>
                    <span class="title">전국</span>
                    <span class="amount">934 <em class="unit">mm</em></span>
                    <span class="percent">75 <em class="unit">%</em>
                      <i class="fa-solid fa-arrow-down-long"></i>
                    </span>
                </dd>
            </dl>
            <!-- 2 -->
            <dl class="average_data_area">
                <dt>지역 누적 평균강수(mm)</dt>
                <dd>
                    <span class="title">경북</span>
                    <span class="amount">934 <em class="unit">mm</em></span>
                    <span class="percent">75 <em class="unit">%</em>
                        <i class="fa-solid fa-arrow-down-long"></i>
                    </span>
                </dd>
            </dl>
        </div>
        <hr>
        <div class="status_container">
        <!-- 상단타이틀 -->
            <h3 class="main_title">누적강수현황</h3>             
            <ul class="search_tab">
                <li><a href="" class="on">본부/지사</a></li>
                <li><a href="">시설검색</a></li>
                <li><a href="">통합정보</a></li>
            </ul>           
            <div class="search_checkbox">
                <!-- 1 -->
                <div class="check_label">        
                    <label class="checkcontainer"><span class="check_icon check_icon1">저수지</span>
                        <input type="checkbox">
                        <span class="checkmark"></span>
                    </label>      
                </div>         
                <hr>
                <!-- 1 -->
                <div class="check_label">        
                    <label class="checkcontainer"><span class="check_icon check_icon2">양수장</span>
                        <input type="checkbox">
                        <span class="checkmark"></span>
                    </label>      
                </div>   
                <hr>
                <!-- 1 -->
                <div class="check_label">        
                    <label class="checkcontainer"><span class="check_icon check_icon3">배수장</span>
                        <input type="checkbox" checked="checked">
                        <span class="checkmark"></span>
                    </label>      
                </div>   
                <hr>
                <!-- 1 -->
                <div class="check_label">        
                    <label class="checkcontainer"><span class="check_icon check_icon4">수문</span>
                        <input type="checkbox" checked="checked">
                        <span class="checkmark"></span>
                    </label>      
                </div>   
                <hr>
                <!-- 1 -->
                <div class="check_label">        
                    <label class="checkcontainer"><span class="check_icon check_icon5">배수갑문</span>
                        <input type="checkbox" checked="checked">
                        <span class="checkmark"></span>
                    </label>      
                </div>   
                <hr>
                <!-- 1 -->
                <div class="check_label">        
                    <label class="checkcontainer"><span class="check_icon check_icon6">수로</span>
                        <input type="checkbox" checked="checked">
                        <span class="checkmark"></span>
                    </label>      
                </div>   
                <hr>       
            </div>  
            <hr>
            <!-- 결과테이블 -->
            <div class="status__table">
                <p class="info"><span>기간</span>22-11-11 이전 기준</p>
                <table class="main_table">
                    <tr>
                       <th rowspan="2">지역(전체)</th>
                       <th colspan="2">저수율</th>
                       <th colspan="4">개소수</th>
                   </tr>
                    <tr>
                      <th>현재/평년</th>
                      <th>평년대비</th>
                      <th><span class="step_point bgcolor_step1"><em class="hidden">관심</em></span></th>
                      <th><span class="step_point bgcolor_step2"><em class="hidden">주의</em></span></th>
                      <th><span class="step_point bgcolor_step3"><em class="hidden">경계</em></span></th>
                      <th><span class="step_point bgcolor_step4"><em class="hidden">심각</em></span></th>
                  </tr>
                   <tr>
                       <td>전국(3,403)</td>
                       <td>64/67</td>
                       <td>96</td>
                       <td>3,250</td>
                       <td>74</td>
                       <td>32</td>
                       <td>82</td>
                   </tr>
                   <tr>
                       <td>경기(111)</td>
                       <td>83/75</td>
                       <td>96</td>
                       <td>3,250</td>
                       <td>74</td>
                       <td>32</td>
                       <td>82</td>
                   </tr>
                   <tr>
                    <td>강원(111)</td>
                    <td>83/75</td>
                    <td>96</td>
                    <td>3,250</td>
                    <td>74</td>
                    <td>32</td>
                    <td>82</td>
                </tr>
                <tr>
                    <td>충북(111)</td>
                    <td>83/75</td>
                    <td>96</td>
                    <td>3,250</td>
                    <td>74</td>
                    <td>32</td>
                    <td>82</td>
                </tr>
                <tr>
                    <td>충남(111)</td>
                    <td>83/75</td>
                    <td>96</td>
                    <td>3,250</td>
                    <td>74</td>
                    <td>32</td>
                    <td>82</td>
                </tr>
                <tr>
                    <td>전북(111)</td>
                    <td>83/75</td>
                    <td>96</td>
                    <td>3,250</td>
                    <td>74</td>
                    <td>32</td>
                    <td>82</td>
                </tr>
                <tr>
                    <td>전남(1,045)</td>
                    <td>83/75</td>
                    <td>96</td>
                    <td>3,250</td>
                    <td>74</td>
                    <td>32</td>
                    <td>82</td>
                </tr>
                <tr>
                    <td>경북(111)</td>
                    <td>83/75</td>
                    <td>96</td>
                    <td>3,250</td>
                    <td>74</td>
                    <td>32</td>
                    <td>82</td>
                </tr>
                <tr>
                    <td>경남(111)</td>
                    <td>83/75</td>
                    <td>96</td>
                    <td>3,250</td>
                    <td>74</td>
                    <td>32</td>
                    <td>82</td>
                </tr>
                <tr>
                    <td>제주(9)</td>
                    <td>83/75</td>
                    <td>96</td>
                    <td>3,250</td>
                    <td>74</td>
                    <td>32</td>
                    <td>82</td>
                </tr>
               </table>   
            </div>
            <hr>
            <div class="main_chart">
                <p>그래프 개발 들어가는곳 이미지로 공간만</p>
            </div>
        </div>
    </section>
</div>
    
</body>
</html>