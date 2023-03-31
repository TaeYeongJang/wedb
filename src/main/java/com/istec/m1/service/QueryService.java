package com.istec.m1.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.istec.m1.controller.QueryConroller;
import com.istec.m1.dao.QueryDao;
import com.istec.m1.utils.CommonMap;
import com.istec.m1.utils.FileVo;

@Service
public class QueryService {

	private Logger logger = LoggerFactory.getLogger(QueryConroller.class);
	
	@Autowired
    private QueryDao queryDao;
 
	
	public List<CommonMap> select(String qid) {
		long start_time = 0;
		long end_time = 0;
		List<CommonMap> rst = null;
		
		start_time = System.currentTimeMillis();
		rst = queryDao.select(qid);
		end_time = System.currentTimeMillis();
		
		if(end_time - start_time > 600000) {
			System.out.println(qid + " // time : " + (end_time - start_time)/1000 + "sec");
		}
		
    	return rst;
    }
	
	public List<CommonMap> select_rims(String qid) {
		long start_time = 0;
		long end_time = 0;
		List<CommonMap> rst = null;
		
		start_time = System.currentTimeMillis();
		rst = queryDao.select_rims(qid);
		end_time = System.currentTimeMillis();
		
		if(end_time - start_time > 600000) {
			System.out.println(qid + " // time : " + (end_time - start_time)/1000 + "sec");
		}
		
    	return rst;
    }
	
	public List<CommonMap> select_rawris(String qid) {
		long start_time = 0;
		long end_time = 0;
		List<CommonMap> rst = null;
		
		start_time = System.currentTimeMillis();
		rst = queryDao.select_rawris(qid);
		end_time = System.currentTimeMillis();
		
		if(end_time - start_time > 600000) {
			System.out.println(qid + " // time : " + (end_time - start_time)/1000 + "sec");
		}
		
    	return rst;
    }
	
	public List<CommonMap> select_postgreSQL(String qid) {
		long start_time = 0;
		long end_time = 0;
		List<CommonMap> rst = null;
		
		start_time = System.currentTimeMillis();
		rst = queryDao.select_postgreSQL(qid);
		end_time = System.currentTimeMillis();
		
		if(end_time - start_time > 600000) {
			System.out.println(qid + " // time : " + (end_time - start_time)/1000 + "sec");
		}
		
    	return rst;
    }

	public List<CommonMap> select(String qid,CommonMap hashMap) {
		long start_time = 0;
		long end_time = 0;
		List<CommonMap> rst = null;
		
		start_time = System.currentTimeMillis();
		try {
				rst = queryDao.select(qid, hashMap);
		} catch (Exception e) {
			end_time = System.currentTimeMillis();
			logger.info("error_check select.catch: "+ qid + " // time : " + (end_time - start_time)/1000 + "sec");
			logger.error(e.getMessage());
		}

		end_time = System.currentTimeMillis();
		
		if(end_time - start_time > 600000) {
			logger.info("error_check select.600000: "+ qid + " // time : " + (end_time - start_time)/1000 + "sec");
		}

		return rst;
    } 
	
	public List<CommonMap> select_rims(String qid,CommonMap hashMap) {
		long start_time = 0;
		long end_time = 0;
		List<CommonMap> rst = null;
		
		start_time = System.currentTimeMillis();
		try {
				rst = queryDao.select_rims(qid, hashMap);
		} catch (Exception e) {
			end_time = System.currentTimeMillis();
			logger.info("error_check select.catch: "+ qid + " // time : " + (end_time - start_time)/1000 + "sec");
			logger.error(e.getMessage());
		}

		end_time = System.currentTimeMillis();
		
		if(end_time - start_time > 600000) {
			logger.info("error_check select.600000: "+ qid + " // time : " + (end_time - start_time)/1000 + "sec");
		}

		return rst;
    }
	
	public List<CommonMap> select_rawris(String qid,CommonMap hashMap) {
		long start_time = 0;
		long end_time = 0;
		List<CommonMap> rst = null;
		
		start_time = System.currentTimeMillis();
		try {
				rst = queryDao.select_rawris(qid, hashMap);
		} catch (Exception e) {
			end_time = System.currentTimeMillis();
			logger.info("error_check select.catch: "+ qid + " // time : " + (end_time - start_time)/1000 + "sec");
			logger.error(e.getMessage());
		}

		end_time = System.currentTimeMillis();
		
		if(end_time - start_time > 600000) {
			logger.info("error_check select.600000: "+ qid + " // time : " + (end_time - start_time)/1000 + "sec");
		}

		return rst;
    }
	
	public List<CommonMap> select_postgreSQL(String qid,CommonMap hashMap) {
		long start_time = 0;
		long end_time = 0;
		List<CommonMap> rst = null;
		
		start_time = System.currentTimeMillis();
		try {
				rst = queryDao.select_postgreSQL(qid, hashMap);
		} catch (Exception e) {
			end_time = System.currentTimeMillis();
			logger.info("error_check select.catch: "+ qid + " // time : " + (end_time - start_time)/1000 + "sec");
			logger.error(e.getMessage());
		}

		end_time = System.currentTimeMillis();
		
		if(end_time - start_time > 600000) {
			logger.info("error_check select.600000: "+ qid + " // time : " + (end_time - start_time)/1000 + "sec");
		}

		return rst;
    }
	
	public FileVo selectBlobFile(CommonMap hashMap) {
		return queryDao.selectBlobFile("rawris.wrms.common.file.inq_krc_blob_file", hashMap);
	}

	public int insert(String qid, CommonMap hashMap) {
    	return queryDao.insert(qid, hashMap);
    }

	public int update(String qid, CommonMap hashMap) {
    	return queryDao.update(qid, hashMap);
    }
	
	public int delete(String qid, CommonMap hashMap) {
    	return queryDao.delete(qid, hashMap);
    }


	public int insert(String qid, List<CommonMap> listMap) {
		return queryDao.insert(qid, listMap);
    }
	public int update(String qid, List<CommonMap> listMap) {
		return queryDao.update(qid, listMap);
    }
	public int delete(String qid, List<CommonMap> listMap) {
		return queryDao.delete(qid, listMap);
    }
}
