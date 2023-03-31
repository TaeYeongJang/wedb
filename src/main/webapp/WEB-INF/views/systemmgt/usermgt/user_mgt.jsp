<%@page contentType="text/html;charset=utf-8"%> 
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %> 
<sec:authentication var="details" property="details" />
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

	<title></title> 
	
	<!-- default -->
	<link rel="stylesheet" type="text/css" href="/wrms/resources/external/jquery.ui/css/jquery-ui.css">
	<link rel="stylesheet" type="text/css" href="/wrms/resources/external/bootstrap/css/bootstrap.css">
	<link rel="stylesheet" type="text/css" href="/wrms/resources/external/skin/skin-rawris.css">
	<link rel="stylesheet" type="text/css" href="/wrms/resources/external/icheck/flat/blue.css">
	<link rel="stylesheet" type="text/css" href="/wrms/resources/wrms/css/wrms_default.css?v=1.03">
	<link rel="stylesheet" href="/wrms/resources/external/font/font-awesome/css/font-awesome.min.css">
	
	<link rel="stylesheet" type="text/css" href="<c:url value='/resources/external/font/font-awesome/css/font-awesome.min.css'/> "> 
	<link rel="stylesheet" type="text/css" href="<c:url value='/resources/external/select2/select2.min.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/resources/external/skin/skin-rawris.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/resources/external/icheck/flat/blue.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/resources/external/jquery.ui/css/jquery-ui.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/resources/external/jquery.ui/css/jquery-ui.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/resources/external/pqgrid/css/pqgrid.css'/>" /> 
	<link rel="stylesheet" type="text/css" href="<c:url value='/resources/external/pqgrid/css/pqgrid.min.css'/>" /> 

	<script src="<c:url value='/resources/external/jquery/jQuery-2.1.4.min.js'/>"></script> 
	<script src="<c:url value='/resources/external/jquery.ui/js/jquery-ui.min.js'/>"></script> 
	<script src="<c:url value='/resources/external/jquery.filedownload/js/jquery.fileDownload.js'/>"></script>
	<script src="<c:url value='/resources/external/jquery.block.ui/jquery.blockUI.js'/>"></script>
    <script src="<c:url value='/resources/external/bootstrap/js/bootstrap.min.js'/>"></script>
    <script src="<c:url value='/resources/external/select2/select2.full.min.js'/>"></script>
    <script src="<c:url value='/resources/external/daterangepicker/daterangepicker.js'/>"></script>
    <script src="<c:url value='/resources/external/dist/app.min.js'/>"></script>
    <script src="<c:url value='/resources/external/datatables/js/jquery.dataTables.min.js'/>"></script>
    <script src="<c:url value='/resources/external/datatables/js/dataTables.bootstrap.min.js'/>"></script>
    <script src="<c:url value='/resources/external/moment/js/moment.min.js'/> "></script>
	    
	<script src="<c:url value='/resources/wrms/js/wrmsUtils.js'/>"></script> 
	<script src="<c:url value='/resources/external/sha/sha512.js'/>"></script>
	 
	<script src="<c:url value='/resources/external/pqgrid/js/pqgrid.min.js'/>"></script> 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.7.7/xlsx.core.min.js"></script> 
	<%@include file="/resources/wrms/inc/jsgrid.inc"%>
	
	<style>
		.jsgrid-header-row > .jsgrid-header-cell {
		    font-size: 13px; color: #646464;
		}
		.hdun {
			font-size: 11px; color: 'gray'; line-height: 1.5;
		}
		.modal-dialog {
			background:#ffffff;
		}
		.modal-dialog .modal-title {
			padding:10px 40px 10px 30px;
		}
		.modal-dialog .card-body , .modal-dialog .card-footer {
			padding:10px 40px 10px 40px;
		}
		.modal-dialog .modal-title, .modal-dialog .card-footer {
			background: #efefef;
		}
		.btn-info {
		    background-color: #f4f4f4; border-color: #ddd; color: #444; font-size: 14px;
		}
		.bxr0 {
		    padding-top: 0px; padding-left: 15px; padding-right: 15px;
		}
		.box-header {
		    padding: 10px;
		}
		.bxr1 {
		    margin-right: 0px; margin-left: 0px;
		}
		.td-lbl{
			font-weight: 500; vertical-align: bottom; 
		}
		.td-lbl2{
			margin-left: 5px;
		}
	</style>
	
	<script type="text/javascript">
	
	var searchConditionObj ;
	var sqlMapper = "rawris.wrms.regist.systemmgt.user_mgt.";
	$(document).ready(function(){ 
		/********************************************************************
		*********************          검색조건         *********************  
		*********************************************************************/

		// 22.05.13. #s_start_date, #s_end_date 해당 태크 없어서 주석처리 
// 		// 조회 기준일자 지정 
// 		var strToDay = rawrisGetDate({}); 
// 		$("#s_start_date").val(rawrisDateCalc(strToDay , "M" , -11 ));
// 		$("#s_end_date").val(strToDay);
		
// 		// 시작일 , 종료일 DatePicker 적용 
// 		rawrisDatePicker("#s_start_date");
// 		rawrisDatePicker("#s_end_date");

		$("#s_user_type").select2(); 
		$("#s_buseo_head_code").select2(); 
		$("#s_buseo_branch_code").select2(); 
		$("#s_user_id").select2();
		// 22.05.13. #s_user_nm 해당 태크 없어서 주석처리 
// 		$("#s_user_nm").select2(); 
		
		// 사용자ID로 검색 	// 22.05.13. #userNm 해당 태크 없어서 주석처리 
// 		$("#userNm").keypress(function(evt){ 
// 			if(evt.keyCode == 13){ 
// 				var dynaGenComboFacNmCodeObj = {  comboInfo     : { targetId : "#s_user_nm" }
// 												, optionValInfo : { optId : "user_id" , optTxt : "user_name" }
// 												, optionInfo    : { postion : "top" , txt : "사용자" , val : "" }
// 												, comboDataInfo : rawrisAjaxPost({ sql      :"rawris.wrms.listcode.search_by_user_nm" 
// 							                                                     , key_word : $("#userNm").val() 
// 							                                                     , user_buseo_code : "${details.level_buseo_code}"
// 							                                                     /* 로그인한 사용자의 BUSEO_CODE 본인의 부서소속 사용자만 조회가능 */
// 							                                                    }) 
// 				};   
// 				rawrisDynaGenSelectOptions(dynaGenComboFacNmCodeObj); 
// 			}    
// 		});
		
		// 사용자목록변경 	// 22.05.13. #s_user_nm 해당 태크 없어서 주석처리 
// 		$("#s_user_nm").change(function(evt){   
			 
// 			if(rawrisIsEmpty($(evt.target).val())) return false;
			 
// 			var userNavObjList = rawrisAjaxPost({ sql      : "rawris.wrms.listcode.search_for_user_nav" 
// 			                                     , s_user_nm : $("#s_user_nm :selected").val() 
// 			                                    });
// 			var userNavObj = userNavObjList[0]; 
//         	if(!rawrisIsEmpty(userNavObj)){ 
//         		$("#s_buseo_head_code").select2("val",userNavObj.buseo_head_code); 
//         		buseoHeadCodeChange(); 
//         		$("#s_buseo_branch_code").select2("val",userNavObj.buseo_branch_code);
//         		buseoBranchCodeChange(); 	
//         		$("#s_user_id").select2("val",""+userNavObj.user_id);  
//         	} 
// 		});

		// 장비관할조직 SelectBox 변경 
		$("#s_user_type").change(function(evt){
			var val	= evt.target.value;
			
			if(val == "01") buseoHeadCodeSetting();
			else		    addrHeadCodeSetting();
		});	
		
		// 본부조회
		buseoHeadCodeSetting();
		
		function buseoHeadCodeSetting(){
			$("#s_buseo_head_code").html("<option value=''>본부</option>").select2();
			$("#s_buseo_branch_code").html("<option value=''>지사</option>").select2();
			$("#s_user_id").html("<option value=''>사용자</option>").select2();
			$("#s_user_name").val("");
			var dynaGenComboBuseoHeadInfoObj = {
					  comboInfo     : { targetId : "#s_buseo_head_code" }
					, optionInfo    : { postion : "top" , txt : "선택" , val : "" }
					, optionValInfo : { optId : "buseo_head_code" , optTxt : "buseo_head_name" } 
					, comboDataInfo : rawrisAjaxPost({ sql             : "rawris.wrms.listcode.inq_buseo_head_code_list"
				                        			 , bonsa 		   : "Y"
						              })
		              
				};  
				rawrisDynaGenSelectOptions(dynaGenComboBuseoHeadInfoObj); 
		}

		function addrHeadCodeSetting(){
			$("#s_buseo_head_code").html("<option value=''>시.도</option>").select2();
			$("#s_buseo_branch_code").html("<option value=''>시.군</option>").select2();
			$("#s_user_id").html("<option value=''>사용자</option>").select2();
			$("#s_user_name").val("");
			var dynaGenComboBuseoHeadInfoObj = {
					  comboInfo     : { targetId : "#s_buseo_head_code" }
					, optionInfo    : { postion : "top" , txt : "선택" , val : "" }
					, optionValInfo : { optId : "addr_head_code" , optTxt : "addr_head_name" } 
					, comboDataInfo : rawrisAjaxPost({ sql             : "rawris.wrms.listcode.inq_addr_head_code_list" }) 
				};  
				rawrisDynaGenSelectOptions(dynaGenComboBuseoHeadInfoObj); 
		}
  		  
		// 본부 SelectBox 변경 
		$("#s_buseo_head_code").change(function(evt){
			var user_type = $("#s_user_type :selected").val();
			
			if(user_type == "01") buseoHeadCodeChange();
			else		    	  addrHeadCodeChange();
		});
		
		function buseoHeadCodeChange(){
			$("#s_buseo_branch_code").html("<option value=''>지사</option>").select2();
			$("#s_user_id").html("<option value=''>사용자</option>").select2();
			$("#s_user_name").val("");
			if(!rawrisIsEmpty($("#s_buseo_head_code :selected").val())) {
				var dynaGenComboBranchInfoObj = {
						  comboInfo     : { targetId : "#s_buseo_branch_code" }
						, optionInfo    : { postion : "top" , txt : "지사" , val : "" }
						, optionValInfo : { optId : "buseo_branch_code" , optTxt : "buseo_branch_name" }  
						, comboDataInfo : rawrisAjaxPost({ sql             : "rawris.wrms.listcode.inq_buseo_branch_code_list"
							                             , buseo_head_code : $("#s_buseo_head_code :selected").val()
							              })
				}; 
				rawrisDynaGenSelectOptions(dynaGenComboBranchInfoObj); 
				//$("#s_buseo_branch_code").select2("val",""); 
				//$("#s_user_id").select2("val","");
			}
		}

		function addrHeadCodeChange(){
			$("#s_buseo_branch_code").html("<option value=''>시.군</option>").select2();
			$("#s_user_id").html("<option value=''>사용자</option>").select2();
			$("#s_user_name").val("");
			if(!rawrisIsEmpty($("#s_buseo_head_code :selected").val())) {
				var dynaGenComboBranchInfoObj = {
						  comboInfo     : { targetId : "#s_buseo_branch_code" }
						, optionInfo    : { postion : "top" , txt : "시.군" , val : "" }
						, optionValInfo : { optId : "addr_branch_code" , optTxt : "addr_branch_name" }  
						, comboDataInfo : rawrisAjaxPost({ sql             : "rawris.wrms.listcode.inq_addr_branch_code_list"
							                             , addr_head_code : $("#s_buseo_head_code :selected").val()
							              })
				}; 
				rawrisDynaGenSelectOptions(dynaGenComboBranchInfoObj); 
				//$("#s_buseo_branch_code").select2("val",""); 
				//$("#s_user_id").select2("val","");
			}			
		}
		
		// 지사 SelectBox변경 
		$("#s_buseo_branch_code").change(function(evt){ 
			var user_type = $("#s_user_type :selected").val();
			
			if(user_type == "01") buseoBranchCodeChange();
			else		    	  addrBranchCodeChange();
		}); 
		
		function buseoBranchCodeChange(){
			$("#s_user_id").html("<option value=''>사용자</option>").select2();
			$("#s_user_name").val("");
			if(!rawrisIsEmpty($("#s_buseo_branch_code :selected").val())){
				var dynaGenComboBranchInfoObj = {
						  comboInfo     : { targetId : "#s_user_id" }
						, optionInfo    : { postion : "top" , txt : "사용자" , val : "" }
						, optionValInfo : { optId : "user_id" , optTxt : "user_name" } 
						, comboDataInfo : rawrisAjaxPost({ sql               : "rawris.wrms.listcode.inq_buseo_user_list"
							                             , buseo_branch_code : $("#s_buseo_branch_code :selected").val()
							              }) 
			    }; 
		      	rawrisDynaGenSelectOptions(dynaGenComboBranchInfoObj); 
				//$("#s_user_id").select2("val",""); 
			}    
		}

		function addrBranchCodeChange(){
			$("#s_user_id").html("<option value=''>사용자</option>").select2();
			$("#s_user_name").val("");
			if(!rawrisIsEmpty($("#s_buseo_branch_code :selected").val())){
				var dynaGenComboBranchInfoObj = {
						  comboInfo     : { targetId : "#s_user_id" }
						, optionInfo    : { postion : "top" , txt : "사용자" , val : "" }
						, optionValInfo : { optId : "user_id" , optTxt : "user_name" } 
						, comboDataInfo : rawrisAjaxPost({ sql               : "rawris.wrms.listcode.inq_addr_user_list"
							                             , buseo_branch_code : $("#s_buseo_branch_code :selected").val()
							              }) 
			    }; 
		      	rawrisDynaGenSelectOptions(dynaGenComboBranchInfoObj); 
				//$("#s_user_id").select2("val",""); 
			}    
		}

		// 사용자명 검색
		$("#s_user_name").keypress(function(evt){
			var s_user_name = $("#s_user_name").val();
			if(rawrisIsEmpty(s_user_name)) return;
			
			if(evt.key == 'Enter') {	
				searchConditionObj.s_user_name = s_user_name;
				searchData();
			}
		});
		
		/********************************************************************
		*********************          데이터 검색      *********************  
		*********************************************************************/
		
		// 검색조건
	    searchConditionObj = {  
			    cmd                 : "selectPageList"	
   		  	  , s_buseo_head_code   : $("#s_buseo_head_code :selected").val()
   		  	  , s_buseo_branch_code : $("#s_buseo_branch_code :selected").val()
   		  	  , s_user_id           : $("#s_user_id :selected").val()
   		  	  , s_user_name         : $("#s_user_name :selected").val()
	  	};
		
	    initUserCustomSearch(); 
    	function initUserCustomSearch(){
    		var buseoLevel = Number("${details.buseo_level}");
    		var buseoCode = "${details.level_buseo_code}";
    		var originBuseoCode = "${details.orgin_buseo_code}";
    	 	 
    		if(buseoLevel == 2){ 
    			$("#s_buseo_head_code").select2("val",buseoCode); 
    			buseoHeadCodeChange(); 
    			rawrisSelect2hide("#s_buseo_head_code"); 
    			searchConditionObj.s_buseo_head_code = buseoCode; 
    		}else if(buseoLevel == 3){ 
    			$("#s_buseo_head_code").select2("val",buseoCode.substr(0,3));
    			buseoHeadCodeChange();  
    			$("#s_buseo_branch_code").select2("val",originBuseoCode);
    			buseoBranchCodeChange(); 
    			
    			rawrisSelect2hide("#s_buseo_head_code");
    			rawrisSelect2hide("#s_buseo_branch_code");
    			
    			searchConditionObj.s_buseo_head_code = buseoCode.substr(0,3);
    			searchConditionObj.s_buseo_branch_code = originBuseoCode;
    		} 
    	} 
    	
    	// 화면 Load시 목록 조회
	    searchData();

    	// 장비관리이력 검색버튼 클릭
   		$("#userMgtSearchBtn").click(function(evt){ 
		  	searchConditionObj.s_buseo_head_code   = $("#s_buseo_head_code :selected").val();
   		  	searchConditionObj.s_buseo_branch_code = $("#s_buseo_branch_code :selected").val();
   		  	searchConditionObj.s_user_id           = $("#s_user_id :selected").val();
				   
			searchData(); 

   		});	
    	
    	
   		$( window ).resize(function() {
			window_resize_handler();
		});
    	grid_resize();
    	
    	$('#btn_user_upd_modal_save').click(function(evt) {
			submit_user_update_modal();
			return false;
	    });
    	
    	// 저장(엑셀다운로드)
        $("#userMgtExcelBtn").click(function(evt){
        		//searchConditionObj.sql = "inq_user_mgt_list";
    	 	var sqlTempletFileName = searchConditionObj.sql.substr(sqlMapper.length)+".xls"; 
       	    var excelDownTempleteInfo = {
       	    	   excelLocation    : "/systemmgt/user_mgt/"+sqlTempletFileName 
       	         , excelFileName    : "사용자 관리" 
    	         , conditions       : searchConditionObj
       	    }  
       	    rawrisExcelTempletDownLoad(excelDownTempleteInfo); 
        });
	});
	 
	function window_resize_handler() {
		grid_resize();
	}
	
	function grid_resize() {
		$("#grid_container").height(10);
		var ht = $(window).height();
		var h2 = $("#grid_container").offset().top;
		var h3 = ht - h2 - 38;
		
		$('#grid_container').height(h3);
	}
	
	
	// 목록 검색 Function
	function searchData() {
		var user_type = $("#s_user_type :selected").val();
		
		if(user_type == "01") searchConditionObj.sql = sqlMapper + "inq_user_mgt_list";
		else		    	  searchConditionObj.sql = sqlMapper + "inq_user_mgt_list_sgg";
		
		searchConditionObj.cmd				   = "selectList";
		searchConditionObj.s_buseo_head_code   = $("#s_buseo_head_code :selected").val();
	  	searchConditionObj.s_buseo_branch_code = $("#s_buseo_branch_code :selected").val();
	  	searchConditionObj.s_user_id           = $("#s_user_id :selected").val();
	  	searchConditionObj.s_user_name         = $("#s_user_name").val();
		load_data(true);
	}
	
	var _dataGrid;

	function load_data(need_init) {
		var parm = $.extend({}, searchConditionObj);
			
		parm.successFn	= function (data){
			_dataGrid = init_grid(data);
		};
		parm.failFn	= function (){
			_dataGrid = init_grid();
		};

		rawrisAjaxPost(parm);
	}
	
	function init_grid(data) {
		
		var cf = function(value, item, index) {
			var colValue = value;
			
			switch(this.name) {
			case '#':
				value = (index+1);
				break;
			case 'user_updateBtn':
				value = "<button style='height:26px; line-height:1' class='btn btn-xs btn-warning' onclick='btnHandler(\""+ item.user_id +"\",\"" + item.user_name + "\",\""  + item.user_role + "\",\"" + item.user_level +"\")'>수정</button>";
				break;
			}
			
			return value;
		};
		
		var opt = jgexp.default_options();
		
		opt.data = data || [];
		opt.height = '100%';

		var user_type = $("#s_user_type :selected").val();
		var title_1, title_2;		
		if(user_type == "01") {
			title_1 = "본부";
			title_2 = "지사";
		} else {
			title_1 = "시.도";
			title_2 = "시.군";
		}
	

		opt.fields		= [
					          {name:"#"          		, title:"순번"   ,   align:"center"  , width:40  ,  itemTemplate:cf}
					        , {name:"user_id"           , title:"ID"    ,   align:"left"    , width:100 ,  itemTemplate:cf}
					        , {name:"buseo_head_name"   , title:title_1 ,   align:"left"    , width:60  ,  itemTemplate:cf}
					        , {name:"buseo_branch_name" , title:title_2 ,   align:"left"    , width:120 ,  itemTemplate:cf}
					        , {name:"user_name"         , title:"이름"   ,   align:"left"    , width:120 ,  itemTemplate:cf}
					        , {name:"user_level_name"   , title:"그룹"   ,   align:"left"    , width:120 ,  itemTemplate:cf}
					        , {name:"user_role_name"    , title:"역할"   ,   align:"left"    , width:100 ,  itemTemplate:cf}
					        , {name:"user_email"        , title:"E-Mail",   align:"left"    , width:100 ,  itemTemplate:cf}
					        , {name:"date_reg"          , title:"등록일"  ,   align:"center"  , width:120 ,  itemTemplate:cf}
					        , {name:"date_mod"          , title:"수정일"  ,   align:"center"  , width:80  ,  itemTemplate:cf}
					        , {name:"user_updateBtn"    , title:"정보변경" ,   align:"center"  , width:80  ,  itemTemplate:cf}
						 ];

		return new DataGrid('jsgrid', opt);
	}

	function btnHandler(id, name, role, level){
		var lvl = "${details.user_level}";
		var rol = "${details.user_role}";

		if( (lvl > 0 || rol > 0) &&  rol != 7  ){ //권한이 없으면
			rawrisShowMsg("사용자를 수정할 권한이 없습니다");
			return false;
		}

		if(!confirm('해당 사용자 정보를 수정하시겠습니까?')) 
			return false;
		
		 $('#modal_user_update').modal({backdrop: 'static', keyboard: false});
		 
		 if(!_user_level_list) {
			 _user_level_list = rawrisAjaxPost({sql : "rawris.wrms.userinfo.user_level_list" });
			 
			 var dynaGenComboFacNmCodeObj =	{
						comboInfo     : { targetId : "#m_user_level" }
					,	optionValInfo : { optId : "user_level_modal" , optTxt : "user_level_name_modal" }
					,	comboDataInfo : _user_level_list 
			};
			rawrisDynaGenSelectOptions(dynaGenComboFacNmCodeObj);
		 }
		 if(!_user_role_list) {
			 _user_role_list = rawrisAjaxPost({sql : "rawris.wrms.userinfo.user_role_list" });

			 var dynaGenComboFacNmCodeObj =	{
						comboInfo     : { targetId : "#m_user_role" }
					,	optionValInfo : { optId : "user_role_modal" , optTxt : "user_role_name_modal" }
					,	comboDataInfo : _user_role_list
			};
			rawrisDynaGenSelectOptions(dynaGenComboFacNmCodeObj); 
		 }

		$("#m_user_name").val(name);
		$("#m_user_name_lbl").text(name);
		$("#m_user_id").val(id);
		$("#m_user_id_lbl").text(id);
		$("#m_user_level").val(level);
		$("#m_user_role").val(role);
			
		return true;
	}
	var _user_role_list, _user_level_list;
	
	function submit_user_update_modal() {
		
		if(!confirm('사용자 정보를 수정하시겠습니까?')) 
			return false;
		
		var pwd;
		if( $('input:checkbox[id="m_user_password"]').is(":checked") == true ) pwd = rawrisGetDecriptStr('0000');
		
		var parm = {
						cmd				: 'update',
						sql 			: 'rawris.wrms.userinfo.new_upd_user_info',
						m_user_id 		: $("#m_user_id").val(),
						m_user_level 	: $("#m_user_level :selected").val(),
						m_user_role 	: $("#m_user_role :selected").val(),
						m_user_password : pwd
				   };
		var m_rst = rawrisAjaxPost(parm);
		
		if(!m_rst) {
			rawrisShowMsg("사용자 정보 수정중 장애가 발생했습니다");
			return false;
		}
		else {
			searchData();
			$('#btn_user_upd_modal_close').trigger('click');
			rawrisShowMsg("사용자 정보가 저장되었습니다.");
			return true;
		}
	}
		

