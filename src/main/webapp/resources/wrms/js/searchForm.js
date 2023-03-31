$(document).ready(function (){
	
	if(typeof load_left_menu == 'function')
		load_left_menu();

	switch(searchConditionObj.s_type) {
	case 'infoReser_lo': 
		return;
	}

	/**************************************************************************************
	* 기본 설정
	* searchConditionObj uBlvl (1: 본사, 2: 지역본부, 3: 지사)
	**************************************************************************************/
	if(searchConditionObj.s_type == 'sisul'){
		$("#s_equip_no").html("<option value=''>시설</option>");
	}
	
	// 시작일 , 종료일 DatePicker 적용  
	rawrisDatePicker("#s_start_date");
    rawrisDatePicker("#s_end_date");
	
	
//	rawrisShowErrMsgDivAdd('uBlvl	= '+ searchConditionObj.uBlvl +'</br>');
	
	if(searchConditionObj.uBlvl == 2){	// 지역본부 소속일 경우 하부 지사 정보는 다 볼 수 있음
		searchConditionObj.s_buseo_head_code	= rawrisSubString(searchConditionObj.uBcd , 0 , 3);
		searchConditionObj.v_buseo_head_code	= rawrisSubString(searchConditionObj.uBcd , 0 , 3);
		
		$("#search_buseo_head_code_area").hide();
		$("#v_search_buseo_head_code_area").hide();
		buseoHeadCodeChange();
		v_buseoHeadCodeChange();
	}else if(searchConditionObj.uBlvl == 3){ // 지사 소속일 경우 해당 지사 정보만 볼 수 있음
		$("#search_buseo_head_code_area").hide();  
		$("#search_buseo_branch_code_area").hide(); 
		$("#v_search_buseo_head_code_area").hide();  
		$("#v_search_buseo_branch_code_area").hide();

		searchConditionObj.s_buseo_head_code	= rawrisSubString(searchConditionObj.uBcd , 0 , 3);
		searchConditionObj.s_buseo_branch_code 	= searchConditionObj.uBorg;
		searchConditionObj.v_buseo_head_code	= rawrisSubString(searchConditionObj.uBcd , 0 , 3);
		searchConditionObj.v_buseo_branch_code 	= searchConditionObj.uBorg;
		buseoBranchCodeChange();
		v_buseoBranchCodeChange();
	}else{
		// 최초1회 본부 값 채우기 
		/*if (searchConditionObj.s_type != 'gisPop'){
			setEquipHeadBuseoCode();
			v_setEquipHeadBuseoCode();
		}*/
	}
	
	// 페이지별 시설종류 셋팅하기
	setFacKind();

	if(searchConditionObj.s_type == 'flow_sum' || searchConditionObj.s_type ==  'flow_sum_rsvr' ) {
		if(typeof on_init_search_box == 'function') {
			on_init_search_box();
		}
		return;
	}
	

	/**************************************************************************************
	* 페이지별 설정
	* searchConditionObj s_type
	* infoReser = 저수지정보
	* infoWater	= 수로정보
	* equip		= 유량정보
	* sisul 	= 유량정보(시설별)
	**************************************************************************************/
	
	switch (searchConditionObj.s_type){
		case 'reser_rpt':
			setBetweenDate();
			
			//console.log(searchConditionObj.s_kind_time);
			$('#search_fac_kind_code_area').hide();
			$('#search_time_term').hide();
			$('#ReportTotalSearchBtn').show();
			//$('#ReportTotalErrorBtn').show();
			$('#search_end_hour_area').show();
			$('#search_end_min_area').show();
			$('#start_date_name_area').show();
			$('#end_date_name_area').show();
			if(!rawrisIsEmpty(searchConditionObj.q_equip))
				setDefaultForQuality();
			break;
		case 'infoReser':
			setBetweenDate();
			$("#s_kind_time").val(searchConditionObj.s_kind_time);
			$('#search_fac_kind_code_area').hide();
			if(!rawrisIsEmpty(searchConditionObj.q_equip)){
//				rawrisShowErrMsgDivAdd('품질관리에서 넘어왔습니다.</br>');
				setDefaultForQuality();
			}
			break;
		case 'infoWater':
			setBetweenDate();
			$("#s_kind_time").val(searchConditionObj.s_kind_time);
			break;
		case 'flow':
		case 'flow_sum':
			setBetweenDate();
			$("#s_kind_time").val(searchConditionObj.s_kind_time);
			break;
		case 'flow_sum_rsvr':
			setBetweenDate();
			$("#s_kind_time").val(searchConditionObj.s_kind_time);
			break;
		case 'sisul':
			setBetweenDate();
			$("#s_kind_time").val(searchConditionObj.s_kind_time);
			break;
		case 'equipList':
			$('#equipNm').attr("placeholder", '장비명 검색');
			$("#s_fac_code_nm").html("<option value=''>장비</option>");
			$('#equipRegMgtRegistBtn').show();
			$('#search_time_group').hide();
			$('#search_equip_no_area').hide();
			$('#search_fac_code_nm_area').hide();
			$('#search_equip_regist_area').show();
			$('#search_equip_management_grp_area').show();
			$('#search_equip_cdma_name_area').show();
			$('#search_obs_yn_flowspeed_area').show();
			$('#s_equip_conn_sts').hide();	// 22.07.22. 통신현황 -> 운영현황 대체
			setInstallYear();
			searchData(1);
			break;
		case 'totEquipList':
			$('#equipNm').attr("placeholder", '장비명 검색');
			$('#search_time_group').hide();
			$('#search_equip_no_area').hide(); 
			$('#search_fac_code_nm_area').hide();
			$('#search_equip_regist_area').show();
			$('#s_equip_oper_sts_code_option8').show();
			$('#search_equip_management_grp_area').show();
			$('#search_equip_cdma_name_area').show();
			$('#search_volcal_method_code_area').show();
			$('#search_obs_yn_flowspeed_area').show();
			$('#search_equip_use_yn_area').show();
			$('#search_fac_kind_code_area').show();	
			$('#s_equip_conn_sts').hide();		
			//$('#s_equip_conn_sts_2').show();	// 22.07.26. 통신현황 -> 운영현황 대체
			$('#v_equip_no_area').show();
			$('#v_s_code_area').show();

			setInstallYear();
			searchData(1);
			break;
		case 'LatConversion':
			$('#equipNm').attr("placeholder", '장비명 검색');
			$('#search_time_group').hide();
			$('#search_equip_no_area').hide(); 
			$('#search_fac_code_nm_area').hide();
			$('#search_equip_regist_area').show();
			$('#s_equip_oper_sts_code_option8').show();
			$('#search_equip_management_grp_area').show();
			$('#search_equip_cdma_name_area').show();
			$('#search_volcal_method_code_area').show();
			$('#search_obs_yn_flowspeed_area').show();
			$('#search_equip_use_yn_area').show();
			$('#search_fac_kind_code_area').show();	
			$('#s_equip_conn_sts').hide();		
			//$('#s_equip_conn_sts_2').show();	// 22.07.26. 통신현황 -> 운영현황 대체
			$('#v_equip_no_area').show();
			$('#v_s_code_area').show();

			setInstallYear();
			searchData(1);
			break;
		case 'winsLostList':
			$('#equipNm').attr("placeholder", '장비명 검색');
			$('#search_time_group').hide();
			$('#search_equip_no_area').hide(); 
			$('#search_fac_code_nm_area').hide();
			$('#search_equip_management_grp_area').show();
			//$('#search_equip_cdma_name_area').show();
			$('#s_equip_conn_sts').hide();		
			//$('#s_equip_conn_sts_2').show();
			searchData(1);
			break;
		case 'qmsParamList':
			$('#equipNm').attr("placeholder", '장비명 검색');
			$('#search_time_group').hide();
			$('#search_equip_no_area').hide(); 
			$('#search_fac_code_nm_area').hide();
			$('#s_fac_kind_code').hide();
			$('#search_time_group').show();
			$('#search_fac_code_area').show();
			$('#search_time_term').hide();
			//$('#search_management_data_gubun_area').show();
			$('#search_new_fac_code_area').show();
			$('#qms_help_area').show();
			setQmsMethodCode();
			setBetweenDate();
			searchData(1);
			break;
		case 'qmsAutoResult':
			setBetweenDate();
			$("#search_time_term").hide();
			$("#s_kind_time").val(searchConditionObj.s_kind_time);
			$('#search_fac_kind_code_area').hide();
			//$('#search_management_data_gubun_area').show();
			$('#search_fac_code_area').show();
			$('#search_equip_no_area').hide();
			$('#qmsParamMngPopup').show();
			$('#qmsManualSearch').show();
			$('#qmsInpoResult').show();
			$('#qms_help_area').show();
			break;
		case 'qmsInpoResult':
			setBetweenDate();
			$("#search_time_term").hide();
			$("#s_kind_time").val(searchConditionObj.s_kind_time);
			$('#search_fac_kind_code_area').hide();
			//$('#search_management_data_gubun_area').show();
			$('#search_fac_code_area').show();
			$('#search_equip_no_area').hide();
			$('#qmsParamMngPopup').show();
			$('#qmsManualSearch').show();
			$('#qms_help_area').show();
			break;
		case 'qmsReport':
			$("#search_time_term").hide();
			$("#search_time_group").hide();
			$('#search_fac_kind_code_area').hide();
			//$('#search_management_data_gubun_area').show();
			$('#search_fac_code_area').show();
			$('#search_inq_year_area').show();
			$('#search_equip_no_area').hide();
			$('#equipFluxBaseExcelBtn').hide();
			$('#equipFluxBaseSearchBtn').hide();
			$('#qmsReportSearchBtn').show();
			$('#search_qms_gbn_area').show();
			$('#s_management_data_gubun').val("2");
			$("#s_management_data_gubun").attr('disabled', true);
			break;
		case 'qmsManualSearch':
			setBetweenDate();
			$("#search_time_term").hide();
			$("#s_kind_time").val(searchConditionObj.s_kind_time);
			$('#search_fac_kind_code_area').hide();
			//$('#search_management_data_gubun_area').show();
			$('#search_fac_code_area').show();
			$('#search_equip_no_area').hide();
			$('#qmsParamMngPopup').show();
			$('#search_qms_manual_grp_area').show();
			$('#qms_help_area').show();
			break;
		case 'qmsHistList':
			setBetweenDate();
			$("#search_time_term").hide();
			$("#s_kind_time").val(searchConditionObj.s_kind_time);
			$('#search_fac_kind_code_area').hide();
			//$('#search_management_data_gubun_area').show();
			$('#search_fac_code_area').show();
			$('#search_equip_no_area').hide();
			$('#equipNm_area').show();
			$('#search_qms_gbn_code_area').show();
			$('#search_fac_code_nm_area').hide();
			$('#qms_help_area').show();
			break;
		case 'qmsWorkMng':
			setBetweenDate();
			$("#search_time_term").hide();
			$("#s_kind_time").val(searchConditionObj.s_kind_time);
			$('#search_fac_kind_code_area').hide();
			//$('#search_management_data_gubun_area').show();
			$('#search_fac_code_area').show();
			$('#search_equip_no_area').hide();
			$('#equipNm_area').show();
			$('#search_fac_code_nm_area').hide();
			$('#search_qms_reason_area').show();
			$('#search_qms_rmse_area').show();
			$('#search_qms_nse_area').show();
			//$('#search_order_gbn_area').show();
			$('#qmsWorkMngExcelBtn').show();
			$('#qms_help_area').show();
			setQmsReason();
			break;
		case 'kmaMapleMap':
			$('#equipNm').attr("placeholder", '장비명 검색');
			$("#s_fac_code_nm").html("<option value=''>장비</option>");
			$('#search_time_group').hide();
			$('#search_equip_no_area').hide(); 
			$('#search_fac_code_nm_area').hide();
			$('#s_fac_kind_code').hide();
			$('#search_masage_area').show();	
			$('#search_fac_code_area').show();
			$('#search_kma_save_date_area').show();
			$('#search_smltn_area').show();
			$('#equipNm_area').show();
			$('#equipFluxBaseExcelBtn').hide();
			searchData(1);
			break;
		case 'equipOper':
			$('#equipNm').attr("placeholder", '장비명 검색');
			$("#s_fac_code_nm").html("<option value=''>장비</option>");
			$('#search_time_group').hide();
			$('#search_equip_no_area').hide();
			$('#search_fac_code_nm_area').hide();
			$('#search_equip_regist_area').show();
			$('#search_equip_management_grp_area').show();
			$('#s_equip_conn_sts').hide();
			
			searchConditionObj.s_fac_kind_code 		= $("#s_fac_kind_code :selected").val();
			searchConditionObj.s_equip_manage_gbn	= $("#search_equip_management_grp_area :selected").val();
			setInstallYear();
    		// 장비운영현황집계테이블 조회
    		inqEquipStatusTotal();
    		
			searchData(1);
			break;
		case 'equipMng':
			$('#equipNm').attr("placeholder", '장비명 검색');
			$("#s_fac_code_nm").html("<option value=''>장비</option>");
			$('#search_time_group').show();
			$('#search_time_term').hide();
			$('#search_time_btn').show();
			$('#search_equip_no_area').hide();
			$('#search_fac_code_nm_area').hide();

			setBetweenDate();

			searchConditionObj.s_fac_kind_code 		= $("#s_fac_kind_code :selected").val();

			setInstallYear();

			if(!rawrisIsEmpty(searchConditionObj.p_equip_no)){
				searchConditionObj.s_equip_no = searchConditionObj.p_equip_no;
				setEquipBaseInfo();
			}
			searchData(1);
			break;
		case 'qualityMng':
			$('#search_fac_kind_code_area').hide();
			$('#search_equip_no_area').hide();
			$('#equipNm_area').hide();
			$('#search_fac_code_nm_area').hide();
			$('#search_time_group').hide();

			searchData(1);
			break;
		case 'gisPop':
			searchData(1);
			break;
		case 'receptionRate':
			$('#search_buseo_head_code_area').show();
			$('#search_buseo_branch_code_area').show();
			$('#search_fac_kind_code_area').show();
			$('#search_equip_no_area').show();
			$('#equipNm_area').show();
			$('#search_fac_code_nm_area').hide();
			$('#s_year_area').show();
			
			setInstallYear();
			break;
		case 'equipDisposal':
			$('#search_time_group').hide();
			$('#search_equip_no_area').hide();
			$('#search_fac_code_nm_area').hide();
			$('#equip_standard_code_area').show();
			searchData(1);
			break;

		case 'infoMeteo':
			$('#search_time_group').hide();
			$('#search_fac_kind_code_area').hide();
			searchData();
			break;
	}
	
	//on_init_search_box();


	/**************************************************************************************
	* Search Form Event
	**************************************************************************************/
	// 본부 변경 
	$("#s_buseo_head_code").change(function(evt){
		searchConditionObj.s_buseo_head_code	= $("#s_buseo_head_code :selected").val();
		searchConditionObj.s_equip_name			= '';
		$("#equipNm").val('');
		buseoHeadCodeChange();
		buseoBranchCodeChange();
	});  
	
	// 본부 변경 
	$("#v_buseo_head_code").change(function(evt){
		searchConditionObj.v_buseo_head_code	= $("#v_buseo_head_code :selected").val();
		searchConditionObj.v_equip_name			= '';
		$("#v_equipNm").val('');
		v_buseoHeadCodeChange();
	}); 

	// 지사 변경 
	$("#s_buseo_branch_code").change(function(evt){
		searchConditionObj.s_buseo_branch_code = $("#s_buseo_branch_code :selected").val();
		searchConditionObj.s_equip_name			= '';
		$("#equipNm").val('');
		buseoBranchCodeChange();
	}); 
	
	// 지사 변경 
	$("#v_buseo_branch_code").change(function(evt){
		searchConditionObj.v_buseo_branch_code = $("#v_buseo_branch_code :selected").val();
		searchConditionObj.v_equip_name			= '';
		$("#v_equipNm").val('');
		v_buseoBranchCodeChange();
	}); 
	
	// 시설종류 변경
	$("#s_fac_kind_code").change(function(evt){
		facKindCodeChange();
	});
	
	// 시설기준 정보 페이지에서 시설 변경 시
	$("#s_equip_no").change(function(evt){
		searchConditionObj.s_equip_no = $("#s_equip_no :selected").val();
		$("#equipNm").val('');
		$("#s_fac_code_nm").html("<option value='0'>시설명</option>");
		equipNoChange();
	});
	
	var popUpWin;
	// 시설기준 정보 페이지에서 시설 변경 시
	$("#qms_help_btn").click(function(evt){ 
	    if(popUpWin != null){
	    	popUpWin.close();
	    } 
	    var url = "/wrms/qms/qms_help_p01";
        var name = "FAQ";
	    var option = "width = 1461px, height = 837px, top = 120, left = 220, location = no, scrollbars = yes;";
	    popUpWin = window.open(url, name, option);
	    popUpWin.focus();
	});
	
	//조건 SelectBox 변경 시 기간 설정 초기화
	$("#s_kind_time").change(function(evt){ 
		var sKindTime	= evt.target.value;
		var strToDay	= rawrisGetDate({});
		
		searchConditionObj.s_kind_time = sKindTime;
		
		setBetweenDate();
	});
	
	// 장비유지관리 기간 버튼 클릭 시 처리
	$("[id^='dateTermBtn_']").click(function(evt){
//		$("#final_object_view").html('');
		var termDiv = $(this).data("termdiv"); 
	
//		rawrisShowErrMsgDivAdd('termDiv = '+ termDiv +'</br>');
		
		$("#equipNm").val('');
		searchConditionObj.s_equip_name = $("#equipNm").val();
		searchConditionObj.termDiv		= termDiv;
		searchConditionObj.s_kind_time 	= termDiv;
		setBetweenDate();
	});

	// 시설명 검색
	$("#equipNm").keypress(function(evt){
		var nm = $("#equipNm").val();
		if(rawrisIsEmpty(nm)) return;
		
		if(evt.key == 'Enter'){
			if (searchConditionObj.s_type == 'equipList'
				|| searchConditionObj.s_type == 'equipOper'
				|| searchConditionObj.s_type == 'equipDisposal'
				|| searchConditionObj.s_type == 'equipMng'
				|| searchConditionObj.s_type == 'totEquipList'
				|| searchConditionObj.s_type == 'winsLostList'
				|| searchConditionObj.s_type == 'kmaMapleMap'
				|| searchConditionObj.s_type == 'qmsParamList'
				|| searchConditionObj.s_type == 'qmsHistList'
				|| searchConditionObj.s_type == 'qmsWorkMng'	
				){
				// 장비등록 관리 페이지 장비명 운영현황, 통신상태, 설치년도 초기화
				$("#s_equip_oper_sts_code").val('').prop("selected", true);
				$("#s_equip_conn_sts").val('').prop("selected", true);
				$("#s_equip_install_year").val('').prop("selected", true);

				searchConditionObj.termDiv	= '';
				searchConditionObj.s_start_date		= '';
				searchConditionObj.s_end_date		= '';
				searchConditionObj.s_fac_kind_code	= $("#s_fac_kind_code").val();
				
				if ( searchConditionObj.s_type == 'equipDisposal') searchConditionObj.equip_st_code	= $("#equip_st_code").val();

				searchConditionObj.s_equip_name = $("#equipNm").val();
				searchData(1);
			}else if(searchConditionObj.s_type == 'qmsAutoResult' || searchConditionObj.s_type == 'qmsInpoResult'|| searchConditionObj.s_type == 'qmsManualSearch' 
				  || searchConditionObj.s_type == 'qmsReport'  
			){
				var dynaGenComboFacNmCodeObj =	{
						comboInfo     : { targetId : "#s_fac_code_nm" }
					,	optionValInfo : { optId : "equip_no" , optTxt : "equip_name" }
					,	optionInfo    : { postion : "top" , txt : "시설" , val : "" }
					,	comboDataInfo : rawrisAjaxPost({
															sql      		: sqlSearchFormMapper + "qms_sisul_list_from_equip_name"
														,	key_word		: $("#equipNm").val()
														,	s_gbn			: $("#s_management_data_gubun").val() 
											          }) 
				};
				rawrisDynaGenSelectOptions(dynaGenComboFacNmCodeObj);

			}else{
				
				var bcd = searchConditionObj.uBcd;
				if(bcd && bcd.substr(0, 1) != '3' && bcd.substr(0, 1) != '4')
					bcd = 3;
				
				var dynaGenComboFacNmCodeObj =	{
						comboInfo     : { targetId : "#s_fac_code_nm" }
					,	optionValInfo : { optId : "equip_no" , optTxt : "equip_name" }
					,	optionInfo    : { postion : "top" , txt : "시설" , val : "" }
					,	comboDataInfo : rawrisAjaxPost({
															sql      		: sqlSearchFormMapper + "sisul_list_from_name"
														,	key_word		: $("#equipNm").val()
														,	user_buseo_code : bcd
														,	s_type			: searchConditionObj.s_type
													  }) 
				};
				rawrisDynaGenSelectOptions(dynaGenComboFacNmCodeObj);
			}
		}
	});
	
	// 시설명 검색
	$("#v_equipNm").keypress(function(evt){
		var nm = $("#v_equipNm").val();
		if(rawrisIsEmpty(nm)) return;
		
		var bcd = searchConditionObj.uBcd;
		if(evt.key == 'Enter'){
			var dynaGenComboFacNmCodeObj =	{
					comboInfo     : { targetId : "#v_fac_code_nm" }
				,	optionValInfo : { optId : "equip_no" , optTxt : "equip_name" }
				,	optionInfo    : { postion : "top" , txt : "시설" , val : "" }
				,	comboDataInfo : rawrisAjaxPost({
														sql      		: sqlSearchFormMapper + "qms_sisul_list_from_equip_name"
													,	key_word		: $("#v_equipNm").val()
													,	s_gbn			: $("#v_management_data_gubun").val() 
										          })
			};
			rawrisDynaGenSelectOptions(dynaGenComboFacNmCodeObj);
		}
	});
	
	//시설명 선택 : $("#s_fac_code_nm").keypress 와 연결 
	$("#s_fac_code_nm").change(function(evt){   
		searchConditionObj.s_equip_no = $(evt.target).val();
		
		if(searchConditionObj.s_equip_no.length == 10) 
			$("#s_management_data_gubun").val('2').prop("selected", true);
		else 
			$("#s_management_data_gubun").val('1').prop("selected", true);
		
		if(searchConditionObj.s_type == 'qmsAutoResult' || searchConditionObj.s_type == 'qmsInpoResult' || searchConditionObj.s_type == 'qmsManualSearch'
			|| searchConditionObj.s_type == 'qmsReport' 
		){
			setQmsBaseInfo();
		}else											 
			setEquipBaseInfo();	
	});
	
	//시설명 선택 : $("#v_fac_code_nm").keypress 와 연결 
	$("#v_fac_code_nm").change(function(evt){   
		searchConditionObj.v_equip_no = $(evt.target).val();
		v_setQmsBaseInfo();
	});
	
	// 운영 현황 변경 시 검색을 위해 시설종류 / 시설명 검색 등 초기화
	$("#s_equip_oper_sts_code").change(function(evt){
		$("#equipNm").val('');
		searchConditionObj.s_equip_name = '';
	});
	
	// 통신현황 변경 시 검색을 위해 시설종류 / 시설명 검색 등 초기화
	$("#s_equip_conn_sts").change(function(evt){
		$("#equipNm").val('');
		searchConditionObj.s_equip_name = '';
	});
	
	// 설치년도 변경 시 검색을 위해 시설종류 / 시설명 검색 등 초기화
	$("#s_equip_install_year").change(function(evt){
		$("#equipNm").val('');
		searchConditionObj.s_equip_name = '';
	});
	
	// 검색버튼 클릭 
	$("#equipFluxBaseSearchBtn").click(function(evt){ 
		var chkVali = true;
		if(searchConditionValidate()) { // 검색조건 유효성 체크
			searchConditionObj.s_fac_kind_code		= $("#s_fac_kind_code :selected").val();
			searchConditionObj.s_equip_no			= $("#s_equip_no :selected").val();
			searchConditionObj.s_kind_time			= $("#s_kind_time :selected").val();
			searchConditionObj.s_equip_name 		= $("#equipNm").val();
			if (searchConditionObj.termDiv == 'all'){
				searchConditionObj.s_start_date		= '';
				searchConditionObj.s_end_date		= '';
			}else{
				searchConditionObj.s_start_date        = $("#s_start_date").val();
				searchConditionObj.s_end_date          = $("#s_end_date").val();
			}
			
//			rawrisShowErrMsgDivAdd('searchConditionObj.s_equip_name = '+ searchConditionObj.s_equip_name +' </br>');
//			rawrisShowErrMsgDivAdd('searchConditionObj.s_buseo_branch_code = '+ searchConditionObj.s_buseo_branch_code +' </br>');
			
			if (searchConditionObj.s_type == 'sisul') {
				chkVali = setEquipNoArray();
			}
			
			if(chkVali){
				searchData(1);
				switch (searchConditionObj.s_type){
					case 'infoReser':
						break;
					case 'infoWater':
						break;
					case 'flow':
						searchCalculate();
						break;
					case 'sisul':
						searchCalculate();
						break;
					case 'equipOper':
						// 장비운영현황집계테이블 조회
			    		inqEquipStatusTotal();
						break;
					case 'qualityMng':
						searchData();
						break;
				}
			}
	   } 
	});
	
 	// 사용자 목록에서 수정버튼 클릭
	$("#rawris_equip_regist_mgt_list_table > tbody").click(function(evt){
		if(!rawrisIsEmpty( $(evt.target).attr("id") )){
			var btnId = $(evt.target).attr("id");
			if(btnId.indexOf("equip_regmgt_updateBtn")> -1){
				var equipNo = $(evt.target).data("equip_no");
				if(confirm('장비수정 하시겠습니까?')) {
					var hiddenFormInfo = { formDefine : { fid     : "equip_modify_form"   
						                              //, action  : "/admin_equip_info_base_update.jsp" 
						                                , action  : getContextPath()+"/registmgt/equip_regist/equip_update" 
						                                , method : "post" 
						                                , style:"display:none;" }
								         , formAttrs  : { equip_no : {type:"text" ,val: equipNo} 
								                        }       
						                 } 
					rawrisDynaGenHiddenForm(hiddenFormInfo);
					$("#equip_modify_form").submit(); 
			   } 
		    } 
		 }   
	   });

	// 등록(장비등록) 버튼 Click Event  	
    $("#equipRegMgtRegistBtn").click(function(evt){ 
    	equipRegistBtnClick();
    });
	
	// 기간설정
	$('[id$=_date]').change(function(evt){
		evt.stopPropagation();
		var dateID				= $(this).attr('id');
		betweenDate.chkChange	= (dateID == 's_start_date') ? 'S' : 'E';

		searchConditionObj.termDiv	= '';
		
//		rawrisShowErrMsgDivAdd('betweenDate.chkStat = '+ betweenDate.chkStat +' </br>');
		
		if (betweenDate.chkStat) setBetweenDate();
	});
	
	// 엑셀 저장 	
    $("#equipFluxBaseExcelBtn").click(function(){  
    	// 유량정보 (시설별) 경우 유량계산 포함할 장비 정보 가져오기
    	var chkBefore = true;

    	if (searchConditionObj.s_type == 'sisul') chkBefore = setEquipNoArray();
 
    	if(chkBefore) excelDown();
 	});

    $("#rawris_equip_quilityTotal_list_table > tbody").click(function(evt){
		if(!rawrisIsEmpty($(evt.target).data("grp_gbn_code"))){
			var grpGbnCode = $(evt.target).data("grp_gbn_code");
			var grpCode = $(evt.target).data("grp_code");
			
			if(grpGbnCode == "1"){
				$("#s_buseo_head_code").val(grpCode).prop("selected", true);
				searchConditionObj.s_buseo_head_code = grpCode;
				buseoHeadCodeChange();
			}else if(grpGbnCode == "2"){
				$("#s_buseo_branch_code").val(grpCode).prop("selected", true);
				searchConditionObj.s_buseo_branch_code = grpCode;
			}else if(grpGbnCode == "3") { 
				var formInfo = { formDefine : { fid:"equipQualityTotDetForm" , action:"/wrms/dataview/wrms_reservoir" , method : "post" }
						       , formAttrs  : { equip_no		: {name : "quality_equip_no",		val:grpCode } 
						       				,	buseo_head		: {name : "quality_buseo_head",		val:searchConditionObj.s_buseo_head_code }
						       				,	buseo_branch	: {name : "quality_buseo_branch",	val:searchConditionObj.s_buseo_branch_code }
						                      }       
				               } 
  				 rawrisDynaGenHiddenForm(formInfo); 
  				 $("#equipQualityTotDetForm").submit(); 
			}  
			searchData();
		} 
	});
    
    if(typeof initializeForm == 'function') {
    	initializeForm();
    }
});

