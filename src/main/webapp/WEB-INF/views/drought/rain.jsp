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
	
	<link rel="stylesheet" href="<c:url value='/resources/sass/css/main.css?v=1.01'/>" /> 
    <!-- icon- font awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css" integrity="sha512-SzlrxWUlpfuzQ+pcUCosxcglQRNAq/DZjVsC0lE40xsADsfeQoEypE+enwcOiGjk/bSuGGKHEyjSoQ1zVisanQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
     
	<script type="text/javascript">
		var lineJson = { "type": "FeatureCollection", "features": [{ "type": "Feature", "properties": {}, "geometry": { "type": "LineString", "coordinates": [[82.5732421875, 29.233683670282787], [84.4573974609375, 28.401064827220896], [82.4139404296875, 28.28019589809702]] } }] }
		var pointJson = { "type": "FeatureCollection", "features": [{ "type": "Feature", "properties": {}, "geometry": { "type": "Point", "coordinates": [80.92529296875, 29.209713225868185] } }, { "type": "Feature", "properties": {}, "geometry": { "type": "Point", "coordinates": [82.15576171875, 29.554345125748267] } }, { "type": "Feature", "properties": {}, "geometry": { "type": "Point", "coordinates": [82.210693359375, 28.748396571187406] } }, { "type": "Feature", "properties": {}, "geometry": { "type": "Point", "coordinates": [83.64990234375, 28.468691297348148] } }, { "type": "Feature", "properties": {}, "geometry": { "type": "Point", "coordinates": [85.53955078125, 27.488781168937997] } }, { "type": "Feature", "properties": {}, "geometry": { "type": "Point", "coordinates": [87.20947265625, 27.235094607795503] } }] }
		var polygonJson = { "type": "FeatureCollection", "features": [{ "type": "Feature", "properties": { "stroke": "#555555", "stroke-width": 2, "stroke-opacity": 1, "fill": "#555555", "fill-opacity": 0.5, "name": "rectangle" }, "geometry": { "type": "Polygon", "coordinates": [[[81.7987060546875, 28.86872905602898], [82.21618652343749, 28.86872905602898], [82.21618652343749, 29.176145182559758], [81.7987060546875, 29.176145182559758], [81.7987060546875, 28.86872905602898]]] } }, { "type": "Feature", "properties": { "stroke": "#555555", "stroke-width": 2, "stroke-opacity": 1, "fill": "#555555", "fill-opacity": 0.5, "name": "polygon" }, "geometry": { "type": "Polygon", "coordinates": [[[82.8973388671875, 28.753212537990336], [82.8094482421875, 28.51696944040106], [83.07861328125, 28.101057958669447], [83.86962890625, 28.41555985166584], [83.4686279296875, 28.99372720461893], [82.8973388671875, 28.753212537990336]]] } }] }

		var searchConditionObj = {
				s_kind_time : 'minute'
			,	uBcd		: '${details.level_buseo_code}'
			,	uBlvl		: Number('${details.buseo_level}')
			,	uBorg		: '${details.orgin_buseo_code}'
	   		,	db_type		: 'rims'
	    };
	    
	    var betweenDate = {
	    		minute		: {key: 'D', view: 30, max: 14}
			,	daily		: {key: 'D', view: 30, max: 31}
			,	chkChange	: 'B'
			,	chkStat		: true
	    };
	    
	    var sqlMapper = "rawris.krc.rawris.";
	    
		$(document).ready(function() { 
			/* =============== 메인패널 ================ */
	        setBetweenDateTime();    
			searchData();
	   		$("#btn_search").click(function () {
				 searchData();
	   		});
	   		
	   		$("#common_pop").css('display','none');
		});
		
		function searchConditionValidate(){return  true}

		 
		 function getDate(type) {

	        if(type == 'from') {
	            return $('#datetimepicker1').val().replace(/-/g, '')
	        }else if(type == 'to') {
	            return $('#datetimepicker2').val().replace(/-/g, '')
	        }
	    }
		// 조회 버튼
		function searchData() {
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
				});
				
				$(".leaflet-left").css('left','1000px');
				$(".leaflet-left").css('top','60px');		
			};
			
			param.failFn	= function (){
				console.log("error");
			};

			ajaxPost(param);

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
	</script>
</head>
<body>
    <!-- header -->
    <%@include file="/WEB-INF/views/tile/default/PageHeader.jsp"%>
    <hr>
    <div id="dashboard_wrap">
    <!-- container -->
    <section id="main_container">
        <!-- map -->
        <!-- map -->
        <div id="windy"></div>
        <div class="inner_map">
            <!-- 지도상단검색바 -->
            <%@include file="/WEB-INF/views/common/searchBox.jsp"%>
            <hr>       
            <!-- sub_menu -->
            <%@include file="/WEB-INF/views/tile/default/SubMenu.jsp"%>
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
    	<!-- 현재시간,단계 / 날씨정보 -->
    	<%@include file="/WEB-INF/views/common/PageLeftTop.jsp"%>
        <hr>
        <!-- 실시간레이더 / 기상특보 알리미 -->
        <%@include file="/WEB-INF/views/common/PageLeftBottom.jsp"%>
    </section>
    <hr>
    <section id="rnb">
        <!-- 전국평균강수량 -->
        <%@include file="/WEB-INF/views/common/PageRightTop.jsp"%>
        <hr> 
        <%@include file="/WEB-INF/views/common/PageRightBottom.jsp"%>
    </section>
</div>
    
</body>
</html>