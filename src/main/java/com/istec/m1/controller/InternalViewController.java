package com.istec.m1.controller;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class InternalViewController {
	
	private static final Logger logger = LoggerFactory.getLogger(InternalViewController.class);
	 
	@RequestMapping(value = "/")
	public String page0(Model model, HttpServletRequest request) { 
        setModeladdAttribute(request, model); 
        return "/gis/main";
	}
	
	@RequestMapping(value = "/{page}", method = RequestMethod.GET)
	public String page1(@PathVariable String page,Model model, HttpServletRequest request) { 
        setModeladdAttribute(request, model); 
        return "/"+page;
	}
	
	@RequestMapping(value = "/{page}", method = RequestMethod.POST)
	public String page1_post(@PathVariable String page,Model model, HttpServletRequest request) { 
		setModeladdAttribute(request, model); 
		return "/"+page;
	}
	 
	@RequestMapping(value = "/{cate}/{page}", method = RequestMethod.GET)
	public String catePath1(@PathVariable String cate , @PathVariable String page, Model model, HttpServletRequest request) {
	    setModeladdAttribute(request, model); 
        return "/"+cate+"/"+page; 
	}

	@RequestMapping(value = "/{cate}/{page}", method = RequestMethod.POST)
	public String catePath1_post(@PathVariable String cate , @PathVariable String page, Model model, HttpServletRequest request) {
		setModeladdAttribute(request, model); 
		return "/"+cate+"/"+page; 
	}
	
	
	@RequestMapping(value = "/{cate1}/{cate2}/{page}", method = RequestMethod.GET)
	public String catePath2(@PathVariable String cate1  , @PathVariable String cate2  , @PathVariable String page, Model model, HttpServletRequest request) { 
	    setModeladdAttribute(request, model);
        return "/"+cate1+"/"+cate2+"/"+ page; 
	}
	@RequestMapping(value = "/{cate1}/{cate2}/{page}", method = RequestMethod.POST)
	public String catePath2_post(@PathVariable String cate1  , @PathVariable String cate2  , @PathVariable String page, Model model, HttpServletRequest request) { 
		setModeladdAttribute(request, model); 
		return "/"+cate1+"/"+cate2+"/"+ page; 
	}

	 
	/**************************************************************************/
	/*
	 * 
	 */

	private void setModeladdAttribute(HttpServletRequest request, Model model) { 
        String ctxPath = request.getContextPath();
        if(ctxPath.equals("/")) ctxPath = ""; 
        model.addAttribute("contextPath", ctxPath);
        
	}
}
