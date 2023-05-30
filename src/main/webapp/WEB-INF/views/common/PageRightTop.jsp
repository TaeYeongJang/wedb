<%@ page contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>

<style>
.carousel-item {
	display: none;
}
.carousel-item.active {
	display: block;
}
</style>

<script type="text/javascript">

$(document).ready(function(){ 	
	getAwsBonbuList();
});

//누적강수 조회
function getAwsBonbuList() {
	const awsInfo = {
			sql 			: "rawris.krc.rawris.get_aws_bonbu_list"
		,	cmd 		 	: "selectList"
		, 	db_type 	 	: "rawris"
		, 	s_start_date	: searchConditionObj.s_start_date
		,	s_start_time	: searchConditionObj.s_start_time
		, 	s_end_date   	: searchConditionObj.s_end_date
		,	s_end_time		: searchConditionObj.s_end_time
	};
	 
    const rst = ajaxPost(awsInfo);
    
 	if(!rst) {
 		rawrisShowMsg("장애가 발생했습니다.");
 		return false;
 	} else {
		var html = '<dl class="average_data_all"><dt>전국 누적 평균강수(mm)</dt><dd><span class="title">전국</span><span class="amount">';
	    	
			html += rst[0].AVG_RAIN;
	    	html += ' <em class="unit">mm</em></span><span class="percent">';
	    	html += rst[0].RATIO;
	    	html += ' <em class="unit">%</em>';
	    	
		if(rst[0].RATIO < 100)
	   		html += '<i class="fa-solid fa-arrow-down-long" style="padding-left: 4px;"></i>';
		else if(rst[0].RATIO == 100)
	   		html += '<i class="fa-solid"></i>';
		else
			html += '<i class="fa-solid fa-arrow-up-long" style="padding-left: 4px;"></i>';
	    	
			html += '</span></dd></dl><dl class="average_data_area"><dt>지역 누적 평균강수(mm)</dt>';

		//지역별 강수량 인덱스 rolling
		for(var i = 0; i < rst.length; i++) {
 	   		if(rst[i].HO_NAME != '제주' && rst[i].HO_NAME != '전국') {
	 	    	html += '<dd class="carousel-item"><span class="title">';
	 	    	html += rst[i].HO_NAME;
	 	    	html += '</span><span class="amount">';
	 	    	html += rst[i].AVG_RAIN;
	 	    	html += ' <em class="unit">mm</em></span><span class="percent">';
	 	    	html += rst[i].RATIO;
	 	    	html += ' <em class="unit">%</em>';
	 	    	
	 	    	if(rst[i].RATIO < 100)
	 	   			html += '<i class="fa-solid fa-arrow-down-long" style="padding-left: 4px;"></i>';
 	   			else if(rst[i].RATIO == 100)
	 	   			html += '<i class="fa-solid"></i>';	
	 			else
	 				html += '<i class="fa-solid fa-arrow-up-long" style="padding-left: 4px;"></i>';
	 	    	
 				html += '</span></dd>';
			}
		}
		html += '</dl>';
 	  
		$('#awsCarousel').html(html);
 		
 		$(".carousel-item:first").addClass("active");
 		
 		var index = 0;
		var length = $(".carousel-item").length;
		
 		setInterval(function() {
 			$(".carousel-item").removeClass("active");
 			index++;
 			if(index === length) index = 0;
 			$(".carousel-item").eq(index).addClass("active");
		}, 3000);
 	}
}
</script>

        <!-- 전국평균강수량 -->
        <div class="average_data" id="awsCarousel"></div>
        