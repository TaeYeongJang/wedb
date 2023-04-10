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
   
   
    <!-- css  -->
  	 <link rel="stylesheet" href="${contextPath}/resources/external/leaflet/leaflet.css" />

    <!-- markercluster  -->
    <link rel="stylesheet" href="${contextPath}/resources/external/leaflet/MarkerCluster.css" />
    <link rel="stylesheet" href="${contextPath}/resources/external/leaflet/MarkerCluster.Default.css" />

	 <!-- markercluster  -->
	 <script src="${contextPath}/resources/external/leaflet/leaflet.markercluster.js"></script>
	 <!-- data -->
	<script src="${contextPath}/resources/external/leaflet/data/data.js" /></script>
 

<script src="https://cdn.jsdelivr.net/npm/leaflet.locatecontrol@0.74.0/dist/L.Control.Locate.min.js" charset="utf-8"></script>

    <title>Leaflet markercluster | GeoDev</title>
    <style>
      body {
        margin: 0px;
        padding: 0%;
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


<script>

  const map = L.map("map").setView([28.2521, 83.9774], 18);
  const osm = L.tileLayer(
    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
    {
      maxZoom: 19,
      attribution:
        '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
    }
  ).addTo(map);

  const geojsonMarkerOptions = {
    radius: 8,
    fillColor: "#ff7800",
    color: "#000",
    weight: 1,
    opacity: 1,
    fillOpacity: 0.8,
  };

  // loading geojson
  const lightData = L.geoJSON(data, {
    onEachFeature: function (feature, layer) {

           const popupContent =
          '<h4 class = "text-primary">Street Light</h4>' +
          '<div class="container"><table class="table table-striped">' +
          "<thead><tr><th>Properties</th><th>Value</th></tr></thead>" +
          "<tbody><tr><td> Name </td><td>" +
          feature.properties.Name +
          "</td></tr>" +
          "<tr><td>Elevation </td><td>" +
          feature.properties.ele +
          "</td></tr>" +
          "<tr><td> Power (watt) </td><td>" +
          feature.properties.Power_Watt +
          "</td></tr>" +
          "<tr><td> Pole Height </td><td>" +
          feature.properties.pole_hgt +
          "</td></tr>" +
          "<tr><td> Time </td><td>" +
          feature.properties.time +
          "</td></tr>";
          
          layer.bindPopup(popupContent);

    },
    pointToLayer: function (feature, latlng) {
      return L.circleMarker(latlng, geojsonMarkerOptions);
    },
  });
  
  const markers = L.markerClusterGroup().addLayer(lightData);

  // marker clustering
  map.addLayer(markers);
  
  L.control.locate().addTo(map);
  
  
  
</script>