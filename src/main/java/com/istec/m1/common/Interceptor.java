package com.istec.m1.common;

import java.security.Principal;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.istec.m1.auth.CustomUserDetails;
import com.istec.m1.service.QueryService;
import com.istec.m1.utils.CommonMap;

public class Interceptor extends HandlerInterceptorAdapter{
	
	private static final Logger logger = LoggerFactory.getLogger(Interceptor.class);
	
	@Autowired
    private QueryService queryService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		Enumeration<String> paramNames = request.getParameterNames();
	    while (paramNames.hasMoreElements()) {
	      String key = (String) paramNames.nextElement(); 
	      logger.debug(" ParamKey ==>  " + key + " : " + request.getParameter(key) + "");
	    }
	    logger.info("Interceptor preHandle Finish !!!!"); 

        // Access Url 
		String accessUrl = request.getRequestURI();
		String contextPath = request.getContextPath(); 
		accessUrl = accessUrl.substring(contextPath.length());
		
		logger.info("Interceptor accessUrl !!!! ==>>"+accessUrl);
        
		// Client IpAddress
		String clientIp = request.getHeader("X-FORWARDED-FOR"); 
		if (clientIp == null) clientIp = request.getRemoteAddr(); 
		
		Principal principal= request.getUserPrincipal();

		if(principal != null){
			String principalName = principal.getName();
			logger.info("Interceptor principalName "+principalName);   
			CustomUserDetails userDetails = (CustomUserDetails)SecurityContextHolder.getContext().getAuthentication().getDetails(); 
			logger.info("isAjaxCall ==>> "+(!isAjaxCall(request))); 

			// userId
			String loginUserId = userDetails.getUser_id(); 
			
			if(!isAjaxCall(request) && !loginUserId.equals("dev111") ){  
				  
				// user Access Menu Log
				CommonMap cMap = new CommonMap();   
				cMap.put("renewal_no", "1");
				cMap.put("user_id"   , loginUserId);
				cMap.put("check_url" , accessUrl);
				cMap.put("user_ip"   , clientIp);
				//queryService.update("rawris.wrms.menumgt.ins_wrms_access_log", cMap); 
			}  
		}else{
			CommonMap cMap = new CommonMap();   
			cMap.put("renewal_no", "1");
			cMap.put("user_id"   , "anonymous");
			cMap.put("check_url" , "/gis/main");
			cMap.put("user_ip"   , clientIp);
			//queryService.update("rawris.wrms.menumgt.ins_wrms_access_log", cMap); 
			
		} 

		boolean isPreHandle = super.preHandle(request, response, handler);
		//logger.info("Interceptor isPreHandle "+isPreHandle);
	    return isPreHandle;  
	    
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception { 
		super.postHandle(request, response, handler, modelAndView);
	}
	
	private boolean isAjaxCall(HttpServletRequest req){  
		String accept = req.getHeader("accept");
		return accept.indexOf("application/json") > -1  ? true : false; 
	}
 
}
