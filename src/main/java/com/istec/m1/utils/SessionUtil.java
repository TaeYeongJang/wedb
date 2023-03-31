package com.istec.m1.utils;

import java.util.Enumeration;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class SessionUtil {
   
	private HttpServletRequest request;
	
	private final Logger logger = LoggerFactory.getLogger(SessionUtil.class);
	
	/**  
	 * <pre> com.istec.m1.utils<br>
	 *     
	 * </pre>   
	 * @Date   : 2018. 3. 5.
	 * @author : yokwoun  
	 * @Constructor : SessionUtil
	 */
	public SessionUtil(HttpServletRequest request) {
		
		logger.info("SessionUtil request ==>>> "+request);
		logger.info("SessionUtil request ==>>> "+request);
		logger.info("SessionUtil request ==>>> "+request);
		
		this.request = request;
	}
	
	
	/** 
	 * <pre> com.istec.m1.utils<br>
	 *     
	 * </pre>   
	 * @Date   : 2018. 3. 5.
	 * @author : yokwoun
	 * @메소드설명 :  HttpSession을 반환한다.
	 * @param : 
	 * @return :  HttpSession
	 * @throws :
	 */
	public HttpSession getSession(){
//		return getSession(false);
		return getSession(true);
	}
	 
	/**  
	 * <pre> com.istec.m1.utils<br>
	 *     
	 * </pre>   
	 * @Date   : 2018. 3. 5.
	 * @author : yokwoun
	 * @메소드설명 : HttpSession을 반환한다.   
	 * @return :  HttpSession
	 * @throws :
	 */
	public HttpSession getSession(boolean isCreate){ 
		if(request != null){
			
			logger.info("SessionUtil getSession session "+isCreate+"==>>>  "+request.getSession(isCreate));
			logger.info("SessionUtil getSession session "+isCreate+"==>>>  "+request.getSession(isCreate));
			logger.info("SessionUtil getSession session "+isCreate+"==>>>  "+request.getSession(isCreate));  
			
			return request.getSession(isCreate);
		}else return null; 
	} 
	
	/** 
	 * <pre> com.istec.m1.utils</pre>   
	 * @Date   : 2018. 3. 5.
	 * @author : yokwoun
	 * @메소드설명 : HttpSession에 속성을 추가한다.  
	 * @return : void  
	 * @throws :
	 */
	public void setSessionAttr(String attrKey , Object attrVal){
		if(request != null){
			HttpSession session = this.getSession();
			
			logger.info("SessionUtil setSessionAttr session==>>> "+session);
			logger.info("SessionUtil setSessionAttr session==>>> "+session);
			logger.info("SessionUtil setSessionAttr session==>>> "+session);
			
			
			session.setAttribute(attrKey, attrVal); 
		}
	}
	
	/** 
	 * <pre> com.istec.m1.utils</pre>   
	 * @Date   : 2018. 3. 5.
	 * @author : yokwoun
	 * @메소드설명 : HttpSession에 속성을 반환한다.
	 * @return : Object 
	 * @throws :
	 */
	public Object getSessionAttr(String attrKey){
		
		if("".equals(attrKey) ||  attrKey == null) return null;
		
		HttpSession session = this.getSession();
		if(session == null) return null;
		 
		return session.getAttribute(attrKey); 
	} 
	
	/** 
	 * <pre> com.istec.m1.utils</pre>   
	 * @Date   : 2018. 3. 5.
	 * @author : yokwoun
	 * @메소드설명 : HttpSession Null여부를 반환한다.  
	 * @return :  boolean 
	 * @throws :
	 */
	public boolean isNullSession(){
		return this.request == null; 
	}
	
	/** 
	 * <pre> com.istec.m1.utils</pre>   
	 * @Date   : 2018. 3. 6.
	 * @author : yokwoun
	 * @메소드설명 : HttpSession이 가지고있는 속성을 반환한다. 
	 * @return :  HashMap
	 * @throws :
	 */
	public HashMap getSessionAttrs(){
		HashMap sesMap = new HashMap();
		HttpSession session = this.getSession();
		Enumeration sesAttrEnu = session.getAttributeNames();
		while(sesAttrEnu.hasMoreElements()){
			String sesAttrKey = (String) sesAttrEnu.nextElement();
			Object sesAttrVal = session.getAttribute(sesAttrKey); 
			sesMap.put(sesAttrKey, sesAttrVal);
		}
		
		return sesMap;
	}
	 
}
