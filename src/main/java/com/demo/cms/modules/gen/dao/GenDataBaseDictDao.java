/**
 * Copyright &copy; 2017 demo.com All rights reserved.
 */
package com.demo.cms.modules.gen.dao;

import com.demo.cms.commons.annotation.MyBatisDao;
import com.demo.cms.modules.gen.entity.GenTable;
import com.demo.cms.commons.dao.FrameworkDao;
import com.demo.cms.modules.gen.entity.GenTableColumn;

import java.util.List;

/**
 * 业务表字段DAO接口
 * @author demo.com
 * @version 2013-10-15
 */
@MyBatisDao
public interface GenDataBaseDictDao extends FrameworkDao<GenTableColumn> {

	/**
	 * 查询表列表
	 * @param genTable
	 * @return
	 */
	List<GenTable> findTableList(GenTable genTable);

	/**
	 * 获取数据表字段
	 * @param genTable
	 * @return
	 */
	List<GenTableColumn> findTableColumnList(GenTable genTable);
	
	/**
	 * 获取数据表主键
	 * @param genTable
	 * @return
	 */
	List<String> findTablePK(GenTable genTable);
	
}
