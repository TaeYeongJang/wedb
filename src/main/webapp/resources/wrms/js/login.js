$(document).ready(function(){	
	/** 로그인 관련 시작 **/
	$("#user_login").click(function(evt) {
		memLogin();
//		memLogin_bak();
	});

	$('input[id="inputId"], input[id="inputPassword"]').keydown(function() {
		if(event.keyCode === 13) memLogin();
	});
	/** 로그인 관련 끝 **/
	
	/** 이메일 등록 관련 시작 **/
	// 인증번호 전송 버튼 클릭 => 이메일 중복체크 후 인증번호 전송
	$("#btn_r_authnum_send").click(function(evt){
		var userType = $("#r_user_type").val();
		var userEmail = $("#r_user_email").val();
		duplicateCheckUserEmail(userType, userEmail, "registemail");
	});
	
	// 인증번호 확인 버튼 클릭
	$("#btn_r_authnum_check").click(function(evt){	
		var userEmail = $("#r_user_email").val();
		var userAuthnum = $("#r_user_authnum").val();
		checkAuthnum(userEmail, userAuthnum, "registemail");
	});
	
	// 등록 버튼 클릭
	$("#btn_r_modal_save").click(function(evt){	
		var userId = $("#r_user_id").val();
		var userEmail = $("#r_user_email").val();
		registEmail(userId, userEmail);
	});
	/** 이메일 등록 관련 끝 **/
	
	/** 회원가입 관련 시작 **/
	$("#user_signup").click(function(evt) {		
		$("#modal_signup").modal({backdrop: "static", keyboard: false}); 
		setUserObj();
		initSignup();
		setUserPhoneOfficeSelectbox();
		changeSidoSelectbox();
	});
	
	$('input[name="user_type"]:radio').change(function(evt) {
		var val	= evt.target.value;
		if(val == "01") changeBonbuSelectbox();	// 농어촌공사 : 부서 (본부/지사)
		else		    changeSidoSelectbox();	// 지자체 : 주소 (시도/시군)
	});	
	
	// 인증번호 전송 버튼 클릭 => 이메일(아이디) 중복체크 후 인증번호 전송
	$("#btn_authnum_send").click(function(evt) {	
		var userAttrVals = rawrisGetEleValues(userValidateObj);
 		var userId = userAttrVals.user_id;
 		var userType = userAttrVals.user_type;
 		duplicateCheckUserEmail(userType, userId, "signup");
	});
	
	// 인증번호 확인 버튼 클릭
	$("#btn_authnum_check").click(function(evt) {
		var userAttrVals = rawrisGetEleValues(userValidateObj);
		var userId = userAttrVals.user_id;
		var userAuthnum = userAttrVals.user_authnum;
		checkAuthnum(userId, userAuthnum, "signup");
	});
	
	$("#user_head_code").change(function(evt) {
 		var val	= evt.target.value;
 		var userAttrVals = rawrisGetEleValues(userValidateObj);
 		var userType = userAttrVals.user_type;
 		if(userType == "01") changeJisaSelectbox(val);
 		else				 changeSigunSelectbox(val);
 	});	

	$("#btn_modal_save").click(function(evt) {
		memSignup();
	});
	/** 회원가입 관련 끝 **/
});

var sqlMapper = "rawris.wrms.login.";
var authnum;
var timer;
var leftSec = 0;	// 타이머 남은시간
var isRunning = false;	// 타이머 작동 중인지 여부

/*
 * 로그인 버튼 클릭 시
 * CASE1) ID 로그인 / 사번 로그인 : 이메일 등록되어 있는 지 확인
 * 		  1-1) 이메일 등록되어 있을 경우 : 이메일 로그인 알림
 * 		  1-2) 이메일 등록되어 있지 않을 경우 : 이메일 등록 화면 이동
 * CASE2) EMAIL 로그인 : 로그인 가능
 */
