package com.istec.m1.auth;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.istec.m1.service.QueryService;
import com.istec.m1.utils.CommonMap;
import com.istec.m1.auth.CustomUserDetails;

@Component
public class CustomAuthenticationProvider implements AuthenticationProvider { 
	@Autowired(required = false)
	private HttpServletRequest request;

	@Autowired
	private QueryService queryService;

	private static final Logger logger = LoggerFactory.getLogger(CustomAuthenticationProvider.class);

	@Override
	public boolean supports(Class<?> authentication) {
		return authentication.equals(UsernamePasswordAuthenticationToken.class);
	}
	
	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		String user_id		= (String)authentication.getPrincipal();
		String user_pw		= (String)authentication.getCredentials();
		String user_type	= request.getParameter("loginType");
		String user_org_pw	= request.getParameter("org_pw");
		
		UsernamePasswordAuthenticationToken result = null;
		
		logger.info("=========================================================================");
		logger.info("로그인정보 {}", user_id + "/" + user_type +"/" + user_org_pw +"/"+ user_pw);
		logger.info("=========================================================================");
		
		// int login_roll = -1;

		CommonMap userInfo = null;
		
		if(!user_id.isEmpty()) {
			CommonMap cMap = new CommonMap();
			List<CommonMap> userInfoList = null;
			cMap.put("user_id", user_id);
			cMap.put("user_org_pw", user_org_pw);
			cMap.put("user_pw", user_pw);
			cMap.put("user_type", user_type);
			
			// 22.05.12. 사번 로그인 없앰 => 무조건 이메일 로그인 => 22.06.08. 변경 취소
			if(user_type.equals("S") || user_type.equals("E")){
				logger.info("사번 로그인===========================================================");
				if(user_type.equals("S")) userInfoList = queryService.select("rawris.wrms.usermgt.userinforims", cMap);
				else userInfoList = queryService.select("rawris.wrms.usermgt.ssouserinforims", cMap);
				
				cMap.put("user_type", "S");

				if(userInfoList.size() > 0){
					userInfo = userInfoList.get(0);

					logger.info("user_info update or insert ====================================");
					logger.info("user_name{}", userInfo.get("user_name"));
					logger.info("user_buseo{}", userInfo.get("user_buseo"));
					logger.info("user_info update or insert ====================================");
					
					cMap.put("user_name", userInfo.get("user_name"));
					cMap.put("user_buseo", userInfo.get("user_buseo"));
					logger.info("cMap{}", cMap.toString());

					queryService.update("rawris.wrms.usermgt.userinforimsup", cMap);

				}
			}
			

			userInfoList = queryService.select("rawris.wrms.usermgt.userinfo", cMap);
			
			if(userInfoList != null && userInfoList.size() > 0){
				userInfo = userInfoList.get(0);
				
				if(((String)userInfo.get("user_password")).equals(user_pw)){
					logger.info("========here!!!=======");
					List<GrantedAuthority> roles = new ArrayList<GrantedAuthority>();
					String user_role = (String)userInfo.get("char_user_role");
					roles.add(new SimpleGrantedAuthority("ROLE_USER"));
					if("ROLE_ADMIN".equals(user_role)){
						roles.add(new SimpleGrantedAuthority("ROLE_ADMIN"));
					}
					
					result = new UsernamePasswordAuthenticationToken(user_id, user_pw, roles);
					result.setDetails(new CustomUserDetails(userInfo));
					
					// 22.05.04. 회원가입시 가입대기회원 권한 해제
//					String user_level = String.valueOf(userInfo.get("user_level"));
//					cMap.put("user_level", user_level);
//					if(!"6".equals(user_level)) {
//						result = new UsernamePasswordAuthenticationToken(user_id, user_pw, roles);
//						result.setDetails(new CustomUserDetails(userInfo));
//					}	
				}
			}
			return result;
		}else{
			throw new BadCredentialsException("Bad credentials");
		}
	} 
}