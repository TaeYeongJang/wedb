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

	// Initialize the map
	var map = L.map('map').setView([28.2096, 83.9856], 13);
	
	// Add the OpenStreetMap tiles
	var osm = L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
	    attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
	})
	osm.addTo(map);
	
	// leaflet draw 
	var drawnFeatures = new L.FeatureGroup();
	map.addLayer(drawnFeatures);
	
	var drawControl = new L.Control.Draw({
	    // position: "topright",
	    edit: {
	        featureGroup: drawnFeatures,
	        remove: false
	    },
	    draw: {
		    polygon: {
		     shapeOptions: {
		      color: 'purple'
		     },
		    //  allowIntersection: false,
		    //  drawError: {
		    //   color: 'orange',
		    //   timeout: 1000
		    //  },
		    },
		    polyline: {
		     shapeOptions: {
		      color: 'red'
		     },
		    },
		    rect: {
		     shapeOptions: {
		      color: 'green'
		     },
		    },
		    circle: {
		     shapeOptions: {
		      color: 'steelblue'
		     },
		    },
		   },
	
	});
	map.addControl(drawControl);
	
	map.on("draw:created", function(e){
	    var type = e.layerType;
	    var layer = e.layer;
	    console.log(layer.toGeoJSON())
	
	    layer.bindPopup(`<p>${JSON.stringify(layer.toGeoJSON())}</p>`)
	    drawnFeatures.addLayer(layer);
	});
	
	map.on("draw:edited", function(e){
	    var layers = e.layers;
	    var type = e.layerType;
	
	    layers.eachLayer(function(layer){
	        console.log(layer)
	    })
	    
	})

  
  
  
</script>