var sqlSearchFormMapper = "rawris.wrms.searchform."

/**************************************************************************************
* function buseoHeadCodeChange()
* 지역본부 변경 시 지사 셋팅하기
**************************************************************************************/
function buseoHeadCodeChange(){
//		rawrisShowErrMsgDivAdd('buseoHeadCodeChange()</br>');
	if(!rawrisIsEmpty(searchConditionObj.s_buseo_head_code)){
		if(searchConditionObj.s_buseo_head_code == '319'){ // 제주도일 경우 예외처리
			searchConditionObj.s_buseo_branch_code = '3191100';
			$("#s_buseo_branch_code").html("<option value=''>지사</option>");
			buseoBranchCodeChange();
		}else{
			searchConditionObj.s_buseo_branch_code = '';
			//유량정보에서 매닝 삭제 로직 추가 2020.07.14 jty
			var sql = sqlSearchFormMapper + "list_for_buseo_branch_list"
			
			if(searchConditionObj.s_type == 'sisul' || searchConditionObj.s_type == 'flow' || searchConditionObj.s_type == 'flow_sum' || searchConditionObj.s_type == 'flow_sum_rsvr'){
				sql = sqlSearchFormMapper + "list_for_buseo_branch_list_water";
				var dynaGenComboBranchInfoObj = {
						  comboInfo     : { targetId : "#s_buseo_branch_code" }
						, optionInfo    : { postion  : "top" , txt : "지사" , val : "" }
						, optionValInfo : { optId    : "buseo_branch_code"  , optTxt : "buseo_branch_name" }   
						, comboDataInfo : rawrisAjaxPost({ sql              : sql
							                            , s_buseo_head_code : searchConditionObj.s_buseo_head_code
							                            , s_type            : searchConditionObj.s_type
								                       })
												};
			}else{
				var dynaGenComboBranchInfoObj = {
						  comboInfo     : { targetId : "#s_buseo_branch_code" }
						, optionInfo    : { postion  : "top" , txt : "지사" , val : "" }
						, optionValInfo : { optId    : "buseo_branch_code"  , optTxt : "buseo_branch_name" }   
						, comboDataInfo : rawrisAjaxPost({ sql              : sql
							                            , s_buseo_head_code : searchConditionObj.s_buseo_head_code
								                       })				                       
												};
			}
			rawrisDynaGenSelectOptions(dynaGenComboBranchInfoObj);
		}
	}else{
		searchConditionObj.s_buseo_head_code	= '';
		searchConditionObj.s_buseo_branch_code 	= '';
		searchConditionObj.s_equip_no		= '';

		$("#s_buseo_branch_code").html("");
		$("#s_buseo_branch_code").html("<option value=''>지사</option>");
		$("#s_equip_no").html("<option value=''>시설</option>");
		$("#equipNm").val('');
		$("#s_fac_code_nm").html("<option value='0'>시설명</option>");
	}
}

