<%@page contentType="text/html;charset=utf-8"%>
<div class="row no-gutter bg-info" style="padding: 10px;">
	<div class="sb-col"  id="search_qms_manual_area" style="display: none;">
		<p style="text-align: right; font-size: 16px; width: 90px; font-weight:bold; padding-top: 7px;">보정 저수지  </p>
	</div>
	<div class="sb-col" id="search_buseo_head_code_area" style="width:100px; ">
		<select id="s_buseo_head_code" class="form-control">
			<option value="0">본부</option>
		</select>
	</div>
	<div class="sb-col" id="search_buseo_branch_code_area" style="width:180px;">
		<select id="s_buseo_branch_code" class="form-control">
			<option value="">지사</option> 
		</select>
	</div>
	<div class="sb-col" id="search_management_data_gubun_area" style="display:none"> 
		<select id="s_management_data_gubun" class="form-control">
			<option value="">데이터 구분</option>
			<option value="1" selected>계측 10분데이터</option>
			<option value="2">RIMS 일데이터</option>
		</select>
	</div>
	<div class="sb-col" id="search_fac_kind_code_area" style="width:120px;">
		<select id="s_fac_kind_code" class="form-control">
			<option value="99">시설종류</option> 
		</select>
	</div>
	<div class="sb-col" id="search_volcal_method_code_area" style="width:130px; display:none;">
		<select id="s_volcal_method_code" class="form-control">
			<option value="">계측방식</option>
			<option value="99">조견표</option> 
			<option value="03">다항식</option> 
			<option value="00">미지정</option> 
			<option value="01">매닝식</option> 
			<option value="02">지수식</option> 
			<option value="04">유량실측</option>
			<option value="003">수로_다항식</option>  
			<option value="000">수로_미지정</option> 
		</select>
	</div>
