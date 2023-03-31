package com.istec.m1.utils;


import java.util.Enumeration;
import java.util.LinkedHashMap;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.istec.m1.controller.QueryConroller;
 
public class CommonMap extends LinkedHashMap{
	
	private Logger logger = LoggerFactory.getLogger(CommonMap.class);
	
	public CommonMap(){
		 super();
	}

	public CommonMap(HttpServletRequest req){ 
		
		logger.info("===========================================================");
		Enumeration<String> paramNames = req.getParameterNames();
		while(paramNames.hasMoreElements()){
			String key = paramNames.nextElement();
			logger.info("key ==>> "+key+" , value = "+req.getParameter(key)); 
			super.put(key.toLowerCase(), req.getParameter(key)); 
		}
		logger.info("===========================================================");
		 
	}
	  
	public void put(String key , Object val){ 
		super.put(key.toLowerCase(), val);
	}

	public Object get(String key){
		return super.get(key.toLowerCase());
	} 
	
	public String getString(String key){
		return getString(key.toLowerCase(),"");
	}
	
	public String getString(String key , String nullStr){
		String keyVal = (String)super.get(key.toLowerCase());
		if(keyVal == null || "".equals(keyVal)){
			keyVal = nullStr;
		} 
		return keyVal;
	} 
}

