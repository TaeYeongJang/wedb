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
   
   
  <link
      rel="stylesheet"
      href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css"
    />

<!-- leaflet js link  -->
<script src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js"></script>

<!-- leaflet geojson vt  -->
<script src="https://unpkg.com/geojson-vt@3.2.0/geojson-vt.js"></script>
<script src="leaflet-geojson-vt.js"></script>
 

<script src="https://cdn.jsdelivr.net/npm/leaflet.locatecontrol@0.74.0/dist/L.Control.Locate.min.js" charset="utf-8"></script>

<!-- citylots data  -->
<script src="./data/citylots.js"></script>

    <title>geojson vector tile</title>
    <style>
      body {
        margin: 0;
        padding: 0;
      }
      #map {
        width: 100%;
        height: 100vh;
      }
    </style>
  </head>
  <body>
    <div id="map"></div>
  </body>
</html>

<!-- citylots data  -->
<script src="${contextPath}/resources/external/leaflet/data/citylots.js" /></script>

<script>

	var map = L.map("map").setView([37.75660, -122.434], 13);
	
	var osm = L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
	  maxZoom: 19,
	  attribution:
	    '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
	});
	
	osm.addTo(map);
	
	var options = {
	maxZoom: 20,
	tolerance: 3,
	debug: 0,
	style: {
	  fillColor: "#1EB300",
	  color: "#F2FF00",
	},
	};
	var vtLayer = L.geoJson.vt(data, options).addTo(map);

</script>