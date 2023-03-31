package com.istec.m1.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
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

import com.istec.m1.common.JacksonParsing;
import com.istec.m1.service.QueryService;
import com.istec.m1.utils.CommonMap;


@Controller
@RequestMapping(value="/query")
public class QueryConroller {

	private Logger logger = LoggerFactory.getLogger(QueryConroller.class);

	@Autowired
    private QueryService queryService;  
	
	
	@RequestMapping(value="/json", method={RequestMethod.POST, RequestMethod.GET}, produces = "application/json; charset=utf-8") 
	public @ResponseBody List<CommonMap> queryGet(HttpServletRequest request, HttpServletResponse response) throws IOException, UnsupportedEncodingException { 
		return getJason(request); 
	
	}
	

	/**************************************************************************/
	
	@RequestMapping(value="/json/insert", method={RequestMethod.POST}, produces = "text/html; charset=utf-8")
	public @ResponseBody String 
	executeInsert(HttpServletRequest request, HttpServletResponse response) throws IOException, UnsupportedEncodingException {
		return executeQuery(request, "insert");
	}
	
	@RequestMapping(value="/json/update", method={RequestMethod.POST}, produces = "text/html; charset=utf-8")
	public @ResponseBody String 
	executeUpdate(HttpServletRequest request, HttpServletResponse response) throws IOException, UnsupportedEncodingException {
		return executeQuery(request, "update");
	}
	
	@RequestMapping(value="/json/delete", method={RequestMethod.POST}, produces = "text/html; charset=utf-8")
	public @ResponseBody String 
	executeDelete(HttpServletRequest request, HttpServletResponse response) throws IOException, UnsupportedEncodingException {
		return executeQuery(request, "delete");
	}
	
	
	protected String executeQuery(HttpServletRequest request, String method) throws IOException {
		 
		 
		String qid = request.getParameter("qid");

		List<CommonMap> listMap = null; 
		String data = getBody(request);
		
		if(data != null && !data.isEmpty()) {
			listMap = JacksonParsing.toList(data);
		}
		 
		
		switch(method) {
		case "insert":
			 queryService.insert(qid, listMap);
			 break;
		case "update":
			 queryService.update(qid, listMap);
			 break;
		case "delete":
			 queryService.delete(qid, listMap);
			 break;
		}
		 
		return JacksonParsing.toString(listMap);
		 
	}
	 
	 
	protected List<CommonMap> getJason(HttpServletRequest request) throws IOException {
		long start_time = 0;
		long end_time = 0;
		List<CommonMap> rst = null;
		
		String qid = request.getParameter("qid"); 
		String db_type = request.getParameter("db_type");
		CommonMap parmMap = new CommonMap(request);  
		
		start_time = System.currentTimeMillis();
		String addr = request.getRemoteAddr();
		String URL = request.getRequestURL().toString();


		try {
			if("rawris_new".equals(db_type))
				rst = queryService.select(qid, parmMap); 
			else if("rims".equals(db_type))
				rst = queryService.select_rims(qid, parmMap); 
			else if("rawris".equals(db_type))
				rst = queryService.select_rawris(qid, parmMap); 
			else
				rst = queryService.select_postgreSQL(qid, parmMap); 
			
			end_time = System.currentTimeMillis();
		} catch (Exception e) {
			end_time = System.currentTimeMillis();
			logger.info("error_check Exception e: "+ qid + " // time : " + (end_time - start_time)/1000 + "sec  //  addr : " + addr + " //  URL: " + URL);
			logger.info(e.getMessage());
		}
		
		end_time = System.currentTimeMillis();
		
		if(end_time - start_time > 600000) {
			logger.info("error_check 600000: "+ qid + " // time : " + (end_time - start_time)/1000 + "sec  //  addr : " + addr + " //  URL: " + URL);
		}
		
		return rst;
		
	}
	 
	protected static String getBody(HttpServletRequest request) throws IOException {
        String body = null;
        StringBuilder stringBuilder = new StringBuilder();
        BufferedReader bufferedReader = null;
        String charSet = request.getCharacterEncoding();
        if (charSet == null) charSet = "utf-8";
        
        try {
            InputStream inputStream = request.getInputStream();
            if (inputStream != null) { 
            	bufferedReader = new BufferedReader(new InputStreamReader(inputStream, charSet));
                char[] charBuffer = new char[128];
                int bytesRead = -1;
                while ((bytesRead = bufferedReader.read(charBuffer)) > 0) {
                    stringBuilder.append(charBuffer, 0, bytesRead);
                }
            }
        } catch (IOException ex) {
            throw ex;
        } finally {
            if (bufferedReader != null) try { bufferedReader.close(); } catch (IOException ex){ throw ex; } 
        }
 
        body = stringBuilder.toString();
        return body;
    } 

	
}



