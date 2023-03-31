<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head> 
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="utf-8">
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

	<title>로그인 | WRMS KRC</title>
	<link href="<c:url value='/resources/wrms/image/favicon.png'/>" rel="shortcut icon" type="image/x-icon">  
	<link rel="stylesheet" href="<c:url value='/resources/external/skin/skin-rawris.css'/>" />
	<link rel="stylesheet" href="<c:url value='/resources/external/icheck/square/blue.css'/>" />
	<link rel="stylesheet" href="<c:url value='/resources/external/bootstrap/css/bootstrap.css"'/>" />
	<link rel="stylesheet" href="<c:url value='/resources/wrms/css/login.css'/>" />
	
	<script src="<c:url value='/resources/external/jquery/jquery-2.2.3.min.js'/>"></script>  
	<script src="<c:url value='/resources/external/bootstrap/js/bootstrap.min.js'/>"></script>
    <script src="<c:url value='/resources/external/datatables/js/jquery.dataTables.min.js'/>"></script>
    <script src="<c:url value='/resources/external/datatables/js/dataTables.bootstrap.min.js'/>"></script>
	<script src="<c:url value='/resources/external/sha/sha512.js'/>"></script>  
	<script src="<c:url value='/resources/wrms/js/wrmsUtils.js'/>"></script>
	<script src="<c:url value='/resources/wrms/js/login.js?v=1.0'/>"></script>  

	<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
	<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
	<!--[if lt IE 9]>
		<script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
		<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<![endif]--> 
 
</head>
<body>
<div id="container">
	<div class="background">
		<div class="col-xs-10 col-md-3">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">
					<a href="/wrms/gis/main"><b>RAWRIS</b></a>
					</h3>
				</div>
				<div class="panel-body">
				
					<form name="form" method="post" action="<c:url value='/loginProcess'/>" id="loginform" class="loginForm">
						<fieldset>
							<div class="form-group">
								<input id="inputId" type="text" class="form-control" placeholder="메일주소/아이디">
							</div>
							<div class="form-group">
								<input id="inputPassword" type="password" class="form-control" placeholder="비밀번호">
							</div>
							<div class="checkbox">
								<label>
									<input type="radio" id="loginType" name="loginType" value="I"checked>ID
								</label>
								<label>
									<input type="radio" id="loginType" name="loginType" value="S">사번
								</label>
<!-- 								<input type="button" id="user_searchpw" value="비밀번호찾기"> -->
							</div>
							<div class="btn-block">
								<input type="button" id="user_login" class="btn btn-lg btn-facebook"  value="로그인" style="width:65%;">
								<input type="button" id="user_signup" class="btn btn-lg btn-facebook"  value="회원가입" style="width:33%; background: #08799c !important;">
							</div>
						</fieldset>
						<input type="hidden" name="id" id="id">
						<input type="hidden" name="pw" id="pw">
						<input type="hidden" name="org_pw" id="org_pw">
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- TEST AREA  -->
<div id='final_object_view' style="position: fixed; left: 1200px; top: 10px; background-color: gray;"></div>
<!-- /TEST AREA  -->

