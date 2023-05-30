<%@ page contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=42f1ea5a15dedbb02d5997fa3f37bee5&libraries=services"></script>
<script type="text/javascript">

$(document).ready(function(){ 		
	displayTime();
	setWeatherDate();
	setRealStatus();	
	getLocationWeather();
	
	setInterval(function () {
		displayTime();
	}, 1000);
	
	setInterval(function () {
		getLocationWeather();
	}, 1000 * 60 * 10);
});

var days = ['일', '월', '화', '수', '목', '금', '토'];

var today 			= new Date();
var year 			= today.getFullYear();
var month 			= ('0' + (today.getMonth() + 1)).slice(-2);
var date			= ('0' + today.getDate()).slice(-2);
var dayOfWeek		= days[today.getDay()];

var hours 			= ('0' + today.getHours()).slice(-2);
var minutes 		= ('0' + today.getMinutes()).slice(-2);
var seconds 		= ('0' + today.getSeconds()).slice(-2);

var tommorow		= new Date(today.setDate(today.getDate() + 1));
var tomm_year 		= tommorow.getFullYear();
var tomm_month 		= ('0' + (tommorow.getMonth() + 1)).slice(-2);
var tomm_date		= ('0' + tommorow.getDate()).slice(-2);
var tomm_dayOfWeek	= days[tommorow.getDay()];

var today2 			= new Date();
var yesterday		= new Date(today2.setDate(today2.getDate() - 1));
var yest_year 		= yesterday.getFullYear();
var yest_month 		= ('0' + (yesterday.getMonth() + 1)).slice(-2);
var yest_date		= ('0' + yesterday.getDate()).slice(-2);

var before_yesterday= new Date(today2.setDate(today2.getDate() - 1));
var bf_yest_year 	= before_yesterday.getFullYear();
var bf_yest_month 	= ('0' + (before_yesterday.getMonth() + 1)).slice(-2);
var bf_yest_date	= ('0' + before_yesterday.getDate()).slice(-2);

//시계
function displayTime() {
	var today 		= new Date();
	var year 		= today.getFullYear();
	var month 		= ('0' + (today.getMonth() + 1)).slice(-2);
	var date		= ('0' + today.getDate()).slice(-2);
	var dayOfWeek	= days[today.getDay()];

	var hours 		= ('0' + today.getHours()).slice(-2);
	var minutes 	= ('0' + today.getMinutes()).slice(-2);
	var seconds 	= ('0' + today.getSeconds()).slice(-2);
	
	var dateString	= year + '년 ' + month + '월 ' + date + '일 ' + dayOfWeek + '요일';
	var time 		= hours + ':' + minutes + ':' + seconds;
	$('#cur_date').html(dateString);
	$('#cur_time').html(time);	
}

//날씨정보 - 날짜
function setWeatherDate() {	
	var today_date_txt	= Number(month) + '.' + Number(date);
	var tomm_date_txt	= Number(tomm_month) + '.' + Number(tomm_date);
	
	$('#today_day').html(dayOfWeek);
	$('#today_date').html(today_date_txt);
	$('#tomm_day').html(tomm_dayOfWeek);
	$('#tomm_date').html(tomm_date_txt);
}

//재해단계 
function setRealStatus() {
	var menu_class = $("#current_menu_class").val(); 
	//var user_id    = '${user_id}';
	var user_id    = "test10";

    if(menu_class == "FLOOD" || menu_class == "TYPHOON") 
		$('#real_status').text("홍수단계");
	else if(menu_class == "DROUGHT")
		$('#real_status').text("가뭄단계");
	else
		$('#real_status').text("평상");
 	
    var RealStatusInfo = {
 			sql			: "rawris.krc.rawris.get_real_status_info"
 		,	cmd 		: "selectList"
 		,	db_type 	: "rawris"
 		,	user_id 	: user_id
 		,	menu_class	: menu_class
 	};
 	
    var rst = ajaxPost(RealStatusInfo);
    
 	if(!rst) {
 		rawrisShowMsg("장애가 발생했습니다.");
 		return false;
 	} else {
 		var status = rst[0].STATUS;
 		var step;
 		if	   (status == "관심")	step = "step1";
 		else if(status == "주의")	step = "step2";
 		else if(status == "경계")	step = "step3";
 		else					step = "step4";
 		
 		$('#real_status_step').text(status);
 		$('#real_status_step').attr("class", step);
 		return true;
 	}	
}

