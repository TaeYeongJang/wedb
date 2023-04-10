<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<!DOCTYPE html>
<html lang="ko">
<head>

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="utf-8">
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  	
    <title>DIMAS 재난안전종합상황실</title>
    
    <%@include file="/WEB-INF/views/tile/default/PageScript.jsp"%>
	<%@include file="/resources/wrms/inc/jsgrid.inc"%>
    
  <%--   <link href="<c:url value='/resources/wrms/image/favicon.png'/>" rel="shortcut icon" type="image/x-icon">  --%>
	<link rel="stylesheet" href="<c:url value='/resources/sass/css/main.css?v=01'/>" /> 
    <!-- icon- font awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css" integrity="sha512-SzlrxWUlpfuzQ+pcUCosxcglQRNAq/DZjVsC0lE40xsADsfeQoEypE+enwcOiGjk/bSuGGKHEyjSoQ1zVisanQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />

	<!-- 내위치 찾기 -->
	<script src="https://cdn.jsdelivr.net/npm/leaflet.locatecontrol@0.74.0/dist/L.Control.Locate.min.js" charset="utf-8"></script>

	<script src="${contextPath}/resources/wrms/js/searchForm.js"></script>
	
	
	<!-- 추가항목 -->
	 <!-- css  -->
	 <link rel="stylesheet" href="${contextPath}/resources/external/leaflet/leaflet.css" />

    <!-- markercluster  -->
    <link rel="stylesheet" href="${contextPath}/resources/external/leaflet/MarkerCluster.css" />
    <link rel="stylesheet" href="${contextPath}/resources/external/leaflet/MarkerCluster.Default.css" />

	 <!-- markercluster  -->
	 <script src="${contextPath}/resources/external/leaflet/leaflet.markercluster.js"></script>
	 <!-- data -->
	<script src="${contextPath}/resources/external/leaflet/data/data.js" /></script>

	
    <style>
         #windy {
             width: 100%;
             height: 900px;
         }
         
         #windy #bottom {
		   	width: 1015px;
   			left: 440px;
		}
		
		.select_date {
		   	color: #706868;
		}
		
		.coordinate {
            position: absolute;
            bottom: 10px;
            right: 50%;
        }

/*         .leaflet-popup-content-wrapper {
            background-color: #000000;
            color: #fff;
            border: 1px solid red;
            border-radius: 0px;
        } */
        
		#windy #map-container .leaflet-control-container {
		    display: block;
		}
		
		 .leaflet-top {
		    left: 1000px;
   			top: 60px;
		}
		
.my-icon {
  background-color: red;
  border-radius: 50%;
  opacity: 0.7;
  transition: all 0.2s ease-out;
}

.my-icon:hover {
  opacity: 1;
  transform: scale(1.2);
}
위 CSS 코드에서는 아이콘의 배경색을 빨간색으로 지정하고, 모양을 둥근 원형으로 만들기 위해 border-radius 속성을 사용합니다. 또한 opacity 속성을 사용하여 아이콘의 투명도를 조절하고, transition 속성을 사용하여 호버 이펙트를 부드럽게 만듭니다. 마지막으로 :hover 선택자를 사용하여 마우스 오버 시 아이콘의 스타일을 변경합니다. 이렇게 하면 사용자가 마우스를 오버하면 아이콘의 크기가 약간 커지고, 불투명도가 증가하여 눈에 더 잘 띄게 됩니다.



.my-div-icon {
		    opacity: 1;
  transform: scale(1.2);
		  }




     </style>
         
	 <div id="windy"></div>

    <script src="https://api4.windy.com/assets/libBoot.js"></script>
    <script>
      windyInit({
        key: "iFsNmn4OAAxQjl0PKyVylkGjF6jxxYvN",
        libPath: "https://api4.windy.com/assets/lib/",
      }, (windyAPI) => {
        const { map } = windyAPI;

        L.tileLayer("https://api.vworld.kr/req/wmts/1.0.0/20C97F2F-C9B6-3EB8-ACF6-826DAEB1FC39/Base/{z}/{y}/{x}.png", {
          tileSize: 256,
          layerId: "Base",
          maxZoom: 18,
          attribution:
            '&copy; <a href="http://www.vworld.kr/">VWorld</a>, &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors',
        }).addTo(map);

        const marker = L.marker([37.5665, 126.9780]).addTo(map);
        marker.bindPopup("서울");

        map.setView([37.5665, 126.9780], 12);
      });
      </script>
      </body>
</html>