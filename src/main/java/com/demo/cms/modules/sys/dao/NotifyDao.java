/**
 * Copyright &copy; 2017 demo.com All rights reserved.
 */
package com.demo.cms.modules.sys.dao;

import com.demo.cms.commons.annotation.MyBatisDao;
import com.demo.cms.commons.dao.FrameworkDao;
import com.demo.cms.modules.sys.entity.Notify;

/**
 * 通知通告DAO接口
 * @author demo.com
 * @version 2014-05-16
 */
@MyBatisDao
public interface NotifyDao extends FrameworkDao<Notify> {
	
	/**
	 * 获取通知数目
	 * @param notify
	 * @return
	 */
	public Long findCount(Notify notify);
	
}