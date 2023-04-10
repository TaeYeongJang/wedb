<!DOCTYPE html>
<html>
<head>
	<title>Leaflet debug page</title>

	 <!-- markercluster  -->
	 
	 
	 
	 
	<link rel="stylesheet" href="${contextPath}/resources/external/leaflet/leaflet2.css" />
	<link rel="stylesheet" href="${contextPath}/resources/external/leaflet/leaflet3.css" />

	<style>
		.sweet-deal-label {
			background-color: #FE57A1;
			background-color: rgba(254, 87, 161, 0.66);
			-moz-box-shadow: none;
			-webkit-box-shadow: none;
			box-shadow: none;
			color: #fff;
			font-weight: bold;
		}
	</style>

	<meta name="viewport" content="width=device-width, initial-scale=1.0">

	<script src="${contextPath}/resources/external/leaflet/leaflet.js"></script>
	<script src="${contextPath}/resources/external/leaflet/leaflet2.js"></script>
</head>
<body>

	<div id="map" style="width: 600px; height: 600px; border: 1px solid #ccc"></div>
	<button id="populate">Populate with 10 markers</button>

	<script type="text/javascript">
		function getRandomLatLng(map) {
			var bounds = map.getBounds(),
				southWest = bounds.getSouthWest(),
				northEast = bounds.getNorthEast(),
				lngSpan = northEast.lng - southWest.lng,
				latSpan = northEast.lat - southWest.lat;

			return new L.LatLng(
				southWest.lat + latSpan * Math.random(),
				southWest.lng + lngSpan * Math.random()
			);
		}

		var map = L.map('map').setView([37.390476, 127.492516], 8);
		
		// Add the OpenStreetMap tiles
		var osm = L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
		    attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
		})
		osm.addTo(map);
		
		
		

		// 팝업 객체 생성
		var popup = L.popup({
		    autoClose: false,
		    closeButton: false
		}).setContent("Hello World!");

		// 마커 객체 생성
		var marker = L.marker([37.5665, 126.9780]).addTo(map);

		// 마커에 팝업 연결
		marker.bindPopup(popup);

		// 마커 클릭 이벤트 처리
		marker.on('click', function(e) {
		    marker.openPopup();
		});

	
	</script>
</body>
</html>