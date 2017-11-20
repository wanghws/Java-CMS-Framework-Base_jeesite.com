/**
 * Copyright &copy; 2017 demo.com All rights reserved.
 */
package com.demo.cms.modules.sys.controller;

import com.demo.cms.commons.utils.Page;
import com.demo.cms.commons.web.BaseController;
import com.demo.cms.modules.sys.entity.Notify;
import com.demo.cms.modules.sys.service.NotifyService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 通知通告Controller
 * @author demo.com
 * @version 2017-06-01
 */
@Controller
@RequestMapping(value = "/oa/oaNotify")
public class NotifyController extends BaseController {

	@Autowired
	private NotifyService oaNotifyService;

	@ModelAttribute
	public Notify get(@RequestParam(required=false) Long id) {
		Notify entity = null;
		if (null!=id){
			entity = oaNotifyService.get(id);
		}
		if (entity == null){
			entity = new Notify();
		}
		return entity;
	}

	@RequiresPermissions("oa:oaNotify:view")
	@RequestMapping(value = {"list", ""})
	public String list(Notify notify, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Notify> page = oaNotifyService.find(new Page<Notify>(request, response), notify);
		model.addAttribute("page", page);
		return "modules/sys/oaNotifyList";
	}

	@RequiresPermissions("oa:oaNotify:view")
	@RequestMapping(value = "form")
	public String form(Notify notify, Model model) {
		if (null==notify.getId()){
			notify = oaNotifyService.getRecordList(notify);
		}
		model.addAttribute("oaNotify", notify);
		return "modules/sys/oaNotifyForm";
	}

	@RequiresPermissions("oa:oaNotify:edit")
	@RequestMapping(value = "save")
	public String save(Notify notify, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, notify)){
			return form(notify, model);
		}
		// 如果是修改，则状态为已发布，则不能再进行操作
		if (null==notify.getId()){
			Notify e = oaNotifyService.get(notify.getId());
			if ("1".equals(e.getStatus())){
				addMessage(redirectAttributes, "已发布，不能操作！");
				return "redirect:"  + "/oa/oaNotify/form?id="+ notify.getId();
			}
		}
		oaNotifyService.save(notify);
		addMessage(redirectAttributes, "保存通知'" + notify.getTitle() + "'成功");
		return "redirect:"  + "/oa/oaNotify/?repage";
	}

	@RequiresPermissions("oa:oaNotify:edit")
	@RequestMapping(value = "delete")
	public String delete(Notify notify, RedirectAttributes redirectAttributes) {
		oaNotifyService.delete(notify);
		addMessage(redirectAttributes, "删除通知成功");
		return "redirect:"  + "/oa/oaNotify/?repage";
	}

	/**
	 * 我的通知列表
	 */
	@RequestMapping(value = "self")
	public String selfList(Notify notify, HttpServletRequest request, HttpServletResponse response, Model model) {
		notify.setSelf(true);
		Page<Notify> page = oaNotifyService.find(new Page<Notify>(request, response), notify);
		model.addAttribute("page", page);
		return "modules/sys/oaNotifyList";
	}

	/**
	 * 我的通知列表-数据
	 */
	@RequiresPermissions("oa:oaNotify:view")
	@RequestMapping(value = "selfData")
	@ResponseBody
	public Page<Notify> listData(Notify notify, HttpServletRequest request, HttpServletResponse response, Model model) {
		notify.setSelf(true);
		Page<Notify> page = oaNotifyService.find(new Page<Notify>(request, response), notify);
		return page;
	}

	/**
	 * 查看我的通知
	 */
	@RequestMapping(value = "view")
	public String view(Notify notify, Model model) {
		if (null!=notify.getId()){
			oaNotifyService.updateReadFlag(notify);
			notify = oaNotifyService.getRecordList(notify);
			model.addAttribute("oaNotify", notify);
			return "modules/sys/oaNotifyForm";
		}
		return "redirect:"  + "/oa/oaNotify/self?repage";
	}

	/**
	 * 查看我的通知-数据
	 */
	@RequestMapping(value = "viewData")
	@ResponseBody
	public Notify viewData(Notify notify, Model model) {
		if (null==notify.getId()){
			oaNotifyService.updateReadFlag(notify);
			return notify;
		}
		return null;
	}
	
	/**
	 * 查看我的通知-发送记录
	 */
	@RequestMapping(value = "viewRecordData")
	@ResponseBody
	public Notify viewRecordData(Notify notify, Model model) {
		if (null==notify.getId()){
			notify = oaNotifyService.getRecordList(notify);
			return notify;
		}
		return null;
	}
	
	/**
	 * 获取我的通知数目
	 */
	@RequestMapping(value = "self/count")
	@ResponseBody
	public String selfCount(Notify notify, Model model) {
		notify.setSelf(true);
		notify.setReadFlag("0");
		return String.valueOf(oaNotifyService.findCount(notify));
	}
}