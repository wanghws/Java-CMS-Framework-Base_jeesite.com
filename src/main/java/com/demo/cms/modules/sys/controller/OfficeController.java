/**
 * Copyright &copy; 2017 demo.com All rights reserved.
 */
package com.demo.cms.modules.sys.controller;

import com.demo.cms.commons.config.Global;
import com.demo.cms.commons.utils.StringUtils;
import com.demo.cms.commons.web.BaseController;
import com.demo.cms.modules.sys.entity.Office;
import com.demo.cms.modules.sys.entity.User;
import com.demo.cms.modules.sys.service.OfficeService;
import com.demo.cms.modules.sys.utils.DictUtils;
import com.demo.cms.modules.sys.utils.UserUtils;
import com.google.common.base.Strings;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 机构Controller
 * @author demo.com
 * @version 2013-5-15
 */
@Controller
@RequestMapping(value = "/sys/office")
public class OfficeController extends BaseController {

	@Autowired
	private OfficeService officeService;
	
	@ModelAttribute("office")
	public Office get(@RequestParam(required=false) Long id) {
		if (null!=id){
			return officeService.get(id);
		}else{
			return new Office();
		}
	}

	@RequiresPermissions("sys:office:view")
	@RequestMapping(value = {""})
	public String index(Office office, Model model) {
		return "modules/sys/officeIndex";
	}

	@RequiresPermissions("sys:office:view")
	@RequestMapping(value = {"list"})
	public String list(Office office, Model model) {
		if (Strings.isNullOrEmpty(office.getParentIds())){
			User user = UserUtils.getUser();
			if (user.isAdmin()){
				model.addAttribute("list", toList(officeService.findAll()));
				return "modules/sys/officeList";
			}
			office.setParentIds(user.getOffice().getParentIds());
		}



		List<Office> list = officeService.findList(office);
        model.addAttribute("list",toList(list) );
		return "modules/sys/officeList";
	}

	public List toList(List<Office> list){
		List<Map<String, Object>> mapList = Lists.newArrayList();
		Map<String, Object> row = null;
		for(Office record:list){
			row = new HashMap<>();
			row.put("id",String.valueOf(record.getId()));
			row.put("parentId",String.valueOf(record.getParentId()));
			row.put("pIds", record.getParentIds());
			row.put("name", record.getName());
			row.put("code", record.getCode());
			row.put("type",record.getType());
			row.put("areaName",record.getArea().getName());
			row.put("remarks", record.getRemarks());
			mapList.add(row);
		}
		return mapList;
	}
	
	@RequiresPermissions("sys:office:view")
	@RequestMapping(value = "form")
	public String form(Office office, Model model) {
		User user = UserUtils.getUser();
		if (office.getParent()==null || office.getParent().getId()==null){
			office.setParent(user.getOffice());
		}
		office.setParent(officeService.get(office.getParent().getId()));
		if (office.getArea()==null){
			office.setArea(user.getOffice().getArea());
		}
		// 自动获取排序号
		if (null==office.getId()&&office.getParent()!=null){
			int size = 0;
			List<Office> list = officeService.findAll();
			for (int i=0; i<list.size(); i++){
				Office e = list.get(i);
				if (e.getParent()!=null && e.getParent().getId()!=null
						&& e.getParent().getId().equals(office.getParent().getId())){
					size++;
				}
			}
			office.setCode(office.getParent().getCode() + StringUtils.leftPad(String.valueOf(size > 0 ? size+1 : 1), 3, "0"));
		}
		model.addAttribute("office", office);
		return "modules/sys/officeForm";
	}
	
	@RequiresPermissions("sys:office:edit")
	@RequestMapping(value = "save")
	public String save(Office office, Model model, RedirectAttributes redirectAttributes) {

		if (!beanValidator(model, office)){
			return form(office, model);
		}
		officeService.save(office);
		
		if(office.getChildDeptList()!=null){
			Office childOffice = null;
			for(String id : office.getChildDeptList()){
				childOffice = new Office();
				childOffice.setName(DictUtils.getDictLabel(id, "sys_office_common", "未知"));
				childOffice.setParent(office);
				childOffice.setArea(office.getArea());
				childOffice.setType("2");
				childOffice.setGrade(String.valueOf(Integer.valueOf(office.getGrade())+1));
				childOffice.setUseable(Global.YES);
				officeService.save(childOffice);
			}
		}
		
		addMessage(redirectAttributes, "保存机构'" + office.getName() + "'成功");
		Long id = office.getParentId().intValue()==0 ? null : office.getParentId();
		return "redirect:"  + "/sys/office/list?id="+id+"&parentIds="+office.getParentIds();
	}
	
	@RequiresPermissions("sys:office:edit")
	@RequestMapping(value = "delete")
	public String delete(Office office, RedirectAttributes redirectAttributes) {


		int sum = officeService.findChildsByParentId(office);
		if (sum>0){
			addMessage(redirectAttributes, "删除机构失败，有子部门未删除");
			return "redirect:"  + "/sys/office/list?id="+office.getParentId()+"&parentIds="+office.getParentIds();
		}
		sum = officeService.findUsersByParentId(office);
		if (sum>0){
			addMessage(redirectAttributes, "删除机构失败，有部门所属用户未删除");
			return "redirect:"  + "/sys/office/list?id="+office.getParentId()+"&parentIds="+office.getParentIds();
		}
		officeService.delete(office);
		addMessage(redirectAttributes, "删除机构成功");

		return "redirect:"  + "/sys/office/list?id="+office.getParentId()+"&parentIds="+office.getParentIds();
	}

	/**
	 * 获取机构JSON数据。
	 * @param extId 排除的ID
	 * @param type	类型（1：公司；2：部门/小组/其它：3：用户）
	 * @param grade 显示级别
	 * @return
	 */
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> treeData(@RequestParam(required=false) String extId,
											  @RequestParam(required=false) String type,
											  @RequestParam(required=false) Long grade,
											  @RequestParam(required=false) Boolean isAll,
											  @RequestParam(required=false) String parentId) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<Office> list = officeService.findAll();
		for (int i=0; i<list.size(); i++){
			Office e = list.get(i);
			if ((StringUtils.isBlank(extId) || (extId!=null && !extId.equals(e.getId())&& e.getParentIds().indexOf(","+extId+",")==-1))
					&& (type == null || (type != null && (type.equals("1") ? type.equals(e.getType()) : true)))
					&& (grade == null || (grade != null && Integer.parseInt(e.getGrade()) <= grade.intValue()))
					&& Global.YES.equals(e.getUseable())){

				if(!Strings.isNullOrEmpty(parentId) && (e.getParentIds().indexOf(","+parentId+",")<0))continue;

				Map<String, Object> map = Maps.newHashMap();
				map.put("id", String.valueOf(e.getId()));
				map.put("pId", String.valueOf(e.getParentId()));
				map.put("pIds", e.getParentIds());
				map.put("name", e.getName());
				if (type != null && "3".equals(type)){
					map.put("isParent", true);
				}
				mapList.add(map);
			}
		}
		return mapList;
	}
}
