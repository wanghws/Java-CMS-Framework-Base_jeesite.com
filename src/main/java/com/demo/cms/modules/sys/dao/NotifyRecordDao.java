/**
 * Copyright &copy; 2017 demo.com All rights reserved.
 */
package com.demo.cms.modules.sys.dao;

import com.demo.cms.commons.annotation.MyBatisDao;
import com.demo.cms.modules.sys.entity.NotifyRecord;
import com.demo.cms.commons.dao.FrameworkDao;

import java.util.List;

/**
 * 通知通告记录DAO接口
 * @author demo.com
 * @version 2014-05-16
 */
@MyBatisDao
public interface NotifyRecordDao extends FrameworkDao<NotifyRecord> {

	/**
	 * 插入通知记录
	 * @param notifyRecordList
	 * @return
	 */
	public int insertAll(List<NotifyRecord> notifyRecordList);
	
	/**
	 * 根据通知ID删除通知记录
	 * @param oaNotifyId 通知ID
	 * @return
	 */
	public int deleteByOaNotifyId(Long oaNotifyId);
	
}