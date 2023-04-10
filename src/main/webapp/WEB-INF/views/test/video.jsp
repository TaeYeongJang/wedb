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
	 
	 
	  <script src="https://unpkg.com/leaflet-label/dist/leaflet.label.js"></script>
	  <link rel="stylesheet" href="https://unpkg.com/leaflet-label/dist/leaflet.label.css" />


 

    <title>Leaflet markercluster | GeoDev</title>
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


<script>

	// Map initialization 
	var map = L.map('map').setView([28.2096, 83.9856], 13);
	
	//osm layer
	var osm = L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
	    attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
	});
	osm.addTo(map);
	
	//Marker add
	var marker = L.marker([28.2096, 83.9856])

	
	marker.bindLabel('Seoul').showLabel();

  
  
  
</script>