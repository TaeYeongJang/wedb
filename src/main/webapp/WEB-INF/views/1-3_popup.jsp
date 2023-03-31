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
    
  <%--   <link href="<c:url value='/resources/wrms/image/favicon.png'/>" rel="shortcut icon" type="image/x-icon">  --%>
	<link rel="stylesheet" href="<c:url value='/resources/sass/css/main.css?v=01'/>" /> 
    <!-- icon- font awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css" integrity="sha512-SzlrxWUlpfuzQ+pcUCosxcglQRNAq/DZjVsC0lE40xsADsfeQoEypE+enwcOiGjk/bSuGGKHEyjSoQ1zVisanQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
	

	<script src="https://unpkg.com/leaflet@1.4.0/dist/leaflet.js"></script>
    <script src="https://api.windy.com/assets/map-forecast/libBoot.js"></script>

   
   
   
    <style>
         #windy {
             width: 100%;
             height: 900px;
         }
         
         #windy #bottom {
		   	width: 1015px;
   			left: 440px;
		}

     </style>
         
	<script type="text/javascript">
		var searchConditionObj 	= {
				s_kind_time : 'minute'
			,	uBcd		: '${details.level_buseo_code}'
			,	uBlvl		: Number('${details.buseo_level}')
			,	uBorg		: '${details.orgin_buseo_code}'
	   		,	db_type		: 'rims'
	    };
	    
	    var betweenDate		= {
	    		minute		: {key: 'D', view: 3,	max: 14		}
			,	daily		: {key: 'D', view: 30, 	max: 31		}
			,	chkChange	: 'B'
			,	chkStat		: true
	    };
	    
	    var sqlMapper = "rawris.krc.rims.";
	    
		$(document).ready(function(){ 
			searchData();
	   		
	   		//$(".progress-line").css("width", "1500px");

		});
		
		function searchConditionValidate(){return  true}
		
		function searchData() {
		  	
			//test rims
			searchConditionObj.sql = sqlMapper + "get_water_rate_date";
			searchConditionObj.base_dt = "20230317";
			searchConditionObj.db_type = "rims"; 
			
			//test rawris
			searchConditionObj.sql = "rawris.krc.rawris.get_sisul";
			searchConditionObj.tab_cd = "tab_2";
			searchConditionObj.db_type = "rawris"; 
			
			//test adms
/* 			searchConditionObj.sql = "rawris.krc.adms.get_adms_chart";
			searchConditionObj.search_term = "S";
			searchConditionObj.type = "G";
			searchConditionObj.target_date = "20230317";
			searchConditionObj.db_type = "adms";  */

			load_data(true);
		} 
		
		function load_data(need_init) {

			var parm = $.extend({}, searchConditionObj);
				
			parm.successFn	= function (data){
				console.log(1, data);
			};
			parm.failFn	= function (){
				console.log("error");
			};

			rawrisAjaxPost(parm);

		}
		
		
		
		function pop_close(){
			$("#common_pop").hide();
		}
		
		function pop_close2(){
			$("#map_popup2").hide();
		}
	
	
		/* 	        const options = {
	    // Required: API key
	    key: 'iFsNmn4OAAxQjl0PKyVylkGjF6jxxYvN', // REPLACE WITH YOUR KEY !!!

	    // Put additional console output
	    verbose: true,

	    // Optional: Initial state of the map
	    lat: 37.390476,
	    lon: 127.492516,
	    zoom: 5,
	};

// Initialize Windy API
windyInit(options, windyAPI => {
    // windyAPI is ready, and contain 'map', 'store',
    // 'picker' and other usefull stuff

    const { map } = windyAPI;
    // .map is instance of Leaflet map

    L.popup()
        .setLatLng([37.390476, 127.492516])
        .setContent('Hello World')
        .openOn(map);
}); */


