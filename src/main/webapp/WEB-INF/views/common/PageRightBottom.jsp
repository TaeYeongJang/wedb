<%@ page contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>
<style>
.awsLink {
	color: white;
}
</style>
<script type="text/javascript">

$(document).ready(function() { 	
	getList(0);
	
	$("#search_equip_btn").click(function() {
		searchEquipList();
	});
	
	$("#search_equip").keypress(function(evt) { 
		if(evt.keyCode == 13) searchEquipList(); 
	}); 
});

// 본부/지사
function searchList() {
	$('#search_data_area').css('display', 'flex');
	$('#search_equip_area').css('display', 'none');
	$('#search_tot_area').css('display', 'none');

	$('#search_data_tab').attr('class', 'on');
	$('#search_equip_tab').attr('class', '');
	$('#search_tot_tab').attr('class', '');
}

// 시설검색
function searchEquip() {
	$('#search_data_area').css('display', 'none');
	$('#search_equip_area').css('display', 'block');
	$('#search_tot_area').css('display', 'none');

	$('#search_data_tab').attr('class', '');
	$('#search_equip_tab').attr('class', 'on');
	$('#search_tot_tab').attr('class', '');
}

// 통합정보
function searchTotData() {
	$('#search_data_area').css('display', 'none');
	$('#search_equip_area').css('display', 'none');
	$('#search_tot_area').css('display', 'block');

	$('#search_data_tab').attr('class', '');
	$('#search_equip_tab').attr('class', '');
	$('#search_tot_tab').attr('class', 'on');
}

//시설검색 조회
function searchEquipList() {
	
}

//누적강수현황
function getList(buseoCode) {
	var awsInfo = {
			cmd 		 	: "selectList"
		, 	db_type 	 	: "rawris"
		, 	s_start_date	: searchConditionObj.s_start_date
		,	s_start_time	: searchConditionObj.s_start_time
		, 	s_end_date   	: searchConditionObj.s_end_date
		,	s_end_time		: searchConditionObj.s_end_time
	};

	var awsBonbuListJson, awsBonbuSubListJson;
	
	awsInfo.sql = "rawris.krc.rawris.get_aws_bonbu_list";
	awsBonbuListJson = ajaxPost(awsInfo);
	
	if(buseoCode != 0) {
		awsInfo.sql = "rawris.krc.rawris.get_aws_bonbu_sub_list";
		awsBonbuSubListJson = ajaxPost(awsInfo);
	}
	
	var rst = [];
	if(buseoCode == 0) {
        rst = awsBonbuListJson;
    }else {
        for (var i in awsBonbuListJson) {
            var item = awsBonbuListJson[i];
            if(item.BONBU_CODE == buseoCode) {
                rst.push(item);
            }
        }
        for (var i in awsBonbuSubListJson) {
            var item = awsBonbuSubListJson[i];
            if(item.BONBU_CODE == buseoCode) {
                rst.push(item);
            }
        }
    }
	
	var aws_start_dt = awsInfo.s_start_date.substr(2, 2) + '-' + awsInfo.s_start_date.substr(4, 2) + '-' + awsInfo.s_start_date.substr(6, 2);
	var aws_end_dt = awsInfo.s_end_date.substr(2, 2) + '-' + awsInfo.s_end_date.substr(4, 2) + '-' + awsInfo.s_end_date.substr(6, 2);

	var status_html = '<p class="info"><span>기간</span>' + aws_start_dt + ' ~ ' + aws_end_dt + '</p>';
		status_html += '<table class="main_table"><tbody><tr><th>지역</th><th>기간 강수량<br>(mm)</th><th>평년 강수량<br>(mm)</th><th>평년대비<br>(%)</th></tr>';
	
	for(var i = 0; i < rst.length; i++) {
		status_html += '<tr><td>';
		if(rst[i].AWS_NM)
			status_html += '<a class="awsLink" href="javascript:onMove(\'' + i + '\', \'' + rst[i].BONBU_CODE + '\');" data-toggle="tooltip" title="'+rst[i].AWS_NM+'">';
		else
			status_html += '<a class="awsLink" href="javascript:onMove(\'' + i + '\', \'' + rst[i].BONBU_CODE + '\');">';
		
		var avg_rain30, ratio;
		if(rst[i].AVG_RAIN30 != null) avg_rain30 = rst[i].AVG_RAIN30;
		else avg_rain30 = '-';
		if(rst[i].RATIO != null) ratio = rst[i].RATIO;
		else ratio = '-';
		
		status_html += rst[i].HO_NAME + '</a></td><td>' + rst[i].AVG_RAIN + '</td><td>' + avg_rain30 + '</td><td>' + ratio;
		
		if(rst[i].RATIO == null)		 status_html += '</td></tr>';
		else if(rst[i].RATIO > 100)	 status_html += ' % ▲</td></tr>';
		else if(rst[i].RATIO == 100) status_html += ' %</td></tr>';	
		else						 status_html += ' % ▼</td></tr>';
	}
	
		status_html += '</tbody></table>';
	
	$('#div_status_table').html(status_html);
}

