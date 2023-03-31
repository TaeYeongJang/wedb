package com.istec.m1.controller;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.EncryptedDocumentException;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.istec.m1.service.QueryService;
import com.istec.m1.utils.CommonMap;

//import jxl.Workbook;
import net.sf.jxls.exception.ParsePropertyException;
import net.sf.jxls.transformer.XLSTransformer;

@Controller
@RequestMapping(value = "/excel") 
public class ExcelController {
	
private static final Logger logger = LoggerFactory.getLogger(ExcelController.class);
	  
	@Autowired
	private QueryService queryService;
	 

	@RequestMapping(value="/templet", method= RequestMethod.POST)
	public void execelTemplet(Map<String,Object> modelMap , HttpServletRequest request, HttpServletResponse response) throws Exception {
		OutputStream os = null; 
		InputStream is = null; 
		CommonMap cMap       = new CommonMap(); 

		String sqlId         = request.getParameter("excelSql"); 
		String excelFileName = request.getParameter("excelFileName");
		String excelLocation = request.getParameter("excelLocation");
		
		Enumeration<String> e = request.getParameterNames();
		while (e.hasMoreElements()) {
			
			String key = e.nextElement();			    
			String value = request.getParameter(key);

			switch (key) {
				case "excelSql"			:
				case "excelFileName" 	:
				case "excelLocation" 	:
					break;
				default: cMap.put(key, value);	break;					
			}
		}
			
	    List<CommonMap> datalist = queryService.select(sqlId, cMap);
	    
	    List<CommonMap> corList =  new ArrayList<CommonMap>();
	    List<CommonMap> outList =  new ArrayList<CommonMap>();

	    if(excelLocation.indexOf("tot_reservoir_report.xls") > -1) {
	    	corList = queryService.select("cor_reservoir_report", cMap);
	    	outList = queryService.select("out_reservoir_report", cMap);	 
	    }
	     
	    String excelTempletPath = request.getSession().getServletContext().getRealPath("/exceldown");
    	is = new BufferedInputStream(new FileInputStream(excelTempletPath + excelLocation));  
    	os = response.getOutputStream(); 
    	
        if(excelLocation.indexOf("list_flux_sum_rsvr_daily_365.xlsx") > -1) {
        	SXSSFWorkbook sxssfWorkbook = null;
        	try {
                // 엑셀템플릿파일 지정 (지정안하고 빈 통합문서로도 가능)
                XSSFWorkbook xssfWorkbook = new XSSFWorkbook(is);
             
                // 엑셀템플릿파일에 쓰여질 부분 검색
                Sheet originSheet = xssfWorkbook.getSheetAt(0);
                Row headerRow = originSheet.getRow(1);
                Cell headerCell;
                int x = 2;
                int cnt = Integer.parseInt(cMap.getString("headCount"));
                for (int i = 1; i < cnt; i++) {
                	 headerCell = headerRow.getCell(i + 5 + x);
                	 headerCell.setCellValue(cMap.getString("head" + i));
                	 x++;
				}

                int rowNo = 2; //originSheet.getLastRowNum();
                // SXSSF 생성
                sxssfWorkbook = new SXSSFWorkbook(xssfWorkbook);
                Sheet sheet = sxssfWorkbook.getSheetAt(0);
                CommonMap tmp = new CommonMap();

                for (int i = 0; i < datalist.size(); i++) {
                	tmp = datalist.get(i);
                	
                	Row row = sheet.createRow(++rowNo);
                    // 엑셀 cell 생성 및 값 주입
                	Cell cell = row.createCell(0);
                    cell.setCellValue( String.valueOf(tmp.get("buseo_pname")) );
                    cell = row.createCell(1);
                    cell.setCellValue( ( "null".equals(String.valueOf(tmp.get("buseo_name"))) ) ? "" : String.valueOf(tmp.get("buseo_name")) );
                    cell = row.createCell(2);
                    cell.setCellValue( ( "null".equals(String.valueOf(tmp.get("rvr_name"))) ) ? "" : String.valueOf(tmp.get("rvr_name")) );
                    cell = row.createCell(3);
                    cell.setCellValue( ( "null".equals(String.valueOf(tmp.get("es_code_rvr"))) ) ? "" : String.valueOf(tmp.get("es_code_rvr")) );
                    cell = row.createCell(4);
                    cell.setCellValue( ( "null".equals(String.valueOf(tmp.get("equip_name"))) ) ? "" : String.valueOf(tmp.get("equip_name")) );
                    cell = row.createCell(5);
                    cell.setCellValue( ( "null".equals(String.valueOf(tmp.get("es_code_way"))) ) ? "" : String.valueOf(tmp.get("es_code_way")) );
                    cell = row.createCell(6);
                    cell.setCellValue( ( "null".equals(String.valueOf(tmp.get("m_code"))) ) ? "" : String.valueOf(tmp.get("m_code")) );
                    cell = row.createCell(7);
                    cell.setCellValue(String.valueOf(tmp.get("r00")));
                    cell = row.createCell(8);
                    cell.setCellValue(String.valueOf(tmp.get("c00")));
                    cell = row.createCell(9);
                    cell.setCellValue(String.valueOf(tmp.get("rate")));
                    int cellNum = 10;
                	for (int j = 1; j < 366; j++) {
                         cell = row.createCell( cellNum );
                         cell.setCellValue(String.valueOf(tmp.get("r" + String.format("%02d", j) )));
                         cellNum++;
                         cell = row.createCell( cellNum );
                         cell.setCellValue(String.valueOf(tmp.get("c" + String.format("%02d", j) )));
                         cellNum++; 
					}
				}
                
                response.setHeader("Content-Disposition", getXlsxHeaderAttachment(request , response , excelFileName));
        		response.setHeader("Set-Cookie", "fileDownload=true; path=/");
        		
        		sxssfWorkbook.write(os);
        		//os.close();
        		//is.close();
        		//sxssfWorkbook.dispose();
        	} catch (ParsePropertyException  | IOException ex) {
				/*
				 * response.setHeader("Set-Cookie", "fileDownload=false; path=/");
				 * response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
				 * response.setHeader("Content-Type","text/html; charset=utf-8"); os = null; is
				 * = null; sxssfWorkbook = null; try { os = response.getOutputStream(); byte[]
				 * data = new String("fail..").getBytes(); os.write(data, 0, data.length); }
				 * catch(Exception ignore) { ignore.printStackTrace(); } finally { if(os !=
				 * null) try { os.close(); } catch(Exception ignore) {} }
				 */

                logger.error("MakeExcel==>>"+ex.getMessage()); // System.out.println(ex);
            } finally {
    			if(os != null) try { os.close(); } catch (IOException ex) { 
    				logger.debug("ExcelController Output IO Exeception 발생" );
    			}
    			if(is != null) try { is.close(); } catch (IOException ex) {
    				logger.debug("ExcelController Input IO Exeception 발생" );
    			}
    			try { sxssfWorkbook.dispose(); } catch(Exception ignore) {} 
    		} 
        	
        }else {
        	try {
            	HashMap<String, Object> beans = new HashMap<String, Object>();
    		    beans.put("list" , datalist );
    		    if(excelLocation.indexOf("tot_reservoir_report.xls") > -1) {
        		    beans.put("list2" , corList );
        		    beans.put("list3" , outList );
        		}
    			beans.put("parm" , cMap );
            	XLSTransformer transformer = new XLSTransformer(); 
                
                Workbook resultWorkbook = transformer.transformXLS(is, beans);   
                resultWorkbook.getCreationHelper().createFormulaEvaluator().evaluateAll();

                response.setHeader("Content-Disposition", getXlsHeaderAttachment(request , response , excelFileName));
        		response.setHeader("Set-Cookie", "fileDownload=true; path=/");
        		
                resultWorkbook.write(os); 

	        } catch (ParsePropertyException | InvalidFormatException | IOException ex) {
	            logger.error("MakeExcel==>>"+ex.getMessage()); // System.out.println(ex);
	        } finally {
				if(os != null) try { os.close(); } catch (IOException ex) { 
					logger.debug("ExcelController Output IO Exeception 발생" );
				}
				if(is != null) try { is.close(); } catch (IOException ex) {
					logger.debug("ExcelController Input IO Exeception 발생" );
				}
			} 
        }   
	}


