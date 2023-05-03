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

 	<style>
			#windy #map-container .leaflet-control-container {
			     display:block; 
			}

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

	        setBetweenDateTime();    
			searchData();
	   		$("#btn_search").click(function () {
				 searchData();
	   		});
	   		
	   		$("#common_pop").css('display','none');
	   		
	   		
	   		//좌측 패널
	   		//setInterval(displayTime, 1000);
	   		displayTime();
	   		setRealStatus();

	   		getRadar(); //레이더 정보 가져오기
			setInterval(function () { //5분마다 새로고침
				getRadar();
			}, 1000 * 60 * 5);
		});
		
		function searchConditionValidate(){return  true}

		 
		 function getDate(type) {

	        if(type == 'from') {
	            return $('#datetimepicker1').val().replace(/-/g, '')
	        }else if(type == 'to') {
	            return $('#datetimepicker2').val().replace(/-/g, '')
	        }
	    }
		 
		function searchData() {
			  // 조회 버튼

            var rFrom = getDate('from');
            var rTo = getDate('to');
            var froms = rFrom.split(" ");
            var tos = rTo.split(" ");
            var fromTime = froms[1].replace("시", "");
            var toTime = tos[1].replace("시", "");

            // 우축 강수량도 변경
            //window.parent.makeRightMiddleHTML( '/krcics/kma/tmplC/awsTable.do?' + param);
           //window.parent.makeRightTopHTML('/krcics/kma/tmplC/kma-rainfall-index.do?' + param);
	 
			
			searchConditionObj.sql = sqlMapper + "get_aws_new_list";
			searchConditionObj.base_dt = "20230317";
			searchConditionObj.db_type = "rawris";  
			searchConditionObj.type = "1"; 
			searchConditionObj.s_start_date = froms[0];
			searchConditionObj.s_start_time = fromTime;
			searchConditionObj.s_end_date = tos[0];
			searchConditionObj.s_end_time = toTime;


			load_data(true);
		} 
		
		const options = {
			    // Required: API key
       	    key: 'iFsNmn4OAAxQjl0PKyVylkGjF6jxxYvN', // REPLACE WITH YOUR KEY !!!
       	    // Optional: Initial state of the map
       	    lat: 36.4703327,
       	    lon: 128.0149211,
       	    zoom: 8,
		};
		
		var cnt = 0;
		function load_data(need_init) {

			var param = $.extend({}, searchConditionObj);
			
			param.successFn	= function (data){

				windyInit(options, windyAPI => {

					var { map } = windyAPI;
				    var markerLayer = L.layerGroup().addTo(map);
				 
	    	        var width = '70px';
			    	          
	    	      	for(key in data){
	    	      		
	    	      		var label = labelContent(data[key].AVG_RATIO, data[key].OBSNM);
	    	      		//console.log(data[key].AVG_RATIO, data[key].OBSNM);
	    	      		var myIcon = L.divIcon({
								    	      		// 텍스트 레이블을 포함하는 HTML 요소 생성
										    	      html: label,
										    	      // 요소의 크기 및 위치 설정
										    	      iconSize: [0, 0], //이값을 주면 백그라운드 div 공간을 차지해버림.
										    	      iconAnchor: [0, 0],
										    	      popupAnchor: [0, 0],
									    	     });        
			    	          
	    	      		var marker = L.marker([data[key].Y, data[key].X], {
				    	    // 아이콘을 DivIcon으로 생성
				    	    icon: myIcon
				    	  }).addTo(markerLayer);
	    	      		
	    	      		//var marker2 = L.marker([data[key].Y, data[key].X]).addTo(markerLayer);
	    	      		
	    	      		marker.bindPopup(  popupContent(data[key].TYPE, data[key].AWDID, data[key].TODAY_RN, data[key].SUM_RN, data[key].AVG_RN, data[key].AVG_RATIO, data[key].OBSNM) , {
	    	      	        maxWidth: 800,
	    	      	        offset: [2.2, 5] // 앞이 좌우 , 뒤가 위아래 -값이면 위로 올라감
	    	      	       //, className: 'my-popup'
	    	      	    });
	    	      		
	    	      		map.on('zoomend', function () {
	    	      		   var zoomLevel = map.getZoom();
	    	      		   if (zoomLevel < 8) 
	    	      			  map.removeLayer(markerLayer);
	    	      		   else 
	    	      			  markerLayer.addTo(map);
		    	      		  
	    	      		});  
	    	      	  
	    	      	 }
	    	      	

	    	     	
	    	     	
	             // Geocoding 컨트롤 추가
	                L.Control.geocoder({
	                    defaultMarkGeocode: false, // 기본값은 true
	                    placeholder: "Search location...",
	                    geocoder: L.Control.Geocoder.nominatim({
	                        // OpenStreetMap의 Nominatim 서비스 사용
	                        // 이 부분은 다른 Geocoding 서비스로 변경할 수 있습니다.
	                    }),
	                    position: "topright",
	                }).on("markgeocode", function (event) {
	                    // 검색 결과를 클릭하면 이벤트 발생
	                    // 위도/경도 좌표를 가져와서 맵 중앙에 마커를 추가
	                    var latlng = event.geocode.center;
	                    map.setView(latlng, options.zoom);
	                    L.marker(latlng).addTo(map);
	                }).addTo(map);

				});

				$(".leaflet-left").css('left','1000px');
				$(".leaflet-left").css('top','60px');		
			};
			
			param.failFn	= function (){
				console.log("error");
			};

			ajaxPost(param);

		}
		
		 function searchLocation() {
             var location = document.getElementById("searchTxt").value;
             cosole.log(location)
             L.Control.Geocoder.nominatim().geocode(location, function (results) {
            	 cosole.log(222)
                 if (results.length > 0) {
                	 cosole.log(333)
                     var latlng = results[0].center;
                     map.setView(latlng, options.zoom);
                     L.marker(latlng).addTo(map);
                 } else {
                	 cosole.log(444)
                     alert("Location not found");
                 }
             });
         }
		 

	    const labelContent = ( AVG_RATIO, OBSNM ) => {
	    	
	    	if(OBSNM.length > 7) width = '100px';
      		else if(OBSNM.length > 9) width = '120px';
      		else if(OBSNM.length > 10) width = '150px';
      		else if(OBSNM.length > 14) width = '200px';
      		else  width = '70px';
	    	
	    	var warn, warn2; 
	    	
	    	if(AVG_RATIO > 65) {
	    		warn  = 'before_step1'; 
	    		warn2 = '<p class="popcolor_step1">'; 
	    	}
	    	else if(AVG_RATIO > 55 && AVG_RATIO <= 65) {
	    		warn  = 'before_step2'; 
	    		warn2 = '<p class="popcolor_step2">'; 
	    	}
	    	else if(AVG_RATIO > 45 && AVG_RATIO <= 55){
	    		warn  = 'before_step3'; 
	    		warn2 = '<p class="popcolor_step3">';
	    	}
	    	else {
	    		warn  = 'before_step4'; 
	    		warn2 = '<p class="popcolor_step4">'; 
	    	}
	    	
	    	/* if( AVG_RATIO == 0 ) AVG_RATIO 	= '-'; 
	    	else 				 AVG_RATIO 	= AVG_RATIO + '%';  */
	    	
		   return  '<div class="map_popup ' + warn + '" style="position:absolute; width:'+ width + ' ">' +
		           '<h3>'+ OBSNM +'</h3>'  + warn2 + AVG_RATIO + ' %</p></div>';
		           
	   }
	    
	    const popupContent = ( TYPE, AWDID, TODAY_RN, SUM_RN, AVG_RN, AVG_RATIO, OBSNM ) => {

	    	var warn; 
	    	if(AVG_RATIO > 65) 		 					warn = '<span class="point_step color_step1 point_step1">관심</span>'; 
	    	else if(AVG_RATIO > 55 && AVG_RATIO <= 65) 	warn = '<span class="point_step color_step2 point_step4">주의</span>'; 
	    	else if(AVG_RATIO > 45 && AVG_RATIO <= 55) 	warn = '<span class="point_step color_step3 point_step4">경계</span>'; 
	    	else 					 					warn = '<span class="point_step color_step4 point_step4">심각</span>'; 
	    	
	    	/* if( TODAY_RN == 0 ) 	TODAY_RN 	= '-'; 
	    	if( SUM_RN == 0 ) 		SUM_RN 	 	= '-';
	    	if( AVG_RN == 0 ) 		AVG_RN 	 	= '-';
	    	if( AVG_RATIO == 0 ) 	AVG_RATIO 	= '-';  */
	    	
	    	var rainType; 
	    	if(TYPE == "ASOS") rainType	= '<span class="asos">ASOS</span>'; 
	    	else 			   rainType	= '<span class="aws">AWS</span>'; 
	    	
		   return  '<div class="map_popup2">' +
		                '<div class="map_popup2_title">' +
		                    '<h3>' + OBSNM + warn + rainType + '</h3>' +
		                '</div>' +  
		                '<ul>' +
		                	'<li><span class="tit">금일강수량</span><span class="con">'+ TODAY_RN +' mm</span></li>' +
		                    '<li><span class="tit">누적강수량</span><span class="con">'+ SUM_RN +' mm</span></li>' +
		                    '<li><span class="tit">평년강수량</span><span class="con">'+ AVG_RN +' mm</span></li>' +
		                    '<li><span class="tit">평년대비</span><span class="con">'+ AVG_RATIO +' %</span></li>' +
		                '</ul>' +
		            '</div>';
	   }
 
	    
	    
	    
	     /* ==================================  왼쪽메뉴 ====================================== */

			
	    //시계
		function displayTime() {
			 var today 		= new Date();
		     var year 		= today.getFullYear();
			 var month 		= ('0' + (today.getMonth() + 1)).slice(-2);
			 var date		= ('0' + today.getDate()).slice(-2);
			 var day 		= today.getDay();  // 요일
			 var days    	= ['일', '월', '화', '수', '목', '금', '토'];
			 var dayOfWeek 	= days[today.getDay()];
			 var hours 		= today.getHours();
			 var minutes 	= today.getMinutes();
			 var seconds 	= today.getSeconds();
				
			//var ampm 		= hours >= 12 ? 'PM' : 'AM';
			hours 			= hours < 10 ? '0' + hours : hours;
			minutes 		= minutes < 10 ? '0' + minutes : minutes;
			seconds 		= seconds < 10 ? '0' + seconds : seconds;
	
			var dateString = year + '년 ' + month  + '월 ' + date + '일 '+ dayOfWeek + '요일';
			//$('#cur_date').text = dateString;
			var time 	= hours + ':' + minutes + ':' + seconds;
			//$('#cur_time').text = time;
			setTimeout(displayTime, 1000);
			
			document.getElementById('cur_date').innerHTML = dateString;
			document.getElementById('cur_time').innerHTML = time;
				
		}

		 //재해단계 
	 	function setRealStatus() {
			/* const menuClass = '${menuClass}';
			const user_id   = '${user_id}'; */
			
			var menu_class = 'DROUGHT'; 
			var user_id    = 'test10'; 
			
			menu_class = 'NORMAL';  
			user_id    = 'ekrsafe25';

			const arrStatus = [];
	        if (menu_class == "FLOOD" || menu_class == "TYPHOON") 
				$('#real_status').text("홍수단계");
			else {
				if (menu_class == "DROUGHT")
					$('#real_status').text("가뭄단계");
				else
					$('#real_status').text("평상");
			}
		 	
	        const RealStatusInfo = {
		 			sql : "rawris.krc.rawris.getRealStatusInfo"
		 		  , cmd : "selectList"
		 		  , db_type : "rawris"
		 		  , user_id : user_id
		 		  , menu_class : menu_class
		 	};
		 	
	        const rst = ajaxPost(RealStatusInfo);
	        
	        
		 	if(!rst) {
		 		//rawrisShowMsg(" 장애가 발생했습니다.");
		 		return false;
		 	} else {
		 		const status = rst[0].STATUS;
		 		var step;
		 		if	   (status == "관심") step= "step1"
		 		else if(status == "주의") step= "step2"
		 		else if(status == "경계") step= "step3"
		 		else 					 step= "step4"
		 		
		 		$('#real_status_step').text(status);
		 		$('#real_status_step').attr("class", step);
		 		return true;
		 	}	
	 	}
		 
	 // 레이다 호출
		function getRadar() {

			var BASEDATETIME = getDateString(5);
			var rdrdt =  BASEDATETIME.substr(0,4) + "년 " +BASEDATETIME.substr(4,2)+ "월 " +BASEDATETIME.substr(6,2)+ "일 " +BASEDATETIME.substr(8,2)+ "시 " +BASEDATETIME.substr(10,2)+ "분";
			$("#live_datetime").html( rdrdt );

			var url = "http://afso.kma.go.kr/cgi/rdr/nph-rdr_cmp_img?tm=" + BASEDATETIME + "&obs=rdr_ppi_qcd&data=3&qcd=1&aws=0&map=D3&grid=2&legend=1&size=475.00&itv=5&zoom_level=0&zoom_x=0000000&zoom_y=0000000&gov=&_DT=RSW:RDRPPIQCD";
			$("#radar_img").attr("src", url);

			return;
		}
		//날짜 호출
		function getDateString(minute) {

			minute = minute || 5;

			var currDay = new Date();
			// 현재시간에서 5분전으로 10분단위로 처리
			var currMinus5m = new Date(currDay.getFullYear(), currDay.getMonth(), currDay.getDate(), currDay.getHours(), Math.floor((currDay.getMinutes() - minute) / 10) * 10, 0);

			yy = currMinus5m.getFullYear();
			mm = currMinus5m.getMonth();
			dd = currMinus5m.getDate();
			hh = currMinus5m.getHours();
			mi = currMinus5m.getMinutes();

			// 두자리로 통일
			var yyStr = '' + yy;
			var mmStr = ((mm + 1) < 10) ? '0' + (mm + 1) : '' + (mm + 1);
			var ddStr = (dd < 10) ? '0' + dd : '' + dd;
			var hhStr = (hh < 10) ? '0' + hh : '' + hh;
			var miStr = (mi < 10) ? '0' + mi : '' + mi;

			return yyStr + mmStr + ddStr + hhStr + miStr;
		}
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
                <form>                        
                    <label for=""><span class="label_tit">날짜지정</span></label>
                    <input type="text" id="datetimepicker1" class="form-control select_date" placeholder="시작일" readonly>                               
                    <span class="typhen">-</span>
                    <input type="text" id="datetimepicker2" class="form-control select_date" placeholder="종료일" readonly>      
                    <button type="button" class="btn_search" id="btn_search">조회</button>
                    <button type="button" class="btn_excel" id="btn_excel">엑셀</button>
                </form>                  
            </div>
            <hr>       
            <!-- sub_menu -->
            <div class="sub_menu">
                <ul>
                    <li><a href="<c:url value='/drought/rain'/>" class="on">누적강수현황</a></li>
                    <li><a href="<c:url value='/drought/waterRate'/>">평년대비저수율</a></li>
                    <li><a href="">수질</a></li>
                    <li><a href="">염도</a></li>
                    <li><a href="">담수호</a></li>
                    <li><a href="">ADMS가뭄분석</a></li>
                </ul>
            </div>
            <hr>
            <!-- 범례 -->
            <div class="legend_box">
                <h5>평년대비 강수율(%)</h5>
                <ul class="legend__type1">
                    <li><span class="step_point2 bgcolor_step1"><em class="hidden">관심</em></span>65초과</li>
                    <li><span class="step_point2 bgcolor_step2"><em class="hidden">주의</em></span>55초과 ~ 65 이하</li>
                    <li><span class="step_point2 bgcolor_step3"><em class="hidden">경계</em></span>45초과 ~ 55 이하</li>
                    <li><span class="step_point2 bgcolor_step4"><em class="hidden">심각</em></span>45이하</li>
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
            <div class="current__time" id= "current__time">
                <p class="date" id = "cur_date"></p>
                <p class="time" id = "cur_time"></p>
            </div>     
            <dl class="current__status">
                <dt id = "real_status" >홍수단계</dt>
                <dd><span class="step1" id = "real_status_step" >관심</span></dd> <!-- step1 - step4 단계별 클래스적용 -->
            </dl>  
        </div>
        <hr>
        <!-- 검색바 -->
        <div class="search_container">
            <input type="text" id = "searchTxt" placeholder="위치를 검색하세요">
            <button type="button" id = "searchLocation" onclick="searchLocation()" ><i class="fa fa-search"></i></button>
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
        <div  id="radar" class="rader_wrap">
            <img id="radar_img" src=""  alt="레이더 HSR" class="w-full radar-img shadow-xl opacity-90 mt-5">
            <div class="pannel_bg">
              <div class="live_datetime" id="live_datetime" > </div> 
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
                <img src="<c:url value='/resources/sass/images/common/graph.png'/>" alt="그래프 오류">
            </div>
        </div>
    </section>
</div>
    
</body>
</html>