/**************************************************************************************
* function buseoHeadCodeChange()
* 지역본부 변경 시 지사 셋팅하기
**************************************************************************************/
function v_buseoHeadCodeChange(){
//		rawrisShowErrMsgDivAdd('buseoHeadCodeChange()</br>');
	if(!rawrisIsEmpty(searchConditionObj.v_buseo_head_code)){	
		searchConditionObj.v_buseo_branch_code = '';
		var sql = sqlSearchFormMapper + "list_for_buseo_branch_list"
		var dynaGenComboBranchInfoObj = {
				  comboInfo     : { targetId : "#v_buseo_branch_code" }
				, optionInfo    : { postion  : "top" , txt : "지사" , val : "" }
				, optionValInfo : { optId    : "buseo_branch_code"  , optTxt : "buseo_branch_name" }   
				, comboDataInfo : rawrisAjaxPost({ sql              : sql
					                             , s_buseo_head_code : searchConditionObj.v_buseo_head_code
						                       })				                       
										};
		rawrisDynaGenSelectOptions(dynaGenComboBranchInfoObj);
	
	}else{
		searchConditionObj.v_buseo_head_code	= '';
		searchConditionObj.v_buseo_branch_code 	= '';
		searchConditionObj.v_equip_no		= '';

		$("#v_buseo_branch_code").html("");
		$("#v_buseo_branch_code").html("<option value=''>지사</option>");
		$("#v_equipNm").val('');
		$("#v_fac_code_nm").html("<option value='0'>시설명</option>");
	}
}

