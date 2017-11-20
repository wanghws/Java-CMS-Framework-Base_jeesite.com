/**
 * Copyright &copy; 2017 demo.com All rights reserved.
 */
package com.demo.cms.modules.sys.dao;

import com.demo.cms.commons.annotation.MyBatisDao;
import com.demo.cms.commons.dao.FrameworkDao;
import com.demo.cms.modules.sys.entity.Dict;

import java.util.List;

/**
 * 字典DAO接口
 * @author demo.com
 * @version 2014-05-16
 */
@MyBatisDao
public interface DictDao extends FrameworkDao<Dict> {

	public List<String> findTypeList(Dict dict);
	
}
