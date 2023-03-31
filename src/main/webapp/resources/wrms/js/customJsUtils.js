/**
 *  2017.02.20   @since 2017.02.20 @author JN.KIM
 */

/*********************************************************************************
 ****************                 RAWRIS  FUNCTIONS                ***************  
 *********************************************************************************/

function rawrisAjax(AjaxObj){
	var resultData = null;
	var baseAjaxObj = {
		  type: "post"
		, url: ""
		, async: false
		, data: {}
	    , dataType: "json"
	    , beforeSend : function(xhr , settings){
	    	rawrisShowProgress(); // TODO :jQuery UIBLOCK , JQUERY PROGRESS(SHOW)적용
	    }	
	    , complete : function(xhr , sts){
	    	rawrisHideProgress(); // TODO :jQuery UIBLOCK , JQUERY PROGRESS(HIDE)적용 
	    }
	    , success: function(rs){
	    	resultData = rs;
		  }
	    , error: function(err) { 
	    	if(!(err.readyState == 4 && err.status == 200 && err.statusText == "OK")){
	    		rawrisShowMsg("처리중 에러가 발생했습니다."); 
	    	}else{
	    		resultData = "OK"; 
	    	}
		} 
	}
	
	$.ajax($.extend(true , baseAjaxObj , AjaxObj)); 
	return resultData;
}
// 기존 CAF에서 쓰던 taglib  <caf:DBManager /> caf:queryList 
function rawrisCafDBManager(cafObj){
		var baseCafAjaxObj = {
				 url  : "query.do"
			   , data : {  cmd   : "getJsonDataPageList" }
		}
		var cafAjaxObj = $.extend(true , baseCafAjaxObj , cafObj);
		return rawrisAjax(cafAjaxObj);

}

function rawrisExcelDownLoad(excelDownUrl){  
	$("body").append("<form id='FormExcel' name='FormExcel' method='post'></form>");
	$("#FormExcel").attr("action",excelDownUrl);
	$("#FormExcel").submit();
	$("#FormExcel").remove(); 
}



function rawrisLnbMenuList(){ 
	
	// 화면 및 tab별 검색조건
	var searchConditionObj = { pid   : "rawris_tb_menu_mgt"
							 , sqlid : "list_for_lnb_menu"
							 , cmd   : "getJsonDataList"
	}
	
	var inqUrl = "query.do"+rawrisSearchConditionByStr(searchConditionObj); 
	return rawrisAjax({url:inqUrl}) ;
	
}


function rawrisConvertLowerDataList(dataList){
	var rtnDataList = new Array();
	$.each(dataList , function(indx , data){
		var dataObj = {}; 
		$.each( Object.keys(data) , function(i , key){ 
			eval("dataObj."+key.toLowerCase()+" = dataList["+indx+"]."+key); 
		}); 
		rtnDataList.push(dataObj);
	});
	return rtnDataList;
}

function rawrisSearchConditionByStr(searchConditionObj){
	   var urlQryStrs = "";
	   var searchConditionArr = Object.keys(searchConditionObj);
	   for(var arrIndx = 0; arrIndx < searchConditionArr.length ; arrIndx++){
		    var searchConditionKey = searchConditionArr[arrIndx];
		    var searchConditionVal = eval("searchConditionObj."+searchConditionKey);
		    urlQryStrs += urlQryStrs == "" ? "?"+searchConditionKey+"="+searchConditionVal : "&"+searchConditionKey+"="+searchConditionVal
	   }
	   return urlQryStrs; 
	   // return  $.param(searchConditionObj); 
}

function rawrisSearchConditionByUpperStr(searchConditionObj){
	   var urlQryStrs = "";
	   var searchConditionArr = Object.keys(searchConditionObj);
	   for(var arrIndx = 0; arrIndx < searchConditionArr.length ; arrIndx++){
		    var searchConditionKey = searchConditionArr[arrIndx];
		    var searchConditionVal = eval("searchConditionObj."+searchConditionKey);
		    urlQryStrs += urlQryStrs == "" ? "?"+searchConditionKey.toUpperCase()+"="+searchConditionVal : "&"+searchConditionKey.toUpperCase()+"="+searchConditionVal
	   }
	   return urlQryStrs; 
	   // return  $.param(searchConditionObj)
}

// Document의 값 수집 
function rawrisGetEleValues(targetObjArr){
	
	var collectionEleDatas = {}; 
	if(rawrisIsEmpty(targetObjArr)) return collectionEleDatas; 
	var collectionKeys = Object.keys(targetObjArr);
	for(var i = 0 ; i < collectionKeys.length; i++){
		var ele = $("[id='"+collectionKeys[i]+"']").length == 1 ? $("[id='"+collectionKeys[i]+"']") : $("[name='"+collectionKeys[i]+"']"); 
		var eleType = rawrisGetEleType(ele); 
		  
		var eleInfo = eval("targetObjArr."+collectionKeys[i]); 
		var eleValidAttrArr = Object.keys(eleInfo);
		var isAbleCollection = true;
		for(var j = 0; j < eleValidAttrArr.length ; j++ ){
			var eleValidAttr = eleValidAttrArr[j]; 
			if(eleValidAttr.toUpperCase().indexOf("SHOW") > -1){ 
			    isAbleCollection = $(ele).css("display") == "none" ? false : true; 
			} 
		}   
		 
		if(isAbleCollection){ 
			if(eleType == "file"){ 
				eval("collectionEleDatas."+collectionKeys[i]+" = $(ele).prop('files')[0]"); 
			}else{ 
				eval("collectionEleDatas."+collectionKeys[i]+" = '"+rawrisGetEleVal($(ele))+"';" );
			} 
		}else{
			eval("collectionEleDatas."+collectionKeys[i]+" = '';" );
		}
	}  
	return collectionEleDatas;
}
  
