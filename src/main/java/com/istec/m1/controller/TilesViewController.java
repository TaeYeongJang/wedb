package com.istec.m1.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.istec.m1.auth.CustomUserDetails;
import com.istec.m1.service.QueryService;
import com.istec.m1.utils.CommonMap;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping(value = "/tiles")
public class TilesViewController {
	
	private static final Logger logger = LoggerFactory.getLogger(TilesViewController.class);
	 
	@Autowired
    private QueryService queryService;
	
	@RequestMapping(value = "/{page}", method = RequestMethod.GET)
	public String page_1(@PathVariable String page,Model model, HttpServletRequest request) { 
        setModeladdAttribute(request, model);  
        logger.info("TilesViewController tiles page ==>> /"+page+".tiles");
         
        return "/"+page+".tiles";
	}
	 
	@RequestMapping(value = "/{cate}/{page}", method = RequestMethod.GET)
	public String catePath1(@PathVariable String cate , @PathVariable String page, Model model, HttpServletRequest request) {
	//public String catePath1(@PathVariable String cate , @PathVariable String page,@PathVariable String extention , Model model, HttpServletRequest request) { 
        setModeladdAttribute(request, model);
        logger.info("TilesViewController tiles catePath1 ==>> /"+cate+"/"+page+".tiles"); 
        return "/"+cate+"/"+page+".tiles"; 
	}
	
	
	@RequestMapping(value = "/{cate1}/{cate2}/{page}", method = RequestMethod.GET)
	public String catePath2(@PathVariable String cate1  , @PathVariable String cate2  , @PathVariable String page, Model model, HttpServletRequest request) { 
	//public String catePath2(@PathVariable String cate1  , @PathVariable String cate2  , @PathVariable String page,@PathVariable String extention, Model model, HttpServletRequest request) {
        setModeladdAttribute(request, model);
        
        logger.info("TilesViewController tiles catePath2 ==>> /"+cate1+"/"+cate2+"/"+page+".tiles"); 
        return "/"+cate1+"/"+cate2+"/"+ page+".tiles"; 
	}

	 
	/**************************************************************************/
	/*
	 * 
	 */

	private void setModeladdAttribute(HttpServletRequest request, Model model) {
		 
		/*CommonMap userSesInqMap = new CommonMap(); 
    	userSesInqMap.put("session_id"   , request.getRequestedSessionId());    // Login User Session ID 
    	List<HashMap<String,Object>> userSessionList = queryService.select("rawris.wrms.usermgt.inq_user_session_info",userSesInqMap); 
    	HashMap<String,Object> userSession = userSessionList.get(0);
		 
    	model.addAttribute("user", new CustomUserDetails(userSession));*/
    	 
		
        String ctxPath = request.getContextPath();
        if(ctxPath.equals("/")) ctxPath = ""; 
        model.addAttribute("contextPath", ctxPath);
        
	}
}
