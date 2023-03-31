package com.istec.m1.auth;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

import com.istec.m1.controller.LoginController;
import com.istec.m1.service.QueryService;
import com.istec.m1.utils.CommonMap;

public class CustomLoginSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {

	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
//	private static final String TARGET_URL = "/gis/main";
	 
	private static final String TARGET_URL = "/registmgt/equip_manage/equip_oper_status";

	@Autowired
    private QueryService queryService;
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws ServletException, IOException {
		String chkID = "";
		String targetUrl = TARGET_URL;
		CustomUserDetails userDetails = null;
		
		if(request.getSession() != null){ 
			userDetails = (CustomUserDetails)SecurityContextHolder.getContext().getAuthentication().getDetails();
             
            // Login User IP Address 
			String clientIp = request.getHeader("X-FORWARDED-FOR"); 
			if (clientIp == null) clientIp = request.getRemoteAddr();
                   
			CommonMap loginInfoMap = new CommonMap();
			loginInfoMap.put("login_session_id" , request.getRequestedSessionId());    // Login User Session ID 
			loginInfoMap.put("client_ip"        , clientIp);                           // Login User IP
			loginInfoMap.put("user_id"          , userDetails.getUser_id() );          // Login User ID
			chkID = userDetails.getUser_id();
			loginInfoMap.put("user_level"       , userDetails.getUser_level());        // Login User Level
			loginInfoMap.put("user_role"        , userDetails.getUser_role());         // Login User Role
			loginInfoMap.put("char_user_role"   , userDetails.getChar_user_role());    // Login User Role (한글)
			loginInfoMap.put("user_name"        , userDetails.getUser_name());         // Login User Name
			loginInfoMap.put("user_email"       , userDetails.getUser_email());        // Login User Email
			loginInfoMap.put("num_office"       , userDetails.getNum_office());        // 사무실전화
			loginInfoMap.put("num_cellular"     , userDetails.getNum_cellular());      // 휴대전화
			loginInfoMap.put("user_ekr_yn"      , userDetails.getUser_ekr_yn());       // 농어촌공사직원여부
			loginInfoMap.put("user_sms_yn"      , userDetails.getUser_sms_yn());       // 문자메세지수신여부
			loginInfoMap.put("user_com_yn"      , userDetails.getUser_com_yn());       // 공용(???)여부
			loginInfoMap.put("buseo_level"      , userDetails.getBuseo_level());       // 부서 레벨 
			loginInfoMap.put("level_buseo_code" , userDetails.getLevel_buseo_code());  // 레벨별 부서코드(시설,장비검색용) 
			loginInfoMap.put("orgin_buseo_code" , userDetails.getOrgin_buseo_code());  //  원 부서 코드
			loginInfoMap.put("bf_login" 		, userDetails.getBf_login());  		   //  최종접속 시간
			loginInfoMap.put("job_status" 		, userDetails.getJob_status());  	   //  스케쥴 잡 상태
 			 
			queryService.insert("rawris.wrms.usermgt.ins_user_login_session_info", loginInfoMap);
			  
		}

		if(chkID.equals("mafra")){
			logger.info("STEP2");
			targetUrl = "/mafra/mf_main";
		}else if(chkID.equals("gamsa")){
			logger.info("STEP2");
			targetUrl = "/custom/cs_main";
		}else if(chkID.equals("dev113")){
			logger.info("STEP2");
			//targetUrl = "/qms/qms_manual_search";
			targetUrl = "/systemmgt/totsysmgt/tot_sys_mgt";
		}else if(chkID.equals("jeonnam")){  //20210621 김규남 과장 요청사항
			logger.info("STEP2");
			//targetUrl = "/qms/qms_auto_result";
			targetUrl = "/salt/salt_list";
		}
		else if(userDetails != null && userDetails.getUser_role() == 11) {
			logger.info("STEP2");
			targetUrl = "/dataview/wrms_reservoir_lo";
		}
		

		super.setAlwaysUseDefaultTargetUrl(true);
		super.setDefaultTargetUrl(targetUrl);
        super.onAuthenticationSuccess(request, response, authentication);
	}
}