// document Validate
function rawrisValidateObj(validObj){
	
	if(rawrisIsEmpty(validObj)) return false;
	
	 var validObjKeyArr = Object.keys(validObj) ;

	 for(var i = 0 ; i < validObjKeyArr.length ; i++){ 
		var keyNm = validObjKeyArr[i] ;
		var ele = $("[id='"+keyNm+"']").length == 1 ? $("[id='"+keyNm+"']") : $("[name='"+keyNm+"']");
		var eleVal = rawrisGetEleVal($(ele));  
		var eleName = eval("validObj."+keyNm+".eleNm");
		
		var eleValidAttrs = Object.keys(eval("validObj."+keyNm));
		for(var j = 0 ; j < eleValidAttrs.length; j++){
			var validAttr = eleValidAttrs[j]; 
			var validAttrVal = eval("validObj."+keyNm+"."+validAttr); 
			
			if(validAttr.toUpperCase() == "REQUIRED"){   
				if(validAttrVal){ 
					if(rawrisIsEmpty(eleVal)){
						rawrisShowMsg(eleName+"은(는) 필수입력 항목입니다."); 
						return false;
					} 
				}
			 }else if(validAttr.toUpperCase() == "PAREREQUIRED"){ // 조건에따른 필수값
				 /* 예) 수로 분기점 존재여부 ('Y':있음 , 'N':없음)  
				  *    'Y' 선택시 , 분기점번호 필수입력
				  *    'N' 선택시 , 분기점번호 입력불가
				  */
				 if(!rawrisIsEmpty(validAttrVal.target)){
					 var pareEle = $("[id='"+validAttrVal.target+"']").length == 1 ? $("[id='"+validAttrVal.target+"']") : $("[name='"+validAttrVal.target+"']");
					 var pareEleVal = rawrisGetEleVal($(pareEle));   
					 if(pareEleVal ==  validAttrVal.pareVal){ 
						 var keyEle = $("[id='"+keyNm+"']").length == 1 ? $("[id='"+keyNm+"']") : $("[name='"+keyNm+"']");
						 var keyEleVal = rawrisGetEleVal($(ele)); 
						 
						 if(rawrisIsEmpty(keyEleVal)){
							 rawrisShowMsg(eleName+"은(는) 필수입력 항목입니다.");
							 return false;
						 } 
					 } 	
				 }else{
					 rawrisShowMsg(eleName+"은(는) 조건 필수입력 항목입니다."); 
					 return false; 
				 }  
			 }else if(validAttr.toUpperCase() == "CONDIREQUIRED"){ 
				 /* 예) 하나의 엘리먼트 조건값에따라 여러개의 Element가 필수값여부로 변경  
				  *     조회방식 : 월별 , 일별, 시간별 
				  *     1)시간별 선택시  본부는 필수값
				  *     1)10분별 선택시 시설은 필수값
				  *     참고페이지 : /App_JSP_Data_View/index.jsp?dir_url=DataSearching-RAWRIS&url=rawris_reservoir&searchType=Equipcode_measure_
				  */
				 
				 var selEleValObj = eval("validAttrVal."+eleVal); 
				 if(!rawrisIsEmpty(selEleValObj)){ 
					 
					 if(!rawrisIsEmpty(selEleValObj.eles)){ 
						 for(var k = 0 ; k < selEleValObj.eles.length ; k++){ 
							 var keyEle = $("[id='"+selEleValObj.eles[k]+"']").length == 1 ? $("[id='"+selEleValObj.eles[k]+"']") : $("[name='"+selEleValObj.eles[k]+"']");
							 var keyEleVal = rawrisGetEleVal($(keyEle));
							 if(rawrisIsEmpty(keyEleVal)){
								 rawrisShowMsg(eleName+"이(가) "+selEleValObj.condiName+"일 경우 "+selEleValObj.eleName+" 은(는) 필수값입니다."); 
								 return false;
							 } 
						 }
					 }
					 
					 
				 } 
			 }else if(validAttr.toUpperCase() == "SHOWREQUIRED"){  // 화면에 나타나 있으면 필수값 
				 if(validAttrVal){ 
					 if( $(ele).css("display") != "none"){
						 if(rawrisIsEmpty(eleVal)){
								rawrisShowMsg(eleName+"은(는) 필수입력 항목입니다."); 
								return false;
						 } 
					 }
				 } 
			 }else if(validAttr.toUpperCase() == "MAXLENGTH"){ 
				 var valLenth = rawrisGetByteLength(eleVal);
				 if(validAttrVal < valLenth){
					 rawrisShowMsg(eleName+"은(는) 최대 "+validAttrVal+"Byte까지 입력가능합니다. \n현재 입력 : "+valLenth+"byte  \n 한글:2Byte , 영문/숫자 : 1Byte"); 
					 return false;
				 } 
			 }else if(validAttr.toUpperCase() == "MINLENGTH"){
				 var valLenth = rawrisGetByteLength(eleVal);
				 if(validAttrVal > valLenth){
					 rawrisShowMsg(eleName+"은(는) 최소 "+validAttrVal+"Byte까지 입력해야합니다. \n현재 입력 : "+valLenth+"byte  \n 한글:2Byte , 영문/숫자 : 1Byte"); 
					 return false;
				 }
			 }else if(validAttr.toUpperCase() == "NUMBER"){ 
				   if(validAttrVal){
					   if(!$.isNumeric(eleVal)){
						   rawrisShowMsg(eleName+"은(는) 숫자만 입력가능합니다."); 
						   return false;
					   }  
				   } 
			 }else if(validAttr.toUpperCase() == "SHOWNUMBER"){ 
				   if(validAttrVal){
					   if( $(ele).css("display") != "none"){
						   if(!$.isNumeric(eleVal)){
							   rawrisShowMsg(eleName+"은(는) 숫자만 입력가능합니다."); 
							   return false;
						   } 
					   } 
				   } 
			 }else if(validAttr.toUpperCase() == "DOUBLEFORMAT"){ 
				 if(!$.isNumeric(eleVal)){
					 rawrisShowMsg(eleName+"은(는) 숫자만 입력가능합니다."); 
					 return false;
				 }
				 var numArr = eleVal.split(".");
				 if(numArr.length > 2){
					 rawrisShowMsg(eleName+"은(는) 값 입력오류 입니다.");
					 return false;
				 }
				 
				 var validFormatArr = validAttrVal.split(","); 
				 if(validFormatArr.length > 2){
					 rawrisShowMsg(eleName+" Validate DoubleFormat 값 입력오류.");
					 return false;
				 }
				 
				 var numLen   = validFormatArr[0];
				 var floatLen = validFormatArr[1];
				 
				 if(numArr[0].length > Number(numLen)){
					 rawrisShowMsg(eleName+"의 정수부입력자리수가 초과되었습니다. \n 현재 : "+numArr[0].length+"자리 , 최대 : "+numLen+"자리까지 입력가능");
					 return false;
				 }
				  
				 if(!rawrisIsEmpty(numArr[1])){
					 if(numArr[1].length > Number(floatLen)){
						 rawrisShowMsg(eleName+"의 소수부입력자리수가 초과되었습니다. \n 현재 : "+numArr[1].length+"자리 , 최대 : "+floatLen+"자리까지 입력가능");
						 return false;
					 } 
				 } 
			 }else if(validAttr.toUpperCase() == "SHOWDOUBLEFORMAT"){
				 if( $(ele).css("display") != "none"){
					 if(!$.isNumeric(eleVal)){
						 rawrisShowMsg(eleName+"은(는) 숫자만 입력가능합니다."); 
						 return false;
					 }
					 var numArr = eleVal.split(".");
					 if(numArr.length > 2){
						 rawrisShowMsg(eleName+"은(는) 값 입력오류 입니다.");
						 return false;
					 }
					 
					 var validFormatArr = validAttrVal.split(","); 
					 if(validFormatArr.length > 2){
						 rawrisShowMsg(eleName+" Validate DoubleFormat 값 입력오류.");
						 return false;
					 }
					 
					 var numLen   = validFormatArr[0];
					 var floatLen = validFormatArr[1];
					 
					 if(numArr[0].length > Number(numLen)){
						 rawrisShowMsg(eleName+"의 정수부입력자리수가 초과되었습니다. \n 현재 : "+numArr[0].length+"자리 , 최대 : "+numLen+"자리까지 입력가능");
						 return false;
					 }
					  
					 if(!rawrisIsEmpty(numArr[1])){
						 if(numArr[1].length > Number(floatLen)){
							 rawrisShowMsg(eleName+"의 소수부입력자리수가 초과되었습니다. \n 현재 : "+numArr[1].length+"자리 , 최대 : "+floatLen+"자리까지 입력가능");
							 return false;
						 } 
					 }  
				 }
			 }else if(validAttr.toUpperCase() == "EMAIL"){
				 if(validAttrVal){ 
					 if(rawrisIsEmpty(eleVal)){
							rawrisShowMsg("메일주소를 입력하세요");
							return false; 
					 }
					 var EmailPattern = /^([a-z\d!#$%&'*+\-\/=?^_`{|}~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+(\.[a-z\d!#$%&'*+\-\/=?^_`{|}~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+)*|"((([ \t]*\r\n)?[ \t]+)?([\x01-\x08\x0b\x0c\x0e-\x1f\x7f\x21\x23-\x5b\x5d-\x7e\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|\\[\x01-\x09\x0b\x0c\x0d-\x7f\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))*(([ \t]*\r\n)?[ \t]+)?")@(([a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|[a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF][a-z\d\-._~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]*[a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])\.)+([a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|[a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF][a-z\d\-._~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]*[a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])\.?$/i;
				     if(!EmailPattern.test(eleVal)){
				     	 rawrisShowMsg("메일주소형식이 부적합 합니다");
						 return false;
				     } 
				 }
		    }else if(validAttr.toUpperCase() == "DATETERM"){
		    	
		    	/*   dateTerm : {eleNm : "엘리먼트명" , dateTerm  : { condition : { beginDt  : "equip_install_date" , beginDtNm : "시작일자" 
                                                                    , finishDt  : "equip_remove_date"  , finishDtNm : "종료일자" 
                                                                    , dtDiv     : "dail" }
                                                      , validAttr : { minute : {condiNm : "10분별" , termDiv: "D" , termDiff:"0" }
														 	        , hour   : {condiNm : "시간별" , termDiv: "D" , termDiff:"3" } 
																	, daily  : {condiNm : "일별"   , termDiv: "D" , termDiff:"30"}
																	, month  : {condiNm : "월별"   , termDiv: "M" , termDiff:"12"} 
																    } 
													  }
                                                             
                 }*/ 
		    	if(!rawrisIsEmpty(validAttrVal.condition)){
		    		if( !rawrisIsEmpty(validAttrVal.condition.beginDt) && !rawrisIsEmpty(validAttrVal.condition.finishDt) && !rawrisIsEmpty(validAttrVal.condition.dtDiv)){
		    			 
		    			var beginEle = $("[id='"+validAttrVal.condition.beginDt+"']").length == 1 ? $("[id='"+validAttrVal.condition.beginDt+"']") : $("[name='"+validAttrVal.condition.beginDt+"']");
		    			var beginEleVal = rawrisGetEleVal($(beginEle));
                        var beginEleNm = rawrisIsEmpty(validAttrVal.condition.beginDtNm) ? "시작일" : validAttrVal.condition.beginDtNm ;
		    			
		    			var finishEle = $("[id='"+validAttrVal.condition.finishDt+"']").length == 1 ? $("[id='"+validAttrVal.condition.finishDt+"']") : $("[name='"+validAttrVal.condition.finishDt+"']");
		    			var finishEleVal = rawrisGetEleVal($(finishEle));
		    			var finishEleNm = rawrisIsEmpty(validAttrVal.condition.finishDtNm) ? "종료일" : validAttrVal.condition.finishDtNm; 
		    			if(!rawrisIsEmpty(beginEleVal) &&  !rawrisIsEmpty(finishEleVal)){
		    				var dateDiv = validAttrVal.condition.dtDiv; 
		    				var validDtKeys = Object.keys(validAttrVal.validAttr);
		    				var isValidChk = false;
		    				for(var k = 0 ; k < validDtKeys.length; k++){ 
		    					var dtKey = validDtKeys[k];
		    					if(dtKey == dateDiv){
		    						var selValidAttr = eval("validAttrVal.validAttr."+dtKey); 
		    						var diffDate = rawrisDateDiff(beginEleVal , finishEleVal , selValidAttr.termDiv); 
		    						var diffDiv  = selValidAttr.termDiv; 
		    						var diffDivNm ;
		    						if("Y" == diffDiv) diffDivNm = "년"; 
		    						else if("M" == diffDiv) diffDivNm = "월"; 
		    						else if("D" == diffDiv) diffDivNm = "일";  
		    							
		    						if(diffDate > selValidAttr.termDiff){ 
		    							rawrisShowMsg(eleName+"은(는) "+selValidAttr.condiNm+"일경우 \n"+beginEleNm+"와 "+finishEleNm+"는 최대 "+selValidAttr.termDiff+diffDivNm+"까지 선택할수있습니다.");
		    							return false; 
		    						}
		    						isValidChk = true;
		    					}
		    				}
		    				if(!isValidChk) return false; 
		    			}else{
		    				rawrisShowMsg(eleName+"은(는) "+beginEleNm+"와 "+finishEleNm+"가 필수입력입니다.");
		    				return false;
		    			} 
		    		}else{ return false; }
		    	}else{ return false; }
		    }else if(validAttr.toUpperCase() == "PAREDATETERM"){
		    	/*{eleNm : "장비설치일자" , pareDateTerm : { pareInfo  : {target:"fac_boff_point_yn" , targetNm : "시설분기점여부", pareVal: "Y"}
											                 condition : { beginDt  : "equip_install_date" , beginDtNm : "장비설치일자" 
											                             , finishDt : "equip_remove_date"  , finishDtNm : "장비제거일자" 
											                             , dtDiv    : "daily" }
											               , validAttr : { minute : {condiNm : "10분별" , termDiv: "D" , termDiff:"0" }
														  	             , hour   : {condiNm : "시간별" , termDiv: "D" , termDiff:"3" } 
																  	     , daily  : {condiNm : "일별"   , termDiv: "D" , termDiff:"30"}
																	     , month  : {condiNm : "월별"   , termDiv: "M" , termDiff:"12"} 
																	     } 
														   }                     
				}*/
		    	if(!rawrisIsEmpty(validAttrVal.pareInfo.target) && !rawrisIsEmpty(validAttrVal.pareInfo.pareVal)){ 
		    		var pareEle = $("[id='"+validAttrVal.pareInfo.target+"']").length == 1 ? $("[id='"+validAttrVal.pareInfo.target+"']") : $("[name='"+validAttrVal.pareInfo.target+"']");
	    			var pareEleVal = rawrisGetEleVal($(pareEle));
	    			var targetNm = rawrisIsEmpty(validAttrVal.pareInfo.targetNm) ? "비교조건" : validAttrVal.pareInfo.targetNm;
	    			if(!rawrisIsEmpty(pareEleVal)){
	    				if(pareEleVal == validAttrVal.pareInfo.pareVal){
	    					
	    					
	    					
	    					if(!rawrisIsEmpty(validAttrVal.condition)){
	    			    		if( !rawrisIsEmpty(validAttrVal.condition.beginDt) && !rawrisIsEmpty(validAttrVal.condition.finishDt) && !rawrisIsEmpty(validAttrVal.condition.dtDiv)){
	    			    			 
	    			    			var beginEle = $("[id='"+validAttrVal.condition.beginDt+"']").length == 1 ? $("[id='"+validAttrVal.condition.beginDt+"']") : $("[name='"+validAttrVal.condition.beginDt+"']");
	    			    			var beginEleVal = rawrisGetEleVal($(beginEle));
	    	                        var beginEleNm = rawrisIsEmpty(validAttrVal.condition.beginDtNm) ? "시작일" : validAttrVal.condition.beginDtNm ;
	    			    			
	    			    			var finishEle = $("[id='"+validAttrVal.condition.finishDt+"']").length == 1 ? $("[id='"+validAttrVal.condition.finishDt+"']") : $("[name='"+validAttrVal.condition.finishDt+"']");
	    			    			var finishEleVal = rawrisGetEleVal($(finishEle));
	    			    			var finishEleNm = rawrisIsEmpty(validAttrVal.condition.finishDtNm) ? "종료일" : validAttrVal.condition.finishDtNm; 
	    			    			if(!rawrisIsEmpty(beginEleVal) &&  !rawrisIsEmpty(finishEleVal)){
	    			    				var dateDiv = validAttrVal.condition.dtDiv; 
	    			    				var validDtKeys = Object.keys(validAttrVal.validAttr);
	    			    				var isValidChk = false;
	    			    				for(var k = 0 ; k < validDtKeys.length; k++){ 
	    			    					var dtKey = validDtKeys[k];
	    			    					if(dtKey == dateDiv){
	    			    						var selValidAttr = eval("validAttrVal.validAttr."+dtKey); 
	    			    						var diffDate = rawrisDateDiff(beginEleVal , finishEleVal , selValidAttr.termDiv); 
	    			    						var diffDiv  = selValidAttr.termDiv; 
	    			    						var diffDivNm ;
	    			    						if("Y" == diffDiv) diffDivNm = "년"; 
	    			    						else if("M" == diffDiv) diffDivNm = "월"; 
	    			    						else if("D" == diffDiv) diffDivNm = "일";  
	    			    							
	    			    						if(diffDate > selValidAttr.termDiff){ 
	    			    							rawrisShowMsg(eleName+"은(는) "+selValidAttr.condiNm+"일경우 \n"+beginEleNm+"와 "+finishEleNm+"는 최대 "+selValidAttr.termDiff+diffDivNm+"까지 선택할수있습니다.");
	    			    							return false; 
	    			    						}
	    			    						isValidChk = true;
	    			    					}
	    			    				}
	    			    				if(!isValidChk) return false; 
	    			    			}else{
	    			    				rawrisShowMsg(eleName+"은(는) "+beginEleNm+"와 "+finishEleNm+"가 필수입력입니다.");
	    			    				return false;
	    			    			} 
	    			    		}else{ return false; }
	    			    	}else{ return false; } 
	    					
	    					
	    				} 
	    			}else{ 
	    			  rawrisShowMsg(targetNm+"을(를) 선택 하세요");	
	    			  return false; 
	    			} 
		    	}else{return false; } 
		    }	
		} 
	 }
	 return true; 
}
// Element getValue
function rawrisGetEleVal( ele ){ 
	
	var eleVal;
	var eleDiv = rawrisGetEleType( $(ele));
	if(eleDiv == "text" || eleDiv == "number"){
		eleVal = $(ele).val();
	}else if(eleDiv == "hidden"){
		eleVal = $(ele).val();
	}else if(eleDiv == "radio"){ 
		var radioName = $(ele[0]).attr("name");
		eleVal = $("[name='"+radioName+"']:checked").val();
	}else if(eleDiv == "select"){
		eleVal = $(ele).val();
	}else if(eleDiv == "file"){   
		// eleVal = $(ele).prop("files")[0].name; 
		   eleVal = $(ele).clone();
	}else if(eleDiv == "checkbox"){ 
		eleVal = $(ele).is(":checked") ? "Y" : "N";
	}else if(eleDiv == "textarea"){
		eleVal = $(ele).val();
	} 
	 
	return eleVal;
}

//Element getType
function rawrisGetEleType( ele ){ 
	var eleType ;  
	if($(ele).is("input")){  
		eleType = $(ele).attr("type");
	}else if($(ele).is("select")){
		eleType = "select";	
	}else if($(ele).is("checkbox")){
		eleType = "checkbox";	
	}else if($(ele).is("textarea")){
		eleType = "textarea";  
	} 
	return eleType; 
} 
 
function rawrisTableDisplay(tarDispObj){
	
	if(!tarDispObj.dispDiv) return false;
	var dispDiv = tarDispObj.dispDiv;
 	
	var colInfo = eval("tarDispObj.displayColInfos."+dispDiv); 
	var targetHtml = "";  
	var colInfoLength = colInfo.length; 
	
	
	if(!rawrisIsEmpty(colInfo)){ 
		
		 
		var resourceRowsLenght = tarDispObj.resource.length; 
		if( resourceRowsLenght == 0 ){
			// targetHtml = "<tr height='30'><td colspan='"+colInfoLength+"' align='center'>데이터가 존재하지 않습니다.</td></tr>";
			// $("#" + tarDispObj.paginginfo.targetId).html(targetHtml);
		       $(tarDispObj.paginginfo.targetId).html("No Data Found");
		}else{
			for(var i = 0 ; i < resourceRowsLenght ; i++){
				
				targetHtml += "<tr>";
				for(var j = 0 ; j < colInfoLength ; j++ ){
					var colId       = colInfo[j].id;
					var colType     = rawrisNVL(colInfo[j].colType  , "string");
                    var colAlign    = rawrisNVL(colInfo[j].align    , "center");
                    var colStyle    = rawrisNVL(colInfo[j].style    , "");
                    var nullDisp    = rawrisNVL(colInfo[j].nullDisp , "Y");
                    
                    var resourceRow = tarDispObj.resource[i];
                    var dataPropsHtml = "";
                      
                    for(var k = 1; k <= 10 ; k++){
                    	var dataProp = rawrisNVL(eval("colInfo["+j+"].data_id"+k),"anonymous");
                    	if("anonymous" != dataProp){ 
                    		var dataPropVal = rawrisNVL(eval("tarDispObj.resource["+i+"]."+dataProp)  , ""); 
                    		dataPropsHtml += " data-"+dataProp+"='"+dataPropVal+"' "; 
                    	}
                    }
                                        
					if(colType == "string"){  
						targetHtml += "   <td align='"+colAlign+"' "+dataPropsHtml+">"+rawrisNVL(eval("resourceRow."+colInfo[j].id),"")+"</td>";
					} else if(colType == "double"){ 
						var colDblPattrn = rawrisNVL(colInfo[j].pattern , ".##");
						var colDblPattrnLen = rawrisInStrCount(colDblPattrn ,"#");  
						 
						var theadLastRowThLength = $(tarDispObj.dispTarget).closest("table").find("thead > tr").eq(0).find("th").length; 
						var totColLen = 0;  
						for(var l = 0 ; l < theadLastRowThLength ; l++){ 
							totColLen += Number(rawrisNVL($( $(tarDispObj.dispTarget).closest("table").find("thead > tr").eq(0).find("th")[l] ).attr("colspan"),1)); 
						}
						 
						if(j < totColLen){ 
							var colDblVal = Number(rawrisNVL(eval("resourceRow."+colInfo[j].id),0)).toFixed(colDblPattrnLen);
							if(colDblVal == 0) colDblVal = rawrisIsEmpty( colInfo[j].zero) ? colDblVal : colInfo[j].zero; 
							targetHtml += "   <td align='"+colAlign+"' "+dataPropsHtml+">"+colDblVal.replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,") +"</td>";
						}  
					} else if(colType == "number"){  
						var colVal  = ""+eval("resourceRow."+colInfo[j].id); 
						    colVal = colVal.substring(0,colVal.indexOf(".") == -1 ? colVal.length : colVal.indexOf(".")); 
						    
						var theadLastRowThLength = $(tarDispObj.dispTarget).closest("table").find("thead > tr").eq(0).find("th").length; 
						var totColLen = 0;
						for(var l = 0 ; l < theadLastRowThLength ; l++){
							totColLen += Number(rawrisNVL($( $(tarDispObj.dispTarget).closest("table").find("thead > tr").eq(0).find("th")[l] ).attr("colspan"),1));
						}   
						if(j < totColLen){
							var colNumlVal = eval("resourceRow."+colInfo[j].id); 
							if($.isNumeric(colNumlVal)){ 
								targetHtml += "   <td align='"+colAlign+"' "+dataPropsHtml+" >"+(""+Math.round(colNumlVal,1)).replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,")+"</td>"; 
							}else{  
								targetHtml += "   <td align='"+colAlign+"' "+dataPropsHtml+" >"+(rawrisIsEmpty( colInfo[j].zero) ? "0" : colInfo[j].zero)+"</td>"; 
							}  
						}  
					}else if(colType == "hidden"){  
						targetHtml += "   <td style='display: none;' id='"+colInfo[j].id+"_"+rawrisNVL(resourceRow.rownum_,i)+"' "+dataPropsHtml+" >"+eval("resourceRow."+colInfo[j].id)+"</td>";
					}else if(colType == "button"){   
						var btnText = !rawrisIsEmpty(eval("resourceRow."+colInfo[j].id)) ? eval("resourceRow."+colInfo[j].id) : rawrisNVL(colInfo[j].buttonTxt,""); 
						targetHtml += "  <td style='text-align:center;'>"; 
						targetHtml += "  	<button type='button' id='"+colInfo[j].id+"_"+resourceRow.rownum_+"' style='"+colStyle+"'  class='"+rawrisNVL(colInfo[j].classNm,'')+"' "+dataPropsHtml+">"+btnText+"</button>";
						targetHtml += "  </td>";
					}else if(colType == "checkbox"){  
						var strChecked = eval("resourceRow."+colInfo[j].id) == "Y" ? "checked" : ""; 
						targetHtml += "<td style='text-align:center;'>";
						targetHtml += "   <input type='checkbox' id='"+colInfo[j].id+"_"+resourceRow.rownum_+"' value='"+colInfo[j].val+"'  style='"+colStyle+"' name='"+colInfo[j].id+"_"+resourceRow.rownum_+"' "+dataPropsHtml+" "+strChecked+" >";
						targetHtml += "</td>";
					}else if(colType == "text"){ 
						targetHtml += "<td style='text-align:center;'>";
						targetHtml += "	  <input type='text' id='"+colInfo[j].id+"_"+resourceRow.rownum_+"' name='"+colInfo[j].id+"'  style='"+colStyle+"'  value='"+rawrisNVL(eval("resourceRow."+colInfo[j].id),"")+"' >";
						targetHtml += "</td>"; 
					}else if(colType == "datepicker"){
						targetHtml += "<td style='text-align:center;'>";
						targetHtml += "	  <input type='text' data-cellTp='datePicker' id='"+colInfo[j].id+"_"+resourceRow.rownum_+"' name='"+colInfo[j].id+"'  style='"+colStyle+"'  value='"+rawrisNVL(eval("resourceRow."+colInfo[j].id),"")+"' readonly>";
						targetHtml += "</td>"; 
					}
				}
				targetHtml += "</tr>";
			} 
			
			// Paging Area Renderer 
			if(!rawrisIsEmpty(tarDispObj.paginginfo) ){
				 
				var isDel = rawrisNVL(tarDispObj.paginginfo.clear,false); 
				if(rawrisNVL(tarDispObj.paginginfo.clear,false)){
					$(tarDispObj.paginginfo.targetId).html("");
				}else{
					rawrisPageNationDisp({
						  pagingAreaId : tarDispObj.paginginfo.targetId
						, clickFnNm    : tarDispObj.paginginfo.fnName
						, pageNo       : tarDispObj.resource.pageNo
						, pageSize     : tarDispObj.resource.pageSize
						, totalCount   : tarDispObj.resource.totalCount
						, btnFnName    : tarDispObj.paginginfo.btnFnName
					}); 
				} 
			} 
		}
	}

	$(tarDispObj.dispTarget).empty();
	$(tarDispObj.dispTarget).html(targetHtml);
	
	// DatePicker적용
	$.each($(tarDispObj.dispTarget).find("[data-cellTp='datePicker']"),function(indx , ele){ 
		rawrisDatePicker("#"+ $(ele).attr("id")); 
	}); 
}
 
function rawrisPageNationDisp(pagingInfoObj){
	  
	var pageDiv    = $(pagingInfoObj.pagingAreaId)
	, 	totalPage   = Math.ceil(pagingInfoObj.totalCount/pagingInfoObj.pageSize)
	, 	totalGroup = Math.ceil(totalPage/10)
	, 	prevGroupNo
	,   nextGroupNo
	, 	pageStart
	,   pageEnd
	, 	groupSize = 10
	, 	nowGroup = parseInt((pagingInfoObj.pageNo-0.1) / groupSize)
	, 	tags = null;

	if(nowGroup <= 0) prevGroupNo = 0;
	else  prevGroupNo = (nowGroup - 1) * groupSize + 1;

	if((totalGroup - 1) <= nowGroup)  nextGroupNo = 0;
	else nextGroupNo = (nowGroup + 1) * groupSize + 1;


	tags = "<ul class='pagination pagination-sm'><li><span style='cursor:pointer;' pageNo='1'>처음</span></li>"
			+ "<li><span style='cursor:pointer;' pageNo='" + prevGroupNo + "'>이전</span></li>";

	pageStart = nowGroup * 10 + 1;
	pageEnd = pageStart + 10;

	if ((totalPage+1) < pageEnd) {
		pageEnd = totalPage+1;
	}

	for(var i = pageStart; i < pageEnd; i++) {
		if(pagingInfoObj.pageNo == i) {
			tags += "<li class='active'><span style='cursor:pointer;' pageNo='" + i + "'>" + i + "</span></li>"
		} else {
			tags += "<li><span style='cursor:pointer;' pageNo='" + i + "'>" + i + "</span></li>"
		}
	}

	tags += "<li><span style='cursor:pointer;' pageNo='" + nextGroupNo + "'>다음</span></li>"
		+"<li><span style='cursor:pointer;' pageNo='" + totalPage + "'>마지막</span></li></ul>";
  
	pageDiv.html(tags);
	
	
	if(pagingInfoObj.pageNo == 1) {
		$(pagingInfoObj.pagingAreaId + " li:eq(0)").addClass("disabled");
		$(pagingInfoObj.pagingAreaId + " li:eq(0) > span").css("cursor", "default");
	} else {
		$(pagingInfoObj.pagingAreaId + " li:eq(0)").removeClass("disabled");
		$(pagingInfoObj.pagingAreaId + " li:eq(0) > span").css("cursor", "pointer");
	}

	if(pagingInfoObj.pageNo == totalPage) {
		$(pagingInfoObj.pagingAreaId + " li:nth-last-child(1)").addClass("disabled");
		$(pagingInfoObj.pagingAreaId + " li:nth-last-child(1) > span").css("cursor", "default");
	} else {
		$(pagingInfoObj.pagingAreaId + " li:nth-last-child(1)").removeClass("disabled");
		$(pagingInfoObj.pagingAreaId + " li:nth-last-child(1) > span").css("cursor", "pointer");
	}

	if(prevGroupNo == 0) {
		$(pagingInfoObj.pagingAreaId + " li:eq(1)").addClass("disabled");
		$(pagingInfoObj.pagingAreaId + " li:eq(1) > span").css("cursor", "default");
	} else {
		$(pagingInfoObj.pagingAreaId + " li:eq(1)").removeClass("disabled");
		$(pagingInfoObj.pagingAreaId + " li:eq(1) > span").css("cursor", "pointer");
	}

	if(nextGroupNo == 0) {
		$(pagingInfoObj.pagingAreaId + " li:nth-last-child(2)").addClass("disabled");
		$(pagingInfoObj.pagingAreaId + " li:nth-last-child(2) > span").css("cursor", "default");
	} else {
		$(pagingInfoObj.pagingAreaId + " li:nth-last-child(2)").removeClass("disabled");
		$(pagingInfoObj.pagingAreaId + " li:nth-last-child(2) > span").css("cursor", "pointer");
	}

	$(pagingInfoObj.pagingAreaId + " li[class !='disabled'] > span").on("click", function() { 
		pagingInfoObj.btnFnName($(this).attr("pageNo"));
	});
}


function rawrisShowMsg(msg){
	alert(msg);
}

function rawrisConfirm(msg){
	return confirm(msg);
}

//  Select Box 생성함수  (@deprecated)
function rawrisDynaGenSelect(comboInfoObj){    
	
	  if(rawrisIsEmpty(comboInfoObj.comboInfo.comboId) || rawrisIsEmpty(comboInfoObj.comboInfo.targetArea)) return false; 
	  
	  var comboBoxId    = comboInfoObj.comboInfo.comboId;
	  var comboBoxNm    = rawrisNVL(comboInfoObj.comboInfo.comboNm , comboInfoObj.comboInfo.comboId);
	  var comboStyle    = rawrisIsEmpty(comboInfoObj.comboInfo.styleStr)  ? "" : " style='"+comboInfoObj.comboInfo.styleStr+"' ";
	  var comboClass    = rawrisIsEmpty(comboInfoObj.comboInfo.className) ? "" : " class='"+comboInfoObj.comboInfo.className+"' "; 
	  var comboChangeFn = rawrisIsEmpty(comboInfoObj.comboInfo.changefn)  ? "" : "onchange='"+comboInfoObj.comboInfo.changefn.fnNm+"("+rawrisNVL(comboInfoObj.comboInfo.changefn.args,'')+")'";
	    	  
	  var comboHtml = "<select name='"+comboBoxNm+"' id='"+comboBoxId+"' "+comboStyle+" "+comboClass+" "+comboChangeFn+" >"; 
	  if(!rawrisIsEmpty(comboInfoObj.optionInfo)){
		  if(rawrisNVL(comboInfoObj.optionInfo.postion,"top") == "top"){ 
			  comboHtml += "<option value='"+rawrisNVL(comboInfoObj.optionInfo.val,"SEL")+"'>"+rawrisNVL(comboInfoObj.optionInfo.txt,"선택")+"</option>"
		  } 
	  } 
	  
	  $.each(comboInfoObj.comboDataInfo , function(indx , arrVal){ 
		  var optionVal = eval("arrVal."+comboInfoObj.optionValInfo.optId);
		  var optionTxt = eval("arrVal."+comboInfoObj.optionValInfo.optTxt);   
		  comboHtml += "<option value='"+optionVal+"'>"+optionTxt+"</option>";
	  }); 
	  
	  if(!rawrisIsEmpty(comboInfoObj.optionInfo)){  	  
		  if(rawrisNVL(comboInfoObj.optionInfo.postion,"top") == "bottom"){
			  comboHtml += "<option value='"+rawrisNVL(comboInfoObj.optionInfo.val,"SEL")+"'>"+rawrisNVL(comboInfoObj.optionInfo.txt,"선택")+"</option>"
		  }
	  }
	  comboHtml += "</select>";
	  $(comboInfoObj.comboInfo.targetArea).empty();
	  $(comboInfoObj.comboInfo.targetArea).html(comboHtml);
	    
}

// Hidden Form 동적 생성
function rawrisDynaGenHiddenForm(formInfo){
	/*var formInfo = { formDefine : { fid:"" , fname:"" , target:"" , action:"" , method : "" , classNm : "" , style:"" }
			         , formAttrs  : { equip_no    : {name : "" , val:"" } 
	                                , date_upload : {name : "" , val:"" }
			                        }       
	                 }
    */
	
	/*$("body").append("<form id='FormExcel' name='FormExcel' method='post'></form>");
	$("#FormExcel").attr("action",excelDownUrl);
	$("#FormExcel").submit();
	$("#FormExcel").remove();*/
	
	if(rawrisIsEmpty(formInfo.formDefine.fid)) return false;
	
	var formId   = formInfo.formDefine.fid;
	var formName = rawrisIsEmpty(formInfo.formDefine.fname) ? formId : formInfo.formDefine.fname;
	var formAction = rawrisIsEmpty(formInfo.formDefine.action) ? "" : " action='"+formInfo.formDefine.action+"'";
	var formEncType = rawrisIsEmpty(formInfo.formDefine.enctype)? "application/json" : formInfo.formDefine.enctype;
	var formTarget = rawrisIsEmpty(formInfo.formDefine.fTarget) ? "" : " target='"+formInfo.formDefine.fTarget+"'";
	var formMethod = rawrisIsEmpty(formInfo.formDefine.method) ? "post" : formInfo.formDefine.method;
	if (formMethod.toUpperCase() != "GET" && formMethod.toUpperCase() != "POST" ) formMethod = "post";
	    formMethod = " method='"+formMethod+"'";
	var formClass  = rawrisIsEmpty(formInfo.formDefine.classNm) ? "" : " class='"+formInfo.formDefine.classNm+"'";
	var formStyle  = rawrisIsEmpty(formInfo.formDefine.style) ? "" : " style='"+formInfo.formDefine.style+"'";
	var insertTrget = rawrisIsEmpty(formInfo.formDefine.insTarget) ? "body" : formInfo.formDefine.insTarget;
	
	
	var inputAttrsHtml = "";
	if(!rawrisIsEmpty(formInfo.formAttrs)){
		var formAttrsKeys = Object.keys(formInfo.formAttrs);
		
		for(var i = 0 ; i < formAttrsKeys.length ; i++ ){
			var inputEleObj = eval("formInfo.formAttrs."+formAttrsKeys[i]); 
			var eleName = rawrisIsEmpty(inputEleObj.name) ? formAttrsKeys[i] : inputEleObj.name;
			var eleType = rawrisIsEmpty(inputEleObj.type) ? "hidden" : inputEleObj.type;
			var eleVal  = rawrisIsEmpty(inputEleObj.val) ? "''" : inputEleObj.val;  
			
			if(eleType == "file"){
				inputAttrsHtml += "<input type='"+eleType+"' id='"+formAttrsKeys[i]+"' name='"+eleName+"'                    style='display:none;' >";
			}else{
				inputAttrsHtml += "<input type='"+eleType+"' id='"+formAttrsKeys[i]+"' name='"+eleName+"' value='"+eleVal+"' style='display:none;' >"; 
			} 
		}
	}
	
	var formHtml  = "<form id='"+formId+"' name='"+formName+"' enctype='"+formEncType+"' "+formAction+" "+formTarget+" "+formMethod+" "+formClass+" "+formStyle+">";
	    formHtml += inputAttrsHtml;
	    formHtml += "</form>"; 
	    $(insertTrget).append(formHtml); 
	
	    
	    
	if(!rawrisIsEmpty(formInfo.formAttrs)){
		var formAttrsKeys = Object.keys(formInfo.formAttrs);
		for(var i = 0 ; i < formAttrsKeys.length ; i++ ){
			var inputEleObj = eval("formInfo.formAttrs."+formAttrsKeys[i]); 
			var eleName = rawrisIsEmpty(inputEleObj.name) ? formAttrsKeys[i] : inputEleObj.name;
			var eleType = rawrisIsEmpty(inputEleObj.type) ? "hidden" : inputEleObj.type;
			var eleVal  = rawrisIsEmpty(inputEleObj.val) ? "''" : inputEleObj.val;  
			
			if(eleType == "file"){
				var colneFile = $(eleVal).clone(true);
				colneFile.insertAfter($("#"+formId+" > #"+eleName));
				$("#"+formId+" > #"+eleName)[0].remove();
			}
		}
	}
}

// select Box Option 갱신
function rawrisDynaGenSelectOptions(optionsInfoObj){
	  
	if(rawrisIsEmpty(optionsInfoObj.comboInfo.targetId)) return false;  // options을 어디에 INPUT할지 지정안하면 return 
	 
	var optPosition = "" , optTxt = "" , optVal = "";
	if(!rawrisIsEmpty(optionsInfoObj.optionInfo)){  
		 optPosition = rawrisNVL(optionsInfoObj.optionInfo.postion , "top");
		 optTxt      = rawrisNVL(optionsInfoObj.optionInfo.txt     , "선택"); 
		 optVal      = rawrisNVL(optionsInfoObj.optionInfo.val     , " "); 
	}	 
	
	var inputOptionHtml = "";
	if(optPosition.toUpperCase() == "TOP"){
		inputOptionHtml += "<option value='"+optVal+"' >"+optTxt+"</option>"; 
	}
    
	var optionCnt = 0;
	if(!rawrisIsEmpty(optionsInfoObj.comboDataInfo)){
		$.each(optionsInfoObj.comboDataInfo , function(indx , arrVal){ 
			var optionVal = eval("arrVal."+optionsInfoObj.optionValInfo.optId);
			var optionTxt = eval("arrVal."+optionsInfoObj.optionValInfo.optTxt);   
			inputOptionHtml += "<option value='"+optionVal+"'>"+optionTxt+"</option>";
			optionCnt++;
		}); 
    } 
	
	if(optPosition.toUpperCase() == "BOTTOM"){
		inputOptionHtml += "<option value='"+optVal+"' >"+optTxt+"</option>"; 
	} 
	
	$(optionsInfoObj.comboInfo.targetId).empty().html(inputOptionHtml); 
	if(!rawrisIsEmpty(optionsInfoObj.optionValInfo.defaultVal )){
		$(optionsInfoObj.comboInfo.targetId).val(optionsInfoObj.optionValInfo.defaultVal)
	}  
}

function rawrisDynaGenRadio(radioOptionObj){
	
	if(rawrisIsEmpty(radioOptionObj.radioInfo.targetId)) return false; 
	if(!rawrisIsEmpty(radioOptionObj.radioInfo.classNm)){
		$(radioOptionObj.radioInfo.targetId).addClass(radioOptionObj.radioInfo.classNm);
	}
	
	var radioId = rawrisIsEmpty(radioOptionObj.radioProp.radioId) ? "tmpRadioId" : radioOptionObj.radioProp.radioId;
	var radioNm = rawrisIsEmpty(radioOptionObj.radioProp.radioNm) ? "tmpRadioNm" : radioOptionObj.radioProp.radioNm;
	var radioClassNm = rawrisIsEmpty(radioOptionObj.radioProp.classNm) ? " " : radioOptionObj.radioProp.classNm;
	var radioStyle   = rawrisIsEmpty(radioOptionObj.radioProp.style)   ? " " : radioOptionObj.radioProp.style;
	
	var radioHtml = ""; 
	if(!rawrisIsEmpty(radioOptionObj.radioDataInfo)){
		var optCode = rawrisIsEmpty(radioOptionObj.optionValInfo.optCode) ? "code" : radioOptionObj.optionValInfo.optCode;
		var optNm = rawrisIsEmpty(radioOptionObj.optionValInfo.optTxt) ? "text" : radioOptionObj.optionValInfo.optTxt;
		
		$.each(radioOptionObj.radioDataInfo , function(indx , arrVal){
			
			var rdOptCode = eval("arrVal."+optCode);
			var rdOptName = eval("arrVal."+optNm);  
			
			var cssHtml = "";
			if(radioClassNm != " ") cssHtml += " class='"+radioClassNm+"' ";
			if(radioStyle != " ")   cssHtml += " style='"+radioStyle+"' "
			 
			radioHtml += "<input type='radio' name='"+radioNm+"' id='"+radioId+rdOptCode+"' value='"+rdOptCode+"' "+cssHtml+" /><label>"+rdOptName+"</label>";
		});
		
		$(radioOptionObj.radioInfo.targetId).html(radioHtml); 
	} 
}

function rawrisGetMonthComboOptions(){  
	var monthOptionHtml = ''; 
	for(var i = 1 ; i <=  12 ; i++){
		if(i == 1) monthOptionHtml += '<option value="'+rawrisLPad(i,2,"0")+'" selected="selected">'+i+'월</option>';
		else monthOptionHtml += '<option value="'+rawrisLPad(i,2,"0")+'">'+i+'월</option>';
	} 
	return monthOptionHtml; 
}

function rawrisGetHourComboOptions(){
	var hourOptionHtml = ''; 
	for(var i = 0 ; i <=  23 ; i++){
		if(i == 0) hourOptionHtml += '<option value="'+rawrisLPad(i,2,"0")+'" selected="selected">'+rawrisLPad(i,2,"0")+'시</option>';
		else hourOptionHtml += '<option value="'+rawrisLPad(i,2,"0")+'">'+rawrisLPad(i,2,"0")+'시</option>';
	} 
	return hourOptionHtml;
}

function rawrisGet10minuteComboOptions(){
	var minuteOptionHtml = ''; 
	for(var i = 0 ; i <=  50 ;){
		if(i == 0) minuteOptionHtml += '<option value="'+rawrisLPad(i,2,"0")+'" selected="selected">'+rawrisLPad(i,2,"0")+'분</option>';
		else minuteOptionHtml += '<option value="'+rawrisLPad(i,2,"0")+'">'+rawrisLPad(i,2,"0")+'분</option>'; 
		i = i + 10; 
	} 
	return minuteOptionHtml;
} 

function rawrisGetYearComboOptions(yearOptObj){
	 
	// {targetYear:2002 , selected:false} 
	var strToDay = rawrisGetDate({});
	var nowYear = Number(rawrisSubString(strToDay,0,4));
	var termYears = nowYear - Number(rawrisNVL(yearOptObj.targetYear, nowYear - 5));
	  
	var yearOptionHtml = "";  
	if(rawrisNVL(yearOptObj.selected , false)){
		for(var i = 0 ; i <= termYears; i++){ 
			if(i == 0) yearOptionHtml += '<option value="'+(nowYear-i)+'" selected="selected">'+(nowYear-i)+'년</option>';
			else yearOptionHtml += '<option value="'+(nowYear-i)+'">'+(nowYear-i)+'년</option>';
		} 
	}else{
		for(var i = 0 ; i <= termYears; i++){ 
			yearOptionHtml += '<option value="'+(nowYear-i)+'">'+(nowYear-i)+'년</option>';
		} 
	}
   return yearOptionHtml;
}

function rawrisGetDecriptStr(orgStr){
	
	// <script src="<c:url value='/App_JSP_Common/asset/js/sha512.js'/>"></script>
	
	var jsShaStr = new jsSHA(rawrisTrimAll(orgStr));
	return jsShaStr.getHash("SHA-512", "HEX")
}


function rawrisMathCeil(numVal , numUnit){ 
	return Math.ceil(numVal / numUnit) * numUnit ;
}

function rawrisMathTrunc(numVal , numUnit){ 
	return Math.trunc(numVal / numUnit) * numUnit ;
}

function rawrisMathRound(numVal , numUnit){ 
	return Math.round(numVal * numUnit,numUnit)/numUnit; 
}
/*********************************************************************************
 ****************                 VALIDATE  FUNCTIONS              ***************  
 *********************************************************************************/

function rawrisIsEmpty(chkObj){  
	if(chkObj == undefined || chkObj == null || chkObj == 'null' || rawrisTrim(chkObj) == "") return true;
	else return false;
}

function rawrisGetByteLength(strObj){
	var objByte = 1000000;
	if(typeof strObj == "string"){
		objByte = 0;
		for ( var i = 0; i < strObj.length; i++) {
			objByte += rawrisCharByteSize(strObj.charCodeAt(i));
		}
	}   
	return objByte;
}

function rawrisCharByteSize(chr){
	    var chrByte = 0;
		if(!rawrisIsEmpty(chr)){
			if(chr > 128) chrByte = 2;
			else chrByte = 1; 
		}; 
		return chrByte; 
}


/*********************************************************************************
 ****************                 STRING FUNCTIONS         *********************** 
 *********************************************************************************/

function rawrisNVL(chkObj , repStr){
	
	repStr = rawrisIsEmpty(repStr) ? "" : repStr; 
	if(rawrisIsEmpty(chkObj)) return repStr;
	else return chkObj;
}

function rawrisTrim(tarTrimStr){
	return $.trim(tarTrimStr);
}

function rawrisInStrCount(tarStr , chkChr){
	var duplCharCnt = 0
	for(var i = 0 ; i < tarStr.length ; i++){
		if( tarStr[i] == chkChr ) duplCharCnt++;
	}
	return duplCharCnt;
} 
function rawrisTrimAll(tarTrimStr){
	var trimSplitArr = tarTrimStr.split(" ");
	return trimSplitArr.join("");
}

function rawrisReplace(tarRepStr){

}

function rawrisReplaceAll(tarStr , tarRepStr){  
	var trimSplitArr = tarStr.split(tarRepStr);
	return trimSplitArr.join("");
}

function rawrisLPad(tarStr ,paddLen ,  paddStr){  
	  tarStr = tarStr.toString();
	  return tarStr.length < paddLen ? rawrisLPad(paddStr + tarStr, paddLen , paddStr) : tarStr;
}

function rawrisRPad(tarStr ,paddLen ,  paddStr){  
	  tarStr = tarStr.toString();
	  return tarStr.length < paddLen ? rawrisRPad(tarStr + paddStr, paddLen , paddStr) : tarStr;
}

function rawrisSubString(orgStr , beginIndx , endIndx){
	return orgStr.substring(beginIndx , endIndx);
}



/*********************************************************************************
 ****************                 DATE FUNCTIONS         ************************* 
 *********************************************************************************/

function rawrisGetDate(dateInfoObj){
	 
	var dateFormat = rawrisNVL(dateInfoObj.dateFormat , "YYYY-MM-DD"); 
	
	var basicDate = dateInfoObj.dateObj; 
	if(rawrisIsEmpty(basicDate))  basicDate = new Date();
	
	var baseYear = basicDate.getFullYear();
	var baseMonth = rawrisLPad(basicDate.getMonth()+1 , 2 , "0" );
	var baseDate = rawrisLPad(basicDate.getDate(), 2 , "0" );  
	
	var rtnDateStr = baseYear+"-"+baseMonth+"-"+baseDate; 
	// TODO Date Format해야하는 함부 별도로 생성후 호출하기 ( rawrisDateFormat )
	return rtnDateStr;
}

function rawrisGetYear(){
	return rawrisGetDate({}).substr(0,4);
}

function rawrisGetNanoTimes(){ 
	return new Date().getTime(); 
}

function rawrisDateCalc(strBaseDate , diffDiv , DiffVal , dateFormat){
	  
	if(rawrisIsEmpty(strBaseDate)) return false;
	strBaseDate = rawrisReplaceAll(rawrisReplaceAll(strBaseDate,"-"),"/");
	if(strBaseDate.length != 8)  return false;
	
	var baseYear = rawrisSubString(strBaseDate , 0 , 4) 
	  , baseMonth = rawrisSubString(strBaseDate , 4 , 6)
	  , baseday = rawrisSubString(strBaseDate , 6 , 8);
	
	var baseDateObj = new Date(baseMonth+"/"+baseday+"/"+baseYear);
	if(diffDiv.toUpperCase() == "D"){
		baseDateObj.setDate(baseDateObj.getDate() + DiffVal); 
	}else if(diffDiv.toUpperCase() == "W"){   
		baseDateObj.setDate(baseDateObj.getDate() + (DiffVal * 7)); 
	}else if(diffDiv.toUpperCase() == "M"){
		baseDateObj.setMonth(baseDateObj.getMonth() + DiffVal);
	}else if(diffDiv.toUpperCase() == "Y"){ 
		baseDateObj.setFullYear(baseDateObj.getFullYear() + DiffVal);
	}   
	
	 var resultYear = baseDateObj.getFullYear();
	 var resultMonth = rawrisLPad(baseDateObj.getMonth()+1, 2 , "0" );
	 var resultDate = rawrisLPad(baseDateObj.getDate(), 2 , "0" ); 
	 
	 // TODO : dateFormat
	 return resultYear+"-"+resultMonth+"-"+resultDate; 
	 
	  	
}

function rawrisMonthLastDay(strYearMon){
	  
	if(rawrisIsEmpty(strYearMon)) strYearMon = rawrisSubString(rawrisGetDate({}) , 0 , 6 ); 
	var tarYearMon = rawrisReplaceAll(rawrisReplaceAll(strYearMon,"-"),"/"); 
	var nextMonFirstDay = rawrisDateCalc(tarYearMon+"01" , "M" , 1 , "YYYY-MM-DD");
	var thisMonLastDay  = rawrisDateCalc(nextMonFirstDay , "D" , - 1 , "YYYY-MM-DD"); 
	return thisMonLastDay;
}


function rawrisDateDiff(strStartDay , strEndDay , diffDiv){

	strStartDay = rawrisReplaceAll(rawrisReplaceAll(strStartDay,"-"),"/");
	strEndDay = rawrisReplaceAll(rawrisReplaceAll(strEndDay,"-"),"/");
	
	var baseStartYear  = rawrisSubString(strStartDay , 0 , 4) 
	  , baseStartMonth = rawrisSubString(strStartDay , 4 , 6)
	  , baseStartday   = rawrisSubString(strStartDay , 6 , 8);
	
	var baseEndYear  = rawrisSubString(strEndDay , 0 , 4) 
	  , baseEndMonth = rawrisSubString(strEndDay , 4 , 6)
	  , baseEndday   = rawrisSubString(strEndDay , 6 , 8);
	 
    var strarDateObj = new Date(Number(baseStartYear) , Number(baseStartMonth)-1 , Number(baseStartday));
	var endDateObj = new Date(Number(baseEndYear) , Number(baseEndMonth)-1 , Number(baseEndday));
	  
	diffDiv = rawrisNVL(diffDiv,"D");  
	var diffs;
	if(diffDiv == "D"){  
		diffs = Math.round((endDateObj-strarDateObj)/(1000*60*60*24)); 
	}else if(diffDiv == "M"){
		months = (endDateObj.getFullYear() - strarDateObj.getFullYear()) * 12;
		months -= strarDateObj.getMonth() - 1; 
		months += endDateObj.getMonth();  
//		diffs = months <= 1 ? 0 : months-1; 
		diffs = months <= 1 ? 0 : months; 
	}else if(diffDiv == "Y"){ 
		diffs = endDateObj.getFullYear() - strarDateObj.getFullYear() ; 
	}  
	return diffs; 
}
 

function rawrisDatePicker(targetSelector){ 
	 var datePickerOpts = {    
			autoclose: true,
			buttonText: "day",
			// showOn : "button", 
			// buttonImage : "/Content_Image/Image_Icon/ui-icons_datepicker.png", 
			// showButtonPanel : true,
			 
			 changeYear: true,
			 changeMonth: true, 
			// constrainInput: true,
			dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
			dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'],
			monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
			monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			nextText: "다음 달",
			prevText: "이전 달",
			dateFormat: "yy-mm-dd"  
	};  
	  
	$(targetSelector).datepicker(datePickerOpts); 
}



/*********************************************************************************
 ********************             HOST FUNCTIONS           *********************** 
 *********************************************************************************/
function rawrisGetJniHost(){ 
	
	var hostName = window.location.hostname; 
	var rtnHost = "";
//	if(hostName == "127.0.0.1" || hostName == "localhost"){ // Developer Local Host
//		rtnHost = "http://210.90.40.177:8080/rstf2nd";      // Developer OPER SERVER URL
//	}else{
		rtnHost = "http://"+hostName+":8080/rstf2nd";       // ETC Server( DEV , STG , OPER )
//	}  
	return rtnHost; 
}

function rawrisGetReportHost(){
	return "http://211.241.74.114/ClipReport4/rawrisNewReport.jsp";
//	return "http://210.90.40.210/App_ReportServer/rawrisNewReport.jsp";
//	return "http://210.90.40.210/App_ReportServer/test.jsp";
}
  
/*********************************************************************************
 ****************                 INPUT FILE FUNCTIONS         ******************* 
 *********************************************************************************/
// @deprecated
function rawrisGetFileData(evt , sheetName){
	     
	    var reader = new FileReader(); 
 	    var f      = evt.target.files[0];
	    var name   = f.name; 
	    var ext    = name.substr(name.indexOf(".")+1);
	   
	  /*  if(ext == "xls"){
	    	reader.onloadend = function (loadedE) { 
	    		var data = loadedE.target.result; 
	    		// TODO xls parse to paramQueryGrid 
	    	}
	    	reader.readAsArrayBuffer(f);
	    }else if(ext == "xlsx"){ */ 
	        reader.readAsArrayBuffer(f); 
	    	reader.onloadend = function (loadedE) { 
				var data = loadedE.target.result;  
				var workbook = XLSX.read(data, { type: 'binary' }); 
				return eval(" XLSX.utils.sheet_to_json(workbook.Sheets."+sheetName+"); ");    
	    	} 
	    /*} */
}
 

function rawrisPreViewImageShow(preViewObj){
		/*var imgPreViewObj = {
				fileEle    : "#imgPreViewFile"
		     , 	preViewEle : "#imgPreView" 
		}*/
   
	var ableImgMimeTypeArr = ["gif","jpg","jpeg","tiff","png"]; 
	if( $(preViewObj.fileEle).length == 0 || $(preViewObj.preViewEle).length == 0 ) return false; 
	if(rawrisGetEleType($(preViewObj.fileEle)) != "file") return false;  
 	 
	var isRegisterAble = rawrisFileExecAllowed( preViewObj.fileEle , "image");  
	if(!isRegisterAble){
		rawrisShowMsg("등록할수없는 이미지 입니다. \n "+ableImgMimeTypeArr.join()+" 형태의 사진만 등록 가능합니다.");
		return false;
	}
	
	var eleFiles = $(preViewObj.fileEle).prop("files"); 
	  
	var fileObj = eleFiles[0]
	var reader = new FileReader();
	reader.onload = function (e) { 
		$(preViewObj.preViewEle).attr("src",e.target.result); 
	} 
	reader.readAsDataURL(fileObj);
 
	if(!rawrisIsEmpty(preViewObj.filePathEle)){ 
		$(preViewObj.filePathEle).val(fileObj.name); 
	} 
	return true;
	
}

function rawrisFileExecAllowed(fileEle , fileDiv){
	var isFileAble = true;
	if(fileDiv.toUpperCase() == "IMAGE"){
		var ableImgMimeTypeArr = ["gif","jpg","jpeg","tiff","png"];
		var mimeType = rawrisGetFileMimeType(fileEle);
		 isFileAble= $.inArray( mimeType, ableImgMimeTypeArr ) == -1 ? false : true; 
	}
	
	return isFileAble;
}

function rawrisGetFileMimeType(eleSelector){
	var fileVal = $(eleSelector).val();
	var lastIndxDot = fileVal.lastIndexOf(".");
	return fileVal.substring(lastIndxDot+1)  
}

function rawrisGetFileInfo(fileSelector){
	
	var trnObj = {} 
	if(rawrisGetEleType(fileSelector) == "file"){
		
		var eleFiles = $(fileSelector).prop("files");
		if(eleFiles.length > 0){ 
			trnObj.fullFileName = eleFiles[0].name;
			trnObj.fileName = (""+eleFiles[0].name).substr(0,(""+eleFiles[0].name).indexOf("."));
			trnObj.fileExt  = rawrisGetFileMimeType(fileSelector);
			trnObj.fileType = eleFiles[0].type;
			trnObj.fileSize = eleFiles[0].size;
		} 
	}
	return trnObj;
}

 


/*********************************************************************************
 ****************                 PARAMQUERY FUNCTIONS         ******************* 
 *********************************************************************************/
function rawrisGetPQDataModel(strPqGrdSel){
	if(rawrisIsEmpty(strPqGrdSel)) return new Array(); 
	if( $(strPqGrdSel).length == 0 ) return new Array(); 
	 
	var dataModel = $(strPqGrdSel).pqGrid("option", "dataModel" ).data; 
	if(rawrisIsEmpty(dataModel)){
		return new Array();
	}else{
		return dataModel;
	} 
}

function rawrisSetPQDataModel(strPqGrdSel , dataModelArray ){
	
	
//	$( strPqGrdSel ).pqGrid( "option", "dataModel", dataModelArray );
	if(!rawrisIsEmpty(dataModelArray)){
		$.each(dataModelArray,function(indx , obj){  
			rawrisAddRowPqData(strPqGrdSel, obj);
		});
	} 
	$(strPqGrdSel).pqGrid( "refreshDataAndView" );
}

function rawrisGetPqGridColNames(strPqGrdSel){
	if(rawrisIsEmpty(strPqGrdSel)) return new Array(); 
	if( $(strPqGrdSel).length == 0 ) return new Array(); 
	return $(strPqGrdSel).pqGrid( "getColModel" );
}


function rawrisGetPqDataByCellIndx(strPqGrdSel , rowIndx , cellindxs){  
	if(rawrisIsEmpty(strPqGrdSel)) return new Array(); 
	if( $(strPqGrdSel).length == 0 ) return new Array(); 
	
	var colNameModel = rawrisGetPqGridColNames(strPqGrdSel);
	
	var cellnames = new Array(); 
	if(typeof cellindxs == "number"){
		if(!rawrisIsEmpty(colNameModel[cellindxs])){ 
			cellnames.push(colNameModel[cellindxs].dataIndx); 
		}
	}else if(cellindxs instanceof Array){
		$.each(cellindxs , function(indx , cellIndx){
			if(!rawrisIsEmpty(colNameModel[cellIndx])){ 
				cellnames.push(colNameModel[cellIndx].dataIndx); 
			}
		});
	} 
	return rawrisGetPqDataByCellNames(strPqGrdSel , cellnames , rowIndx ); 	
}

// ParamQuery Grid getData
function rawrisGetPqDataByCellNames(strPqGrdSel , cellNames , rowIndx ){
     
	if(rawrisIsEmpty(strPqGrdSel)) return new Array(); 
	if( $(strPqGrdSel).length == 0 ) return new Array(); 
	var row0Data = $( strPqGrdSel ).pqGrid( "getRowData", {rowIndxPage: 0} );
	if(rawrisIsEmpty(row0Data)) return  Array();
	
	var namesArr;
	if(typeof cellNames == "string"){
		namesArr = new Array();
		namesArr.push(cellNames);
	}else if(cellNames instanceof Array){
		namesArr = cellNames;
	} 
	
	var gridDatas = $(strPqGrdSel).pqGrid( "getData", { dataIndx: namesArr } );
	var findSelVal;
	if(gridDatas.length == 1){
		findSelVal = eval("gridDatas[0]."+cellNames);
	}else{
		rowIndx = rawrisNVL(rowIndx , 0);
		findSelVal = eval("gridDatas["+rowIndx+"]."+cellNames);
	}
	   return findSelVal;
} 



function rawrisGetPqDataByRowData( strPqGrdSel , rowIndx ){
	
	if(rawrisIsEmpty(strPqGrdSel)) return new Object(); 
	if( $(strPqGrdSel).length == 0 ) return new Object(); 
	
	var dataModel = rawrisGetPQDataModel(strPqGrdSel); 
	if(rowIndx >= dataModel.length) return new Object(); 
	
	return $( strPqGrdSel ).pqGrid( "getRowData", {rowIndxPage: rowIndx} );	
}

function rawrisAddRowPqData(strPqGrdSel , pqDataObj){
	$( strPqGrdSel ).pqGrid("addRow" , {rowData :  pqDataObj });
	//$(strPqGrdSel).pqGrid( "refreshDataAndView" );
}

function rawrisUpdRowPqData(strPqGrdSel ,rowIndx , pqDataObj){
	 $(strPqGrdSel).pqGrid( "updateRow", { rowIndx: rowIndx, row: pqDataObj }); 
}  


// ParamQuery Grid 초기화
function rawrisInitPqGrid(strPqGrdSel){
	if(rawrisIsEmpty(strPqGrdSel)) return false; 
	if( $(strPqGrdSel).length == 0 ) return false; 
	$(strPqGrdSel).pqGrid( { dataModel : { data: [] } } ); 
	$(strPqGrdSel).pqGrid( "refreshDataAndView" );
} 


/*********************************************************************************
 *********************                 POPUP 호출         ************************ 
 *********************************************************************************/

function rawrisPostPopCall(PopupObj){
	  
	
	if(rawrisIsEmpty(PopupObj.formInfo.id)) return false;
	if(rawrisIsEmpty(PopupObj.formInfo.action)) return false; 
	
	var formId = PopupObj.formInfo.id;
	var action = PopupObj.formInfo.action;
	var formName = rawrisIsEmpty(PopupObj.formInfo.name) ? formId : PopupObj.formInfo.name;
	var method = rawrisIsEmpty(PopupObj.formInfo.method) ? "post" : PopupObj.formInfo.method; 
	if(method.toUpperCase() != "GET" && method.toUpperCase() != "POST" ) method = "post"; 
	var target = rawrisIsEmpty(PopupObj.formInfo.target) ? "blank_" : PopupObj.formInfo.target;
	var postPopHtml  = "<form id='"+formId+"' name='"+formName+"' method='"+method+"' action='"+action+"' target='"+target+"' >";
	    
	if(!rawrisIsEmpty(PopupObj.formParam)){ 
		var paramKeys = Object.keys(PopupObj.formParam); 
		$.each(paramKeys , function(indx , key){
			var paramKey = key;
			var paramVal = eval("PopupObj.formParam."+key);
			postPopHtml += "<input id='"+paramKey+"' name='"+paramKey+"' value='"+paramVal+"'/>";	
		});
	} 
    postPopHtml += "</form>";
     
    if( $("#"+formId).length >= 1 ) $("#"+formId).remove(); 
    $("body").append(postPopHtml); 
    
    var windowStyle = rawrisIsEmpty(PopupObj.windowStyle) ? "" : PopupObj.windowStyle; 
    
    console.log("windowStyle ==>> "+windowStyle);
    
    window.open("",target, windowStyle);
    $("#"+formId).submit();
    
}


function rawrisInitQryStr2Map(){ 
	
	//TODO Post Popup Parameter
	
	var qryStr = window.location.search.substr(1); 
	var qryStrArr = qryStr.split("&");
	
	var paramMap = new Map();
	
	$.each(qryStrArr , function(indx , paramArr){
		var paramSet = paramArr.split("=");
		var paramKey = paramSet[0];
		var paramval = paramSet[1];
		
		paramMap.put(paramKey , paramval)
		
	});  
	return paramMap;
	
}

/*********************************************************************************
 *********************               PROGRESS             ************************ 
 *********************************************************************************/

function rawrisShowProgress(){  
	/*var progresHtml  = "<div class='overlay' style='z-index:800;display:none;'>";
	    progresHtml += "    <div style='position:absolute; top:50%; left:50%; margin-top:-34px; margin-left:-100px; width:200px; text-align:center; font-size: 20px;'>";
	    progresHtml += "        <div style='font-size: 30px;'>";
	    progresHtml += "            <i class='fa fa-spinner fa-spin'></i>";
	    progresHtml += "        </div>";
	    progresHtml += "        <div style='padding-top:10px;'>Loading...</div>";
	    progresHtml += "    </div>";
	    progresHtml += "</div>";*/  
	var progresHtml = "<div style='font-size: 30px;'><i class='fa fa-spinner fa-spin'></i></div><div style='padding-top:10px;'>Loading...</div>"; 
	if(typeof $.blockUI != "undefined"){
		console.log("rawrisShowProgress  $.blockUI NOT undefined");
		$.blockUI({message : progresHtml}); 
	}  
}
 
function rawrisHideProgress(){
	if(typeof $.unblockUI != "undefined"){ 
		$.unblockUI();
		console.log("rawrisHideProgress  $.unblockUI NOT undefined"); 
	}
}

/*********************************************************************************
 *********************              Map Object생성      ************************ 
 *********************************************************************************/


Map = function(){ 
	 this.map = new Object(); 
};   

Map.prototype = {   
    put : function(key, value){   
        this.map[key] = value;
    },  
    
    get : function(key){   
        return this.map[key];
    },
    
    containsKey : function(key){    
     return key in this.map;
    },
    
    containsValue : function(value){    
     for(var prop in this.map){
      if(this.map[prop] == value) return true;
     }
     return false;
    },

    isEmpty : function(key){    
     return (this.size() == 0);
    },

    clear : function(){   
     for(var prop in this.map){
      delete this.map[prop];
     }
    },

    remove : function(key){    
     delete this.map[key];
    },
    keys : function(){   
        var keys = new Array();   
        for(var prop in this.map){   
            keys.push(prop);
        }   
        return keys;
    },
    values : function(){   
     var values = new Array();   
        for(var prop in this.map){   
         values.push(this.map[prop]);
        }   
        return values;
    },
    size : function(){
      var count = 0;
      for (var prop in this.map) {
        count++;
      }
      return count;
    }
};