	@RequestMapping(value="/sample", method= RequestMethod.POST)
	public void execelSample(Map<String,Object> modelMap , HttpServletRequest request, HttpServletResponse response) throws IOException, EncryptedDocumentException, InvalidFormatException {

		try {
                // 조회정보 세팅 
				String excelFileName   = request.getParameter("excelFileName");
				String excelLocation = request.getParameter("excelLocation");  
				String excelTempletPath = request.getSession().getServletContext().getRealPath("/exceldown");
				  
				 
				String sampleExt = excelLocation.substring(excelLocation.lastIndexOf(".")+1);
				
				InputStream is = new BufferedInputStream(new FileInputStream(excelTempletPath + excelLocation));
				XLSTransformer transformer = new XLSTransformer(); 
	            Workbook resultWorkbook = transformer.transformXLS(is, new HashMap());
				
				
			    if("xls".equals(sampleExt)){
			    	response.setHeader("Content-Disposition", getXlsHeaderAttachment(request ,response , excelFileName)); 
			    }else if("xlsx".equals(sampleExt)){
			    	response.setHeader("Content-Disposition", getXlsxHeaderAttachment(request ,response , excelFileName)); 
			    }  
	    		
			    response.setHeader("Set-Cookie", "fileDownload=true; path=/"); 
	            OutputStream os = response.getOutputStream(); 
	            resultWorkbook.write(os); 
	            
	        } catch (ParsePropertyException | IOException ex) {
	            logger.error("MakeExcel==>>"+ex.getMessage()); // System.out.println(ex);
	        } 
				 
	}
	
