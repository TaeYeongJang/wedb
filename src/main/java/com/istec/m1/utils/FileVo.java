package com.istec.m1.utils;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.SQLException;

import org.apache.ibatis.session.ResultContext;
import org.apache.ibatis.session.ResultHandler;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class FileVo implements ResultHandler{
	
	private static final Logger logger = LoggerFactory.getLogger(FileVo.class);
	
	public int fileSeq = 0;
	public Blob blobContent = null;
	public byte[] blobContentByte = null;
	public String fileName = null;
	public String  fileType = null;
	public int fileSize = 0; 
	public String fileExt = null;
	public String fileDesc = null;
	public String tmpCol1 = null;
	public String tmpCol2 = null;
	public String tmpCol3 = null;
	public String tmpCol4 = null;
	public String tmpCol5 = null; 
	
	@Override
	public void handleResult(ResultContext resultContext) {
		 
		CommonMap rsltMap = (CommonMap)resultContext.getResultObject(); 
		this.fileSeq      = Integer.parseInt(""+rsltMap.get("file_seq"));
		this.blobContent  = (Blob)rsltMap.get("file_content");
		initBlobToByte(this.blobContent);  
		this.fileName     = (String)rsltMap.get("file_name");
		this.fileType     = (String)rsltMap.get("file_type");
		this.fileSize      = Integer.parseInt(""+rsltMap.get("file_size"));
		this.fileDesc     = (String)rsltMap.get("file_ext");
		this.tmpCol1      = (String)rsltMap.get("tmp_col1");
		this.tmpCol2      = (String)rsltMap.get("tmp_col2");
		this.tmpCol3      = (String)rsltMap.get("tmp_col3");
		this.tmpCol4      = (String)rsltMap.get("tmp_col4");
		this.tmpCol5      = (String)rsltMap.get("tmp_col5");  
	}
	
	public int getFileSeq() { return fileSeq; } 
	public void setFileSeq(int fileSeq) { this.fileSeq = fileSeq; }

	public Blob getBlobContent() { return blobContent; } 
	public void setBlobContent(Blob blobContent) { this.blobContent = blobContent; }
	
	public byte[] getBlobContentByte() { return blobContentByte; } 
	  
	public String getFileName() { return fileName; }
	public void setFileName(String fileName) { this.fileName = fileName; }

	public String getFileType() { return fileType; }
	public void setFileType(String fileType) { this.fileType = fileType; }

	public int getFileSize() { return fileSize; }
	public void setFileSize(int fileSize) { this.fileSize = fileSize; }

	public String getFileExt() { return fileExt; }
	public void setFileExt(String fileExt) { this.fileExt = fileExt; }

	public String getFileDesc() { return fileDesc; }
	public void setFileDesc(String fileDesc) { this.fileDesc = fileDesc; }

	public String getTmpCol1() { return tmpCol1; }
	public void setTmpCol1(String tmpCol1) { this.tmpCol1 = tmpCol1; }

	public String getTmpCol2() { return tmpCol2; }
	public void setTmpCol2(String tmpCol2) { this.tmpCol2 = tmpCol2; }

	public String getTmpCol3() { return tmpCol3; }
	public void setTmpCol3(String tmpCol3) { this.tmpCol3 = tmpCol3; }

	public String getTmpCol4() { return tmpCol4; } 
	public void setTmpCol4(String tmpCol4) {this.tmpCol4 = tmpCol4;}

	public String getTmpCol5() { return tmpCol5; } 
	public void setTmpCol5(String tmpCol5) { this.tmpCol5 = tmpCol5; }
	
	private void initBlobToByte(Blob blobContent){
		
		try {
			 ByteArrayOutputStream outs = new ByteArrayOutputStream();
			 InputStream ins = blobContent.getBinaryStream();
			 
			 int length = (int) blobContent.length();
			 byte[] buffer = new byte[1024];
			
			 while ((length = ins.read(buffer)) != -1) {
				outs.write(buffer, 0, length);
			 } 
			 ins.close();
			 outs.flush(); 
			 this.blobContentByte = outs.toByteArray(); 
			 outs.close(); 
		} catch (SQLException sqle) { 
			sqle.printStackTrace();
		} catch (IOException ioe) { 
			ioe.printStackTrace();
		}
		 
	}
  
}