<!-- 	<div class="sb-col" id="search_equip_kind_code_area" style="width:120px; display:none;">
		<select id="s_equip_kind_code" class="form-control">
			<option value="">장비구분</option> 
			<option value="A.RLM">저수지_A.RLM</option>
			<option value="A.WLM">수로_A.WLM</option>
			<option value="A.VLM">하천_A.VLM</option>
		</select>
	</div> -->
	<div class="sb-col" id="search_equip_water_area" style="display:none;">
		<select id="s_equip_water" class="form-control">
			<option value="">계측방식</option>
			<option value="W" selected>수위</option>
			<option value="S">수위 + 유속</option> 
		</select>
	</div>
	<div class="sb-col" id="search_obs_yn_flowspeed_area" style="display:none;">
		<select id="s_obs_yn_flowspeed" class="form-control">
			<option value="">유속관측</option>
			<option value="Y">예</option>
			<option value="N">아니오</option> 
		</select>
	</div>
	<div class="sb-col" id="search_equip_cdma_name_area" style="display:none">
		<select id="s_equip_cdma_name" class="form-control">
			<option value="00" selected>통신방식</option>
			<option value="Y">CDMA(2G)</option>
			<option value="W">WCDMA(3G)</option>
			<option value="L">LTE</option>
			<option value="I">LoRa</option>
			<option value="C">CatM1</option>
			<option value="O">기타</option>
		</select>
	</div>
	<div class="sb-col" id="search_equip_no_area" style="width:120px;">
		<select id="s_equip_no" class="form-control">
			<option value="">장비</option> 
		</select>
	</div>
	<div class="sb-col" id="search_fac_code_area" style="width:120px; display:none;">
		<select id="s_fac_code" class="form-control">
			<option value="">장비</option> 
		</select>
	</div>
	<div class="sb-col" id="equipNm_area" style="width:110px;">
		<input type="text" id="equipNm" class="form-control" placeholder="장비명검색">
	</div>
	<div class="sb-col" id="search_qms_gbn_code_area" style="width:175px; display:none;">
		<select id="qms_gbn" class="form-control">
			<option value="">보정 종류</option>
			<option value="1">전처리</option>
			<option value="2">1차 필터보정[1일]</option>
			<option value="3">2차 필터보정[10일]</option>
		</select>
	</div>
	<div class="sb-col" id="v_equip_no_area" style="width:90px; display: none;">
		<input type="text" id="v_equip_no" class="form-control" placeholder="장비번호">
	</div>
	<div class="sb-col" id="v_s_code_area" style="width:140px; display: none;">
		<input type="text" id="v_s_code" class="form-control" placeholder="표준코드(10자리)">
	</div>
	<div class="sb-col" id="search_qms_reason_area" style="width:120px; display:none;">
		<select id="s_qms_reason" class="form-control">
			<option value="">보정사유</option> 
		</select>
	</div>
	<div class="sb-col" id="search_order_gbn_area" style="width:140px; display:none;">
		<select id="s_order_gbn" class="form-control">
			<option value="">장비조회기준</option> 
			<option value="nse" selected>NSE</option> 
			<option value="rmse">RMSE</option>
		</select>
	</div>
	<div class="sb-col" id="search_masage_area" style="width:120px; display:none;">
		<select id="s_masage_code" class="form-control">
			<option value="">관리주체</option> 
			<option value="A">RIMS</option> 
			<option value="B">계측시스템</option> 
		</select>
	</div>
	<div class="sb-col" id="search_smltn_area" style="width:180px; display:none;">
		<select id="s_smltn_code" class="form-control">
			<option value="">홍수 모의 대상유무</option> 
			<option value="A">예</option> 
			<option value="B">아니오</option> 
		</select>
	</div>
	<div class="sb-col" id="search_fac_code_nm_area" style="width:100px;">
		<select id="s_fac_code_nm" class="form-control">
			<option value="0">장비명</option> 
		</select>
	</div>
	<div class="sb-group" id="search_time_group" style="">
		<div class="sb-col" id="search_time_term" style="width:110px;">
			<select id="s_kind_time" class="form-control">
				<option value="0">검색기간</option>
				<option value="month">월별</option>
				<option value="daily">일별</option>
				<option value="hour">시간별</option>
				<option value="minute">10분별</option> 
			</select>
		</div>
		<div class="sb-col" id="start_date_name_area" style="width:49px; padding-top: 6px; display:none; font-weight:bold; font-size: 15px;">
			시작일
		</div>
		<div class="sb-col" id="search_start_date" style="width:110px;">
			<input type="text" id="s_start_date" class="form-control select_date" placeholder="시작일" readonly>
		</div>
		<div class="sb-col" id="end_date_name_area" style="width:49px; padding-top: 6px; display:none; font-weight:bold; font-size: 15px;">
			종료일
		</div>
		<div class="sb-col" id="search_end_date" style="width:110px;">
			<input type="text" id="s_end_date" class="form-control select_date" placeholder="종료일" readonly>
		</div>
		<div class="sb-col" id="search_end_hour_area" style="width:110px; display:none;" >
			<select id="search_end_hour" class="form-control">
				<option value="00">00시</option>
				<option value="01">01시</option>
				<option value="02">02시</option>
				<option value="03">03시</option>
				<option value="04">04시</option>
				<option value="05">05시</option>
				<option value="06">06시</option>
				<option value="07">07시</option>
				<option value="08">08시</option>
				<option value="09">09시</option>
				<option value="10">10시</option>
				<option value="11">11시</option>
				<option value="12">12시</option>
				<option value="13">13시</option>
				<option value="14">14시</option>
				<option value="15">15시</option>
				<option value="16">16시</option>
				<option value="17">17시</option>
				<option value="18">18시</option>
				<option value="19">19시</option>
				<option value="20">20시</option>
				<option value="21">21시</option>
				<option value="22">22시</option>
				<option value="23">23시</option>
		    </select>
		</div>
		<div class="sb-col" id="search_end_min_area" style="width:110px; display:none;" >
			<select id="search_end_min" class="form-control">
				<option value="00">00분</option>
				<option value="10">10분</option>
				<option value="20">20분</option>
				<option value="30">30분</option>
				<option value="40">40분</option>
				<option value="50">50분</option>
		    </select>
		</div>
		
	</div>
	<div class="sb-group" id="search_equip_regist_area" style="display:none">
		<div class="sb-col">
			<select id="s_equip_oper_sts_code" class="form-control">
				<option value="">운영현황</option>
				<option value="0">운용정지</option>
				<option value="1">장비점검</option>
				<option value="2">정상운용</option>
				<option value="3">오류검출</option>
				<option value="4">승인대기</option>
				<option value="5">일정값 지속(3일)</option>
				<option value="6">저수율 급강하(5% 이상)</option>
				<option value="7">통신이상</option>
				<option value="8" style="display:none;" id="s_equip_oper_sts_code_option8">통신대기</option>
		    </select>
		</div>
		<div class="sb-col">
			<select id="s_equip_conn_sts" class="form-control">
				<option value="">통신현황</option>
				<option value="1">정상</option>
				<option value="0">통신이상</option>
			</select>
		</div>
		<div class="sb-col">
			<select id="s_equip_conn_sts_2" class="form-control" style="display:none">
				<option value="">통신현황</option>
				<option value="1">정상</option>
				<option value="2">통신이상</option>
				<option value="0">통신대기</option>
			</select>
		</div>
		<div class="sb-col">
			<select id="s_equip_install_year" class="form-control">
				<option value="">설치년도</option>
		    </select>
		</div>
	</div>
	<div class="sb-col" id="search_equip_use_yn_area" style="width:110px; display:none;">
		<select id="s_equip_use_yn" class="form-control">
			<option value="">사용여부</option> 
			<option value="Y" selected>사용</option>
			<option value="N">폐기</option>
		</select>
	</div>
	<div class="sb-col" id="search_equip_management_grp_area" style="display:none">
		<select id="s_equip_manage_gbn" class="form-control">
			<option value="">장비관할조직</option>
			<option value="01" selected>농어촌공사</option>
			<option value="02">지방자치단체</option>
		</select>
	</div>
	<div class="sb-col" id="search_qms_method_area" style="display:none"> 
		<select id="s_qms_method" class="form-control">
		</select>
	</div>
	<div class="sb-group" id="search_salt_grp_area" style="display:none">
		<div class="sb-col">
			<select id="s_equip_auto_yn" class="form-control">
				<option value="00" selected>구분</option>
				<option value="Y">자동</option>
				<option value="N">수동</option>
			</select>
		</div>
		<div class="sb-col" id="search_salt_cdma">
			<select id="s_cdma_type_gbn" class="form-control">
				<option value="00" selected>통신방식</option>
				<option value="Y">CDMA(2G)</option>
				<option value="W">WCDMA(3G)</option>
				<option value="L">LTE</option>
				<option value="I">LoRa</option>
				<option value="C">CatM1</option>
				<option value="O">기타</option>
			</select>
		</div>
		<div class="sb-col">
			<select id="s_salt_type_gbn" class="form-control">
				<option value="00" selected>측정방식</option>
				<option value="I">이온선택</option>
				<option value="E">전도도</option>
			</select>
		</div>
		<div class="sb-col">
			<select id="s_salt_level" class="form-control">
				<option value="00" selected>염도</option>
				<option value="점검필요">점검필요</option>
				<option value="심각">심각</option>
				<option value="경계">경계</option>
				<option value="주의">주의</option>
				<option value="관심">관심</option>
			</select>
		</div>
	</div>
	<div class="sb-group" id="search_salt_and_temp_grp_area" style="display:none">
		<div class="sb-col" id="start_salt_area" style="width:110px;">
			<input type="text" id="start_salt_level" class="form-control" placeholder="염도 from" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
		</div>
		<div class="sb-col" id="end_salt_area" style="width:110px;">
			<input type="text" id="end_salt_level" class="form-control" placeholder="염도 to" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
		</div>
		<div class="sb-col" id="start_temp_area" style="width:110px;">
			<input type="text" id="start_temp_level" class="form-control" placeholder="수온 from" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
		</div>
		<div class="sb-col" id="end_temp_area" style="width:110px;">
			<input type="text" id="end_temp_level" class="form-control" placeholder="수온 to" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
		</div>
	</div>
	<div class="sb-col" id="equip_standard_code_area" style="width:150px; display:none;">
		<input type="text" id="equip_st_code" maxlength="10" size="10" class="form-control" placeholder="표준코드검색">
	</div>
	
	<div class="sb-group" id="search_qms_gbn_area" style="display:none">
			<select id="s_qms_gbn" class="form-control" style="margin-left: 2px;">
				<option value="">데이터 구분</option>
				<option value="N" selected>품질관리 전</option>
				<option value="Y">품질관리 최종</option>
			</select>
	</div> 
	<div class="sb-group" id="search_inq_year_area" style="display:none">
			<select id="s_inq_year" class="form-control" style="margin-left: 5px;">
			</select>
	</div> 

	<div class="sb-col" style="padding-left:8px; border:0px solid #ffffff;" >
		<button type="button" class="btn btn-primary" id="equipRegMgtRegistBtn" style="display:none">등록</button>
		<button type="button" class="btn btn-default" id="equipFluxBaseSearchBtn">검색</button>
		<button type="button" class="btn btn-default" id="ReportTotalSearchBtn" style="display:none;">집계</button>
		<button type="button" class="btn btn-default" id="qmsReportSearchBtn" style="display:none;">검색</button>
		<button type="button" class="btn btn-default" id="equipFluxBaseExcelBtn">저장</button>
		<button type="button" class="btn btn-default" id="ReportTotalErrorBtn" style="display:none;">오류시설 모두 점검 체크 or 해제</button>
		<button type="button" class="btn btn-primary" id="qmsWorkMngExcelBtn" style="display:none; background-color: #00b2cc; border-color: #00b2cc;">전체 저장</button>
		<button type="button" class="btn btn-primary" id="wrmsFluxBuseoGraphView" style="display:none; background-color: #00b2cc; border-color: #00b2cc;">누적 그래프 보기 / 해제</button>
		<button type="button" class="btn btn-primary" id="qmsParamMngPopup" style="display:none; background-color: #00b2cc; border-color: #00b2cc;">매개변수 수정</button>
		<button type="button" class="btn btn-primary" id="qmsManualGraphView" style="display:none; background-color: #239ff7; border-color: #239ff7;">저수율 그래프 보기 / 해제</button>
		<button type="button" class="btn btn-primary" id="qmsManualSearch" style="display:none; background-color: #00b2cc; border-color: #00b2cc;">수동보정</button>
		<button type="button" class="btn btn-primary" id="qmsInpoResult" style="display:none; background-color: #00b2cc; border-color: #00b2cc;">신뢰도평가</button>
	</div>
	<div  id="search_kma_save_date_area" style="margin-right: 10px; float: right; display:none; font-weight: bold; margin-top: 6px;" >
		<p style="text-align: right; font-size: 16px;">최종 수집일 : <span id="kma_save_date"></span> </p>
	</div>
	<div  id="qms_help_area" style="margin-right: 4px; float: right; display:none; font-weight: bold;" >
		<button type="button" class="btn btn-primary" id="qms_help_btn" style="background-color: #1642df; border-color: #1642df; display:inline;">FAQ</button>
	</div>
	<div  id="search_new_fac_code_area" style="margin-right: 10px; float: right; display:none; font-weight: bold;" >
		<p style="text-align: right; font-size: 16px; display:inline">계측 신규 : <span id="rawris_new_fac_count"></span> / </p>
		<p style="text-align: right; font-size: 16px; display:inline">림스 신규 : <span id="rims_new_fac_count"></span></p>
		<button type="button" class="btn btn-primary" id="insert_new_fac_code" style="background-color: #00b2cc; border-color: #00b2cc; display:inline; margin-left: 5px;">전체 자료등록</button>
	</div>

