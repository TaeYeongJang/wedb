<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no"/>
        <script src="https://unpkg.com/leaflet@1.4.0/dist/leaflet.js"></script>
        <script src="https://api.windy.com/assets/map-forecast/libBoot.js"></script>
       
        <style>
            #windy {
                width: 80%;
                height: 900px;
                ali
            }
        </style>
        <script>
        const renderMap = (): void => {
            const options = {
                key: 'xyz',
                lat: 41.3,
                lon: 2.1,
                zoom: 10,
            };
            // eslint-disable-next-line @typescript-eslint/no-explicit-any
            (window as any).windyInit(options, (windyAPI: any) => {
                const { map } = windyAPI;
                // eslint-disable-next-line @typescript-eslint/no-explicit-any
                (window as any).L.popup()
                    .setLatLng([41.3, 2.1])
                    .setContent(':)')
                    .openOn(map);
            });
        };

	        	
		</script>
	        
    </head>
    <body>
        <div id="windy" ></div>
    </body>
</html>

c