function getLocationWeather() {
	//HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
	if(navigator.geolocation) {    
    	// GeoLocation을 이용해서 접속 위치를 얻어옵니다
    	navigator.geolocation.getCurrentPosition(function(position) {
        
	        var lat = position.coords.latitude, // 위도
	            lon = position.coords.longitude; // 경도
	        
	        // 주소-좌표 변환 객체를 생성합니다
	        var geocoder = new kakao.maps.services.Geocoder();	
	        
     		// 좌표로 법정동 상세 주소 정보를 요청합니다 (좌표->주소->예보코드->API호출) : 오늘,내일 하늘상태,강수확률
        	geocoder.coord2Address(lon, lat, callbackLocationWeather);
     		
        	var [nx, ny] = parseNxNy(lat, lon);
    		
    		getUltraSrtNcst(nx, ny);	// 현재 기온		
    		getUltraSrtFcst(nx, ny);	// 현재 하늘상태
    		getVilageFcst(nx, ny);		// 오늘,내일 최고,최저 기온 
		});
	} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
		console.log("geolocation을 사용할수 없어요.");	    
	}
}

// 위도,경도 -> 주소 변환 후 기상청 예보구역 정보 조회 -> 기상청 동네예보 api 호출
function callbackLocationWeather(result, status) {
    if(status === kakao.maps.services.Status.OK) {
    	//console.log("result : ", result);
    	
    	var addr1 = result[0].address.region_1depth_name;
    	var addr2 = result[0].address.region_2depth_name;
    	var full_addr;
    	if(addr2.slice(-1) == "시" || addr2.slice(-1) == "군")	full_addr = addr1 + " " + addr2;
    	else													full_addr = addr1;
    	
    	var addrInfo = {
     			sql			: "rawris.krc.rawris.get_addr_info"
     		,	cmd 		: "selectList"
     		, 	db_type 	: "rawris"
     		, 	full_addr	: full_addr
     	};
     	
        var rst = ajaxPost(addrInfo);
        
     	if(!rst) {
     		rawrisShowMsg("장애가 발생했습니다.");
     		return false;
     	} else {
     		var addr_code = rst[0].ADDR_CODE;
     		// 주소로 기상청 예보구역 조회 후 동네예보 api 호출
     		getLandFcst(addr_code);
     	}
    }
}

