package com.throne212.info168.web.biz;

import java.util.List;


public interface BaseBiz {

	public <T> List<T> getAll(Class<T> clazz);
	public <T> List<T> getAll(Class<T> clazz,String col,String orderType);
	public <T> T getEntityById(Class<T> clazz,Long id);
	public <T> T getEntityByUnique(Class<T> clazz,String col,Object val);
	
	public void saveOrUpdateEntity(Object e);
	
	public <T>  boolean checkUnique(Class<T> clazz,String colName,Object value);
	
	public <T>  void deleteEntity(Class<T> clazz,Long id);
	
	public Long getEntitySum(Class clazz);
	
}
