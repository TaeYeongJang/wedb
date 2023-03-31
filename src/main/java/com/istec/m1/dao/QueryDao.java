package com.istec.m1.dao;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.istec.m1.utils.CommonMap;
import com.istec.m1.utils.FileVo;

@Repository
public class QueryDao {
	
	@Autowired 
	@Resource(name="sqlSession") 
	private SqlSessionTemplate sqlsession;
	
	@Autowired 
	@Resource(name="sqlSession_rawris") 
	private SqlSessionTemplate sqlSession_rawris;
	
	@Autowired 
	@Resource(name="sqlSession_rims") 
	private SqlSessionTemplate sqlSession_rims;
	
	
	@Autowired 
	@Resource(name="sqlSession_postgreSQL") 
	private SqlSessionTemplate sqlSession_postgreSQL;
	

	private Logger logger = LoggerFactory.getLogger(QueryDao.class);
	 
	public List<CommonMap> select(String qid) {
		logger.debug("[DAO-SELECT] " + qid);
		return sqlsession.selectList(qid); 
	}
	
	public List<CommonMap> select_rims(String qid) {
		logger.debug("[DAO-SELECT] " + qid);
		return sqlSession_rims.selectList(qid); 
	}
	
	public List<CommonMap> select_rawris(String qid) {
		logger.debug("[DAO-SELECT] " + qid);
		return sqlSession_rawris.selectList(qid); 
	}
	
	public List<CommonMap> select_postgreSQL(String qid) {
		logger.debug("[DAO-SELECT] " + qid);
		return sqlSession_postgreSQL.selectList(qid); 
	}

	public List<CommonMap> select(String qid, CommonMap hashMap) {
		logger.debug("[DAO-SELECT] " + qid + ", " + hashMap);
		return sqlsession.selectList(qid, hashMap); 
	}
	
	public List<CommonMap> select_rims(String qid, CommonMap hashMap) {
		logger.debug("[DAO-SELECT] " + qid + ", " + hashMap);
		return sqlSession_rims.selectList(qid, hashMap); 
	}
	
	public List<CommonMap> select_rawris(String qid, CommonMap hashMap) {
		logger.debug("[DAO-SELECT] " + qid + ", " + hashMap);
		return sqlSession_rawris.selectList(qid, hashMap); 
	}
	
	public List<CommonMap> select_postgreSQL(String qid, CommonMap hashMap) {
		logger.debug("[DAO-SELECT] " + qid + ", " + hashMap);
		return sqlSession_postgreSQL.selectList(qid, hashMap); 
	}
	   

	public int insert(String qid, CommonMap hashMap) {
		logger.debug("[DAO-INSERT] " + qid + ", " + hashMap);
		return sqlsession.insert(qid, hashMap);
	}
	
	public FileVo selectBlobFile(String qid , CommonMap hashMap){
		FileVo rsltFileVo = new FileVo(); 
		sqlsession.select(qid, hashMap, rsltFileVo); 
		return rsltFileVo;
		
	} 

	public int delete(String qid, CommonMap hashMap) {
		logger.debug("[DAO-DELETE] " + qid + ", " + hashMap);
		return sqlsession.delete(qid, hashMap);
	}

	public int update(String qid, CommonMap hashMap) {
		logger.debug("[DAO-UPDATE] " + qid + ", " + hashMap);
		return sqlsession.update(qid, hashMap);
	}

	/**************************************************************************/

	public int insert(String qid, List<CommonMap> listMap) {
		logger.debug("[DAO-INSERT-LIST] " + qid + ", " + listMap);
		int result = 0;
		for (CommonMap item : listMap) {
			result += sqlsession.insert(qid, item);
		}
		return result;
	}
	
	/*
	 * public CommonMap insertString(String qid, CommonMap hashMap) {
	 * logger.debug("[DAO-INSERT-LIST] " + qid + ", " + hashMap); return
	 * sqlsession.insert(qid, hashMap);
	 * 
	 * }
	 */
	
	
	public int insertList(String qid, List<CommonMap> listMap) {
		logger.debug("[DAO-INSERT-LIST] " + qid + ", " + listMap);
		int result = 0;
		result += sqlsession.insert(qid, listMap);
		return result;
	}

	public int delete(String qid, List<CommonMap> listMap) {
		logger.debug("[DAO-DELETE-LIST] " + qid + ", " + listMap);
		int result = 0;
		for (CommonMap item : listMap) {
			result += sqlsession.delete(qid, item);
		}
		return result;
	}

	public int update(String qid, List<CommonMap> listMap) {
		logger.debug("[DAO-UPDATE-LIST] " + qid + ", " + listMap);
		int result = 0;
		for (CommonMap item : listMap) {
			result += sqlsession.update(qid, item);
		}
		
		return result;
	}
}