function memLogin_bak() {
	$("#pw").val(rawrisGetDecriptStr($("#inputPassword").val()));
	$("#id").val(rawrisTrimAll($("#inputId").val()));
	$("#org_pw").val($("#inputPassword").val());
	
	if(rawrisIsEmpty($("#id").val()) || rawrisIsEmpty($("#org_pw").val())) {
		rawrisShowMsg("아이디와 비밀번호를 입력하세요");
		return false;
	}
	
	if(checkEmailPatternBasic($("#id").val())) {	// 이메일 로그인
		$("#user_login").prop("disabled",true);
		$("#loginform").submit();
	} else {	// 아이디, 사번 로그인 => 이메일 등록 되어있는지 확인 후 이메일 등록 또는 이메일 로그인 알림
		//$("#user_login").prop("disabled",true);	// 22.05.24. 이메일등록 팝업 닫기 시, 로그인 버튼 비활성화되는 것 때문에 수정
		checkUserEmail();
	}
}

/*
 * 22.06.08. 로그인 기존으로 돌리기
 */
function memLogin() {
	$("#pw").val(rawrisGetDecriptStr($("#inputPassword").val()));
	$("#id").val(rawrisTrimAll($("#inputId").val()));
	$("#org_pw").val($("#inputPassword").val());
	
	if (!rawrisIsEmpty($("#id").val()) && !rawrisIsEmpty($("#org_pw").val())){
			$('#loginform').submit();	
			$('#user_login').prop('disabled',true);
	}else{
		rawrisShowMsg("아이디와 비밀번호를 입력하세요");
		$("#inputId").val('');
	}
}

/*
 * ID/사번 로그인 시, email 등록 되어있는 지 확인
 * TYPE 01) 공사 : ekr.or.kr
 * TYPE 02) 지자체 : korea.kr
 * (1) 이메일 등록되어 있을 경우, 로그인 가능
 * (2) 이메일 등록되어 있지 않을 경우, 이메일 인증 모달 띄움
 * (3) 로그인 실패할 경우, CustomLoginFailHandler
 */
function checkUserEmail() {
	var userId = $("#id").val();
	var userPassword = $("#pw").val();
	var loginType = $('input[name="loginType"]:radio:checked').val();
	
	var fn = function(rs) {
		//console.log(rs);
		if(rs.length > 0) {
			var userId, userName, userEmail, userType;
			$.each(rs, function(indx , item) { 
				userId = item.user_id;
				userName = item.user_name;
				userEmail = item.user_email;
				userType = item.user_type;
				
				$("#r_user_id").val(userId);
				$("#r_user_name").val(userName);
				$("#r_user_type").val(userType);
				
				if(checkEmailPatternBasic(userEmail) || checkEmailPatternDetail(userType, userEmail)) {	// 이메일 등록되어 있으면 이메일 로그인 알림
//				if(checkEmailPatternBasic(userEmail)) {	// 이메일 등록되어 있으면 이메일 로그인 알림
					rawrisShowMsg("등록된 이메일이 있습니다. 이메일로 로그인하여 주세요.");
					$("#user_login").prop("disabled", false);
				} else {	// 이메일 등록 안되어 있으면 이메일 인증 모달 click
					rawrisShowMsg("이메일이 등록되어 있지 않습니다. 이메일 등록 화면으로 이동합니다.");
					$("#modal_registemail").modal({backdrop: "static", keyboard: false}); 
				}
			});
		} else {	// 아이디, 비번 안맞을 경우 어차피 CustomLoginFailHandler에서 실패 처리
			$("#loginform").submit();
		}
	};
	
	rawrisAjaxPost({ 
		async : false,
		sql : sqlMapper + "chk_user_email",
		user_id : userId,
		user_password : userPassword,
		user_id_type : loginType,
		successFn: fn
	});
}

