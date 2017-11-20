/**
 * Copyright &copy; 2017 demo.com All rights reserved.
 */
package com.demo.cms.modules.sys.service;

import com.demo.cms.commons.utils.Page;
import com.demo.cms.commons.service.FrameworkService;
import com.demo.cms.commons.utils.DateUtils;
import com.demo.cms.modules.sys.dao.LogDao;
import com.demo.cms.modules.sys.entity.Log;
import org.springframework.stereotype.Service;

/**
 * 日志Service
 * @author demo.com
 * @version 2014-05-16
 */
@Service
public class LogService extends FrameworkService<LogDao, Log> {

	public Page<Log> findPage(Page<Log> page, Log log) {
		
		// 设置默认时间范围，默认当前月
		if (log.getBeginDate() == null){
			log.setBeginDate(DateUtils.setDays(DateUtils.parseDate(DateUtils.getDate()), 1));
		}
		if (log.getEndDate() == null){
			log.setEndDate(DateUtils.addMonths(log.getBeginDate(), 1));
		}
		
		return super.findPage(page, log);
		
	}
	
}
