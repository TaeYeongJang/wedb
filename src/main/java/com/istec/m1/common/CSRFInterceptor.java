package com.istec.m1.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class CSRFInterceptor extends HandlerInterceptorAdapter {

 @Override
 public boolean preHandle(HttpServletRequest request, HttpServletResponse response, 
   Object handler) throws Exception {
  
   //System.out.println("CSRFInterceptor");
   if (!request.getMethod().equalsIgnoreCase("POST") ) {
   // Not a POST - allow the request
       return true;
   } else {
       
	   // This is a POST request - need to check the CSRF token
       String sessionToken = CSRFTokenManager.getTokenForSession(request.getSession());
       String requestToken = CSRFTokenManager.getTokenFromRequest(request);
       if (sessionToken.equals(requestToken)) {
         return true;
       } else {
         response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bad or missing CSRF value");
         return false;
      }
   }
 }
}