/**************************************************************************************
* function buseoBranchCodeChange()
* 지사 변경 시 하부 정보 셋팅하기
* 기본: 시설종류, 시설
**************************************************************************************/
function buseoBranchCodeChange(){
//		rawrisShowErrMsgDivAdd('buseoBranchCodeChange()</br>');
	if(!rawrisIsEmpty(searchConditionObj.s_buseo_branch_code)){
		if(searchConditionObj.s_type == 'kmaMapleMap'){
			sqlEquipListKind	= 'rims_sisul_list_from_buseo_branch_code';
			
			var dynaGenSelectEquipList = {
					comboInfo     : { targetId	: "#s_fac_code" 									}
				,	optionInfo    : { postion	: "top",		txt 	: "선택",			val : ""	}
				,	optionValInfo : { optId		: "fac_code",	optTxt	: "fac_name"				} 
				,	comboDataInfo : rawrisAjaxPost({
										sql					: sqlSearchFormMapper + sqlEquipListKind
									,	s_buseo_branch_code	: searchConditionObj.s_buseo_branch_code
									})
			};
	      	rawrisDynaGenSelectOptions(dynaGenSelectEquipList);
		}else if(searchConditionObj.s_type == 'qmsParamList'){
				sqlEquipListKind	= 'qms_sisul_list_from_buseo_branch_code';
				
				var dynaGenSelectEquipList = {
						comboInfo     : { targetId	: "#s_fac_code" 									}
					,	optionInfo    : { postion	: "top",		txt 	: "선택",			val : ""	}
					,	optionValInfo : { optId		: "param_mng_no",	optTxt	: "equip_name"			} 
					,	comboDataInfo : rawrisAjaxPost({
											sql					: sqlSearchFormMapper + sqlEquipListKind
										,	s_buseo_branch_code	: searchConditionObj.s_buseo_branch_code
										,	s_gbn	            : $("#s_management_data_gubun :selected").val()
										})
				};
		      	rawrisDynaGenSelectOptions(dynaGenSelectEquipList);
		}else if(searchConditionObj.s_type == 'qmsAutoResult' || searchConditionObj.s_type == 'qmsInpoResult' || searchConditionObj.s_type == 'qmsManualSearch' 
			  || searchConditionObj.s_type == 'qmsHistList' || searchConditionObj.s_type == 'qmsReport' || searchConditionObj.s_type == 'qmsWorkMng'){
			sqlEquipListKind	= 'qms_auto_sisul_list_from_buseo_branch_code';
			
			var dynaGenSelectEquipList = {
					comboInfo     : { targetId	: "#s_fac_code" 									}
				,	optionInfo    : { postion	: "top",		txt 	: "선택",			val : ""	}
				,	optionValInfo : { optId		: "equip_no",	optTxt	: "equip_name"				} 
				,	comboDataInfo : rawrisAjaxPost({
										sql					: sqlSearchFormMapper + sqlEquipListKind
									,	s_buseo_branch_code	: searchConditionObj.s_buseo_branch_code
									,	s_gbn	            : $("#s_management_data_gubun :selected").val()
									})
			};
	      	rawrisDynaGenSelectOptions(dynaGenSelectEquipList);
		}else{
			sqlEquipListKind	= 'sisul_list_from_buseo_branch_code';
			
			//rawrisShowErrMsgDivAdd('searchConditionObj.facKind == '+ searchConditionObj.facKind +'</br>');
	
			// 시설종류 셋팅
			switch (searchConditionObj.s_type){
				case 'infoReser':
					searchConditionObj.facKind	= '1';
					break;
				case 'infoMeteo':
					searchConditionObj.facKind	= '1';
					break;
				default:
					break;
			}
			
			var dynaGenSelectEquipList = {
					comboInfo     : { targetId	: "#s_equip_no" 									}
				,	optionInfo    : { postion	: "top",		txt 	: "선택",			val : ""	}
				,	optionValInfo : { optId		: "equip_no",	optTxt	: "equip_name"				} 
				,	comboDataInfo : rawrisAjaxPost({
										sql					: sqlSearchFormMapper + sqlEquipListKind
									,	s_buseo_branch_code	: searchConditionObj.s_buseo_branch_code
									,	s_fac_kind_code		: searchConditionObj.facKind
									,	s_type				: searchConditionObj.s_type
									})
			};
	      	rawrisDynaGenSelectOptions(dynaGenSelectEquipList); 
		}
	}else{
//			$("#final_object_view").html('');
//			rawrisShowErrMsgDivAdd('buseoBranchCodeChange() false </br>');
		
		$("#s_equip_no").html("<option value=''>시설</option>");
		$("#equipNm").val('');
		$("#s_fac_code_nm").html("<option value='0'>시설명</option>");
		$("#s_fac_code").html("<option value=''>시설</option>");
	}
	
}