// 기상청 동네예보 통보문 - [육상예보조회] - 오늘,내일 하늘상태,강수확률
function getLandFcst(addr_code) {
	var apiUrl 		= 'http://apis.data.go.kr/1360000/VilageFcstMsgService/getLandFcst';
	var serviceKey 	= 'fiBoNuw95UN1HIsqqvzzIUg1VahPqGu/JPwwbqm+2fJcB998R7oG9+jcnQlOZMbvthNF4KTIXd+zmv2MjanAHA=='; // 발급받은 인증키를 입력합니다.
	var regId 		= addr_code; // 예보구역코드
	var base_time	= hours; 

	// API 요청을 위한 파라미터 설정
	var params = {
			serviceKey	: serviceKey
		,	pageNo		: '1' 		// 페이지 번호
	  	,	numOfRows	: '10' 		// 조회할 데이터의 수
	  	,	dataType	: 'JSON' 	// 응답 데이터 타입
	  	,	regId		: regId 	// 예보구역코드
	};
	
	// API 요청을 보내고 데이터를 받아옵니다.
	// 5시, 11시, 17시에 데이터 들어옴
	$.getJSON(apiUrl, params, function(response) {
	  	// API 요청이 성공한 경우, 응답 데이터를 파싱하여 처리합니다.
	  	var weatherData = response.response.body.items.item;
	  	//console.log(weatherData);
	  	var today_sky_am, today_sky_pm, tomm_sky_am, tomm_sky_pm;		// 하늘상태
	  	var today_rain_am, today_rain_pm, tomm_rain_am, tomm_rain_pm;	// 강수확률
	  	if(base_time < 5) {	// 전날 17시 데이터의 내일, 모레 데이터 사용
	  		today_sky_am = weatherData[1].wfCd;
	  		today_rain_am = weatherData[1].rnSt;
	  		today_sky_pm = weatherData[2].wfCd;
	  		today_rain_pm = weatherData[2].rnSt;
	  		tomm_sky_am = weatherData[3].wfCd;
	  		tomm_rain_am = weatherData[3].rnSt;
	  		tomm_sky_pm = weatherData[4].wfCd;
	  		tomm_rain_pm = weatherData[4].rnSt;
	  	} else if(base_time < 11) {	// 5시 데이터의 오늘, 내일 데이터 사용
	  		today_sky_am = weatherData[0].wfCd;
	  		today_rain_am = weatherData[0].rnSt;
	  		today_sky_pm = weatherData[1].wfCd;
	  		today_rain_pm = weatherData[1].rnSt;
	  		tomm_sky_am = weatherData[2].wfCd;
	  		tomm_rain_am = weatherData[2].rnSt;
	  		tomm_sky_pm = weatherData[3].wfCd;
	  		tomm_rain_pm = weatherData[3].rnSt;	  		
	  	} else if(base_time < 17) {	// 11시 데이터의 오늘오후, 내일 데이터 사용
	  		today_sky_pm = weatherData[0].wfCd;
	  		today_rain_pm = weatherData[0].rnSt;
	  		tomm_sky_am = weatherData[1].wfCd;
	  		tomm_rain_am = weatherData[1].rnSt;
	  		tomm_sky_pm = weatherData[2].wfCd;
	  		tomm_rain_pm = weatherData[2].rnSt;	  		
	  	} else {	// 17시 데이터의 오늘오후, 내일 데이터 사용
	  		today_sky_pm = weatherData[0].wfCd;
	  		today_rain_pm = weatherData[0].rnSt;
	  		tomm_sky_am = weatherData[1].wfCd;
	  		tomm_rain_am = weatherData[1].rnSt;
	  		tomm_sky_pm = weatherData[2].wfCd;
	  		tomm_rain_pm = weatherData[2].rnSt;	  		
	  	}
	  	
	  	// DB01 : 맑음 , DB03 : 구름많음 , DB04 : 흐림
	  	if	   (today_sky_am == "DB01") $("#today_sky_am").addClass("sun");
	  	else if(today_sky_am == "DB03") $("#today_sky_am").addClass("cloud2");
	  	else if(today_sky_am == "DB04") $("#today_sky_am").addClass("cloud");

	  	if	   (today_sky_pm == "DB01")	$("#today_sky_pm").addClass("sun");
	  	else if(today_sky_pm == "DB03")	$("#today_sky_pm").addClass("cloud2");
	  	else if(today_sky_pm == "DB04")	$("#today_sky_pm").addClass("cloud");

	  	if	   (tomm_sky_am == "DB01")	$("#tomm_sky_am").addClass("sun");
	  	else if(tomm_sky_am == "DB03")	$("#tomm_sky_am").addClass("cloud2");
	  	else if(tomm_sky_am == "DB04")	$("#tomm_sky_am").addClass("cloud");
	  	
	  	if	   (tomm_sky_pm == "DB01")	$("#tomm_sky_pm").addClass("sun");
	  	else if(tomm_sky_pm == "DB03")	$("#tomm_sky_pm").addClass("cloud2");
	  	else if(tomm_sky_pm == "DB04")	$("#tomm_sky_pm").addClass("cloud");
		
	  	if(today_rain_am != null)	$("#today_rain_am").html(today_rain_am + "%");
	  	else						$("#today_rain_am").html("-");
	  	
	  	if(today_rain_pm != null)	$("#today_rain_pm").html(today_rain_pm + "%");
	  	else						$("#today_rain_pm").html("-");
	  	
	  	if(tomm_rain_am != null)	$("#tomm_rain_am").html(tomm_rain_am + "%");
	  	else						$("#tomm_rain_am").html("-");
	  	
	  	if(tomm_rain_pm != null)	$("#tomm_rain_pm").html(tomm_rain_pm + "%");
	  	else						$("#tomm_rain_pm").html("-");
	})
	.fail(function(error) {
	  	// API 요청이 실패한 경우, 오류 메시지를 출력합니다.
		console.log(error.responseJSON.error.message);
	});
}