/* 
const options = {
	    key: 'iFsNmn4OAAxQjl0PKyVylkGjF6jxxYvN', // REPLACE WITH YOUR KEY !!!

	    // Tip: Use verbose true for nice console output
	    // verbose: true
	    lat: 37.390476,
	    lon: 127.492516,
	    zoom: 5,
	};

	windyInit(options, windyAPI => {
	    const { store, broadcast } = windyAPI;
	    // broadcast is main Windy's event emmiter that
	    // let you know what is happening inside

	    // Change overlays programatically
	    const overlays = ['rain', 'wind', 'temp', 'clouds'];
	    let i = 0;

	    setInterval(() => {
	        i = i === 3 ? 0 : i + 1;
	        store.set('overlay', overlays[i]);
	    }, 800);

	    // Observe the most important broadcasts
	    broadcast.on('paramsChanged', params => {
	        console.log('Params changed:', params);
	    });

	    broadcast.on('redrawFinished', params => {
	        console.log('Map was rendered:', params);
	    });

	    const { map } = windyAPI;
	    
	    L.popup()
        .setLatLng([37.390476, 127.492516])
        .setContent('Hello World')
        .openOn(map);
	}); */

/* 	const options = {
		    key: 'iFsNmn4OAAxQjl0PKyVylkGjF6jxxYvN', // REPLACE WITH YOUR KEY !!!

		    // Tip: Use verbose true for nice console output
		    // verbose: true
		};

		windyInit(options, windyAPI => {
		    const { store, broadcast } = windyAPI;
		    // broadcast is main Windy's event emmiter that
		    // let you know what is happening inside

		    // Change overlays programatically
		    const overlays = ['rain', 'wind', 'temp', 'clouds'];
		    let i = 0;

		    setInterval(() => {
		        i = i === 3 ? 0 : i + 1;
		        store.set('overlay', overlays[i]);
		    }, 800);

		    // Observe the most important broadcasts
		    broadcast.on('paramsChanged', params => {
		        console.log('Params changed:', params);
		    });

		    broadcast.on('redrawFinished', params => {
		        console.log('Map was rendered:', params);
		    });
		}); */


		const options = {


			    // Required: API key
        	    key: 'iFsNmn4OAAxQjl0PKyVylkGjF6jxxYvN', // REPLACE WITH YOUR KEY !!!



        	    // Optional: Initial state of the map
        	    lat: 37.390476,
        	    lon: 127.492516,
        	    zoom: 7,
			};

			windyInit(options, windyAPI => {
			    const { picker, utils, broadcast, store } = windyAPI;

			    picker.on('pickerOpened', ({ lat, lon, values, overlay }) => {
			        // -> 48.4, 14.3, [ U,V, ], 'wind'
			        console.log('opened', lat, lon, values, overlay);

			        const windObject = utils.wind2obj(values);
			        console.log(windObject);
			    });

			    picker.on('pickerMoved', ({ lat, lon, values, overlay }) => {
			        // picker was dragged by user to latLon coords
			        console.log('moved', lat, lon, values, overlay);
			    });

			    picker.on('pickerClosed', () => {
			        // picker was closed
			    });

			    store.on('pickerLocation', ({ lat, lon }) => {
			        console.log(lat, lon);

			        const { values, overlay } = picker.getParams();
			        console.log('location changed', lat, lon, values, overlay);
			    });

			    // Wait since wather is rendered
			    broadcast.once('redrawFinished', () => {
			        // Opening of a picker (async)
			        picker.open({ lat: 37.390476, lon: 127.492516 });
			    });
			    
			    const { map } = windyAPI;
			    
			   /*  L.popup()
		        .setLatLng([37.390476, 127.492516])
		        .setContent('Hello World')
		        .openOn(map); */
			    
			   /*  var marker = L.marker([37.390476, 127.492516]).addTo(map);
			    
			    var circle = L.circle([37.390412, 127.492523, -500], {
			        color: 'red',
			        fillColor: '#f03',
			        fillOpacity: 0.5,
			        radius: 1500
			    }).addTo(map);
			    
			     var polygon = L.polygon([
			    	 [37.390476, 127.492544],
			    	 [37.390476, 127.492566],
			    	 [37.390476, 127.492577]
			    ]).addTo(map);
			    
			    var popup = L.popup()
			    .setLatLng([37.390455, 127.492555])
			    .setContent("I am a standalone popup.")
			    .openOn(map);   */
			    
			    var marker = L.marker([37.390476, 127.492516],{alt: 'Kyiv'}).addTo(map).bindPopup('Kyiv, Ukraine is the birthplace of Leaflet!');
			});
			
	</script>