//수동보정 비교저수지
function v_buseoBranchCodeChange(){
//	rawrisShowErrMsgDivAdd('buseoBranchCodeChange()</br>');
	if(!rawrisIsEmpty(searchConditionObj.v_buseo_branch_code)){
			var dynaGenSelectEquipList = {
					comboInfo     : { targetId	: "#v_fac_code" 									}
				,	optionInfo    : { postion	: "top",		txt 	: "선택",			val : ""	}
				,	optionValInfo : { optId		: "equip_no",	optTxt	: "equip_name"				} 
				,	comboDataInfo : rawrisAjaxPost({
										sql					: sqlSearchFormMapper + 'qms_auto_sisul_list_from_buseo_branch_code'
									,	s_buseo_branch_code	: searchConditionObj.v_buseo_branch_code
									,	s_gbn	            : $("#v_management_data_gubun :selected").val()
									})
			};
	      	rawrisDynaGenSelectOptions(dynaGenSelectEquipList);
		
	}else{
		$("#v_equipNm").val('');
		$("#v_fac_code_nm").html("<option value='0'>시설명</option>");
		$("#v_fac_code").html("<option value=''>시설</option>");
	}
}


//보정사유 셋팅
function setQmsReason(){
	var qmsReason = {
			comboInfo     : { targetId	: "#s_qms_reason" 									}
		,	optionInfo    : { postion	: "top",		txt 	: "보정사유",		val : ""	}
		,	optionValInfo : { optId		: "qms_cd",		optTxt	: "qms_cd_nm"				} 
		,	comboDataInfo : rawrisAjaxPost({
								sql			: sqlSearchFormMapper + 'select_qms_reason_list'
							,	s_grp_cd 	: "QC_CD"
							,	s_attr1_a	: "A"
							,	s_attr1_b	: "M"
							,	s_attr1_c	: "XXXXX"
							})
	};
  	rawrisDynaGenSelectOptions(qmsReason);	
}

/**************************************************************************************
* function setEquipHeadBuseoCode()
* 본부값 채우기
**************************************************************************************/
function setEquipHeadBuseoCode(){
	searchConditionObj.s_equip_no = '';
	var dynaGenComboBranchInfoObj = {
			  comboInfo     : { targetId : "#s_buseo_head_code" }
			, optionInfo    : { postion  : "top" , txt : "본부" , val : "" }
			, optionValInfo : { optId    : "buseo_head_code"    , optTxt : "buseo_head_name" } 
			, comboDataInfo : rawrisAjaxPost({ sql             : sqlSearchFormMapper + "list_for_buseo_head_list"
				                            ,  s_fac_kind_code : $("#s_fac_kind_code :selected").val()
				                            })
	}; 
	rawrisDynaGenSelectOptions(dynaGenComboBranchInfoObj);
	searchConditionObj.facKind = '99';
}

/**************************************************************************************
* function v_setEquipHeadBuseoCode()
* 수동보정 비교저수지 본부값 채우기
**************************************************************************************/
function v_setEquipHeadBuseoCode(){
	searchConditionObj.v_equip_no = '';
	var dynaGenComboBranchInfoObj = {
			  comboInfo     : { targetId : "#v_buseo_head_code" }
			, optionInfo    : { postion  : "top" , txt : "본부" , val : "" }
			, optionValInfo : { optId    : "buseo_head_code"    , optTxt : "buseo_head_name" } 
			, comboDataInfo : rawrisAjaxPost({ sql             : sqlSearchFormMapper + "list_for_buseo_head_list"
				                            ,  s_fac_kind_code : '1'
				                            })
	}; 
	rawrisDynaGenSelectOptions(dynaGenComboBranchInfoObj);
	searchConditionObj.facKind = '99';
}

/**************************************************************************************
* function setQmsMethodCode()
* 품질관리방법  채우기 채우기
**************************************************************************************/
function setQmsMethodCode(){
	searchConditionObj.s_equip_no = '';
	var dynaGenComboBranchInfoObj = {
			    comboInfo     : { targetId : "#s_qms_method" }
		    ,	optionInfo    : { postion : "top" , txt : "품질관리방법" , val : "" }
			,	optionValInfo : { optId : "cd" , optTxt : "cd_nm" }
			,   comboDataInfo : rawrisAjaxPost({
													sql      : sqlSearchFormMapper + "list_qms_combo_data"
												,	key_word : 'QC_METHOD'
											    }) 
	}; 
	rawrisDynaGenSelectOptions(dynaGenComboBranchInfoObj);
}




/**************************************************************************************
* function facKindCodeChange()
* 시설종류 선택 시
**************************************************************************************/
function facKindCodeChange(){
//		$("#final_object_view").html('');
//		rawrisShowErrMsgDivAdd('facKindCodeChange()</br>');
	var changeSisul = (searchConditionObj.uBlvl == 3) ? true : (changeSisul = (rawrisIsEmpty(searchConditionObj.s_buseo_branch_code)) ? false : true);
	
	searchConditionObj.facKind	= ($("#s_fac_kind_code :selected").length == 0) ? '99' : $("#s_fac_kind_code :selected").val();

//		rawrisShowErrMsgDivAdd('searchConditionObj.facKind = '+ searchConditionObj.facKind +'</br>');

	$("#s_equip_no").html("<option value=''>시설</option>");
	
	if (searchConditionObj.s_type != 'equipList'
		&& searchConditionObj.s_type != 'equipOper'
		&& searchConditionObj.s_type != 'receptionRate'
		&& searchConditionObj.s_type != 'equipDisposal'
		&& searchConditionObj.s_type != 'totEquipList'
		&& searchConditionObj.s_type != 'winsLostList'
		&& searchConditionObj.s_type != 'equipMng'){
		changeSisul = (changeSisul) ? buseoBranchCodeChange() : rawrisShowMsg('지사를 선택하세요') ;
	}else{
		buseoBranchCodeChange();
	}
	
	if (searchConditionObj.facKind == '99'){
		$("#equipNm").val('');
		$("#s_fac_code_nm").html("<option value='0'>시설명</option>");
	}
}

