/**
 * Copyright &copy; 2017 demo.com All rights reserved.
 */
package com.demo.cms.modules.gen.dao;

import com.demo.cms.commons.annotation.MyBatisDao;
import com.demo.cms.commons.dao.FrameworkDao;
import com.demo.cms.modules.gen.entity.GenTableColumn;

/**
 * 业务表字段DAO接口
 * @author demo.com
 * @version 2013-10-15
 */
@MyBatisDao
public interface GenTableColumnDao extends FrameworkDao<GenTableColumn> {
	
	public void deleteByGenTableId(Long genTableId);
}
