package com.istec.m1.auth;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import com.istec.m1.service.QueryService;
import com.istec.m1.utils.CommonMap;

public class CustomLoginFailHandler  implements AuthenticationFailureHandler{
	
	private static final Logger logger = LoggerFactory.getLogger(CustomLoginFailHandler.class);
	
	@Autowired
    private QueryService queryService;
	
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws IOException, ServletException {
			
		 CommonMap cMap = new CommonMap(request); 
		 
		 logger.info("CustomLoginFailHandler onAuthenticationFailure Login Fail Begin ~~!!!");
		 logger.info("CustomLoginFailHandler onAuthenticationFailure cMap ==>> "+cMap);  
		 logger.info("CustomLoginFailHandler onAuthenticationFailure queryService ==>> "+queryService);  
		 logger.info("CustomLoginFailHandler onAuthenticationFailure Login Fail Finish ~~!!!"); 

		 String msg = "로그인이 실패하였습니다.";
		 
		 // 22.05.04. 회원가입시 가입대기회원 권한 해제
//		 String user_id = request.getParameter("id");
//		 String user_pw	= request.getParameter("pw");
//	 
//		 if(!user_id.isEmpty()) {
//			 List<CommonMap> userInfoList = null;
//			 userInfoList = queryService.select("rawris.wrms.usermgt.userlevelinfo", cMap);
//			 
//			 if(userInfoList != null && userInfoList.size() > 0){
//				 CommonMap userInfo = null;
//				 userInfo = userInfoList.get(0);
//				 if(((String)userInfo.get("user_password")).equals(user_pw)){
//					 String user_level = String.valueOf(userInfo.get("user_level"));
//					 if(user_level.equals("6")) msg = "승인 대기 상태입니다. 관리자 승인 후 이용가능합니다.";
//				 }
//			 }
//		 }
		 
		 response.setContentType("text/html; charset=UTF-8"); 
		 PrintWriter writer = response.getWriter();
		 writer.println("<script>alert('"+msg+"');location.href='"+request.getContextPath()+"/login'; </script>"); 
	}
}
