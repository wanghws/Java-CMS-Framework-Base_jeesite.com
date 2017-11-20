package com.demo.cms.commons.redis;

import org.apache.shiro.util.SimpleByteSource;

import java.io.Serializable;

/**
 * Created by demo on 16/9/29.
 */
public class RedisSimpleByteSource extends SimpleByteSource implements Serializable {
    public RedisSimpleByteSource(byte[] bytes) {
        super(bytes);
    }
}
