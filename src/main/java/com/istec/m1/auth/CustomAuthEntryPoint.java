package com.istec.m1.auth;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
//import org.apache.commons.lang.StringUtils;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.stereotype.Component;
//import com.syaku.rest.commons.ResponseResult;


@Component
public class CustomAuthEntryPoint implements AuthenticationEntryPoint {
	
    private static final Logger logger = LoggerFactory.getLogger(CustomAuthEntryPoint.class);
	
	/*private String loginFormUrl;

	public String getLoginFormUrl() {
		return loginFormUrl;
	}

	public void setLoginFormUrl(String loginFormUrl) {
		this.loginFormUrl = loginFormUrl;
	}

	public UnauthorizedEntryPoint() {
	}

	public UnauthorizedEntryPoint(String loginFormUrl) {
		this.loginFormUrl = loginFormUrl;
	}*/

    private String errorPage;
    
    public void setErrorPage(String errorPage) {
        this.errorPage = errorPage;
    }
    
	@Override
	public void commence(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException authException) throws IOException, ServletException {
		
		logger.info("CustomAuthEntryPoint!");
		
		request.getRequestDispatcher(errorPage).forward(request, response);

		//response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Unauthorized");
		
		//response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
		//RestSendError.sendError(response, HttpServletResponse.SC_UNAUTHORIZED, "Unauthorized");
	}
}
