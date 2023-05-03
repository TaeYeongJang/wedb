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
   
   
    <!-- leaflet js  -->
	<link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.2/dist/leaflet.css" />
	<script src="https://unpkg.com/leaflet@1.9.2/dist/leaflet.js"></script>
	
	<!-- leaflet draw plugin  -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/leaflet.draw/0.4.2/leaflet.draw.css"/>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/leaflet.draw/0.4.2/leaflet.draw.js"></script>

 

<script src="https://cdn.jsdelivr.net/npm/leaflet.locatecontrol@0.74.0/dist/L.Control.Locate.min.js" charset="utf-8"></script>

    <title>Leaflet markercluster | GeoDev</title>
    <style>
      html, body, #map {
            height: 100vh;
            width: 100%;
            margin: 0;
            padding: 0;
        }
    </style>
  </head>
  <body>
    <div id="map"></div>
  </body>
</html>


<script>


	var map = L.map('map').setView([ 37.7749, -122.4194], 13);
	
	// Add the OpenStreetMap tiles
	var osm = L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
	    attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
	})
	osm.addTo(map);
	

	const markers = [];
	const videos = 
		   [
		     'https://www.youtube.com/embed/jHd1u_lM32c?start=937&autoplay=1" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture',
		     'https://www.youtube.com/embed/jHd1u_lM32c?start=937&autoplay=1" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture',
		     'https://www.youtube.com/embed/jHd1u_lM32c?start=937&autoplay=1" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture'
		   ];
	const latlngs = [
	  [37.7749, -122.4194],
	  [37.7607, -122.4366],
	  [37.7666, -122.4419]
	];

	for (let i = 0; i < videos.length; i++) {
	  const marker = L.marker(latlngs[i]).addTo(map);

	  const popupContent = '<iframe width="200"height="150" src="${videos[i]}" frameborder="0" allowfullscreen  ></iframe>';

	  const popup = L.popup().setContent(popupContent);
	  marker.bindPopup(popup);

	  markers.push(marker);
	}

	markers.forEach(marker => marker.openPopup());
  
  
</script>