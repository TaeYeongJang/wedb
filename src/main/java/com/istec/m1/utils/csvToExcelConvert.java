package com.istec.m1.utils;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;

import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class csvToExcelConvert {

	public static void main(String[] args) {
		try {
			
			String FilePath = "C:\\Users\\j\\Desktop\\test";
			File FileList = new File(FilePath);

			//해당 폴더의 전체 파일리스트 조회
			String fileList[] = FileList.list();
			
			//전체파일
			for(int i=0; i<fileList.length; i++){
				//파일명 조회
			    String csvFileAddress = FilePath+ "\\" + fileList[i];//csv file address
			    //System.out.println(fileList[i].lastIndexOf(".") + "   " + fileList[i].length());
			    String csvName = fileList[i].substring(fileList[i].lastIndexOf(".") + 1, fileList[i].length());
			    //System.out.println(csvName);
			    String xlsxName = fileList[i].substring(0, fileList[i].lastIndexOf(".") + 1);
			    System.out.println(xlsxName);
			    if("csv".equals(csvName)) {
			        String xlsxFileAddress = "C:\\Users\\j\\Desktop\\xlsx\\" + xlsxName + "xlsx"; //xlsx file address
					
					  System.out.println(xlsxFileAddress); 
					  System.out.println(csvFileAddress);
					 
			        
			        XSSFWorkbook workBook = new XSSFWorkbook();
			        XSSFSheet sheet = workBook.createSheet("sample");
			        String currentLine=null;
			        int RowNum=0;
			        BufferedReader br = new BufferedReader(new FileReader(csvFileAddress));
			        while ((currentLine = br.readLine()) != null) {
			            String str[] = currentLine.split(",");
			            //if(RowNum == 0 ) continue;
			            XSSFRow currentRow=sheet.createRow(RowNum);
			            //System.out.println("1111111" + RowNum);
			            for(int x=0;x<str.length;x++){
			            	if(str[x].indexOf(".") == 0) str[x] = "0" + str[x];
			                currentRow.createCell(x).setCellValue(str[x]);
			               
			            }
			            RowNum++;
			            //System.out.println("2222222222222222" + RowNum);
			            
			        }
	
			        FileOutputStream fileOutputStream =  new FileOutputStream(xlsxFileAddress);
			        workBook.write(fileOutputStream);
			        workBook.close();
			        fileOutputStream.close();
			        System.out.println("Done");  
			    }
			}   
	    } catch (Exception ex) {
	        System.out.println(ex.getMessage()+"Exception in try");
	    }
    }

}
