package com.demo.cms.commons.database;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.jdbc.datasource.lookup.AbstractRoutingDataSource;

import java.util.concurrent.atomic.AtomicInteger;


public class DynamicDataSource extends AbstractRoutingDataSource implements InitializingBean {
    private final Logger logger = LoggerFactory.getLogger(DynamicDataSource.class);


    private AtomicInteger counter = new AtomicInteger(1);
    private String writeDataSource;
    private String[] readDataSources;
    private int readCount;

    public String getWriteDataSource() {
        return writeDataSource;
    }

    public void setWriteDataSource(String writeDataSource) {
        this.writeDataSource = writeDataSource;
    }

    public String getReadDataSource() {
        if (readCount == 0) {
            return writeDataSource;
        } else {
            return determineReadDataSource();
        }
    }

    public void setReadDataSources(String[] readDataSources) {
        this.readDataSources = readDataSources;
    }

    @Override
    public void afterPropertiesSet() {
        super.afterPropertiesSet();
        if (readDataSources == null || readDataSources.length <= 0) {
            readCount = 0;
        } else {
            readCount = readDataSources.length;
        }
    }

    @Override
    protected Object determineCurrentLookupKey() {
        return DynamicDataSourceHolder.getDataSource();
    }

    private String determineReadDataSource() {
        //按照顺序选择读库
        int index = counter.incrementAndGet() % readDataSources.length;
        if (index < 0) {
            index = -index;
        }
        return readDataSources[index];
    }
}
