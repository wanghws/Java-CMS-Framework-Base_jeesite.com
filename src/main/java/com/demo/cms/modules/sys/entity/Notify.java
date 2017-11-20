/**
 * Copyright &copy; 2017 demo.com All rights reserved.
 */
package com.demo.cms.modules.sys.entity;

import com.demo.cms.commons.entity.FrameworkEntity;
import com.demo.cms.commons.utils.Collections3;
import com.demo.cms.commons.utils.StringUtils;
import com.demo.cms.commons.utils.IdWorker;
import com.google.common.collect.Lists;
import org.hibernate.validator.constraints.Length;

import java.util.List;

/**
 * 通知通告Entity
 * @author demo.com
 * @version 2014-05-16
 */
public class Notify extends FrameworkEntity<Notify> {
	
	private static final long serialVersionUID = 1L;
	private String type;		// 类型
	private String title;		// 标题
	private String content;		// 类型
	private String files;		// 附件
	private String status;		// 状态

	private String readNum;		// 已读
	private String unReadNum;	// 未读
	
	private boolean isSelf;		// 是否只查询自己的通知
	
	private String readFlag;	// 本人阅读状态
	
	private List<NotifyRecord> notifyRecordList = Lists.newArrayList();
	
	public Notify() {
		super();
	}

	public Notify(Long id){
		super(id);
	}

	@Length(min=0, max=200, message="标题长度必须介于 0 和 200 之间")
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	@Length(min=0, max=1, message="类型长度必须介于 0 和 1 之间")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}


	public void setStatus(String status) {
		this.status = status;
	}
	
	@Length(min=0, max=2000, message="附件长度必须介于 0 和 2000 之间")
	public String getFiles() {
		return files;
	}

	public void setFiles(String files) {
		this.files = files;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getReadNum() {
		return readNum;
	}

	public void setReadNum(String readNum) {
		this.readNum = readNum;
	}

	public String getUnReadNum() {
		return unReadNum;
	}

	public void setUnReadNum(String unReadNum) {
		this.unReadNum = unReadNum;
	}
	
	public List<NotifyRecord> getNotifyRecordList() {
		return notifyRecordList;
	}

	public void setNotifyRecordList(List<NotifyRecord> notifyRecordList) {
		this.notifyRecordList = notifyRecordList;
	}
	
	/**
	 * 获取通知发送记录用户ID
	 * @return
	 */
	public String getOaNotifyRecordIds() {
		return Collections3.extractToString(notifyRecordList, "user.id", ",") ;
	}
	
	/**
	 * 设置通知发送记录用户ID
	 * @return
	 */
	public void setOaNotifyRecordIds(String oaNotifyRecord) {
		this.notifyRecordList = Lists.newArrayList();
		for (String id : StringUtils.split(oaNotifyRecord, ",")){
			NotifyRecord entity = new NotifyRecord();
			try{
				entity.setId(IdWorker.getFlowIdWorkerInstance().nextId());
			}catch(Exception e){
				e.printStackTrace();
			}

			entity.setNotify(this);
			entity.setUser(new User(Long.parseLong(id)));
			entity.setReadFlag("0");
			this.notifyRecordList.add(entity);
		}
	}

	/**
	 * 获取通知发送记录用户Name
	 * @return
	 */
	public String getOaNotifyRecordNames() {
		return Collections3.extractToString(notifyRecordList, "user.name", ",") ;
	}
	
	/**
	 * 设置通知发送记录用户Name
	 * @return
	 */
	public void setOaNotifyRecordNames(String oaNotifyRecord) {
		// 什么也不做
	}

	public boolean isSelf() {
		return isSelf;
	}

	public void setSelf(boolean isSelf) {
		this.isSelf = isSelf;
	}

	public String getReadFlag() {
		return readFlag;
	}

	public void setReadFlag(String readFlag) {
		this.readFlag = readFlag;
	}
}