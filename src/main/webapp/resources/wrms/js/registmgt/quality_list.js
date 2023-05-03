$(document).ready(function(){
	searchConditionObj.s_bonbu	= (searchConditionObj.s_bonbu == '')	? 'bonbu'		: searchConditionObj.s_bonbu;
	searchConditionObj.s_code	= (searchConditionObj.s_code == '')		? ''			: searchConditionObj.s_code;
	searchConditionObj.s_search	= (searchConditionObj.s_search == '')	? 'equip_all'	: searchConditionObj.s_search;
	
	var bonbuCd	= searchConditionObj.s_code.substring(0,3);
	var jisaCd	= searchConditionObj.s_code;
	
	if (!rawrisIsEmpty(searchConditionObj.s_code)){
		switch(searchConditionObj.s_bonbu){
			case 'bonbu':
				break;
			case 'jisa':
				$("#s_buseo_head_code").val(bonbuCd).prop("selected", true);
				searchConditionObj.s_buseo_head_code = bonbuCd;
				buseoHeadCodeChange();
				break;
			case 'equip':
				$("#s_buseo_head_code").val(bonbuCd).prop("selected", true);
				searchConditionObj.s_buseo_head_code	= bonbuCd;
				buseoHeadCodeChange();
				$("#s_buseo_branch_code").val(jisaCd).prop("selected", true);
				searchConditionObj.s_buseo_branch_code	= jisaCd;
				break;
		}
	}
	
	searchData();
	
	function searchData(){
		var sqlDispDiv			= "inq_equip_quality_list";
		searchConditionObj.sql	= sqlMapper+sqlDispDiv;

//		rawrisShowErrMsgDivAdd('searchConditionObj.s_bonbu	= '+ searchConditionObj.s_bonbu +'</br>');
//		rawrisShowErrMsgDivAdd('searchConditionObj.s_code	= '+ searchConditionObj.s_code +'</br>');
		
 		var displayInfoObj = {
				dispTarget		: "#rawris_equip_quilityTotal_list_table > tbody"
			,	dispDiv			: sqlDispDiv
			,	resource		: (searchConditionObj)
			,	displayColInfos : {
					inq_equip_quality_list : [	{id:"list_name"			, align:"center"						, data_id1:"list_code"	, data_id2:"jisa_code"}
											,	{id:"equip_cnt"			, align:"right"		, colType:"number"	, data_id1:"list_code"	, data_id2:"jisa_code"}
											,	{id:"obs_cnt"			, align:"right"		, colType:"number"	, data_id1:"list_code"	, data_id2:"jisa_code"}
											,	{id:"not_obs_cnt"		, align:"right"		, colType:"number"	, data_id1:"list_code"	, data_id2:"jisa_code"}
											,	{id:"obs_rate"			, align:"right"		, colType:"double"	, data_id1:"list_code"	, data_id2:"jisa_code"	, pattern : ".#"}
											,	{id:"cnt_gap_rims"		, align:"right"		, colType:"number"	, data_id1:"list_code"	, data_id2:"jisa_code"}
											,	{id:"cnt_gap_prev"		, align:"right"		, colType:"number"	, data_id1:"list_code"	, data_id2:"jisa_code"}
											,	{id:"cnt_gap_level"		, align:"right"		, colType:"number"	, data_id1:"list_code"	, data_id2:"jisa_code"}
											,	{id:"cnt_gap_time"		, align:"right"		, colType:"number"	, data_id1:"list_code"	, data_id2:"jisa_code"}
											,	{id:"cnt_quality"		, align:"right"		, colType:"number"	, data_id1:"list_code"	, data_id2:"jisa_code"}
											]
				}
		}
		rawrisTableDisplay(displayInfoObj);
 		
 		chkListView();
	}
	
	
	function chkListView(){
		if (searchConditionObj.s_bonbu == 'equip'){
			$('.equip_cnt').hide();
			$('#rawris_equip_quilityTotal_list_table tbody tr > *:nth-child(2)').toggle();	
		}
	}
	
	
	/********************************************************************
	*********************          데이터 검색      *********************  
	*********************************************************************/
   // 저장 (Excel Export) 
	$("#equipQualityExcelBtn").click(function(evt){ 
		var sqlTempletFileName = searchConditionObj.sql.substr(sqlMapper.length)+".xls"; 
   	    var excelDownTempleteInfo = {
   	    	   excelLocation    : "/registmgt/quality_manage/quality_total/"+sqlTempletFileName 
   	         , excelFileName    : "품질관리총괄" 
	         , conditions       : searchConditionObj
   	    }  
   	    rawrisExcelTempletDownLoad(excelDownTempleteInfo);
	});
	
	// 검색버튼 클릭 
	$("#equipFluxBaseSearchBtn").click(function(evt){
		searchConditionObj.s_buseo_head_code	= $("#s_buseo_head_code").val();
		searchConditionObj.s_buseo_branch_code	= $("#s_buseo_branch_code").val();
		
		if(!rawrisIsEmpty(searchConditionObj.s_buseo_branch_code)){
//			rawrisShowMsg('지사 검색!!!! '+ searchConditionObj.s_buseo_branch_code) ;
			searchConditionObj.s_bonbu	= 'equip';
			searchConditionObj.s_code	= searchConditionObj.s_buseo_branch_code;
		}else if(!rawrisIsEmpty(searchConditionObj.s_buseo_head_code)){
//			rawrisShowMsg('본부 검색!!!! '+ searchConditionObj.s_buseo_head_code) ;
			searchConditionObj.s_bonbu	= 'jisa';
			searchConditionObj.s_code	= searchConditionObj.s_buseo_head_code;
		}else{
//			rawrisShowMsg('전국 검색!!!!') ;
			searchConditionObj.s_bonbu	= 'bonbu';
			searchConditionObj.s_code	= '';
		}
		
		$("#s_bonbu").val(searchConditionObj.s_bonbu);
		$("#s_code").val(searchConditionObj.s_code);
		
		$("#frmQualityList").submit();
	});

	$("#rawris_equip_quilityTotal_list_table > tbody").click(function(evt){
//		$("#final_object_view").html('');
		
		var list_type	= (searchConditionObj.s_bonbu == 'bonbu') ? 'jisa' : (searchConditionObj.s_bonbu == 'jisa') ? 'equip' : 'detail'; 
    	
//		rawrisShowErrMsgDivAdd('searchConditionObj.s_bonbu	= '+ searchConditionObj.s_bonbu +'</br>');
		
		var list_code	= $(evt.target).attr("data-list_code");
		var jisa_code	= $(evt.target).attr("data-jisa_code");
    	var celIndx		= $(evt.target).index();
    	var rowIndx		= $(evt.target).parent().index();
    	var search_type	= searchConditionObj.s_search;
    	
    	if (rowIndx == '0'){
    		list_type	= (searchConditionObj.s_bonbu == 'equip') ? 'jisa' : (searchConditionObj.s_bonbu == 'jisa') ? 'bonbu' : ''; 
    	}else{
    		list_type	= (searchConditionObj.s_bonbu == 'bonbu') ? 'jisa' : (searchConditionObj.s_bonbu == 'jisa') ? 'equip' : 'detail'; 
    	}
    	
//    	rawrisShowErrMsgDivAdd('rowDiv	= '+ list_code +'</br>');
//    	rawrisShowErrMsgDivAdd('celIndx	= '+ celIndx +'</br>');
    	
    	switch (celIndx){
	    	case 5:
	    		search_type = 'cnt_gap_rims'
	    	break;
	    	case 6:
	    		search_type = 'cnt_gap_prev'
	    	break;
	    	case 7:
	    		search_type = 'cnt_gap_level'
	    	break;
	    	case 8:
	    		search_type = 'cnt_gap_time'
	    	break;
	    	case 9:
	    		search_type = 'cnt_quality'
	    	break;
	    	default:
	    		search_type = 'equip_all'
	    	break;
    	}
    	
    	
    	if (rowIndx == '0' && list_code != ''){
    		searchConditionObj.s_search = 'equip_all';
    	}
    	
    	list_type = (rowIndx != '0' && searchConditionObj.s_search != 'equip_all') ? 'detail' : list_type ;	// 조건 검색 시 장비 세부정보 페이지 이동 위해
    	
//    	rawrisShowErrMsgDivAdd('list_type	= '+ list_type +'</br>');

    	if (list_type == 'detail'){
    		$("#quality_buseo_head").val(jisa_code.substr(0,3));
			$("#quality_buseo_branch").val(jisa_code);
			$("#quality_equip_no").val(list_code);
			$("#frmQualityEquip").submit();
    	}else{
	    	$("#s_bonbu").val(list_type);
			$("#s_code").val(list_code);
			$("#s_search").val(search_type);
			$("#frmQualityList").submit();
    	}
	});
	
	});