// 기상청 단기예보 - [초단기실황조회] : 현재 기온
function getUltraSrtNcst(nx, ny) {
	var apiUrl 		= 'http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst';
	var serviceKey 	= 'fiBoNuw95UN1HIsqqvzzIUg1VahPqGu/JPwwbqm+2fJcB998R7oG9+jcnQlOZMbvthNF4KTIXd+zmv2MjanAHA=='; // 발급받은 인증키를 입력합니다.
	var base_date	= year + month + date;
	var base_hours	= hours;
	var base_minutes= minutes;
	var base_date2	= yest_year + yest_month + yest_date;
	var base_time2 	= (base_hours + 1) > 23 ? '0000' : (base_hours + 1) + '00';
	
	// 데이터 기준시간 : 매시 00분 (api 제공시간 : 40분 후)
	// 40분 이전에는 이전 시간 조회 (예. 01시00분~01시39분 일때는 00시00분 데이터 조회 / 01시40분~02시39분 일때는 01시00분 데이터 조회)
	if(base_minutes < '40')	{
		base_date	= (base_hours - 1) < 0 ? base_date2 : base_date;
		base_hours	= (base_hours - 1) < 0 ? '23' : ('0' + (base_hours - 1)).slice(-2);
		base_date2	= (base_hours - 1) < 0 ? bf_yest_year + bf_yest_month + bf_yest_date : base_date2;
	}
	var base_time = base_hours + '00';
	
	// API 요청을 위한 파라미터 설정
	var params = {
			serviceKey	: serviceKey
		,	pageNo		: '1' 		// 페이지 번호
	  	,	numOfRows	: '10' 		// 조회할 데이터의 수
	  	,	dataType	: 'JSON' 	// 응답 데이터 타입
	  	,	base_date	: base_date // 조회 시작일
	  	,	base_time	: base_time // 조회 시작시간
	  	,	nx			: nx
	  	,	ny			: ny
	};
	
	// API 요청을 보내고 데이터를 받아옵니다.
	$.getJSON(apiUrl, params, function(response) {
		// API 요청이 성공한 경우, 응답 데이터를 파싱하여 처리합니다.
	  	var weatherData = response.response.body.items.item;
		var now_temp;
		for(var i = 0; i < weatherData.length; i++) {
			var category = weatherData[i].category;
			if(category == 'T1H') now_temp = weatherData[i].obsrValue;	// 현재 기온
	  	}
		now_temp = parseFloat(now_temp).toFixed(1);
		$("#now_temp").html(now_temp);
	})
	.fail(function(error) {
	  	// API 요청이 실패한 경우, 오류 메시지를 출력합니다.
	  	console.log(error.responseJSON.error.message);
	});
}