// 누적강수현황 - 지역 변경
function onMove(area, bonbuCode) {
	if(area != '0') getList(bonbuCode);
	else	 		getList(0);
}
</script>
        
		<div class="status_container">
			<!-- 상단타이틀 -->
			<h3 class="main_title">누적강수현황</h3>   
			<ul class="search_tab">
	        	<li><a href="javascript:searchList();" id="search_data_tab" class="on">본부/지사</a></li>
	            <li><a href="javascript:searchEquip();" id="search_equip_tab">시설검색</a></li>
	            <li><a href="javascript:searchTotData();" id="search_tot_tab">통합정보</a></li>
			</ul>
			<div class="search_checkbox" id="search_data_area">
				<!-- 1 -->
				<div class="check_label">        
	            	<label class="checkcontainer"><span class="check_icon check_icon1">저수지</span>
	                	<input type="checkbox">
	                    <span class="checkmark"></span>
	                </label>      
	            </div>
	            <hr>
	            <!-- 2 -->
				<div class="check_label">        
	            	<label class="checkcontainer"><span class="check_icon check_icon2">양수장</span>
	                	<input type="checkbox">
	                    <span class="checkmark"></span>
	                </label>      
	            </div>
	            <hr>
	            <!-- 3 -->
				<div class="check_label">        
	            	<label class="checkcontainer"><span class="check_icon check_icon3">배수장</span>
	                	<input type="checkbox">
	                    <span class="checkmark"></span>
	                </label>      
	            </div>
	            <hr>
	            <!-- 4 -->
				<div class="check_label">        
	            	<label class="checkcontainer"><span class="check_icon check_icon4">수문</span>
	                	<input type="checkbox">
	                    <span class="checkmark"></span>
	                </label>      
	            </div>
	            <hr>
	            <!-- 5 -->
				<div class="check_label">        
	            	<label class="checkcontainer"><span class="check_icon check_icon5">배수갑문</span>
	                	<input type="checkbox">
	                    <span class="checkmark"></span>
	                </label>      
	            </div>
	            <hr>
	            <!-- 6 -->
				<div class="check_label">        
	            	<label class="checkcontainer"><span class="check_icon check_icon6">수로</span>
	                	<input type="checkbox">
	                    <span class="checkmark"></span>
	                </label>      
	            </div>
	            <hr>
			</div>
			<hr>
			<!-- 검색바 -->
		    <div class="search_container" id="search_equip_area" style="display: none;">
		    	<input type="text" id="search_equip" placeholder="시설을 검색하세요">
		       	<button type="button" id="search_equip_btn"><i class="fa fa-search"></i></button>
		    </div>
		    <hr>
		    <!-- 통합정보 -->
		    <div class="search_container" id="search_tot_area" style="display: none;">
		    	통합정보
		    </div>
		    <hr>    
			<!-- 결과테이블 -->
			<div class="status__table" id="div_status_table"></div>
			<hr>
			<div class="main_chart">
				<img src="<c:url value='/resources/sass/images/common/graph.png'/>" alt="그래프 오류">
				<!-- <p>그래프 개발 들어가는곳 이미지로 공간만</p> -->
			</div>
		</div>        