	private String getXlsxHeaderAttachment(HttpServletRequest request , HttpServletResponse response , String fileName) throws UnsupportedEncodingException{ 
		response.setContentType("application/application/vnd.openxmlformats-officedocument.spreadsheetml.sheet; charset=utf-8");
		
  		String header = getBrowser(request);
  		String headAttachmentNm = "";
  		if (header.contains("MSIE")) { 
  		       String docName = URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+", "%20");   
  		       headAttachmentNm = "attachment;filename=" + docName + ".xlsx;"; 
  		} else if (header.contains("Firefox")) { 
  		       String docName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1"); 
  		       headAttachmentNm = "attachment; filename=\"" + docName + ".xlsx\""; 
  		} else if (header.contains("Opera")) { 
  		       String docName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1"); 
  		       headAttachmentNm = "attachment; filename=\"" + docName + ".xlsx\""; 
  		} else if (header.contains("Chrome")) { 
  		       String docName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1"); 
  		       headAttachmentNm = "attachment; filename=\"" + docName + ".xlsx\""; 
  		}
  		
  		return headAttachmentNm;
  	}
	
	private String getXlsHeaderAttachment(HttpServletRequest request, HttpServletResponse response  , String fileName) throws UnsupportedEncodingException{ 
		response.setContentType("application/vnd.ms-excel; charset=utf-8");
		
		String header = getBrowser(request);
		String headAttachmentNm = "";
		if (header.contains("MSIE")) { 
	        String docName = URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+", "%20");   
	        headAttachmentNm = "attachment;filename=" + docName + ".xls;"; 
		} else if (header.contains("Firefox")) { 
			String docName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1"); 
			headAttachmentNm = "attachment; filename=\"" + docName + ".xls\""; 
		} else if (header.contains("Opera")) { 
			String docName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1"); 
			headAttachmentNm = "attachment; filename=\"" + docName + ".xls\""; 
		} else if (header.contains("Chrome")) { 
			String docName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1"); 
			headAttachmentNm = "attachment; filename=\"" + docName + ".xls\""; 
		}
		
		return headAttachmentNm;
	}
  	
	private String getBrowser(HttpServletRequest request) {

          String header =request.getHeader("User-Agent"); 
          if (header.contains("MSIE") || header.contains("Trident")) return "MSIE"; 
          else if(header.contains("Chrome")) 						 return "Chrome";
          else if(header.contains("Opera"))  						 return "Opera"; 

          return "Firefox";
     }
}