</head>
<body>
    <!-- header -->
    <header id="header">
       <div class="header__wrap">
            <h1><a href=""><img src="<c:url value='/resources/sass/images/common/logo.png'/>" alt="DIMAS 재난안전종합상황실"></a></h1>
            <nav id="nav">
                <ul class="main-menu">
                    <li><a href="" class="on">가뭄</a></li>
                    <li><a href="">홍수</a></li>
                    <li><a href="">태풍/지진</a></li>
                    <li><a href="">평상시</a></li>
                    <li><a href="">사회재난</a></li>
                </ul>
            </nav>
            <div class="sub-menu">
                <ul class="menu">
                    <li><a href="" class="news"><span class="new">1</span><i class="fa-sharp fa-solid fa-bell"><span class="hidden">알람</span></i></a></li>
                    <li><a href="" class="settings"><i class="fa-sharp fa-solid fa-gear"><span class="hidden">설정</span></i></a></li>
                    <li><a href="" class="user"><i class="fa-solid fa-user"></i><span class="hidden">정보수정</span></a></li>                  
                </ul>
                <a href="" class="logout">로그아웃</a>
            </div>
       </div>
    </header> 
    <hr>
    <!-- container -->
    <section id="main_container">
        <!-- map -->
        <div id="windy"></div>
        <span class="hidden">임시로 지도 이미지 넣은 부분</span>       
        <div class="inner_map">
            <!-- 지도상단검색바 -->
            <div class="search_bar_sub">
                <form>                        
                    <label for="" class="label_tit">날짜지정</label>                    
                    <input type="text" name="" placeholder="2022-06-01 00시">                
                    <span class="typhen">-</span>
                    <input type="text" name="" placeholder="2022-06-01 00시">                    
                    <button type="button" class="btn_search">조회</button>
                    <button type="button" class="btn_excel">엑셀</button>
                </form>                  
            </div>
            <hr>       
            <!-- sub_menu -->
            <div class="sub_menu">
                <ul>
                    <li><a href="" class="on">누적강수현황</a></li>
                    <li><a href="">평년대비저수율</a></li>
                    <li><a href="">수질</a></li>
                    <li><a href="">염도</a></li>
                    <li><a href="">담수호</a></li>
                    <li><a href="">ADMS가뭄분석</a></li>
                </ul>
            </div>
            <hr>
            <!-- 플레이바 -->
           <!--  <div class="progress_bar">
                <div class="progress_line">
                    <div class="avbl"></div>
                    <div class="played" style="width:200px">
                        <span class="bar" style="left: 140.441px"></span>
                    </div>
                </div>
                <div class="timecode" title="현지 시각" style="left: 140.441px;">
                    <div class="box">22-06-01 12:00</div>
                </div>
                <div class="play_pause"><i class="fa-solid fa-play"></i></div>           
            </div>   -->      
            <hr>
            <!-- 관심 -->
            <div class="map_popup" style="position:absolute;top:30%;left:50%">
                <h3>흑산도</h3>
                <span class="point popcolor_step1"></span>
                <p class="popcolor_step1">436.2</p>
            </div>
             <!-- 주의 -->
             <div class="map_popup" style="position:absolute;top:35%;left:50%">
                <h3>흑산도</h3>
                <span class="point popcolor_step2"></span>
                <p class="popcolor_step2">436.2</p>
            </div>
            <!-- 경계 -->
              <div class="map_popup" style="position:absolute;top:40%;left:50%">
                <h3>흑산도</h3>
                <span class="point popcolor_step3"></span>
                <p class="popcolor_step3">436.2</p>
            </div>
            <!-- 경고 -->
            <div class="map_popup" style="position:absolute;top:45%;left:50%">
                <h3>흑산도</h3>
                <span class="point popcolor_step4"></span>
                <p class="popcolor_step4">436.2</p>
            </div>
            <hr>
            <!-- 팝업에서 지역 마우스클릭시 -->
            <div class="map_popup2" id="map_popup2" style="position:absolute;bottom:700px;left:10%">
                <a href="javascript:pop_close2()" class="btn_close"><i class="fa-sharp fa-solid fa-xmark"></i></a>
                <div class="map_popup2_title">
                    <h3>고창
                        <span class="color_step1 point_step point_step1">경고</span>
                        <span class="asos">ASOS</span>
                    </h3>
                   
                </div>  
                <ul>
                    <li><span class="tit">누적강수량</span><span class="con">1,549.7mm</span></li>
                    <li><span class="tit">평년강수량</span><span class="con">1,007.8mm</span></li>
                    <li><span class="tit">평년대비</span><span class="con">154%</span></li>
                </ul>
            </div>
            <hr>
            <!-- 범례 -->
            <div class="legend_box">
                <h5>평년대비 저수율(%)</h5>
                <ul class="legend__type1">
                    <li><span class="step_point2 bgcolor_step1"><em class="hidden">관심</em></span>65초과</li>
                    <li><span class="step_point2 bgcolor_step2"><em class="hidden">주의</em></span>55초과 ~ 65 이하</li>
                    <li><span class="step_point2 bgcolor_step3"><em class="hidden">경계</em></span>45초과 ~ 55 이하</li>
                    <li><span class="step_point2 bgcolor_step4"><em class="hidden">심각</em></span>45이하</li>
                </ul>
            </div>
            <hr>  
            <!-- popup -->
            <div class="popup_common" id="common_pop" style="position:absolute;bottom:0%;left:50%;transform:translate(-50%, -70%)">
                <a href="javascript:pop_close()" class="btn_close"><i class="fa-sharp fa-solid fa-xmark"></i></a>
                <!-- pop_con -->
                <div class="pop_con">
                    <div class="pop_con__info">
                        <h4>금계</h4>
                        <div class="info_wrap">
                            <dl>
                                <dt>전일 저수율(%)</dt>
                                <dd>53.1</dd>
                            </dl>
                            <dl>
                                <dt>금일 저수율(%)</dt>
                                <dd>12.4</dd>
                            </dl>
                            <dl>
                                <dt>관할지사</dt>
                                <dd>경북 영주, 봉화</dd>
                            </dl>
                            <dl>
                                <dt>관할지사</dt>
                                <dd>경북 영주, 봉화</dd>
                            </dl>
                        </div>
                        <div class="img"><img src="<c:url value='/resources/sass/images/common/img_sample.png'/>" alt=""></div>
                    </div>
                    <hr>                  
                    <div class="pop_con__list">
                        <div class="tab_type1">
                            <ul>
                                <li><a href="" class="on">수위</a></li>
                                <li><a href="">수질</a></li>
                                <li><a href="">가동</a></li>
                                <li><a href="">변위</a></li>
                                <li><a href="">누수</a></li>
                                <li><a href="">지진</a></li>
                            </ul>
                        </div>	
                        <div class="table_type_pop1">
                            <table>
                                <colgroup>
                                <col width="28%">
                                <col>
                                </colgroup>
                                <tbody><tr>
                                    <th>홍수위 (EL.m)</th>
                                    <td>307.80</td>
                                </tr>
                                <tr>
                                    <th>만수위 (EL.m)</th>
                                    <td>307.80</td>
                                </tr>
                                <tr>
                                    <th>사수위 (EL.m)</th>
                                    <td>307.80</td>
                                </tr>
                                <tr>
                                    <th>총저수량</th>
                                    <td>5,293</td>
                                </tr>
                                <tr>
                                    <th>유효저수량</th>
                                    <td>5,271</td>
                                </tr>
                            </tbody></table>

                            <table>
                                <colgroup>
                                <col width="28%">
                                <col>
                                </colgroup>
                                <tbody><tr>
                                    <th>기준일시</th>
                                    <td>2022-06-20</td>
                                    <td>2022-06-21 11:20</td>
                                </tr>
                                <tr>
                                    <th>저수량</th>
                                    <td>2,799</td>
                                    <td>2,760</td>
                                </tr>
                                <tr>
                                    <th>수위(EL.m)</th>
                                    <td>299.28</td>
                                    <td>299.14</td>
                                </tr>
                            </tbody></table>
                        </div>
                        <hr>  
                    </div>   
                </div>
                <!-- //pop_con -->
            </div>
        </div>
    </section>    
    <hr>
    <!-- lnb -->
    <section id="lnb">
        <!-- 현재시간,단계 -->
        <div class="current">
            <div class="current__time">
                <p class="date">2022년 06월 22일 수요일</p>
                <p class="time">20:03:12</p>
            </div>     
            <dl class="current__status">
                <dt>홍수단계</dt>
                <dd><span class="step1">관심</span></dd> <!-- step1 - step4 단계별 클래스적용 -->
            </dl>  
        </div>
        <hr>
        <!-- 검색바 -->
        <div class="search_container">
            <input type="text" placeholder="위치를 검색하세요">
            <button type="button"><i class="fa fa-search"></i></button>
        </div>
        <hr>
        <!-- 날씨정보 -->
        <div class="weather_container">
            <div class="today">
                <h3>24.9°</h3>
                <div class="weather_wrap">
                    <span class="weather_icons_small cloud2"></span><span class="txt">흐림</span><span class="wind">1M/S</span>
                </div>
            </div>
            <!-- 1 -->
            <dl class="day_weather">
                <dt class="day">수</dt>
                <dd><span class="weather_icons cloud"></span></dd>
                <dd class="temp">26°</dd>
            </dl>
            <!-- 1 -->
            <dl class="day_weather">
                <dt class="day">목</dt>
                <dd><span class="weather_icons cloud2"></span></dd>
                <dd class="temp">21°</dd>
            </dl>
            <!-- 1 -->
            <dl class="day_weather">
                <dt class="day">금</dt>
                <dd><span class="weather_icons sun"></span></dd>
                <dd class="temp">26°</dd>
            </dl>
            <!-- 1 -->
            <dl class="day_weather">
                <dt class="day">토</dt>
                <dd><span class="weather_icons rain"></span></dd>
                <dd class="temp">26°</dd>
            </dl>
            <!-- 1 -->
            <dl class="day_weather">
                <dt class="day">일</dt>
                <dd><span class="weather_icons snow"></span></dd>
                <dd class="temp">26°</dd>
            </dl>
        </div>
        <hr>
        <!-- 실시간레이더 -->
        <div data-v-667d9d7e="" id="radar" class="rader_wrap">
            <img data-v-667d9d7e="" src="http://radar.kma.go.kr/cgi-bin/center/nph-rdr_cmp_img?aws=0&amp;cmp=HSP&amp;qcd=HSL&amp;obs=ECHO&amp;map=HR&amp;color=C4&amp;legend=1&amp;size=380&amp;lonlat=0&amp;tm=202207262100&amp;xp=589.51&amp;yp=565.34&amp;zoom=2.0000" alt="레이더 HSR" class="w-full radar-img shadow-xl opacity-90 mt-5"><img data-v-667d9d7e="" src="http://radar.kma.go.kr/cgi-bin/center/nph-rdr_cmp_img?aws=1&amp;cmp=HSP&amp;qcd=HSL&amp;obs=ECHO&amp;map=HR&amp;color=C4&amp;legend=1&amp;size=380&amp;lonlat=0&amp;tm=202207262100&amp;xp=528.5&amp;yp=546.7&amp;zoom=9.0000" alt="레이더 HSR" class="w-full radar-img shadow-xl opacity-90  mt-5" style="display: none;"><div data-v-667d9d7e="" class="radar__grid"><div data-v-667d9d7e=""></div><div data-v-667d9d7e=""></div><div data-v-667d9d7e=""></div><div data-v-667d9d7e=""></div></div>
            <div data-v-667d9d7e="" class="pannel_bg">
              <div class="live_datetime">2022년 07월 26일 21시 00분 </div> 
            </div>                 
        </div>
        <hr>
        <!-- 기상특보 알리미 -->
        <div class="alarm_news">   
            <h3>기상특보 알리미</h3>         
            <!-- 1 -->
            <dl class="on">
                <dt>
                    <p class="day">22</p>
                    <p class="year">2023.01</p>
                </dt>
                <dd>
                    <p class="con">강풍주의보가 해제되었습니다.</p>
                    <a href="" class="detail_view">자세히보기</a>
                </dd>
            </dl>
            <!-- 2 -->
            <dl>
                <dt>
                    <p class="day">11</p>
                    <p class="year">2023.01</p>
                </dt>
                <dd>
                    <p class="con">강풍주의보가 해제되었습니다.</p>
                    <a href="" class="detail_view">자세히보기</a>
                </dd>
            </dl>
            <!-- 3 -->
            <dl>
                <dt>
                    <p class="day">05</p>
                    <p class="year">2023.01</p>
                </dt>
                <dd>
                    <p class="con">강풍주의보 풍량주의보가 발표되었습니다.</p>
                    <a href="" class="detail_view">자세히보기</a>
                </dd>
            </dl>
        </div>  
    </section>
    <hr>
    <section id="rnb">
        <!-- 전국평균강수량 -->
        <div class="average_data">
            <!-- 1 -->
            <dl class="average_data_all">
                <dt>전국 누적 평균강수(mm)</dt>
                <dd>
                    <span class="title">전국</span>
                    <span class="amount">934 <em class="unit">mm</em></span>
                    <span class="percent">75 <em class="unit">%</em>
                      <i class="fa-solid fa-arrow-down-long"></i>
                    </span>
                </dd>
            </dl>
            <!-- 2 -->
            <dl class="average_data_area">
                <dt>지역 누적 평균강수(mm)</dt>
                <dd>
                    <span class="title">경북</span>
                    <span class="amount">934 <em class="unit">mm</em></span>
                    <span class="percent">75 <em class="unit">%</em>
                        <i class="fa-solid fa-arrow-down-long"></i>
                    </span>
                </dd>
            </dl>
        </div>
        <hr>
        <div class="status_container">
        <!-- 상단타이틀 -->
            <h3 class="main_title">누적강수현황</h3>             
            <ul class="search_tab">
                <li><a href="" class="on">본부/지사</a></li>
                <li><a href="">시설검색</a></li>
                <li><a href="">통합정보</a></li>
            </ul>           
            <div class="search_checkbox">
                <!-- 1 -->
                <div class="check_label">        
                    <label class="checkcontainer"><span class="check_icon check_icon1">저수지</span>
                        <input type="checkbox">
                        <span class="checkmark"></span>
                    </label>      
                </div>         
                <hr>
                <!-- 1 -->
                <div class="check_label">        
                    <label class="checkcontainer"><span class="check_icon check_icon2">양수장</span>
                        <input type="checkbox">
                        <span class="checkmark"></span>
                    </label>      
                </div>   
                <hr>
                <!-- 1 -->
                <div class="check_label">        
                    <label class="checkcontainer"><span class="check_icon check_icon3">배수장</span>
                        <input type="checkbox" checked="checked">
                        <span class="checkmark"></span>
                    </label>      
                </div>   
                <hr>
                <!-- 1 -->
                <div class="check_label">        
                    <label class="checkcontainer"><span class="check_icon check_icon4">수문</span>
                        <input type="checkbox" checked="checked">
                        <span class="checkmark"></span>
                    </label>      
                </div>   
                <hr>
                <!-- 1 -->
                <div class="check_label">        
                    <label class="checkcontainer"><span class="check_icon check_icon5">배수갑문</span>
                        <input type="checkbox" checked="checked">
                        <span class="checkmark"></span>
                    </label>      
                </div>   
                <hr>
                <!-- 1 -->
                <div class="check_label">        
                    <label class="checkcontainer"><span class="check_icon check_icon6">수로</span>
                        <input type="checkbox" checked="checked">
                        <span class="checkmark"></span>
                    </label>      
                </div>   
                <hr>       
            </div>  
            <hr>
            <!-- 결과테이블 -->
            <div class="status__table">
                <p class="info"><span>기간</span>22-11-11 이전 기준</p>
                <table class="main_table">
                    <tr>
                       <th rowspan="2">지역(전체)</th>
                       <th colspan="2">저수율</th>
                       <th colspan="4">개소수</th>
                   </tr>
                    <tr>
                      <th>현재/평년</th>
                      <th>평년대비</th>
                      <th><span class="step_point bgcolor_step1"><em class="hidden">관심</em></span></th>
                      <th><span class="step_point bgcolor_step2"><em class="hidden">주의</em></span></th>
                      <th><span class="step_point bgcolor_step3"><em class="hidden">경계</em></span></th>
                      <th><span class="step_point bgcolor_step4"><em class="hidden">심각</em></span></th>
                  </tr>
                   <tr>
                       <td>전국(3,403)</td>
                       <td>64/67</td>
                       <td>96</td>
                       <td>3,250</td>
                       <td>74</td>
                       <td>32</td>
                       <td>82</td>
                   </tr>
                   <tr>
                       <td>경기(111)</td>
                       <td>83/75</td>
                       <td>96</td>
                       <td>3,250</td>
                       <td>74</td>
                       <td>32</td>
                       <td>82</td>
                   </tr>
                   <tr>
                    <td>강원(111)</td>
                    <td>83/75</td>
                    <td>96</td>
                    <td>3,250</td>
                    <td>74</td>
                    <td>32</td>
                    <td>82</td>
                </tr>
                <tr>
                    <td>충북(111)</td>
                    <td>83/75</td>
                    <td>96</td>
                    <td>3,250</td>
                    <td>74</td>
                    <td>32</td>
                    <td>82</td>
                </tr>
                <tr>
                    <td>충남(111)</td>
                    <td>83/75</td>
                    <td>96</td>
                    <td>3,250</td>
                    <td>74</td>
                    <td>32</td>
                    <td>82</td>
                </tr>
                <tr>
                    <td>전북(111)</td>
                    <td>83/75</td>
                    <td>96</td>
                    <td>3,250</td>
                    <td>74</td>
                    <td>32</td>
                    <td>82</td>
                </tr>
                <tr>
                    <td>전남(1,045)</td>
                    <td>83/75</td>
                    <td>96</td>
                    <td>3,250</td>
                    <td>74</td>
                    <td>32</td>
                    <td>82</td>
                </tr>
                <tr>
                    <td>경북(111)</td>
                    <td>83/75</td>
                    <td>96</td>
                    <td>3,250</td>
                    <td>74</td>
                    <td>32</td>
                    <td>82</td>
                </tr>
                <tr>
                    <td>경남(111)</td>
                    <td>83/75</td>
                    <td>96</td>
                    <td>3,250</td>
                    <td>74</td>
                    <td>32</td>
                    <td>82</td>
                </tr>
                <tr>
                    <td>제주(9)</td>
                    <td>83/75</td>
                    <td>96</td>
                    <td>3,250</td>
                    <td>74</td>
                    <td>32</td>
                    <td>82</td>
                </tr>
               </table>   
            </div>
            <hr>
            <div class="main_chart">
                <p>그래프 개발 들어가는곳 이미지로 공간만</p>
            </div>
        </div>
    </section>
    <hr>

    
</body>
</html>