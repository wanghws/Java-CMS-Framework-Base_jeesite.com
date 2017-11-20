/**
 * Copyright &copy; 2017 demo.com All rights reserved.
 */
package com.demo.cms.modules.sys.dao;

import com.demo.cms.commons.annotation.MyBatisDao;
import com.demo.cms.commons.dao.TreeDao;
import com.demo.cms.modules.sys.entity.Office;

import java.util.List;


/**
 * 机构DAO接口
 * @author demo.com
 * @version 2014-05-16
 */
@MyBatisDao
public interface OfficeDao extends TreeDao<Office> {

    /**
     * 查询emp
     * @author Ashon
     * @version 2017-06-07
     */
    public List<Office> findEmployeeList(Office Office);

    /**
     * 查询学员
     * @param
     * @return
     */
    public List<Office> findStudentList(Office Office);

    public int findChildsByParentId(Office Office);
    public int findUsersByParentId(Office Office);
}