//기상청 단기예보 - [초단기예보조회] : 현재 하늘상태
function getUltraSrtFcst(nx, ny) {
	var apiUrl 		= 'http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtFcst';
	var serviceKey 	= 'fiBoNuw95UN1HIsqqvzzIUg1VahPqGu/JPwwbqm+2fJcB998R7oG9+jcnQlOZMbvthNF4KTIXd+zmv2MjanAHA=='; // 발급받은 인증키를 입력합니다.
	
	// 매시간 30분에 생성되고 10분마다 최신 정보로 업데이트(직전시간 조회->직전시간에 현재시간 예보한 것을 보여줌)
	// 예. 10시~11시 사이에는 9시30분 조회 -> 10시 예보 보여줌
	var base_date 	= (hours - 1) < 0 ? yest_year + yest_month + yest_date : year + month + date;
	var base_time	= (hours - 1) < 0 ? '2330' : ('0' + (hours - 1)).slice(-2) + '30';
	
	// API 요청을 위한 파라미터 설정
	var params = {
			serviceKey	: serviceKey
		,	pageNo		: '4' 		// 페이지 번호
	  	,	numOfRows	: '6' 		// 조회할 데이터의 수
	  	,	dataType	: 'JSON' 	// 응답 데이터 타입
	  	,	base_date	: base_date // 조회 시작일
	  	,	base_time	: base_time // 조회 시작시간
	  	,	nx			: nx
	  	,	ny			: ny
	};
	
	// API 요청을 보내고 데이터를 받아옵니다.
	$.getJSON(apiUrl, params, function(response) {
		// API 요청이 성공한 경우, 응답 데이터를 파싱하여 처리합니다.
	  	var weatherData = response.response.body.items.item;
		//console.log(weatherData);
		var now_sky = weatherData[0].fcstValue;
		if(now_sky == "1"){
	  		$("#now_sky_txt").html("맑음");
	  		$("#now_sky").addClass("sun");
	  	} else if(now_sky == "3") {
	  		$("#now_sky_txt").html("구름많음");
	  		$("#now_sky").addClass("cloud2");
	  	} else if(now_sky == "4") {
	  		$("#now_sky_txt").html("흐림");
	  		$("#now_sky").addClass("cloud");
	  	}
	})
	.fail(function(error) {
	  	// API 요청이 실패한 경우, 오류 메시지를 출력합니다.
	  	console.log(error.responseJSON.error.message);
	});
}

