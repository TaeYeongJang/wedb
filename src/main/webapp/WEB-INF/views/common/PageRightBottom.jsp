<%@ page contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>

<script type="text/javascript">

$(document).ready(function(){ 	
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
			<div class="status__table">
				<p class="info"><span>기간</span>22-11-11 이전 기준</p>
				<table class="main_table">
					<tbody>
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
	                       	<td>전남(111)</td>
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
	                       	<td>제주(111)</td>
	                       	<td>83/75</td>
	                       	<td>96</td>
	                       	<td>3,250</td>
	                       	<td>74</td>
	                       	<td>32</td>
	                    	<td>82</td>
	                	</tr>
					</tbody>
				</table>
			</div>
			<hr>
			<div class="main_chart">
				<img src="<c:url value='/resources/sass/images/common/graph.png'/>" alt="그래프 오류">
				<!-- <p>그래프 개발 들어가는곳 이미지로 공간만</p> -->
			</div>
		</div>        