// 이메일 등록 버튼 클릭 시 이메일 저장
function registEmail(userId, userEmail) {
	if($("#check_r_authnum").val() != "Y" || $("#confirm_r_user_email").val() != $("#r_user_email").val()) {
		rawrisShowMsg("인증번호 확인을 해주세요."); 
		return false;
	}
	
	var userEmailInfo = {
			sql : sqlMapper + "upd_user_info"
		  , cmd : "update"
		  , user_id : userId
		  , user_email : userEmail
	};
	
	var rst = rawrisAjaxPost(userEmailInfo);
	if(!rst) {
		rawrisShowMsg("이메일 등록 중 장애가 발생했습니다.");
		return false;
	} else {
		$("#btn_r_modal_close").trigger("click");
		$("#user_login").prop("disabled", false);
		rawrisShowMsg("이메일 등록이 완료되었습니다.");
		return true;
	}	
}

// 회원가입 시 필요한 field 설정
function setUserObj() {
	userValidateObj = { 
			user_type			: {eleNm : "장비관할조직"		, required : true					}
		  , user_id				: {eleNm : "메일주소(아이디)"	, required : true					}
		  , user_authnum		: {eleNm : "인증번호"			, required : true					}
		  , user_password		: {eleNm : "비밀번호"			, required : true					}
		  , user_pw_confirm		: {eleNm : "비밀번호확인"		, required : true					}
		  , user_name			: {eleNm : "이름"				, required : true					}
		  , user_phone_office_1	: {eleNm : "사무실번호 앞자리"	, required : true	, number : true	, minLength : 2	, maxLength : 3	}
		  , user_phone_office_2	: {eleNm : "사무실번호 가운데자리"	, required : true	, number : true	, minLength : 3 , maxLength : 4 }
		  , user_phone_office_3	: {eleNm : "사무실번호 뒷자리"	, required : true	, number : true , minLength : 4 , maxLength : 4 }
		  , user_head_code		: {eleNm : "주소"				, required : true					}
		  , user_branch_code	: {eleNm : "주소"				, required : true					}
	}
}

// 회원가입 시 필요한 field 초기화
function initSignup() {
	$("#user_type_02").prop("checked", true);
	$("#user_id").val("");
	$("#confirm_user_id").val("");
	$("#btn_authnum_send").html("인증번호 전송");
	$("#user_authnum").val("");
	$("#check_authnum").val("");
	$("#user_authnum").attr("disabled", true);
	$("#btn_authnum_check").attr("disabled", true);
	$("#user_password").val("");
	$("#user_pw_confirm").val("");
	$("#user_name").val("");
	$("#user_phone_office").val("");
	clearInterval(timer);
}

/*
 * 회원가입 시, 이메일 중복체크
 * TYPE 01) 공사 : ekr.or.kr
 * TYPE 02) 지자체 : korea.kr
 * (1) 이메일 등록되어 있을 경우, 로그인 가능
 * (2) 이메일 등록되어 있지 않을 경우, 이메일 인증 모달 띄움
 * (3) 로그인 실패할 경우, CustomLoginFailHandler
 */
function checkUserId(userType, userId) {
	if(!userId) {
		rawrisShowMsg("메일주소(아이디)를 입력해주세요.");
		return false;
	}
	if(!checkSpace(userId)) {
		alert("입력한 메일주소(아이디)에 공백이 있습니다. 공백 없이 입력해주세요.");
		$("#user_id").focus();
		return false;
	}
    
	var fn = function(rs) {
		if(rs.length > 0){
			var idCnt;
			$.each(rs, function(indx , item){ 
				idCnt  = item.id_cnt;
			});
			
			if(idCnt == 0) {
				sendAuthnumMail(userType, userId, "signup");
			} else {
				alert("이미 사용중인 메일주소(아이디)입니다. 다른 메일주소(아이디)를 입력해주세요.");
				$("#user_id").focus(); 
				return false;
			}
		}
	};
	
	rawrisAjaxPost({
		async : false,
		sql : sqlMapper + "dup_user_info",
		user_email : userId,
		successFn: fn
	});
}

