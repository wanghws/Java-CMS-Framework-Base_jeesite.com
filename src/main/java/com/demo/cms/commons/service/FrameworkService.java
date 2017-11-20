/**
 * Copyright &copy; 2017 demo.com All rights reserved.
 */
package com.demo.cms.commons.service;

import com.demo.cms.commons.dao.FrameworkDao;
import com.demo.cms.commons.entity.FrameworkEntity;
import com.demo.cms.commons.utils.Page;
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
		if (null==entity.getId()){
			try{
				entity.nextId();
			}catch (Exception e){
				e.printStackTrace();
			}
			entity.setCreateTime(new Date());
			entity.setCreateUser(UserUtils.getUser().getId());

			//
			entity.setCreateDate(new Date());
			entity.setCreateBy(UserUtils.getUser());
			entity.setUpdateDate(new Date());
			entity.setUpdateBy(UserUtils.getUser());

			dao.insert(entity);
			return;
		}
		entity.setUpdateTime(new Date());
		//
		entity.setUpdateDate(new Date());
		entity.setUpdateBy(UserUtils.getUser());

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
