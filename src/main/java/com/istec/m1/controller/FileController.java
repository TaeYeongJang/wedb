package com.istec.m1.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.istec.m1.auth.CustomUserDetails;
import com.istec.m1.service.QueryService;
import com.istec.m1.utils.CommonMap;
import com.istec.m1.utils.CommonUtil;
import com.istec.m1.utils.FileVo; 


/**
 * File Upload / DownLoad Controller.
 */
@Controller
@RequestMapping(value = "/files")
public class FileController {
	
	private static final Logger logger = LoggerFactory.getLogger(FileController.class);
	
	@Autowired
    private QueryService queryService;
	
	@RequestMapping(value="/krc_upload", method=RequestMethod.POST)
	public synchronized  @ResponseBody boolean fileUpload(MultipartHttpServletRequest mReq) throws IOException{
		  
		
			String queryId = CommonUtil.strNVL(mReq.getParameter("qid"),"rawris.wrms.common.file.ins_krc_file_upload");  
			 
			/*CommonMap userSesInqMap = new CommonMap(); 
	    	userSesInqMap.put("session_id"   , mReq.getRequestedSessionId());    // Login User Session ID  
	    	List<CommonMap> userSessionList = queryService.select("rawris.wrms.usermgt.inq_user_session_info",userSesInqMap); 
	    	HashMap<String,Object> userSession = userSessionList.get(0);
	    	String sesUserId = ""+userSession.get("user_id");*/
			
			// Login User조회  
	    	CustomUserDetails userDetails = (CustomUserDetails)SecurityContextHolder.getContext().getAuthentication().getDetails();
	    	String sesUserId = userDetails.getUser_id();
			
			
			Set<String>  mFilesKeySet = mReq.getFileMap().keySet(); 
			if(!mFilesKeySet.isEmpty()){
				Iterator<String> iterFileKey = mFilesKeySet.iterator();
				while(iterFileKey.hasNext()){
					String fileKey = iterFileKey.next();
					
					logger.info("queryId ==>> "+queryId); 
					logger.info("sesUserId ==>> "+sesUserId); 
					logger.info("fileKey ==>> "+fileKey); 
					
					MultipartFile file = mReq.getFile(fileKey); 
					String fileName = file.getOriginalFilename(); 
					    
					
					CommonMap paramMap = new CommonMap();  
					
					paramMap.put("appl"          , mReq.getParameter("appl"));
					paramMap.put("file_cate"     , mReq.getParameter("file_cate"));
					paramMap.put("cate_uniq_seq" , mReq.getParameter("cate_uniq_seq")); 
					paramMap.put("user_id"       , sesUserId ); 
					paramMap.put("file_desc"     , mReq.getParameter("file_desc")); 
					paramMap.put("tmp_col1"      , mReq.getParameter("tmp_col1"));  
					paramMap.put("tmp_col2"      , mReq.getParameter("tmp_col2")); 
					paramMap.put("tmp_col3"      , mReq.getParameter("tmp_col3")); 
					paramMap.put("tmp_col4"      , mReq.getParameter("tmp_col4")); 
					paramMap.put("tmp_col5"      , mReq.getParameter("tmp_col5")); 
					paramMap.put("tmp_col_desc"  , mReq.getParameter("tmp_col_desc"));  
					 
					paramMap.put("file_content" , file.getBytes());
					paramMap.put("file_name"    , fileName);
					paramMap.put("file_type"    , file.getContentType());
					paramMap.put("file_ext"     , fileName.substring(fileName.lastIndexOf(".")+1));
					paramMap.put("file_size"    , file.getSize()); 
					queryService.insert(queryId, paramMap); 
				}
			}
				 
			
			return true; 
	 } 
	
	@RequestMapping(value="/krc_img_view", method=RequestMethod.GET)
	public ResponseEntity<byte[]> fileImgView(HttpServletRequest req , HttpServletResponse res) throws IOException, SQLException{
		   
		 CommonMap cMap = new CommonMap(req);  
		 FileVo filevo = queryService.selectBlobFile(cMap);  
		 byte[] imageByte = filevo.getBlobContentByte();
		   
		 final HttpHeaders headers = new HttpHeaders();
		 headers.setContentType(MediaType.valueOf(filevo.getFileType()));
    	 return new ResponseEntity<byte[]>(imageByte, headers, HttpStatus.OK); 
	}
	
	
}