// 회원가입 > 사무실번호 앞자리 select box
function setUserPhoneOfficeSelectbox() {
	var opt = {
				comboInfo     : { targetId : "#user_phone_office_1" },
				optionInfo    : { postion  : "top" , txt : "사무실번호 앞자리" , val : "" },
				optionValInfo : { optId    : "code", optTxt : "text" },   
				comboDataInfo : [
									{'code':'02', text:'02'}
								  , {'code':'031', text:'031'}
								  , {'code':'032', text:'032'}
								  , {'code':'033', text:'033'}
								  , {'code':'041', text:'041'}
								  , {'code':'042', text:'042'}
								  , {'code':'043', text:'043'}
								  , {'code':'044', text:'044'}
								  , {'code':'051', text:'051'}
								  , {'code':'052', text:'052'}
								  , {'code':'053', text:'053'}
								  , {'code':'054', text:'054'}
								  , {'code':'055', text:'055'}
								  , {'code':'061', text:'061'}
								  , {'code':'062', text:'062'}
								  , {'code':'063', text:'063'}
								  , {'code':'064', text:'064'}
								  , {'code':'010', text:'010'}
								  , {'code':'070', text:'070'}
								]
	};
	rawrisDynaGenSelectOptions(opt);
}

// 회원가입 > 주소 > 시/도 select box
function changeSidoSelectbox() {
	$("#user_head_code_label").html("주소<span>*</span>");
	$("#user_branch_code").html("<option value=''>시.군 선택</option>");
		
	var fn = function(data) {
 		var opt = {
					comboInfo     : { targetId : "#user_head_code" },
					optionInfo    : { postion  : "top" , txt : "시.도 선택" , val : "" },
					optionValInfo : { optId    : "adm_code", optTxt : "adm_name" },   
					comboDataInfo : data
		};
		rawrisDynaGenSelectOptions(opt);
	};
	
		rawrisAjaxPost({ 
		sql : sqlMapper + "list_common_addr_sd_group",
		successFn: fn
	});
}

// 회원가입 > 주소 > 시/군 select box
function changeSigunSelectbox(headCode) {
	if(!headCode) {
		return;
	}
	
	var fn = function(data) {
		var opt = {
					comboInfo     : { targetId : "#user_branch_code" },
					optionInfo    : { postion  : "top" , txt : "시.군 선택" , val : "" },
					optionValInfo : { optId    : "adm_code", optTxt : "adm_name" },   
					comboDataInfo : data
		};
		rawrisDynaGenSelectOptions(opt);
	};
	
	rawrisAjaxPost({ 
		sql : sqlMapper + "list_common_addr_sgg_group",
		s_juso_do : headCode,
		successFn: fn
	});
}

// 회원가입 > 부서 > 본부 select box
function changeBonbuSelectbox() {
	$("#user_head_code_label").html("부서<span>*</span>");
	$("#user_branch_code").html("<option value=''>지사 선택</option>");
		
	var fn = function(data) {
	 	var opt = {
					comboInfo     : { targetId : "#user_head_code" },
					optionInfo    : { postion  : "top" , txt : "본부 선택" , val : "" },
					optionValInfo : { optId    : "buseo_head_code", optTxt : "buseo_name" },   
					comboDataInfo : data
	 	};
	 	rawrisDynaGenSelectOptions(opt);
	};
	
	rawrisAjaxPost({ 
		sql : sqlMapper + "list_common_buseo_group",
		successFn: fn
	});
}
	
// 회원가입 > 부서 > 지사 select box
function changeJisaSelectbox(headCode) {
	if(!headCode) {
		return;
	}
	
	var fn = function(data) {
		var opt = {
					comboInfo     : { targetId : "#user_branch_code" },
					optionInfo    : { postion  : "top" , txt : "지사 선택" , val : "" },
					optionValInfo : { optId    : "buseo_branch_code", optTxt : "buseo_name" },   
					comboDataInfo : data
		};
		rawrisDynaGenSelectOptions(opt);
	};
	
	rawrisAjaxPost({ 
		sql : sqlMapper + "list_common_buseo_group",
		s_buseo_head_code : headCode,
		successFn: fn
	});
}

