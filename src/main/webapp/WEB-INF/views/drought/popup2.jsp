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

mapPagePopulate:function(){

    var self=this;
    self.show_loader("Loading map data...");

    //set initial zoom depending on device
    var initZoom = 7;
    if(self.deviceIsMobile()){ initZoom = 6; }

    //init map with centre around Nottingham
    var map = L.map('map_canvas').setView([52.946104,-1.170044], initZoom);
  
    //add copyright - v important!
    L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: 'Map data © OpenStreetMap contributors',
        maxZoom: 18,
        minZoom: 6
    }).addTo(map);


    //get park data from local storage
        var parkListLite = $.parseJSON(window.localStorage.getItem(self.localStorageKeys.parkListLite));
       
       //declare empty arrays
        var locations = [];
        var markers = [];

        //get label positiong (t,r,b,l)
        var labelPositions = self.settings.mapLabelPositions();

        //loop through park data, create location object with everything we need,
        //and push it to locations array
        $(parkListLite).each(function(i, obj){ 
            var location = [];

            //popup html
            var calloutMarkup = String.format('{0}'+'{1}'+ 'From {4}',
            obj['ParkName'],
            obj['MapCopy'],
            obj['EPiServerPageId'],
            self.endpoints.img_url + obj['MapThumbnail'],
            self.utils.makePriceFriendly(obj['CheapestPrice'],"£")
            
            );

            var wrapper = document.createElement("div");
            wrapper.innerHTML = calloutMarkup;
            wrapper.className="mapCallout";


            location[0] = obj['ParkName'];
            location[1] = obj['Latitude'];
            location[2] = obj['Longitude'];
            location[3] = wrapper;
            location[4] = labelPositions[obj['ParkName']];
            location[5] = ''+ obj['ParkName'] +'';
            locations.push(location);
        });

    //create icons
    var mapMarkerSmall, mapMarkerLarge, iconAnchor;

    
    $(locations).each(function(i, loc){

        //label anchor influences where the popup appears
        //here we check if we want top, left, right or bottom
        //and specify the anchor and css accordingly
        switch(loc[4])
        {
        case 't':
          labelAnchor= [-128,-63];
          labelClass = "mapLabel top";
          break;
        case 'r':
          labelAnchor= [-263,-24];
          labelClass = "mapLabel right";
          break;
        case 'b':
          labelAnchor= [-128,25];
          labelClass = "mapLabel bottom";
          break;
        case 'l':
          labelAnchor= [0,-24];
          labelClass = "mapLabel left";
          break;
        default:
          labelAnchor= [0,-24];
          labelClass = "mapLabel left";
        }

        //create the large and small icon for each park, with the anchor specified above
        mapMarkerSmall = L.icon({
            iconUrl: 'img/mapParkMarker.png',
            iconRetinaUrl: 'img/mapParkMarker.png',
            iconSize: [20, 20],
            iconAnchor: [10,10],
            popupAnchor: [0,-20],
            labelAnchor: labelAnchor
        });

        mapMarkerLarge = L.icon({
            iconUrl: 'img/mapMarkerLarge.png',
            iconRetinaUrl: 'img/mapMarkerLarge.png',
            iconSize: [130, 130],
            iconAnchor: [65,65],
            popupAnchor: [0,-20],
            labelAnchor: labelAnchor
        });

        //add marker to map with label
        var marker = L.marker([loc[1], loc[2]], {icon: mapMarkerSmall}).bindLabel(loc[5], {noHide: true,direction: 'left',className:labelClass}).addTo(map);

        //bind popup to marker
        marker.bindPopup(loc[3]);

        //we can assign arbitrary properties to marker. here we assign small and large markers
        marker.iconSmall = mapMarkerSmall;
        marker.iconLarge = mapMarkerLarge;

        //hide labels on initial load
        map.removeLayer(marker.label);

        //push marker to marker array
        markers.push(marker);

    });

    //for some zooms we need to show/hide labels or switch out markers for larger/smaller
    map.on('zoomend', function(event) {
        var zoom = map.getZoom();
        var markerLabelClass;

        for (i = 0; i < locations.length; i++) {
            markerLabelClass = markers[i].labelClass;
            if(zoom <= 10){
                 markers[i].setIcon(markers[i].iconSmall);
                 map.removeLayer(markers[i].label);
            }else{
                 markers[i].setIcon(markers[i].iconLarge);
                 map.addLayer(markers[i].label);
            }
        }

    });

    //capture popup open event and run JQM create so it creates the button widget
    //also assign click event to park view button
    map.on('popupopen', function(e) {
        $('#map_canvas').trigger('create');
        $('.parkButton').unbind();
        $('.parkButton').on('click',function(){
                self.setLocalStorage(self.localStorageKeys.lastRequestedParkId,$(this).data('parkPageId'));
                self.utils.notify('Not yet implemented','OK');
                //$.mobile.changePage('#parkoverview');
            }); 

    });

    self.hide_loader();
}

  
  
  
</script>