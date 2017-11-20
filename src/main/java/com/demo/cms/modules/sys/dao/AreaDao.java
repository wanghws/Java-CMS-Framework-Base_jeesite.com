/**
 * Copyright &copy; 2017 demo.com All rights reserved.
 */
package com.demo.cms.modules.sys.dao;

import com.demo.cms.commons.annotation.MyBatisDao;
import com.demo.cms.commons.dao.TreeDao;
import com.demo.cms.modules.sys.entity.Area;

/**
 * 区域DAO接口
 * @author demo.com
 * @version 2014-05-16
 */
@MyBatisDao
public interface AreaDao extends TreeDao<Area> {
	
}
