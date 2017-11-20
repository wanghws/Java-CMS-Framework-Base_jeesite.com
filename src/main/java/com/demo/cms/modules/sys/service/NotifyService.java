/**
 * Copyright &copy; 2017 demo.com All rights reserved.
 */
package com.demo.cms.modules.sys.service;

import com.demo.cms.commons.service.FrameworkService;
import com.demo.cms.commons.utils.Page;
import com.demo.cms.modules.sys.dao.NotifyRecordDao;
import com.demo.cms.modules.sys.entity.Notify;
import com.demo.cms.modules.sys.entity.NotifyRecord;
import com.demo.cms.modules.sys.dao.NotifyDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;

/**
 * 通知通告Service
 * @author demo.com
 * @version 2014-05-16
 */
@Service
public class NotifyService extends FrameworkService<NotifyDao, Notify> {

	@Autowired
	private NotifyRecordDao notifyRecordDao;

	public Notify get(Long id) {
		Notify entity = dao.get(id);
		return entity;
	}
	
	/**
	 * 获取通知发送记录
	 * @param notify
	 * @return
	 */
	public Notify getRecordList(Notify notify) {
		notify.setNotifyRecordList(notifyRecordDao.findList(new NotifyRecord(notify)));
		return notify;
	}
	
	public Page<Notify> find(Page<Notify> page, Notify notify) {
		notify.setPage(page);
		page.setList(dao.findList(notify));
		return page;
	}
	
	/**
	 * 获取通知数目
	 * @param notify
	 * @return
	 */
	public Long findCount(Notify notify) {
		return dao.findCount(notify);
	}
	
	@Transactional(readOnly = false)
	public void save(Notify notify) {
		super.save(notify);
		
		// 更新发送接受人记录
		notifyRecordDao.deleteByOaNotifyId(notify.getId());
		if (notify.getNotifyRecordList().size() > 0){
			notifyRecordDao.insertAll(notify.getNotifyRecordList());
		}
	}
	
	/**
	 * 更新阅读状态
	 */
	@Transactional(readOnly = false)
	public void updateReadFlag(Notify notify) {
		NotifyRecord notifyRecord = new NotifyRecord(notify);
		notifyRecord.setUser(notifyRecord.getCurrentUser());
		notifyRecord.setReadDate(new Date());
		notifyRecord.setReadFlag("1");
		notifyRecordDao.update(notifyRecord);
	}
}