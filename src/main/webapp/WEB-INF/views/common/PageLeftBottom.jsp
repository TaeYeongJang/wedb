<%@ page contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>

<style>
.report-detail {
	margin-left: 50px; 
	color: white; 
	margin-bottom: 10px; 
	font-size: 14px; 
	display: none;
}
.display-none {
	display: none;
}
.display-block {
	display: block;
}
</style>

<script type="text/javascript">

$(document).ready(function(){ 	
	getRadar();
	getKmaSpReport();
	
	setInterval(function() { //5분마다 새로고침
		getRadar();
	}, 1000 * 60 * 5);
	
	setInterval(function() { //1분마다 새로고침
		getKmaSpReport();
	}, 1000 * 60);
});

//날짜 호출
function getDateString(minute) {
	minute = minute || 5;

	var currDay = new Date();
	// 현재시간에서 5분전으로 10분단위로 처리
	var currMinus5m = new Date(currDay.getFullYear(), currDay.getMonth(), currDay.getDate(), currDay.getHours(), Math.floor((currDay.getMinutes() - minute) / 10) * 10, 0);

	yy = currMinus5m.getFullYear();
	mm = currMinus5m.getMonth();
	dd = currMinus5m.getDate();
	hh = currMinus5m.getHours();
	mi = currMinus5m.getMinutes();

	// 두자리로 통일
	var yyStr = '' + yy;
	var mmStr = ((mm + 1) < 10) ? '0' + (mm + 1) : '' + (mm + 1);
	var ddStr = (dd < 10) ? '0' + dd : '' + dd;
	var hhStr = (hh < 10) ? '0' + hh : '' + hh;
	var miStr = (mi < 10) ? '0' + mi : '' + mi;

	return yyStr + mmStr + ddStr + hhStr + miStr;
}

//레이다 호출
function getRadar() {
	var BASEDATETIME = getDateString(5);
	var rdrdt = BASEDATETIME.substr(0,4) + "년 " + BASEDATETIME.substr(4,2) + "월 " + BASEDATETIME.substr(6,2) + "일 " + BASEDATETIME.substr(8,2) + "시 " + BASEDATETIME.substr(10,2) + "분";
	$("#live_datetime").html(rdrdt);

	var url = "http://afso.kma.go.kr/cgi/rdr/nph-rdr_cmp_img?tm=" + BASEDATETIME + "&obs=rdr_ppi_qcd&data=3&qcd=1&aws=0&map=D3&grid=2&legend=1&size=475.00&itv=5&zoom_level=0&zoom_x=0000000&zoom_y=0000000&gov=&_DT=RSW:RDRPPIQCD";
	$("#radar_img").attr("src", url);
}

//기상특보
function getKmaSpReport() {
    var reportInfo = {
			sql		: "rawris.krc.rawris.get_kma_report_list"
		,	cmd 	: "selectList"
 		, 	db_type	: "rawris"
 	};
    var rst = ajaxPost(reportInfo);
 	if(!rst) {
 		rawrisShowMsg("장애가 발생했습니다.");
 		return false;
 	} else {
        var today	= new Date();
	    var year 	= today.getFullYear();
		var month 	= ('0' + (today.getMonth() + 1)).slice(-2);
		var date	= ('0' + today.getDate()).slice(-2);
		var time 	= year + month + date;
		
        var html = '<h3>기상특보 알리미</h3>';

        if(rst.length > 0) {
			for(var i = 0; i < rst.length; i++) {
            	var row = rst[i];
            	
            	var y = row.TM_FC.substr(0, 4);
            	var m = row.TM_FC.substr(4, 2);
            	var d = row.TM_FC.substr(6, 2);
            	var hh = row.TM_FC.substr(8, 2);
            	var mi = row.TM_FC.substr(10, 2);
            	
            	var a_txt, display_class;
               	if(i == 0) {
               		a_txt = '';
               		display_class = 'display-block';
               	} else {
               		a_txt = '자세히보기';
               		display_class = 'display-none';
               	}
               	
              	//날짜가 오늘이면 빨간색 아이콘
                if(y + m == time)	html += '<dl class="on">';
               	else				html += '<dl>';
               	
				html += '<dt><p class="day">' + d + '</p><p class="year">' + y + '.' + m + '</p></dt>';
				html += '<dd><p class="con">' + row.T1 + '</p>'; 
				html += '<a id="reportDetail-a' + i + '" href="javascript:getKmaSpReportDetail(\'' + i + '\', \'' + rst.length + '\')" class="detail_view">' + a_txt + '</a></dd></dl>';
				html += '<dd id = "reportDetail'+ i +'"class ="report-detail ' + display_class + '"><p class="con">';
           		html += '<span style ="color:#b492b7;">발표시각 : ' + y + '.' + m + '.' + d + ' ' + hh + ':' + mi + '</span><hr><span style ="margin-top:20px;">' + row.T2 + '</span></dd>';
            }            
            $('#alarm_news').html(html);
        } else 
            $('#alarm_news').text('없음');
 	}	
}

//기상특보 자세히 보기 
function getKmaSpReportDetail(idx, length) {
	for(var i = 0; i < length; i++) {
		if(i == idx) {
			$("#reportDetail-a" + i).text("");
			$("#reportDetail" + i).show();
		} else {
			$("#reportDetail-a" + i).text("자세히보기");
			$("#reportDetail" + i).hide();
		}
    } 	
}
</script>

		<!-- 실시간레이더 -->
        <div id="radar" class="rader_wrap">
        	<img id="radar_img" alt="레이더 HSR" class="w-full radar-img shadow-xl opacity-90 mt-5">
            <div class="pannel_bg">
            	<div class="live_datetime" id="live_datetime"></div> 
            </div>                 
        </div>
        <hr>
        <!-- 기상특보 알리미 -->
        <div class="alarm_news" id="alarm_news"></div>
        