</div>
<div class="row no-gutter bg-info" id="search_qms_manual_grp_area" style="display:none; padding: 10px;margin-top: 3px;">
		<div class="sb-col">
			<p style="text-align: right; font-size: 16px; width: 90px; font-weight:bold; margin-top: 7px;">비교 저수지  </p>
		</div>
		<div class="sb-col" id="v_search_buseo_head_code_area" style="width:100px; ">
			<select id="v_buseo_head_code" class="form-control">
				<option value="0">본부</option>
			</select>
		</div>
		<div class="sb-col" id="v_search_buseo_branch_code_area" style="width:180px;">
			<select id="v_buseo_branch_code" class="form-control">
				<option value="">지사</option> 
			</select>
		</div>	
		<div class="sb-col" id="v_search_management_data_gubun_area"> 
			<select id="v_management_data_gubun" class="form-control">
				<option value="">데이터 구분</option>
				<option value="1" selected>계측 10분데이터</option>
				<option value="2">RIMS 일데이터</option>
			</select>
		</div>
		<div class="sb-col" id="v_search_fac_code_area" style="width:120px;">
			<select id="v_fac_code" class="form-control">
				<option value="">장비</option> 
			</select>
		</div>
		<div class="sb-col" id="v_equipNm_area" style="width:110px;">
			<input type="text" id="v_equipNm" class="form-control" placeholder="장비명검색">
		</div>
		<div class="sb-col" id="v_search_fac_code_nm_area" style="width:100px;">
			<select id="v_fac_code_nm" class="form-control">
				<option value="0">장비명</option> 
			</select>
		</div>
	</div>	
<div class="row no-gutter bg-info" style="padding-top: 5px; padding-left:10px; display: none;" id='s_sisul_sub_equip'>
	<div class="col-xs-1">
		수로계통
	</div>
	<div id="sisul_sub_equip_no_area">
		수로정보
	</div>
</div>