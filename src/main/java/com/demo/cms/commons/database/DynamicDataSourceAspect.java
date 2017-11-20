package com.demo.cms.commons.database;


import com.demo.cms.commons.utils.SpringContextHolder;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.reflect.MethodSignature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.lang.reflect.Method;

/**
 * Created by liufm on 15/9/25.
 */
public class DynamicDataSourceAspect {
    private final Logger logger = LoggerFactory.getLogger(DynamicDataSourceAspect.class);

    public void before(JoinPoint point) {
        Object target = point.getTarget();
        String method = point.getSignature().getName();
        Class<?> classz = target.getClass();
        Class<?>[] parameterTypes = ((MethodSignature) point.getSignature()).getMethod().getParameterTypes();

        try {
            Method mm = classz.getMethod(method, parameterTypes);
            String mName = mm.getName();
            DynamicDataSource dynamicDataSource = SpringContextHolder.getBean(DynamicDataSource.class);

            // @TODO 需要考虑从一个入口进入的情况下走多个Service时,使用同一个数据源
            if (isRead(mName)) {
                logger.info("ReadDataSource");
                DynamicDataSourceHolder.putDataSource(dynamicDataSource.getReadDataSource());
            } else {
                logger.info("WriteDataSource");
                DynamicDataSourceHolder.putDataSource(dynamicDataSource.getWriteDataSource());
            }
        } catch (NoSuchMethodException e) {
            logger.debug(e.getMessage());
        } catch (Exception e) {
            logger.debug(e.getMessage());
        }
    }

    private boolean isRead(String mName) {
        if(mName.startsWith("query")) {
            return true;
        } else if(mName.startsWith("get")) {
            return true;
        } else if(mName.startsWith("find")) {
            return true;
        } else {
            return false;
        }
    }
}
