/**
 * Copyright &copy; 2017 demo.com All rights reserved.
 */
package com.demo.cms.commons.service;

import com.demo.cms.commons.dao.FrameworkDao;
import com.demo.cms.commons.entity.FrameworkEntity;
import com.demo.cms.commons.status.Status;
import com.demo.cms.commons.utils.Page;
import com.demo.cms.modules.sys.entity.User;
import com.demo.cms.modules.sys.utils.UserUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

/**
 * Service基类
 * @author demo.com
 * @version 2014-05-16
 */

public abstract class FrameworkService<D extends FrameworkDao<T>, T extends FrameworkEntity<T>> extends BaseService {
	
	/**
	 * 持久层对象
	 */
	@Autowired
	protected D dao;
	
	/**
	 * 获取单条数据
	 * @param id
	 * @return
	 */
	public T get(Long id) {
		return dao.get(id);
	}
	
	/**
	 * 获取单条数据
	 * @param entity
	 * @return
	 */
	public T get(T entity) {
		return dao.get(entity);
	}
	
	/**
	 * 查询列表数据
	 * @param entity
	 * @return
	 */
	public List<T> findList(T entity) {
		return dao.findList(entity);
	}
	
	/**
	 * 查询分页数据
	 * @param page 分页对象
	 * @param entity
	 * @return
	 */
	public Page<T> findPage(Page<T> page, T entity) {
		entity.setPage(page);
		page.setList(dao.findList(entity));
		return page;
	}

	/**
	 * 保存数据（插入或更新）
	 * @param entity
	 */
	@Transactional()
	public void save(T entity) {
		Date now = new Date();
		User user = UserUtils.getUser();
		if (null==entity.getId()){
			try{
				entity.nextId();
			}catch (Exception e){
				e.printStackTrace();
			}
			if(null==entity.getCreateTime()) entity.setCreateTime(now);
			if(null==entity.getUpdateTime()) entity.setUpdateTime(now);
			if(null==entity.getUpdateDate()) entity.setUpdateDate(now);
			if(null==entity.getCreateDate()) entity.setCreateDate(now);

			if (null==entity.getStatus())entity.setStatus(Status.NORMAL.getValue());

			if(null==entity.getCreateUser() || null == entity.getCreateUser().getId())entity.setCreateUser(user.getId()==null?new User(1L):user);
			if(null==entity.getCreateBy() || null==entity.getCreateBy().getId())entity.setCreateBy(user.getId()==null?new User(1L):user);
			if(null==entity.getUpdateBy() || null == entity.getUpdateBy().getId())entity.setUpdateBy(user.getId()==null?new User(1L):user);
			if(null==entity.getUpdateUser() || null==entity.getUpdateUser().getId())entity.setUpdateUser(user.getId()==null?new User(1L):user);

			dao.insert(entity);
			return;
		}
		entity.setUpdateTime(now);
		if (null==entity.getUpdateUser() || null==entity.getUpdateUser().getId())entity.setUpdateUser(user.getId()==null?new User(1L):user);
		//
		entity.setUpdateDate(now);
		if (null==entity.getUpdateBy() || null==entity.getUpdateBy().getId())entity.setUpdateBy(user.getId()==null?new User(1L):user);

		this.update(entity);
	}
	@Transactional()
	public void update(T entity) {
		dao.update(entity);
	}
	/**
	 * 删除数据
	 * @param entity
	 */
	@Transactional()
	public void delete(T entity) {
		dao.delete(entity);
	}

}