// 기상청 단기예보 - [단기예보조회] : 오늘,내일 최고,최저 기온
function getVilageFcst(nx, ny) {
	var apiUrl 		= 'http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst';
	var serviceKey	= 'fiBoNuw95UN1HIsqqvzzIUg1VahPqGu/JPwwbqm+2fJcB998R7oG9+jcnQlOZMbvthNF4KTIXd+zmv2MjanAHA=='; // 발급받은 인증키를 입력합니다.
	var base_date = year + month + date;
	var real_time = hours + minutes;
	var base_time, base_time2, base_time3;
	
	// 데이터 기준시간 : 02,05,08,11,14,17,20,23시 (api 제공시간 : 10분 후)
	if(real_time < '0210') {
		// 오늘 - 최저 : 내일 최저 / 최고 : 내일 최고
		// 내일 - 최저 : 모레 최저 / 최고 : 모레 최고
		// 2시에 그날의 첫 데이터가 생성되므로 2시 이전에는 전날 23시 데이터의 내일과 모레 기온 정보를 사용
		base_date = yest_year + yest_month + yest_date;
		base_time = '2300';
	} else if(real_time < '0510') {
		// 2시 데이터에는 오늘, 내일의 최저/최고 기온 데이터 모두 존재
		base_time = '0200';
	} else if(real_time < '0810') {
		// 오늘 최저 기온 데이터만 2시 데이터 사용, 나머지는 5시 데이터 사용
		base_time = '0200';
		base_time2 = '0500';
	} else if(real_time < '1110') {
		// 오늘 최저 기온 데이터만 2시 데이터 사용, 나머지는 8시 데이터 사용
		base_time = '0200';
		base_time2 = '0800';	
	} else if(real_time < '1410') {
		// 오늘 최저 기온 데이터만 2시 데이터 사용, 나머지는 11시 데이터 사용
		base_time = '0200';
		base_time2 = '1100';
	} else if(real_time < '1710') {
		// 오늘 최저 기온 : 2시 데이터 사용, 오늘 최고 기온 : 11시 데이터 사용, 내일은 14시 데이터 사용
		base_time = '0200';
		base_time2 = '1100';
		base_time3 = '1400';
	} else if(real_time < '2010') {
		// 오늘 최저 기온 : 2시 데이터 사용, 오늘 최고 기온 : 11시 데이터 사용, 내일은 17시 데이터 사용
		base_time = '0200';
		base_time2 = '1100';
		base_time3 = '1700';
	} else if(real_time < '2310') {
		// 오늘 최저 기온 : 2시 데이터 사용, 오늘 최고 기온 : 11시 데이터 사용, 내일은 20시 데이터 사용
		base_time = '0200';
		base_time2 = '1100';
		base_time3 = '2000';		
	} else {
		// 오늘 최저 기온 : 2시 데이터 사용, 오늘 최고 기온 : 11시 데이터 사용, 내일은 23시 데이터 사용
		base_time = '0200';
		base_time2 = '1100';
		base_time3 = '2300';		
	}
	
	var today_temp_low, today_temp_high, tomm_temp_low, tomm_temp_high;
	
	if(base_time) {
		// API 요청을 위한 파라미터 설정
		var params = {
				serviceKey	: serviceKey
			,	pageNo		: '1' 		// 페이지 번호
		  	,	numOfRows	: '500' 	// 조회할 데이터의 수
		  	,	dataType	: 'JSON' 	// 응답 데이터 타입
		  	,	base_date	: base_date	// 조회 시작일
		  	,	base_time	: base_time // 조회 시작시간
		  	,	nx			: nx
		  	,	ny			: ny
		};
		
		// API 요청을 보내고 데이터를 받아옵니다.
		$.getJSON(apiUrl, params, function(response) {
			// API 요청이 성공한 경우, 응답 데이터를 파싱하여 처리합니다.
		  	var weatherData = response.response.body.items.item;
			//console.log(weatherData);
			if(real_time < '0210') {
				console.log(weatherData[84], weatherData[193], weatherData[374], weatherData[483]);
				today_temp_low = parseInt(weatherData[84].fcstValue);
				today_temp_high = parseInt(weatherData[193].fcstValue);
				tomm_temp_low = parseInt(weatherData[374].fcstValue);
				tomm_temp_high = parseInt(weatherData[483].fcstValue);
			} else if(real_time < '0510') {
				console.log(weatherData[48], weatherData[157], weatherData[338], weatherData[447]);
				today_temp_low = parseInt(weatherData[48].fcstValue);
				today_temp_high = parseInt(weatherData[157].fcstValue);
				tomm_temp_low = parseInt(weatherData[338].fcstValue);
				tomm_temp_high = parseInt(weatherData[447].fcstValue);
			} else {
				console.log(weatherData[48]);
				today_temp_low = parseInt(weatherData[48].fcstValue);
			}
			$("#today_temp_low").html(today_temp_low);
			$("#today_temp_high").html(today_temp_high);
			$("#tomm_temp_low").html(tomm_temp_low);
			$("#tomm_temp_high").html(tomm_temp_high);
		})
		.fail(function(error) {
		  	// API 요청이 실패한 경우, 오류 메시지를 출력합니다.
		  	console.log(error.responseJSON.error.message);
		});
	}
	
	if(base_time2) {
		// API 요청을 위한 파라미터 설정
		var params = {
				serviceKey	: serviceKey
			,	pageNo		: '1' 			// 페이지 번호
		  	,	numOfRows	: '500' 		// 조회할 데이터의 수
		  	,	dataType	: 'JSON' 		// 응답 데이터 타입
		  	,	base_date	: base_date 	// 조회 시작일
		  	,	base_time	: base_time2	// 조회 시작시간
		  	,	nx			: nx
		  	,	ny			: ny
		};
		
		// API 요청을 보내고 데이터를 받아옵니다.
		$.getJSON(apiUrl, params, function(response) {
			// API 요청이 성공한 경우, 응답 데이터를 파싱하여 처리합니다.
		  	var weatherData = response.response.body.items.item;
			//console.log(weatherData);
			if(real_time < '0810') {
				console.log(weatherData[120], weatherData[301], weatherData[410]);
				today_temp_high = parseInt(weatherData[120].fcstValue);
				tomm_temp_low = parseInt(weatherData[301].fcstValue);
				tomm_temp_high = parseInt(weatherData[410].fcstValue);
			} else if(real_time < '1110') {
				console.log(weatherData[84], weatherData[265], weatherData[374]);
				today_temp_high = parseInt(weatherData[84].fcstValue);
				tomm_temp_low = parseInt(weatherData[265].fcstValue);
				tomm_temp_high = parseInt(weatherData[374].fcstValue);
			} else if(real_time < '1410') {
				console.log(weatherData[48], weatherData[229], weatherData[338]);
				today_temp_high = parseInt(weatherData[48].fcstValue);
				tomm_temp_low = parseInt(weatherData[229].fcstValue);
				tomm_temp_high = parseInt(weatherData[338].fcstValue);
			} else {
				console.log(weatherData[48]);
				today_temp_high = parseInt(weatherData[48].fcstValue);
			} 
			$("#today_temp_high").html(today_temp_high);
			$("#tomm_temp_low").html(tomm_temp_low);
			$("#tomm_temp_high").html(tomm_temp_high);
		})
		.fail(function(error) {
		  	// API 요청이 실패한 경우, 오류 메시지를 출력합니다.
		  	console.log(error.responseJSON.error.message);
		});
	}
	
	if(base_time3) {
		// API 요청을 위한 파라미터 설정
		var params = {
				serviceKey	: serviceKey
			,	pageNo		: '1' 			// 페이지 번호
		  	,	numOfRows	: '500' 		// 조회할 데이터의 수
		  	,	dataType	: 'JSON' 		// 응답 데이터 타입
		  	,	base_date	: base_date		// 조회 시작일
		  	,	base_time	: base_time3	// 조회 시작시간
		  	,	nx			: nx
		  	,	ny			: ny
		};
		
		// API 요청을 보내고 데이터를 받아옵니다.
		$.getJSON(apiUrl, params, function(response) {
			// API 요청이 성공한 경우, 응답 데이터를 파싱하여 처리합니다.
		  	var weatherData = response.response.body.items.item;
			//console.log(weatherData);
			if(real_time < '1710') {
				console.log(weatherData[192], weatherData[301]);
				tomm_temp_low = parseInt(weatherData[192].fcstValue);
				tomm_temp_high = parseInt(weatherData[301].fcstValue);
			} else if(real_time < '2010') {
				console.log(weatherData[156], weatherData[265]);
				tomm_temp_low = parseInt(weatherData[156].fcstValue);
				tomm_temp_high = parseInt(weatherData[265].fcstValue);
			} else if(real_time < '2310') {
				console.log(weatherData[120], weatherData[229]);
				tomm_temp_low = parseInt(weatherData[120].fcstValue);
				tomm_temp_high = parseInt(weatherData[229].fcstValue);
			} else {
				console.log(weatherData[84], weatherData[193]);
				tomm_temp_low = parseInt(weatherData[84].fcstValue);
				today_temp_high = parseInt(weatherData[193].fcstValue);
			} 
			$("#tomm_temp_low").html(tomm_temp_low);
			$("#tomm_temp_high").html(tomm_temp_high);
		})
		.fail(function(error) {
		  	// API 요청이 실패한 경우, 오류 메시지를 출력합니다.
		  	console.log(error.responseJSON.error.message);
		});
	}
}

