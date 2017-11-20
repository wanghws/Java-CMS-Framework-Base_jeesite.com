/**
 * Copyright &copy; 2017 demo.com All rights reserved.
 */
package com.demo.cms.modules.sys.service;

import com.demo.cms.modules.sys.utils.UserUtils;
import com.demo.cms.commons.service.TreeService;
import com.demo.cms.modules.sys.dao.OfficeDao;
import com.demo.cms.modules.sys.entity.Office;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * 机构Service
 * @author demo.com
 * @version 2014-05-16
 */
@Service
public class OfficeService extends TreeService<OfficeDao, Office> {

	public List<Office> findAll(){
		return dao.findAllList(new Office());
//		User user = UserUtils.getUser();
//		if (user.isAdmin()){
//			return dao.findAllList(new Office());
//		}else{
//			Office office = new Office();
//			office.getSqlMap().put("dsf", BaseService.dataScopeFilter(user, "a", ""));
//			return  dao.findList(office);
//		}
	}

	/**
	 * 查询emp
	 * @author Ashon
	 * @version 2017-06-07
	 */
	public List<Office> findEmployeeList(){
		return dao.findEmployeeList(new Office());
	}

	/**
	 * 查询学员
	 * @return
	 */
	public List<Office> findStudentList(){
		return dao.findStudentList(new Office());
	}

	public List<Office> findList(Boolean isAll){
		if (isAll != null && isAll){
			return dao.findAllList(new Office());
		}else{
			return findAll();
		}
	}
	

	public List<Office> findList(Office office){
		if(office != null){
			office.setParentIds(office.getParentIds());
			return dao.findByParentIdsLike(office);
		}
		return  new ArrayList<Office>();
	}
	
	@Transactional(readOnly = false)
	public void save(Office office) {
		super.save(office);
		UserUtils.removeCache(UserUtils.CACHE_OFFICE_LIST);
	}
	
	@Transactional(readOnly = false)
	public void delete(Office office) {
		super.delete(office);
		UserUtils.removeCache(UserUtils.CACHE_OFFICE_LIST);
	}

	public int findChildsByParentId(Office office){
		return dao.findChildsByParentId(office);
	}
	public int findUsersByParentId(Office office){
		return dao.findUsersByParentId(office);
	}

}
