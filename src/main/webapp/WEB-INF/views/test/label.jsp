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
		
		
	/* 	
		var cloudmadeUrl = 'http://{s}.tile.cloudmade.com/BC9A493B41014CAABB98F0471D759707/997/256/{z}/{x}/{y}.png',
			cloudmadeAttribution = 'Map data &copy; 2011 OpenStreetMap contributors, Imagery &copy; 2011 CloudMade',
			cloudmade = new L.TileLayer(cloudmadeUrl, {maxZoom: 18, attribution: cloudmadeAttribution}),
			latlng = new L.LatLng(50.5, 30.51);

		var map = new L.Map('map', {center: latlng, zoom: 15, layers: [cloudmade]}); */
		
		var markers = new L.FeatureGroup();

		var SweetIcon = L.Icon.Label.extend({
			options: {
				iconUrl: '${contextPath}/resources/external/leaflet/images/marker-icon.png',
				shadowUrl: null,
				iconSize: new L.Point(24, 24),
				iconAnchor: new L.Point(0, 1),
				labelAnchor: new L.Point(26, 0),
				wrapperAnchor: new L.Point(12, 13),
				labelClassName: 'sweet-deal-label'
			}
		});

		function populate() {
			for (var i = 0; i < 10; i++) {
				markers.addLayer(
					new L.Marker(
						getRandomLatLng(map),
						{ icon: new SweetIcon({ labelText: "Love it!" }) }
					)
				);
			}
			return false;
		}
		
		

		markers.bindPopup("<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio. Quisque volutpat mattis eros. Nullam malesuada erat ut turpis. Suspendisse urna nibh, viverra non, semper suscipit, posuere a, pede.</p><p>Donec nec justo eget felis facilisis fermentum. Aliquam porttitor mauris sit amet orci. Aenean dignissim pellentesque.</p>");

		map.addLayer(markers);

		   
		   //const marker1 = L.marker([37.97396, 124.71241]).addTo(map);
		   const marker1 = L.marker([13882921.97680196, 4575747.887029074]).addTo(map);

		populate();
		L.DomUtil.get('populate').onclick = populate;
	</script>
</body>
</html>