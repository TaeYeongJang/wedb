package com.istec.m1.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.istec.m1.service.MailService;
import com.istec.m1.utils.CommonMap;

@Controller
@RequestMapping(value = "/mail") 
public class mailController {
	
	private static final Logger logger = LoggerFactory.getLogger(mailController.class);
	
	@Autowired
    private MailService mailService;
 
	/** 
	 * <pre> com.istec.m1.controller</pre>   
	 * @Date   : 2021. 04. 22.
	 * @author : 유혜수
	 * @메소드설명 : 회원가입/이메일등록/비밀번호재설정 인증번호 이메일 전송
	 * @return :  
	 * @throws : IOException 
	 */
	@RequestMapping(value="/send_mail", method={RequestMethod.POST, RequestMethod.GET}, produces = "application/json; charset=utf-8") 
	public @ResponseBody List<CommonMap> sendMail(HttpServletRequest request, HttpServletResponse response) throws IOException, UnsupportedEncodingException { 
		
		CommonMap parmMap = new CommonMap(request);
		
		return mailService.sendMail(parmMap); 

	}
	
}
