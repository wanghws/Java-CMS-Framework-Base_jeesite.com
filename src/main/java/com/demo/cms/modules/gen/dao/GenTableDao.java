/**
 * Copyright &copy; 2017 demo.com All rights reserved.
 */
package com.demo.cms.modules.gen.dao;

import com.demo.cms.commons.annotation.MyBatisDao;
import com.demo.cms.modules.gen.entity.GenTable;
import com.demo.cms.commons.dao.FrameworkDao;

/**
 * 业务表DAO接口
 * @author demo.com
 * @version 2013-10-15
 */
@MyBatisDao
public interface GenTableDao extends FrameworkDao<GenTable> {
	
}
