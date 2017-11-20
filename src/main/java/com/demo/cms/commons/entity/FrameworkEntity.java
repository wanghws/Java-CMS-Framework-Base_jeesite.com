/**
 * Copyright &copy; 2017 demo.com All rights reserved.
 */
package com.demo.cms.commons.entity;

import com.demo.cms.modules.sys.entity.User;
import com.demo.cms.commons.utils.IdWorker;
import com.demo.cms.modules.sys.utils.UserUtils;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import org.hibernate.validator.constraints.Length;

import java.util.Date;

/**
 * 数据Entity类
 * @author demo.com
 * @version 2014-05-16
 */
public abstract class FrameworkEntity<T> extends BaseEntity<T> {
	
	protected String remarks;	// 备注
	protected User createBy;	// 创建者
	protected Date createDate;	// 创建日期
	protected User updateBy;	// 更新者
	protected Date updateDate;	// 更新日期
	protected String delFlag; 	// 删除标记（0：正常；1：删除；2：审核）

	//new
	protected Long createUser;	// 创建者
	protected Date createTime;	// 创建日期
	protected Date updateTime;	// 更新日期
	protected Integer status;	// 状态


	public FrameworkEntity() {
		super();
		this.delFlag = DEL_FLAG_NORMAL;
	}
	
	public FrameworkEntity(Long id) {
		super(id);
	}

	public void nextId()throws Exception{
		this.id = IdWorker.getFlowIdWorkerInstance().nextId();
	}
	
	@Length(min=0, max=255)
	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
	@JsonIgnore
	public User getCreateBy() {
		return createBy;
	}

	public void setCreateBy(User createBy) {
		this.createBy = createBy;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	@JsonIgnore
	public User getUpdateBy() {
		return updateBy;
	}

	public void setUpdateBy(User updateBy) {
		this.updateBy = updateBy;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	@JsonIgnore
	@Length(min=1, max=1)
	public String getDelFlag() {
		return delFlag;
	}

	public void setDelFlag(String delFlag) {
		this.delFlag = delFlag;
	}


	/**
	 * 兼容性方法
	 * */
	public void preInsert(){
		// 不限制ID为UUID，调用setIsNewRecord()使用自定义ID
		if (null==getId()){
			try{
				setId(IdWorker.getFlowIdWorkerInstance().nextId());
			}catch (Exception e){
				e.printStackTrace();
			}
		}
		User user = UserUtils.getUser();
		if (null!=user.getId()){
			this.updateBy = user;
			this.createBy = user;
		}
		this.updateDate = new Date();
		this.createDate = this.updateDate;
	}

	public void preUpdate(){
		User user = UserUtils.getUser();
		if (null!=user.getId()){
			this.updateBy = user;
		}
		this.updateDate = new Date();
	}



	public Long getCreateUser() {
		return createUser;
	}

	public void setCreateUser(Long createUser) {
		this.createUser = createUser;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}
}
