package com.istec.m1.utils;

import java.util.List;
import java.util.Map;

public class CommonUtil {
	
	/** 
	 * <pre> com.istec.m1.utils</pre>   
	 * @Date   : 2018. 3. 9.
	 * @author : jn.kim
	 * @메소드설명 :  Object Null Check 
	 * @return :  boolean 
	 * @throws :
	 */
	public static boolean isNull(Object obj){   
		return "".equals(obj) || null == obj || "null".equals(obj);
	}
	
	/** 
	 * <pre> com.istec.m1.utils</pre>   
	 * @Date   : 2018. 3. 9.
	 * @author : jn.kim
	 * @메소드설명 : string NVL 
	 * @return :  
	 * @throws :
	 */
	public static String strNVL(String orginStr , String replaceStr){ 
		return !isNull(orginStr) ? orginStr : replaceStr;
	}
	
	/** 
	 * <pre> com.istec.m1.utils</pre>   
	 * @Date   : 2018. 3. 9.
	 * @author : jn.kim
	 * @메소드설명 : return Object Type (String) 
	 * @return :  String
	 * @throws :
	 */
	public static String typeOf(Object obj){
		
		String objType = ""; 
		
		     if (obj.getClass() == Integer.class) objType = "Integer"; 
		else if (obj.getClass() == String.class)  objType = "String"; 
		else if (obj.getClass() == Float.class)   objType = "Float"; 
		
		return objType;
	}
	
	/**
	 * 
	 * <pre> com.istec.m1.utils</pre>   
	 * @Date   : 2018. 4. 12.
	 * @author : jn.kim
	 * @메소드설명 : Empty 여부 체크
	 * @return :  
	 * @throws :
	 */
	public static boolean isEmpty(Object chkObj){
		   
		  if (chkObj == null)  return true;  
		  if ((chkObj instanceof String) && (((String)chkObj).trim().length() == 0))  return true; 
		  if (chkObj instanceof Map)  return ((Map<?, ?>)chkObj).isEmpty();  
		  if (chkObj instanceof List) return ((List<?>)chkObj).isEmpty();  
		  if (chkObj instanceof Object[]) return (((Object[])chkObj).length == 0); 
		  
		  return false;  
		   
	   }
	
}