// 위도, 경도 -> 기상청 좌표 변환
function parseNxNy(lat, lon) {
	var lat = parseFloat(lat);
	var lon = parseFloat(lon);
	
	// 단기예보 지도 정보
	var map = {};
	map.Re = 6371.00877; // 지도반경
	map.grid = 5.0; // 격자간격 (km)
	map.slat1 = 30.0; // 표준위도 1
	map.slat2 = 60.0; // 표준위도 2
	map.olon = 126.0; // 기준점 경도
	map.olat = 38.0; // 기준점 위도
	map.xo = 210/map.grid; // 기준점 X좌표
	map.yo = 675/map.grid; // 기준점 Y좌표
	map.first = 0;
	
	if(map.first == 0) {
		PI = Math.asin(1.0)*2.0;
		DEGRAD = PI/180.0;
		RADDEG = 180.0/PI;

		re = map.Re/map.grid;
		slat1 = map.slat1 * DEGRAD;
		slat2 = map.slat2 * DEGRAD;
		olon = map.olon * DEGRAD;
		olat = map.olat * DEGRAD;

		sn = Math.tan(PI*0.25 + slat2*0.5)/Math.tan(PI*0.25 + slat1*0.5);
		sn = Math.log(Math.cos(slat1)/Math.cos(slat2))/Math.log(sn);
		sf = Math.tan(PI*0.25 + slat1*0.5);
		sf = Math.pow(sf,sn)*Math.cos(slat1)/sn;
		ro = Math.tan(PI*0.25 + olat*0.5);
		ro = re*sf/Math.pow(ro,sn);
		map.first = 1;
	}
	
	ra = Math.tan(PI*0.25+lat*DEGRAD*0.5);
	ra = re*sf/Math.pow(ra,sn);
	theta = lon*DEGRAD - olon;
	if(theta > PI) theta -= 2.0*PI;
	if(theta < -PI) theta += 2.0*PI;
	theta *= sn;
	x = parseFloat(ra*Math.sin(theta)) + map.xo;
	y = parseFloat(ro - ra*Math.cos(theta)) + map.yo;
	
	x = parseInt(x + 1.5);
	y = parseInt(y + 1.5);
	
	return [x, y]
}
</script>

		<!-- 현재시간,단계 -->
        <div class="current">
        	<div class="current__time">
            	<p class="date" id="cur_date"></p>
                <p class="time" id="cur_time"></p>
            </div>     
            <dl class="current__status">
                <dt id="real_status"></dt>
                <dd><span id="real_status_step"></span></dd> <!-- step1 - step4 단계별 클래스적용 -->
            </dl>  
        </div>
        <hr>
        <!-- 날씨정보 -->
        <div class="weather_container">
        	<div class="today">
            	<h3><span class="weather_icons" id="now_sky"></span><span class="temp" id="now_temp"></span><span>°</span></h3>
                <div class="today_weather" id="now_sky_txt"></div>
            </div>
            <!-- day_weather_wrap -->
            <div class="day_weather_wrap">
                <!-- 1 -->
                <div class="day_weather">
                	<dl class="day_weather__date">
                    	<dt class="day" id="today_day"></dt>
                        <dd class="date" id="today_date"></dd>
                        <dd class="temp"><span id="today_temp_low"></span>/<span id="today_temp_high"></span>°</dd>
                    </dl>
                    <dl class="day_weather__time day_am">
                        <dt>오전</dt>
                        <dd><span class="weather_icons" id="today_sky_am"></span></dd>
                        <dd class="percent" id="today_rain_am"></dd>
                    </dl>
                    <dl class="day_weather__time day_pm">
                        <dt>오후</dt>
                        <dd><span class="weather_icons" id="today_sky_pm"></span></dd>
                        <dd class="percent" id="today_rain_pm"></dd>
                    </dl>
                </div>
                <hr>
                <!-- 2 -->
                <div class="day_weather">
                    <dl class="day_weather__date">
                    	<dt class="day" id="tomm_day"></dt>
                        <dd class="date" id="tomm_date"></dd>
                        <dd class="temp" id="tomm_temp"><span id="tomm_temp_low"></span>/<span id="tomm_temp_high"></span>°</dd>
                    </dl>
                    <dl class="day_weather__time day_am">
                        <dt>오전</dt>
                        <dd><span class="weather_icons" id="tomm_sky_am"></span></dd>
                        <dd class="percent" id="tomm_rain_am"></dd>
                    </dl>
                    <dl class="day_weather__time day_pm">
                        <dt>오후</dt>
                        <dd><span class="weather_icons" id="tomm_sky_pm"></span></dd>
                        <dd class="percent" id="tomm_rain_pm"></dd>
                    </dl>
                </div>
                <hr>
			</div>
        </div>
		