/**************************************************************************************
* function setFacKind()
* 시설 종류 채우기 (페이지 별 옵션이 다를 수 있음)
**************************************************************************************/
function setFacKind(){
//		rawrisShowErrMsgDivAdd('setFacKind()</br>');
	var facKindArray = new Array();
	switch (searchConditionObj.s_type){
		case 'infoReser':
			break;
		case 'infoWater':
			facKindArray = [{fac_kind :'R'	, fac_Kind_name:'저수지수로'	}
						,	{fac_kind :'2'	, fac_Kind_name:'양수장'		}
						,	{fac_kind :'3'	, fac_Kind_name:'양배수장'		}
						,	{fac_kind :'4'	, fac_Kind_name:'배수장'		}
						,	{fac_kind :'5'	, fac_Kind_name:'취입보'		}
						,	{fac_kind :'9'	, fac_Kind_name:'방조제'		}
						,	{fac_kind :'0'	, fac_Kind_name:'평야부수로'	}
						] 
			break;
		case 'flow':
			facKindArray = [{fac_kind :'R'	, fac_Kind_name:'저수지수로'	}
						,	{fac_kind :'2'	, fac_Kind_name:'양수장'		}
						,	{fac_kind :'3'	, fac_Kind_name:'양배수장'		}
						,	{fac_kind :'4'	, fac_Kind_name:'배수장'		}
						,	{fac_kind :'5'	, fac_Kind_name:'취입보'		}
						]
			break;
		case 'flow_sum':
			facKindArray = [{fac_kind :'R'	, fac_Kind_name:'저수지수로'	}
						,	{fac_kind :'2'	, fac_Kind_name:'양수장'		}
						,	{fac_kind :'3'	, fac_Kind_name:'양배수장'		}
						,	{fac_kind :'5'	, fac_Kind_name:'취입보'		}
						]
			break;
		case 'sisul':
			facKindArray = [{fac_kind :'1'	, fac_Kind_name:'저수지'		}
						,	{fac_kind :'2'	, fac_Kind_name:'양수장'		}
						,	{fac_kind :'3'	, fac_Kind_name:'양배수장'		}
						,	{fac_kind :'5'	, fac_Kind_name:'취입보'		}
						]
			break;
		case 'equipList':
		case 'totEquipList':
		case 'winsLostList':
			facKindArray = [{fac_kind :'1'	, fac_Kind_name:'저수지'		}
						,	{fac_kind :'88'	, fac_Kind_name:'수로부전체'	}
						,	{fac_kind :'R'	, fac_Kind_name:'저수지수로'	}
						,	{fac_kind :'2'	, fac_Kind_name:'양수장'		}
						,	{fac_kind :'3'	, fac_Kind_name:'양배수장'		}
						,	{fac_kind :'4'	, fac_Kind_name:'배수장'		}
						,	{fac_kind :'5'	, fac_Kind_name:'취입보'		}
						,	{fac_kind :'9'	, fac_Kind_name:'방조제'		}
						,	{fac_kind :'0'	, fac_Kind_name:'평야부수로'	}
						] 
			break;
		case 'equipOper':
		case 'equipDisposal':
			facKindArray = [{fac_kind :'1'	, fac_Kind_name:'저수지'		}
						,	{fac_kind :'88'	, fac_Kind_name:'수로부전체'	}
						,	{fac_kind :'R'	, fac_Kind_name:'저수지수로'	}
						,	{fac_kind :'2'	, fac_Kind_name:'양수장'		}
						,	{fac_kind :'3'	, fac_Kind_name:'양배수장'		}
						,	{fac_kind :'4'	, fac_Kind_name:'배수장'		}
						,	{fac_kind :'5'	, fac_Kind_name:'취입보'		}
						,	{fac_kind :'9'	, fac_Kind_name:'방조제'		}
						,	{fac_kind :'0'	, fac_Kind_name:'평야부수로'	}
						,	{fac_kind :'S'	, fac_Kind_name:'염도계'		}
						] 
			break;
		case 'equipMng':
			facKindArray = [{fac_kind :'1'	, fac_Kind_name:'저수지'		}
						,	{fac_kind :'R'	, fac_Kind_name:'저수지수로'	}
						,	{fac_kind :'2'	, fac_Kind_name:'양수장'		}
						,	{fac_kind :'3'	, fac_Kind_name:'양배수장'		}
						,	{fac_kind :'4'	, fac_Kind_name:'배수장'		}
						,	{fac_kind :'5'	, fac_Kind_name:'취입보'		}
						,	{fac_kind :'9'	, fac_Kind_name:'방조제'		}
						,	{fac_kind :'0'	, fac_Kind_name:'평야부수로'	}
						,	{fac_kind :'S'	, fac_Kind_name:'염도계'		}
						] 
			break;
		case 'receptionRate':
			facKindArray = [{fac_kind :'1'	, fac_Kind_name:'저수지'		}
						,	{fac_kind :'R'	, fac_Kind_name:'저수지수로'	}
						,	{fac_kind :'2'	, fac_Kind_name:'양수장'		}
						,	{fac_kind :'3'	, fac_Kind_name:'양배수장'		}
						,	{fac_kind :'4'	, fac_Kind_name:'배수장'		}
						,	{fac_kind :'5'	, fac_Kind_name:'취입보'		}
						,	{fac_kind :'9'	, fac_Kind_name:'방조제'		}
						,	{fac_kind :'0'	, fac_Kind_name:'평야부수로'	}
						] 
			break;
	}

	var dynaGenSelectFacKind = {
			comboInfo     : { targetId	: "#s_fac_kind_code" 								}
		,	optionInfo    : { postion	: "top",		txt 	: "시설종류",		val : "99"	}
		,	optionValInfo : { optId		: "fac_kind",	optTxt	: "fac_Kind_name"			} 
		,	comboDataInfo : facKindArray
	};
	rawrisDynaGenSelectOptions(dynaGenSelectFacKind);
}

/**************************************************************************************
* function setInstallYear()
* 설치년도 채우기
**************************************************************************************/
function setInstallYear(){
//		$("#final_object_view").html('');
//		rawrisShowErrMsgDivAdd('setInstallYear()</br>');
	var installYearArray = new Array();
	var stYear = 2002; 			// DB 상 가장 오래전 설치된 장비 날짜 기준
	var toDate = rawrisGetDate({});
	
	var cntYear = rawrisDateDiff(stYear+'-01-01', toDate, 'Y');

//		rawrisShowErrMsgDivAdd('cntYear='+ cntYear +'</br>');
	
	if (searchConditionObj.s_type == 'receptionRate'){
		for (i = 0; i <= cntYear; i++){
			$("#s_year").append("<option value='"+ stYear +"'>"+ stYear +"</option>");
			stYear++;
		}
	}else{
		for (i = 0; i <= cntYear; i++){
			$("#s_equip_install_year").append("<option value='"+ stYear +"'>"+ stYear +"</option>");
			stYear++;
		}
	}
		
}



/**************************************************************************************
* function equipNoChange()
* 시설중심 정보 페이지 (ex. 유량정보(시설별))에서 시설 선택 시 해당 시설의 하부 정보 가져오기
* searchConditionObj.s_type == 'sisul' 일때만 동작
**************************************************************************************/
function equipNoChange(){
//		$("#final_object_view").html('');
//		rawrisShowErrMsgDivAdd('equipNoChange()</br>');
	
//		rawrisShowErrMsgDivAdd('searchConditionObj.s_equip_no = '+ searchConditionObj.s_equip_no +'</br>');

	if(!rawrisIsEmpty(searchConditionObj.s_equip_no)){
		
		var sqlEquipListKind = (searchConditionObj.s_type == 'sisul') ? true : false;

		if(sqlEquipListKind){
			var dynaGenRadioMangGbn = {
					radioInfo		: { targetId	: "#sisul_sub_equip_no_area",			classNm		: "col-xs-11"}
				,	radioProp		: { radioId		: "sisul_sub_equip_",					radioNm		: "sisul_sub_equip_no",	radioType: 'checkbox',	style	: "margin-left:10px;" }
				,	optionValInfo	: { optCode		: "equip_no",	optTxt : "equip_name",	optChecked	: "checked" } 
				,	radioDataInfo	: rawrisAjaxPost({
										sql					: sqlMapper + "equip_sisul_sub_list"
									  ,	s_equip_no			: searchConditionObj.s_equip_no
									  }) 
/*				, radioDataInfo : [
  				                 	{'equip_no':'2764', equip_name:'대평(포함)', checked:'checked'}
				                 ,	{'equip_no':'2986', equip_name:'백운1(포함)', checked:'checked'}
				                 ,	{'equip_no':'3330', equip_name:'장찬3(포함)', checked:'checked'}
				                 ,	{'equip_no':'3331', equip_name:'장찬4(제외)', checked:'checked'}
				                 ,	{'equip_no':'2391', equip_name:'옥계(포함)', checked:'checked'}
				                 ]
*/				};
			var sisulSubEquipObj = dynaGenRadioMangGbn.radioDataInfo[0];
			if(!rawrisIsEmpty(sisulSubEquipObj)){
				rawrisDynaGenRadio(dynaGenRadioMangGbn);
			}else{
				$('#sisul_sub_equip_no_area').html('검색 된 수로계통 정보가 없습니다.');
			}
			$('#s_sisul_sub_equip').show();
		}
		
		if(searchConditionObj.s_type == 'qmsAutoResult' || searchConditionObj.s_type == 'qmsInpoResult' || searchConditionObj.s_type == 'qmsManualSearch' 
			|| searchConditionObj.s_type == 'qmsReport' ){
			$("#equipNm").val('');
			$("#s_fac_code_nm").html("<option value='0'>시설명</option>");
		}
		
	}else{
//			rawrisShowErrMsgDivAdd('chk Here !!!</br>');
		$("#equipNm").val('');
		$("#s_fac_code_nm").html("<option value='0'>시설명</option>");
		//$("#s_fac_code").val('');
	}
}