<!-- 모달팝업 -->
<div class="modal" id="modal_signup" >
	<div class="modal-dialog" style="width: 700px;">
    	<div class="card">
        	<div class="card-header">
            	<h5 class="modal-title" style="font-size:20px;font-weight: bold;"><i class="fa fa-key"></i> 회원가입</h5>
            </div>
            <div class="card-body">
            	<div style="float:right; color:red; font-weight:bold; margin-bottom:10px;">* 필수 입력 사항 입니다.</div>
            	<form name="form" method="post" id="signupform" class="signupForm" style="clear:both;">
            		<fieldset>
            			<div class="form-group" style="display:none;">	<!-- 22.06.16. 지방자체단체만 회원가입 가능 -->
            				<label for="user_type_02" class="control-label">장비관할조직<span>*</span></label>
	            			<div class="checkbox">	
								<label style="padding-left:0;">
									<input type="radio" id="user_type_02" name="user_type" value="02" checked>지방자치단체
								</label>
								<label>
									<input type="radio" id="user_type_01" name="user_type" value="01">농어촌공사
								</label>
							</div>
            			</div>
            			<div class="form-group">
           					<label for="user_id" class="control-label">메일주소(아이디)<span>*</span></label>
            				<input type="text" class="form-control" id="user_id" name="user_id" style="display:inline; width:75%;">
            				<button type="button" id="btn_authnum_send" class="btn-primary signup_btn" style="width:24%; height:34px; float:right;">인증번호 전송</button>
            			</div>
            			<div class="form-group">
            				<label for="user_authnum" class="control-label">인증번호<span>*</span></label>
            				<input type="text" class="form-control" id="user_authnum" name="user_authnum" style="display:inline; width:75%;" disabled>
            				<button type="button" id="btn_authnum_check" class="btn-primary signup_btn" style="width:24%; height:34px; float:right;">인증번호 확인</button>
            				<span id="user_authnum_timer" style="font-weight:normal; position:relative; left:65%; top:-25px; font-size:14px; color:#ccc;"></span>
            			</div>
            			<div class="form-group" style="margin-top:15px;">
            				<label for="user_password" class="control-label">비밀번호<span>*</span></label>
							<input type="password" class="form-control" id="user_password" name="user_password" autocomplete="new-password">
            			</div>
            			<div class="form-group">
            				<label for="user_pw_confirm" class="control-label">비밀번호 확인<span>*</span></label>
							<input type="password" class="form-control" id="user_pw_confirm" name="user_pw_confirm">
            			</div>
            			<div class="form-group">
            				<label for="user_name" class="control-label">이름<span>*</span></label>
							<input type="text" class="form-control" id="user_name" name="user_name">
            			</div>
            			<div class="form-group" style="margin-bottom:50px;">
            				<label for="user_phone_office_1" class="control-label">사무실번호<span>*</span></label>
            				<select id="user_phone_office_1" class="select form-control" name="user_phone_office_1" style="width:32%;">
								<option>전화번호 앞자리</option>
							</select>
							<span style="float:left; width:2%; line-height:34px; text-align:center; padding-left:0; color:#333; font-weight:normal;">-</span>
							<input type="text" class="form-control" id="user_phone_office_2" name="user_phone_office_2" placeholder="사무실번호 가운데자리" minlength="3" maxlength="4" style="width:32%; float:left;">
							<span style="float:left; width:2%; line-height:34px; text-align:center; padding-left:0; color:#333; font-weight:normal;">-</span>
							<input type="text" class="form-control" id="user_phone_office_3" name="user_phone_office_3" placeholder="사무실번호 뒷자리" minlength="4" maxlength="4" style="width:32%; float:left;">
            			</div>
            			<div class="form-group">
            				<label for="user_head_code" class="control-label" id="user_head_code_label">주소<span>*</span></label>
							<select id="user_head_code" class="select form-control" name="user_head_code" style="margin-right:2%;">
								<option>시.도</option>
							</select>
							<select id="user_branch_code" class="select form-control" name="user_branch_code">
								<option>시.군</option>
							</select>     
            			</div>
            		</fieldset>
					<input type="hidden" name="confirm_user_id" id="confirm_user_id">
					<input type="hidden" name="check_authnum" id="check_authnum">
            	</form>
	        </div>
			<div class="card-footer" style="height:50px;">
				<div style="position: relative;float: right;">
			        <button id="btn_modal_close" class="btn-secondary signup_btn" data-dismiss="modal">닫기</button>
			    	<button id="btn_modal_save" class="btn-primary signup_btn">등록</button>
				</div>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<div class="modal" id="modal_registemail" >
	<div class="modal-dialog" style="width: 700px;">
    	<div class="card">
        	<div class="card-header">
            	<h5 class="modal-title" style="font-size:20px;font-weight: bold;"><i class="fa fa-key"></i> 이메일 등록</h5>
            </div>
            <div class="card-body">
            	<form name="form" method="post" id="registemailform" class="registemailForm" style="clear:both;">
            		<fieldset>
						<div class="form-group">
							<label for="r_user_id" class="control-label">기존 아이디</label>
							<input type="text" class="form-control" name="r_user_id" id="r_user_id" readonly> 
						</div>
						<div class="form-group">
							<label for="r_user_name" class="control-label">이름</label>
							<input type="text" class="form-control" name="r_user_name" id="r_user_name" readonly> 
						</div>
            			<div class="form-group">
           					<label for="r_user_email" class="control-label">메일주소 (<span>*</span> 메일 인증 후 로그인 시 메일 주소를 입력해주세요)</label>
            				<input type="text" class="form-control" id="r_user_email" name="r_user_email" style="display:inline; width:75%;">
            				<button type="button" id="btn_r_authnum_send" class="btn-primary signup_btn" style="width:24%; height:34px; float:right;">인증번호 전송</button>
            			</div>
            			<div class="form-group">
            				<label for="r_user_authnum" class="control-label">인증번호</label>
            				<input type="text" class="form-control" id="r_user_authnum" name="r_user_authnum" style="display:inline; width:75%;" disabled>
            				<button type="button" id="btn_r_authnum_check" class="btn-primary signup_btn" style="width:24%; height:34px; float:right;">인증번호 확인</button>
            				<span id="r_user_authnum_timer" style="font-weight:normal; position:relative; left:65%; top:-25px; font-size:14px; color:#ccc;"></span>
            			</div>
					</fieldset>
					<input type="hidden" name="confirm_r_user_email" id="confirm_r_user_email">
					<input type="hidden" name="check_r_authnum" id="check_r_authnum">
					<input type="hidden" name=r_user_type id="r_user_type">
				</form>
	        </div>
			<div class="card-footer" style="height:50px;">
				<div style="position: relative;float: right;">
			        <button id="btn_r_modal_close" class="btn-secondary signup_btn" data-dismiss="modal">닫기</button>
			    	<button id="btn_r_modal_save" class="btn-primary signup_btn">등록</button>
				</div>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- <div class="modal" id="modal_searchpw" > -->
