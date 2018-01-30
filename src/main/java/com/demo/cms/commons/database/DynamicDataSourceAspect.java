package com.demo.cms.commons.database;


import com.demo.cms.commons.utils.SpringContextHolder;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.reflect.MethodSignature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.aop.AfterReturningAdvice;
import org.springframework.aop.MethodBeforeAdvice;

import java.lang.reflect.Method;

public class DynamicDataSourceAspect implements MethodBeforeAdvice,AfterReturningAdvice {
    private final Logger logger = LoggerFactory.getLogger(DynamicDataSourceAspect.class);
    @Override
    public void before(Method method, Object[] objects, Object o) throws Throwable {
        String mName = method.getName();
        DynamicDataSource dynamicDataSource = SpringContextHolder.getBean(DynamicDataSource.class);

        if (mName.startsWith("query")
                || mName.startsWith("get")
                || mName.startsWith("find")) {
            logger.debug(">>>>>>>>>>>>>>>>>> DataSource Read");
            DynamicDataSourceHolder.putDataSource(dynamicDataSource.getReadDataSource());
        } else {
            logger.debug(">>>>>>>>>>>>>>>>>> DataSource Write");
            DynamicDataSourceHolder.putDataSource(dynamicDataSource.getWriteDataSource());
        }
    }

    @Override
    public void afterReturning(Object o, Method method, Object[] objects, Object o1) throws Throwable {
        DynamicDataSourceHolder.removeDataSource();
    }
}
