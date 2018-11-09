package com.demo.cms.commons.redis;

import org.apache.shiro.util.SimpleByteSource;

import java.io.Serializable;

public class RedisSimpleByteSource extends SimpleByteSource implements Serializable {
    public RedisSimpleByteSource(byte[] bytes) {
        super(bytes);
    }
}