</script> 
</head>
<body class="hold-transition skin-rawris sidebar-mini">
	<div class="wrapper">

		<!-- Logo, Header Navbar Include -->
	    <%@include file="/WEB-INF/views/tile/default/PageHeader.jsp"%>

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
			<ol class="breadcrumb"></ol>
			</section>
			<!-- End of Content Header (Page header) -->

			<!-- Main content -->
			<section class="content">
			<div class="row">
				<div class="bxr0">
					<div class="nav-tabs-custom" style="background:#DEE1E4;">
		              	<div class="box-header with-border bg-info">   
							  <div class="row bxr1">   
							    <select style="width:150px" id="s_user_type">
							      <option value="01" selected>농어촌공사</option>
								  <option value="02">지방자치단체</option>
							    </select> 
							    <select style="width:150px" id="s_buseo_head_code">
							      <option value="0">본부</option>  
							    </select> 
							    <select style="width:180px" id="s_buseo_branch_code">
							      <option value="">지사</option>
							    </select>
							    <select style="width:180px" id="s_user_id">
							      <option value="">사용자</option> 
							    </select>
							    <input type="text" id="s_user_name" class="form-control" placeholder="사용자명 검색" style="display:inline-block; width:180px; vertical-align:middle;">
								<button type="button" id="userMgtSearchBtn" class="btn btn-info btn-sm" >검색</button>
								<button type="button" id="userMgtExcelBtn" class="btn btn-info btn-sm" >저장</button> 
							  </div>
						</div>	  
					</div>
				</div>
				<!-- /.col -->
			</div>
			<div id="grid_container">
				<div id="jsgrid"></div>
			</div>
			<!-- /.row --> </section>
			<!-- /Main content -->
		</div>
		<!-- /.content-wrapper -->
	    <%@include file="/WEB-INF/views/tile/default/PageFooter2.jsp"%>
	</div>
	
	
	<div class="modal" id="modal_user_update" >
    <div class="modal-dialog" style="width: 400px;">
        <div class="card">
            <div class="card-header">
            	<h5 class="modal-title" style="font-size:20px;font-weight: bold;"><i class="fa fa-key"></i> 사용자 정보 변경</span></h5>
            </div>
            <div class="card-body" >
                <div class="row">
					    <table style="width:100%">
					    	<colgroup>
					            <col width="35%">
					            <col width=auto>
					    	</colgroup>
					        <tbody>
					        	<tr style="height:40px;">
					                <td><label for="m_user_name">사용자 이름</label></td>
					            	<td>
                                        <input type="hidden" id="m_user_name" value="" class="form-control" readonly="">
                                        <label for="m_user_name" id="m_user_name_lbl" class="td-lbl">name</label>
                                    </td>
					            </tr>
					        	<tr style="height:40px;">
					                <td><label for="m_user_id">사용자 ID</label></td>
					            	<td>
                                        <input type="hidden" id="m_user_id" value="" class="form-control" readonly="">
                                        <label for="m_user_id" id="m_user_id_lbl" class="td-lbl">xixfive</label> 
                                    </td>
					            </tr>
					            <tr style="height:40px;">
					                <td><label for="m_user_password">암호 초기화</label></td>
					            	<td>
					            		<input type="checkbox" id="m_user_password" style="width:19px;height:19px; margin:0px;">
					            		<label for="m_user_password" class="td-lbl td-lbl2" >0000</label>
				            		</td>
					            </tr>
					            <tr>
					                <td><label for="m_user_level">사용자 레벨</label></td>
					                <td>
						                <select id="m_user_level" class="form-control">
											<option value="99">사용자 레벨</option> 
										</select>
									</td>
					            </tr>
					            <tr style="height:40px;">
					                <td><label for="m_user_role">사용자 권한</label></td>
					                <td>
						                <select id="m_user_role" class="form-control">
											<option value="99">사용자 권한</option> 
										</select>
									</td>
					            </tr>
					        </tbody>
					    </table>
	                </div>
	            </div>
			   <div class="card-footer" style="height:50px;">
			       <div style="position: relative;float: right;">
			           <button id="btn_user_upd_modal_close" class="btn btn-secondary btn" data-dismiss="modal">닫기</button>
			           <button id="btn_user_upd_modal_save" class="btn btn-primary btn">변경</button>
			       </div>
			   </div>
	        </div><!-- /.modal-content -->
	    </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->

</body>
</html>