// 공백이 있나 없나 체크
function checkSpace(str) { 
	if(str.search(/\s/) != -1) {
		return false; 
	} 
	return true;
} 

// 이름 패턴 체크 (한글만 입력 가능, 2자 이상)
function checkKoreanName(str) {
	var pattern = /^[ㄱ-ㅎ|가-힣]+$/;
	if(!pattern.test(str)) {
		return false; 
	}
	if(str.length < 2) {
		return false;
	}
	return true;
}

// 비밀번호 패턴 체크 (9자 이상, 문자, 숫자, 특수문자 포함여부 체크) 
function checkPasswordPattern(str) { 
	var pattern1 = /[0-9]/; // 숫자 
	var pattern2 = /[a-zA-Z]/; // 문자 
	var pattern3 = /[~!@#$%^&*()_+|<>?:{}]/; // 특수문자 
	
	if(!pattern1.test(str) || !pattern2.test(str) || !pattern3.test(str) || str.length < 9) {
		return false; 
	}
	return true;
}

/*
 * 이메일 패턴 체크
 * EmailPattern : 기본 이메일 패턴
 */
function checkEmailPatternBasic(userEmail) {
	var EmailPattern = /^([a-z\d!#$%&'*+\-\/=?^_`{|}~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+(\.[a-z\d!#$%&'*+\-\/=?^_`{|}~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+)*|"((([ \t]*\r\n)?[ \t]+)?([\x01-\x08\x0b\x0c\x0e-\x1f\x7f\x21\x23-\x5b\x5d-\x7e\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|\\[\x01-\x09\x0b\x0c\x0d-\x7f\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))*(([ \t]*\r\n)?[ \t]+)?")@(([a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|[a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF][a-z\d\-._~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]*[a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])\.)+([a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|[a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF][a-z\d\-._~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]*[a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])\.?$/i;
    
    if(!EmailPattern.test(userEmail)) {
		return false;
    }
    return true;
}

/*
 * 이메일 패턴 체크
 * EmailPattern01 : 공사 이메일 패턴
 * EmailPattern02 : 지자체 이메일 패턴
 */
function checkEmailPatternDetail(userType, userEmail) {
    var EmailPattern01 = /@ekr.or.kr$/;
    var EmailPattern02 = /@korea.kr$/;
    
    if(userType == "01" && !EmailPattern01.test(userEmail)) {
    	return false;
    } else if(userType == "02" && !EmailPattern02.test(userEmail)) {
    	return false;
    }
    return true;
}

/*
 * 이메일 등록/회원가입 시, 인증번호 전송 버튼 클릭 시 이메일 중복 체크
 * ID 로그인 시 ID 대신 이메일 사용 => 이메일 중복되면 안됨
 */
function duplicateCheckUserEmail(userType, userEmail, gbn) {
	var fn = function(rs) {
		//console.log(rs);
		if(rs.length > 0) {
			var emailCnt;
			$.each(rs, function(indx , item) {
				emailCnt = item.email_cnt;
			});
			
			if(emailCnt == 0) {	// 해당 이메일로 가입된 회원 없을 경우 인증번호 메일 보내기
				sendAuthnumMail(userType, userEmail, gbn);
			} else {
				alert("이미 사용중인 메일주소입니다. 다른 메일주소를 입력해주세요.");
				return false;
			}
		}
	};
	
	rawrisAjaxPost({
		async : false,
		sql : sqlMapper + "dup_chk_user_email",
		user_email : userEmail,
		successFn: fn
	});
}

/*
 * 인증번호 이메일 보내기
 * email : 해당 이메일로 인증번호를 보낸다
 * gbn : signup(회원가입), registemail(이메일등록), searchpw(비밀번호재설정)
 */
function sendAuthnumMail(userType, userEmail, gbn) {	
	if(!checkEmailPatternBasic(userEmail) || !checkEmailPatternDetail(userType, userEmail)) {
		//rawrisShowMsg("메일주소형식이 부적합 합니다.\n농어촌공사 < @ekr.or.kr >\n지방자치단체 < @korea.kr >");
		rawrisShowMsg("메일주소형식이 부적합 합니다.\n지방자치단체 < @korea.kr >");
    	return false;
	}
	
	var authnumMailInfo = {
			async		: true  
          , cmd			: "mail"
       	  , url     	: "/send_mail"
          , gbn			: gbn
          , email		: userEmail
	  	  , successFn	: callbackMailSuccess
		  , failFn      : callbackMailFail
	}
	rawrisAjaxPost(authnumMailInfo);
}

function callbackMailSuccess(rs) {
	//console.log(rs);
	if(rs.length > 0) {
		$.each(rs, function(indx , item) {
			var gbn = item.gbn;
			var email = item.email;	// 실제 전송한 이메일주소
			authnum = item.authnum;	// 실제 전송한 인증번호
			
			leftSec = 300;	// 남은 시간 (5분 이내 입력 해야함)
			var display;	// 남은 시간 보여주는 span 태그
			if(gbn == "signup") {
				$("#btn_authnum_send").html("인증번호 재전송");
				$("#user_authnum").attr("disabled", false);
				$("#user_authnum").val("");
				$("#check_authnum").val("");	// 인증번호 확인 후 인증번호 재전송 누를 경우 대비
				$("#btn_authnum_check").attr("disabled", false);
				$("#btn_authnum_check").html("인증번호 확인");
				$("#confirm_user_id").val(email);	// 이메일 전송 후 메일주소 수정했을 경우 대비 => 인증번호 확인 시 비교
				
				display = $("#user_authnum_timer");
			} else if(gbn == "registemail") {
				$("#btn_r_authnum_send").html("인증번호 재전송");
				$("#r_user_authnum").attr("disabled", false);
				$("#r_user_authnum").val("");
				$("#check_r_authnum").val("");
				$("#btn_r_authnum_check").attr("disabled", false);
				$("#btn_r_authnum_check").html("인증번호 확인");				
				$("#confirm_r_user_email").val(item.email);
				
				display = $("#r_user_authnum_timer");
			} else {
				$("#btn_s_authnum_send").html("인증번호 재전송");
				$("#s_user_authnum").attr("disabled", false);
				$("#s_user_authnum").val("");
				$("#check_s_authnum").val("");
				$("#btn_s_authnum_check").attr("disabled", false);
				$("#btn_s_authnum_check").html("인증번호 확인");				
				// $("#confirm_s_user_id").val(item.email); 다시 확인 해야함 (비밀번호 재설정시)
				
				display = $("#s_user_authnum_timer");
			}
			alert("메일 확인 후 인증번호를 입력해주세요.");
			
			if(isRunning) clearInterval(timer);	// 현재 타이머 작동 중이면 정지
			
			startTimer(leftSec, display);	// 이메일 전송 되면 타이머 시작
		});
	}
}

/*
 * 인증번호 전송 후 타이머 시작
 * 5분 이내에 인증번호 입력 후 확인 해야함
 * count : 남은 시간
 * display : 남은 시간 보여주는 span 태그
 */
function startTimer(count, display) {
	var minutes, seconds;
    timer = setInterval(function () {
	    minutes = parseInt(count / 60, 10);
	    seconds = parseInt(count % 60, 10);
	
	    minutes = minutes < 10 ? "0" + minutes : minutes;
	    seconds = seconds < 10 ? "0" + seconds : seconds;
	
	    display.html(minutes + ":" + seconds);
	
	    // 타이머 끝
	    if(--count < 0) {
	    	clearInterval(timer);
	    	
	    	alert("인증번호 유효시간이 초과하였습니다. 인증번호를 재전송 해주세요.");
	    	
	    	$("#btn_authnum_check").attr("disabled", true);		// 회원가입 > 인증번호 확인 버튼 클릭 막기
	    	$("#btn_r_authnum_check").attr("disabled", true);	// 이메일 등록 > 인증번호 확인 버튼 클릭 막기
	    	$("#btn_s_authnum_check").attr("disabled", true);	// 비밀번호 재설정 > 인증번호 확인 버튼 클릭 막기
	    	
	    	isRunning = false;
	    }
	}, 1000);
	
    isRunning = true;
}

function callbackMailFail() {
	alert("메일 전송 실패");
} 

/* 
 * 인증번호 확인
 * email : 현재 input box에 입력된 이메일주소
 * userAuthnum : 현재 input box에 입력된 인증번호
 * gbn : signup(회원가입), registemail(이메일등록), searchpw(비밀번호재설정)
 * (1) 현재 입력된 인증번호(userAuthnum)와 실제 전송한 인증번호(authnum)가 같은 지 확인
 * (2) 현재 입력된 이메일주소(email)와 실제 전송한 이메일주소(confirmAttr.email)가 같은 지 확인
 * (3) 이메일 전송 후 유효시간(5분) 이내인지 확인
 */
function checkAuthnum(email, userAuthnum, gbn) {
	if(!userAuthnum) {
		alert("인증번호를 입력해주세요.");
        return false;
	}
	
	if(leftSec == 0) {
		alert("인증번호 유효시간이 초과하였습니다. 인증번호를 재전송 해주세요.");
		return false;
	}
	
	var confirmAttr;	// 인증 번호 확인 후 field setting
	if(gbn == "signup") {
		confirmAttr = {
				email		: $("#confirm_user_id").val() 	
			  , successFn	: function successFn() {
				  				$("#check_authnum").val("Y");
						  		$("#user_authnum").attr("disabled", true);
						  		$("#user_authnum_timer").html("");
						  		$("#btn_authnum_check").attr("disabled", true);
						  		$("#btn_authnum_check").html("인증 완료");
				}
		}
	} else if(gbn == "registemail") {
		confirmAttr = {
				email		: $("#confirm_r_user_email").val() 	
			  , successFn	: function successFn() {
						  	  	$("#check_r_authnum").val("Y");
						  	  	$("#r_user_authnum").attr("disabled", true);
						  	  	$("#r_user_authnum_timer").html("");
						  	  	$("#btn_r_authnum_check").attr("disabled", true);
						  	  	$("#btn_r_authnum_check").html("인증 완료");
			  	}
		}
	} else {
		confirmAttr = {
				email		: $("#confirm_s_user_email").val()	// 확인 필요!! 	
			  , successFn	: function successFn() {
						  	  	$("#check_s_authnum").val("Y");
						  	  	$("#s_user_authnum").attr("disabled", true);
						  	  	$("#s_user_authnum_timer").html("");
						  	  	$("#btn_s_authnum_check").attr("disabled", true);
						  	  	$("#btn_s_authnum_check").html("인증 완료");
			  	}
		}	
	}
	
	if(rawrisGetDecriptStr(userAuthnum) == authnum && email == confirmAttr.email) {
		confirmAttr.successFn();
		clearInterval(timer);
		alert("인증번호가 일치합니다.");
	} else if(email != confirmAttr.email) {	// 입력된 이메일과 보낸 이메일 다를 경우 (이메일 전송 이후 이메일 변경한 경우)
		alert("메일주소를 다시 확인해주세요.");
		return false;
	} else {	// 인증번호 다를 경우
		alert("인증번호를 다시 확인해주세요.");
		return false;
	}
}

function checkUserPassword() {
	var userPassword = $("#user_password").val();
	var userPasswordConfirm = $("#user_pw_confirm").val();
	
	if(!checkSpace(userPassword)) {
		$("#user_password").focus();
		alert("입력한 암호에 공백이 있습니다. 공백 없이 입력해주세요."); 
		return false;
	}
	
	if(!checkPasswordPattern(userPassword)) {
		$("#user_password").focus();
		alert("암호는 9자리 이상 문자, 숫자, 특수문자 등으로 조합하여야 합니다."); 
		return false;
	}
	
	if(userPassword != userPasswordConfirm) {
		$("#user_pw_confirm").focus();
		alert("변경할 암호와 암호 확인이 일치 하지 않습니다. 다시 입력해 주세요.");
		return false;
	} else {
		return true;	
	}		
}

function memSignup() {
	if($("#check_authnum").val() != "Y" || $("#confirm_user_id").val() != $("#user_id").val()) {
		alert("인증번호 확인을 해주세요."); 
		return false;
	}
	
	if(!checkSpace($("#user_name").val())) {
		alert("입력한 이름에 공백이 있습니다. 공백 없이 입력해주세요.");
		$("#user_name").focus();
		return false;
	}
	
	if(!checkKoreanName($("#user_name").val())) {
		alert("이름은 한글만 입력가능 합니다. 2자 이상 한글만 입력해 주세요.");
		$("#user_name").focus();
		return false;
	}
	
	if(!checkSpace($("#user_phone_office_2").val())) {
		alert("입력한 사무실번호 가운데자리에 공백이 있습니다. 공백 없이 입력해주세요.");
		$("#user_phone_office_2").focus();
		return false;
	}
	
	if(!checkSpace($("#user_phone_office_3").val())) {
		alert("입력한 사무실번호 뒷자리에 공백이 있습니다. 공백 없이 입력해주세요.");
		$("#user_phone_office_3").focus();
		return false;
	}
	
	if(checkUserPassword() && rawrisValidateObj(userValidateObj)) {
		var userAttrVals = rawrisGetEleValues(userValidateObj);
		var user_type = userAttrVals.user_type;
		var user_branch_code = userAttrVals.user_branch_code;
		var user_email = userAttrVals.user_id;
		var user_phone_office = userAttrVals.user_phone_office_1 + userAttrVals.user_phone_office_2 + userAttrVals.user_phone_office_3;

		if(!checkEmailPatternBasic(user_email) || !checkEmailPatternDetail(user_type, user_email)) {
			//rawrisShowMsg("메일주소형식이 부적합 합니다.\n농어촌공사 < @ekr.or.kr >\n지방자치단체 < @korea.kr >");
			rawrisShowMsg("메일주소형식이 부적합 합니다.\n지방자치단체 < @korea.kr >");
	    	return false;
		}

		var user_id_type = "I"
		  , user_sms_yn = "N"
		  , user_com_yn = "N"
		  , org_code = ""
		  , org_name = ""
		  , building_admin_no = "";
		var user_level, user_role, adm_code, buseo_code, user_ekr_yn;
		if(user_type == "01") {
			user_level = "5";
			user_role = "9";
			adm_code = "";
			buseo_code = user_branch_code;
			user_ekr_yn = "Y";
		} else {
			user_level = "4";
			user_role = "11";
			adm_code = user_branch_code;
			buseo_code = "";
			user_ekr_yn = "N";
		}
		
		userAttrVals.sql = sqlMapper + "ins_user_info";
		userAttrVals.cmd = "insert";
		userAttrVals.user_email = user_email;
		userAttrVals.user_phone_office = user_phone_office;
		userAttrVals.user_level = user_level;
		userAttrVals.user_role = user_role;
		userAttrVals.adm_code = adm_code;
		userAttrVals.buseo_code = buseo_code;
		userAttrVals.user_id_type = user_id_type;
		userAttrVals.user_ekr_yn = user_ekr_yn;
		userAttrVals.user_sms_yn = user_sms_yn;
		userAttrVals.user_com_yn = user_com_yn;
		userAttrVals.org_code = org_code;
		userAttrVals.org_name = org_name;
		userAttrVals.building_admin_no = building_admin_no;
		
		var rst = rawrisAjaxPost(userAttrVals);
		if(!rst) {
			rawrisShowMsg("회원가입 중 장애가 발생했습니다.");
			return false;
		} else {
			$('#btn_modal_close').trigger('click');
			rawrisShowMsg("회원가입이 완료되었습니다.");
			return true;
		}
	}
}