/**************************************************************************************
* function v_equipNoChange()
* 수동보정 비교대상저수지 장비명검색후 장비명 선택시
**************************************************************************************/
function v_equipNoChange(){
	$("#v_equipNm").val('');
	$("#v_fac_code_nm").html("<option value='0'>시설명</option>");
}

/**************************************************************************************
* function setQmsBaseInfo();
* 시설 선택 시 본부/지사/종류 선택
* 품질관리 개별 장비 선택시 필요
**************************************************************************************/
function setQmsBaseInfo(){
	var equipNavObjList	= rawrisAjaxPost({
		sql			: sqlSearchFormMapper + "set_searchform_from_qmsSisulName"
	, 	equip_no	: searchConditionObj.s_equip_no
	});
	var equipNavObj 	= equipNavObjList[0]; 
	
	searchConditionObj.s_equip_no			= equipNavObj.equip_no;

	if(!rawrisIsEmpty(equipNavObj)){
		buseoBranchCodeChange();
		equipNoChange();
	} 
	
	// 본사일 경우 본부/지사/시설 정보 셋팅하기
	searchConditionObj.s_buseo_head_code	= equipNavObj.buseo_head_code;
	$("#s_buseo_head_code").val(searchConditionObj.s_buseo_head_code).prop("selected", true);
	buseoHeadCodeChange();

	searchConditionObj.s_buseo_branch_code 	= equipNavObj.buseo_branch_code;
	$("#s_buseo_branch_code").val(searchConditionObj.s_buseo_branch_code).prop("selected", true);
	buseoBranchCodeChange();
	
	$("#s_fac_code").val(searchConditionObj.s_equip_no).prop("selected", true);

	if( searchConditionObj.s_equip_no.length == 10 ) searchConditionObj.s_kind_time = 'daily';
	else		     			  searchConditionObj.s_kind_time = 'minute';
	setBetweenDate();
		
	if( searchConditionObj.s_type == 'qmsReport' ) 
		 searchConditionObj.s_fac_code =  searchConditionObj.s_equip_no;
	else searchConditionObj.s_code     =  searchConditionObj.s_equip_no;
	//console.log(1, searchConditionObj.s_code );

	if( searchConditionObj.s_type == 'qmsManualSearch' ) 
		vFacCodeChange(searchConditionObj.s_buseo_head_code, searchConditionObj.s_buseo_branch_code, searchConditionObj.s_equip_no);
}

function v_setQmsBaseInfo(){
	var equipNavObjList	= rawrisAjaxPost({
		sql			: sqlSearchFormMapper + "set_searchform_from_qmsSisulName"
	, 	equip_no	: searchConditionObj.v_equip_no
	});

	var equipNavObj 	= equipNavObjList[0]; 
	
	searchConditionObj.v_equip_no			= equipNavObj.equip_no;
	
	if(!rawrisIsEmpty(equipNavObj)){
		v_buseoBranchCodeChange();
		v_equipNoChange();
	} 
	
	// 본사일 경우 본부/지사/시설 정보 셋팅하기
	searchConditionObj.v_buseo_head_code	= equipNavObj.buseo_head_code;
	$("#v_buseo_head_code").val(searchConditionObj.v_buseo_head_code).prop("selected", true);
	v_buseoHeadCodeChange();
	
	searchConditionObj.v_buseo_branch_code 	= equipNavObj.buseo_branch_code;
	$("#v_buseo_branch_code").val(searchConditionObj.v_buseo_branch_code).prop("selected", true);
	v_buseoBranchCodeChange();
	
	$("#v_fac_code").val(searchConditionObj.v_equip_no).prop("selected", true);

	searchConditionObj.v_code =  searchConditionObj.v_equip_no; 
	//console.log(1, searchConditionObj.s_code );

} 


/**************************************************************************************
* function setEquipBaseInfo();
* 시설 선택 시 본부/지사/종류 선택
* 시설명 검색, 유지관리 > 유지관리이력 페이지 이동 시 필요
**************************************************************************************/
function setEquipBaseInfo(){
//		$("#final_object_view").html('');
//		rawrisShowErrMsgDivAdd('setEquipBaseInfo() </br>');

	var equipNavObjList	= rawrisAjaxPost({
		sql			: sqlSearchFormMapper + "set_searchform_from_sisulname"
	, 	equip_no	: searchConditionObj.s_equip_no
	});
	var equipNavObj 	= equipNavObjList[0]; 

	searchConditionObj.s_equip_no			= equipNavObj.equip_no;
	searchConditionObj.facKind				= equipNavObj.fac_kind_code;

	if(!rawrisIsEmpty(equipNavObj)){
//			rawrisShowErrMsgDivAdd('chkThis22!! </br>');
		switch (searchConditionObj.s_type){
			case 'infoReser':
				break;
			case 'infoWater':
				break;
			case 'flow':
				buseoBranchCodeChange();
				break;
			case 'sisul':
				break;
			case 'equipMng':
				break;
		}
		equipNoChange();
	} 
	
	if(searchConditionObj.uBlvl == 2){			// 지역본부일 경우 지사/시설 정보 셋팅
		searchConditionObj.s_buseo_branch_code 	= equipNavObj.buseo_branch_code;
	
		$("#s_buseo_branch_code").val(searchConditionObj.s_buseo_branch_code).prop("selected", true);
		buseoBranchCodeChange();
	}else if(searchConditionObj.uBlvl == 3){ 	// 지사 소속일 경우 시설 정보 셋팅하기
		//rawrisShowErrMsgDivAdd('chkThis!! </br>');
	}else{										// 본사일 경우 본부/지사/시설 정보 셋팅하기
		searchConditionObj.s_buseo_head_code	= equipNavObj.buseo_head_code;
		$("#s_buseo_head_code").val(searchConditionObj.s_buseo_head_code).prop("selected", true);
		buseoHeadCodeChange();

		searchConditionObj.s_buseo_branch_code 	= equipNavObj.buseo_branch_code;
		$("#s_buseo_branch_code").val(searchConditionObj.s_buseo_branch_code).prop("selected", true);
		buseoBranchCodeChange();
	}
	
	$("#s_fac_kind_code").val(searchConditionObj.facKind).prop("selected", true);
	$("#s_equip_no").val(searchConditionObj.s_equip_no).prop("selected", true);
}

/**************************************************************************************
* function setEquipNoArray()
* 유량정보 시설 검색을 위해 하위 장비목록을 만들어 넘긴다.
*  
**************************************************************************************/
function setEquipNoArray(){
//		$("#final_object_view").html('');
	var chkCnt 			= 99;
	var equip_no_gr		= ""; 
	var eqno_gr			= "0 AS T";
	var asText			= new Array('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I');
	var chkTextArray	= 0;
		
	$("input:checkbox[name='sisul_sub_equip_no']").each(function(idx){
		if($(this).is(":checked") == true){
			equip_no_gr = (chkTextArray == 0) ? "'"+ $(this).val() +"'" : equip_no_gr  +", '"+ $(this).val() + "'";
			eqno_gr		= eqno_gr +", '"+ $(this).val() + "' AS "+ asText[chkTextArray];
			chkTextArray++;
		}
		chkCnt		= chkTextArray - 1;
	});
	if (eqno_gr == "0 AS T") {
		rawrisShowMsg("수로계통 정보가 없습니다. 다시 검색하세요"); 
		return false;
	}
	
	if (chkCnt < 0) {
		rawrisShowMsg("수로계통 정보가 없습니다. 다시 검색하세요"); 
		return false;
	}/*else{		
		if(chkCnt < 4){
			$.each(asText, function(idx){
				if (idx <= chkCnt){
				}else{
					eqno_gr = eqno_gr +", '' AS "+ asText[idx];
				}
			});
		}
	}*/
	searchConditionObj.equip_no_gr		= equip_no_gr;
	searchConditionObj.eqno_gr			= eqno_gr;
	searchConditionObj.eqno_Cnt			= chkTextArray + 1;
	return true;
}

