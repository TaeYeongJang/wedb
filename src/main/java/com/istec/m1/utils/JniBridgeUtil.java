package com.istec.m1.utils;

import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import net.sf.jni4net.Bridge; 

public class JniBridgeUtil {
	
	private static Logger logger = LoggerFactory.getLogger(JniBridgeUtil.class);
	private static boolean _inited = false;
	
/*  This Application Simulation */ 
	public static boolean BridgeInit(HttpServletRequest req) throws IOException{ 
		
		if(_inited)
			return true;
		
		try{ 
			logger.info("=======    JniBridgeUtil.BridgeInit  Begin!!! =============");  
			/*Enumeration sesEnu = req.getSession().getServletContext().getAttributeNames();
			while(sesEnu.hasMoreElements()){
				String enuName = (String)sesEnu.nextElement();
				String enuVal = ""+req.getSession().getServletContext().getAttribute(enuName);
				logger.info("=======  enuName ==>> "+enuName+"  , enuVal ==>> "+enuVal); 
			} 
			URL url = req.getSession().getServletContext().getResource("/");
			String urlPath = url.getPath();*/
			
			String contxtRoot = req.getSession().getServletContext().getRealPath("/");
			logger.debug("=======  HttpServletRequest  contxtRoot : "+contxtRoot+" ============="); 
			logger.debug("=======    coreFile   : "+contxtRoot+"WEB-INF"+File.separator+"lib"+File.separator+"jni4net.n.w64.v40-0.8.8.0.dll");
			logger.debug("=======    dll_File   : "+contxtRoot+"WEB-INF"+File.separator+"lib"+File.separator+"CshapJni.j4n.dll  =============");
			   
			File coreFile = new File(contxtRoot+"WEB-INF"+File.separator+"lib"+File.separator+"jni4net.n.w64.v40-0.8.8.0.dll");  
			File dll_File = new File(contxtRoot+"WEB-INF"+File.separator+"lib"+File.separator+"CshapJni.j4n.dll");
			
			logger.debug("=======    JniBridgeUtil.BridgeInit  coreFile.exists() ============= "+coreFile.exists());
			logger.debug("=======    JniBridgeUtil.BridgeInit  dll_File.exists() ============= "+dll_File.exists());
			
			Bridge.setVerbose(true);
			logger.debug("=======    JniBridgeUtil.BridgeInit  setVerbose(true) ============= ");  
			
			Bridge.init(coreFile); 
			Bridge.LoadAndRegisterAssemblyFrom(dll_File); 
			
			_inited = true;
			
			return true;
		} catch(Exception e){
			return false;
		} 
	}
	 
}
