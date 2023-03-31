package com.istec.m1.utils;


import java.io.File;
import java.io.FileInputStream;

import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class ExcelInsert {

	
	/*
	 * @Autowired
	 * 
	 * @Resource(name="sqlSession") public static SqlSessionTemplate sqlsession;
	 */
	
	@SuppressWarnings("resource")
	public static void main(String[] args) {
		try {
			String FilePath = "C:\\Users\\j\\Desktop\\test\\";
			File FileList = new File(FilePath);

			//해당 폴더의 전체 파일리스트 조회
			String fileList[] = FileList.list();

			//전체파일
			for(int i=0; i<fileList.length; i++){
				//파일명 조회
			    String FileName = fileList[i];

				 FileInputStream file = new FileInputStream(FilePath+FileName);
		         XSSFWorkbook workbook = new XSSFWorkbook(file);
		
		         int rowindex=0;
		         int columnindex=0;
		         //시트 수 (첫번째에만 존재하므로 0을 준다)
		         //만약 각 시트를 읽기위해서는 FOR문을 한번더 돌려준다
		         XSSFSheet sheet=workbook.getSheetAt(0);
		         //행의 수
		         int rows=sheet.getPhysicalNumberOfRows();
		         for(rowindex=0;rowindex<rows;rowindex++){
		             //행을읽는다
		             XSSFRow row=sheet.getRow(rowindex);
		             if(row !=null){
		                 //셀의 수
		                 int cells=row.getPhysicalNumberOfCells();
		                 for(columnindex=0; columnindex<=cells; columnindex++){
		                     //셀값을 읽는다
		                     XSSFCell cell=row.getCell(columnindex);
		                     String value="";
		                     //셀이 빈값일경우를 위한 널체크
		                     if(cell==null){
		                         continue;
		                     }else{
		                         //타입별로 내용 읽기
		                         switch (cell.getCellType()){
		                         case XSSFCell.CELL_TYPE_FORMULA:
		                             value=cell.getCellFormula();
		                             break;
		                         case XSSFCell.CELL_TYPE_NUMERIC:
		                             value=cell.getNumericCellValue()+"";
		                             break;
		                         case XSSFCell.CELL_TYPE_STRING:
		                             value=cell.getStringCellValue()+"";
		                             break;
		                         case XSSFCell.CELL_TYPE_BLANK:
		                             value=cell.getBooleanCellValue()+"";
		                             break;
		                         case XSSFCell.CELL_TYPE_ERROR:
		                             value=cell.getErrorCellValue()+"";
		                             break;
		                         }
		                     }
		                     System.out.println(rowindex+"번 행 : "+columnindex+"번 열 값은: "+value);
		                 }
		
		             }
		         }
			}
	     }catch(Exception e) {
	         e.printStackTrace();
	     }

    }

}