/**************************************************************************************
* function setBetweenDate()
* 검색일자 셋팅하기, 시작일과 종료일 차이를 날짜로 계산해서 셋팅
* key	: D(일), M(월), Y(년)
* view	: 변경 시 기본 셋팅할 날짜 (strCalcuBaseDay 에 저장) 
* max	: 최대 입력 가능한 기간
* chkChange : 최초 셋팅인지 (B) 시작일 변경인지(S) 종료일 변경인지(E) 구분
* var betweenDate			= {
		minute		: {key: 'D', view: 1,	max: 3	}
	,	hour		: {key: 'D', view: 15,	max: 30	}
	,	daily		: {key: 'M', view: 1, 	max: 12	}
	,	month		: {key: 'Y', view: 1,	max: 10	}
	,	year		: {key: 'Y', view: 1,	max: 20	}
	,	chkChange	: 'B'
};
* strStartDay		: 시작일
* strEndDay			: 종료일
* strCalcuBaseDay	: chkChange 에 따라 시작일(S), 종료일(B, E)을 기준으로 날짜 계산하기
* betDateview		: 날짜 선택 창에 셋팅할 날짜, chaChange 가 종료일(B,E)기준일 때 -값
* betDateMax		: 날짜 선택의 최대치, chaChange 가 종료일(B,E)기준일 때 -값
* strCalcuDay		: strCalcuBaseDay, betDateKey, betDateview로 계산된 날짜
**************************************************************************************/
function setBetweenDate(){
	var srcKindTime		= searchConditionObj.s_kind_time
	,	betDateKey		= betweenDate[srcKindTime].key
	,	betChkChange	= betweenDate.chkChange
	,	betDateview		= (betChkChange == 'S') ? betweenDate[srcKindTime].view : betweenDate[srcKindTime].view * -1
	,	betDateMax		= (betChkChange == 'S') ? betweenDate[srcKindTime].max : betweenDate[srcKindTime].max * -1
	,	strStartDay 	= (betChkChange == 'B') ? rawrisGetDate({}) : $("#s_start_date").val()
	,	strEndDay		= (betChkChange == 'B') ? rawrisGetDate({}) : $("#s_end_date").val()
	,	strCalcuBaseDay	= (betChkChange == 'S') ? strStartDay : strEndDay
	;

//		$("#final_object_view").html('');
//		rawrisShowErrMsgDivAdd('KEY = '+ betDateKey +' ===== '+ betChkChange +' ===== '+ betDateview +' ===== '+ betDateMax +'</br>');
//		rawrisShowErrMsgDivAdd('rawrisDateCalc = '+ strCalcuBaseDay +' , '+ betDateKey +' , '+ betDateMax +'</br>');
	

    var	strCalcuDay		= rawrisDateCalc(strCalcuBaseDay, betDateKey, betDateMax, "yyyy-mm-dd")
    ,	strCalcuViewDay	= rawrisDateCalc(strCalcuBaseDay, betDateKey, betDateview, "yyyy-mm-dd")
    ,	betwStEdDate	= rawrisDateDiff(strStartDay , strEndDay , betDateKey)
    ;

    var	viewStartDay	= strStartDay  
	,	viewEndDay		= strEndDay
	;

    if (betChkChange == 'S'){
    	strEndDay		= (betwStEdDate > betDateMax) ? strCalcuDay : strEndDay;
    	viewEndDay		= (betwStEdDate > betDateMax) ? strCalcuViewDay : strEndDay;
    }else{
    	strStartDay 	= (betwStEdDate > betDateMax) ? strCalcuDay : strStartDay;
    	viewStartDay	= (betwStEdDate > betDateMax) ? strCalcuViewDay : strStartDay;
    }
    
    if (betChkChange == 'B'){
	    $("#s_start_date").val(viewStartDay);
	    $("#s_end_date").val(viewEndDay);
    }

//		rawrisShowErrMsgDivAdd('$("#s_start_date").val() = '+ $("#s_start_date").val() +'</br>');

	// 기본 설정 (시작일은 종료일보다 작아야 하고 종료일은 시작일보다 커야함)
    $("#s_start_date").datepicker('option', 'maxDate', viewEndDay);
    $("#s_end_date").datepicker('option', 'minDate', $("#s_start_date").val());
    $("#s_end_date").datepicker('option', 'maxDate', rawrisGetDate({}));
}

function setBetweenDateTime(){
	
 	$.datetimepicker.setLocale('kr');
 	
	var srcKindTime		= searchConditionObj.s_kind_time
	,	betDateKey		= betweenDate[srcKindTime].key
	,	betChkChange	= betweenDate.chkChange
	,	betDateview		= (betChkChange == 'S') ? betweenDate[srcKindTime].view : betweenDate[srcKindTime].view * -1
	,	betDateMax		= (betChkChange == 'S') ? betweenDate[srcKindTime].max : betweenDate[srcKindTime].max * -1
	,	strStartDay 	= (betChkChange == 'B') ? rawrisGetDate({}) : $("#s_start_date").val()
	,	strEndDay		= (betChkChange == 'B') ? rawrisGetDate({}) : $("#s_end_date").val()
	,	strCalcuBaseDay	= (betChkChange == 'S') ? strStartDay : strEndDay
	;

    var	strCalcuDay		= rawrisDateCalc(strCalcuBaseDay, betDateKey, betDateMax, "yyyy-mm-dd")
    ,	strCalcuViewDay	= rawrisDateCalc(strCalcuBaseDay, betDateKey, betDateview, "yyyy-mm-dd")
    ,	betwStEdDate	= rawrisDateDiff(strStartDay , strEndDay , betDateKey)
    ;

    var	viewStartDay	= strStartDay  
	,	viewEndDay		= strEndDay
	;

    if (betChkChange == 'S'){
    	strEndDay		= (betwStEdDate > betDateMax) ? strCalcuDay : strEndDay;
    	viewEndDay		= (betwStEdDate > betDateMax) ? strCalcuViewDay : strEndDay;
    }else{
    	strStartDay 	= (betwStEdDate > betDateMax) ? strCalcuDay : strStartDay;
    	viewStartDay	= (betwStEdDate > betDateMax) ? strCalcuViewDay : strStartDay;
    }

  
   $('#datetimepicker1').val(viewStartDay + " 00시");
   $('#datetimepicker2').val(viewEndDay + " 23시");
        
        
	var maxYear = new Date().getFullYear();
	$('#datetimepicker1').datetimepicker({
        closeOnDateSelect: true,
        format: 'Y-m-d H시',
        maxDate: true,
        yearEnd: maxYear
    });
    $('#datetimepicker2').datetimepicker({
        format: 'Y-m-d H시',
        maxDate: true,
        yearEnd: maxYear
    });
    
   
}


/**************************************************************************************
* function setDefaultForQuality()
* 품질관리 메뉴에서 장비 클릭 시 계측정보시스템 > 저수지 정보 메뉴로 이동되면서 해당 장비의 정보를 출력하기
* searchConditionObj.q_equip	: 장비번호
* searchConditionObj.q_BHead	: 본부
* searchConditionObj.q_BBranch	: 지사
**************************************************************************************/
function setDefaultForQuality(){
	$("#s_buseo_head_code").val(searchConditionObj.q_BHead).prop("selected", true);
	searchConditionObj.s_buseo_head_code = searchConditionObj.q_BHead;
	buseoHeadCodeChange();
	
	$("#s_buseo_branch_code").val(searchConditionObj.q_BBranch).prop("selected", true);
	searchConditionObj.s_buseo_branch_code = searchConditionObj.q_BBranch;
	buseoBranchCodeChange();
	
	$("#s_equip_no").val(searchConditionObj.q_equip).prop("selected", true);
	searchConditionObj.s_equip_no = searchConditionObj.q_equip;
		
	$("#s_kind_time").val('minute');
	searchConditionObj.s_kind_time = 'minute';
	
	var strStartDay	= rawrisDateCalc(rawrisGetDate({}), 'D', -4, "yyyy-mm-dd");
	var strEndDay	= rawrisDateCalc(rawrisGetDate({}), 'D', -2, "yyyy-mm-dd");

	$("#s_start_date").val(strStartDay);
	$("#s_end_date").val(strEndDay);

	searchConditionObj.s_start_date        = $("#s_start_date").val();
	searchConditionObj.s_end_date          = $("#s_end_date").val();
	
	searchData();
}
//});