<!-- 	<div class="modal-dialog" style="width: 700px;"> -->
<!--     	<div class="card"> -->
<!--         	<div class="card-header"> -->
<!--             	<h5 class="modal-title" style="font-size:20px;font-weight: bold;"><i class="fa fa-key"></i> 비밀번호 찾기</h5> -->
<!--             </div> -->
<!--             <div class="card-body"> -->
<!--             	<form name="form" method="post" id="searchpwform" class="searchpwForm" style="clear:both;"> -->
<!--             		<fieldset> -->
<!--             			<div class="form-group"> -->
<!--            					<label for="s_user_id" class="control-label">메일주소(아이디)<span>*</span></label> -->
<!--             				<input type="text" class="form-control" id="s_user_id" name="s_user_id" style="display:inline; width:75%;"> -->
<!--             				<button type="button" id="btn_s_authnum_send" class="btn-primary signup_btn" style="width:24%; height:34px; float:right;">인증번호 전송</button> -->
<!--             			</div> -->
<!--             			<div class="form-group"> -->
<!--             				<label for="s_user_authnum" class="control-label">인증번호<span>*</span></label> -->
<!--             				<input type="text" class="form-control" id="s_user_authnum" name="s_user_authnum" style="display:inline; width:75%;" disabled> -->
<!--             				<button type="button" id="btn_s_authnum_check" class="btn-primary signup_btn" style="width:24%; height:34px; float:right;">인증번호 확인</button> -->
<!--             				<span id="s_user_authnum_timer" style="font-weight:normal; position:relative; left:65%; top:-25px; font-size:14px; color:#ccc;"></span> -->
<!--             			</div> -->
<!--             			<div class="form-group" style="margin-top:15px;"> -->
<!--             				<label for="s_user_password" class="control-label">새 비밀번호<span>*</span></label> -->
<!-- 							<input type="password" class="form-control" id="s_user_password" name="s_user_password" autocomplete="new-password"> -->
<!--             			</div> -->
<!--             			<div class="form-group"> -->
<!--             				<label for="s_user_pw_confirm" class="control-label">새 비밀번호 확인<span>*</span></label> -->
<!-- 							<input type="password" class="form-control" id="s_user_pw_confirm" name="s_user_pw_confirm"> -->
<!--             			</div> -->
<!--             		</fieldset> -->
<!-- 					<input type="hidden" name="s_confirm_user_id" id="s_confirm_user_id"> -->
<!-- 					<input type="hidden" name="s_check_authnum" id="s_check_authnum"> -->
<!--             	</form> -->
<!-- 	        </div> -->
<!-- 			<div class="card-footer" style="height:50px;"> -->
<!-- 				<div style="position: relative;float: right;"> -->
<!-- 			        <button id="btn_modal_close2" class="btn-secondary signup_btn" data-dismiss="modal">닫기</button> -->
<!-- 			    	<button id="btn_modal_save2" class="btn-primary signup_btn">변경</button> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div>/.modal-content -->
<!-- 	</div>/.modal-dialog -->
<!-- </div>/.modal -->

</body>
</html>
