package com.demo.cms.commons.redis;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.ShardedJedis;
import redis.clients.jedis.ShardedJedisPool;

import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by demo on 16/9/20.
 */
public class Redis{
    private final Logger logger = LoggerFactory.getLogger(Redis.class);

    private ShardedJedisPool shardedJedisPool;

    public Redis(ShardedJedisPool shardedJedisPool) {
        this.shardedJedisPool = shardedJedisPool;
    }


    private void returnResource(ShardedJedis shardedJedis){
        if (null==shardedJedis)return;
        shardedJedis.close();
    }

    /**
     * 设置key过期时间
     * */
    public long expire(String key, int seconds) {
        ShardedJedis shardedJedis = null;
        try {
            shardedJedis = shardedJedisPool.getResource();

            return shardedJedis.expire(key, seconds);
        } catch (Exception ex) {
            logger.error("redis expire error.", ex);
            returnResource(shardedJedis);
        } finally {
            returnResource(shardedJedis);
        }
        return 0;
    }

    /**
     * 添加到Set列表中
     */
    public boolean sadd(String key, String... value) {
        ShardedJedis shardedJedis = null;
        try {
            shardedJedis = shardedJedisPool.getResource();
            shardedJedis.sadd(key, value);
            return true;
        } catch (Exception ex) {
            logger.error("redis sadd error.", ex);
            returnResource(shardedJedis);
        } finally {
            returnResource(shardedJedis);
        }
        return false;
    }
    /**
     * 移除Set列表中对象
     */
    public boolean srem(String key, String... value) {
        ShardedJedis shardedJedis = null;
        try {
            shardedJedis = shardedJedisPool.getResource();
            shardedJedis.srem(key, value);
            return true;
        } catch (Exception ex) {
            logger.error("redis srem error.", ex);
            returnResource(shardedJedis);
        } finally {
            returnResource(shardedJedis);
        }
        return false;
    }

    /**
     * 获取Set列表
     */
    public  Set<String> smembers(String key){
        ShardedJedis shardedJedis = null;
        try {
            shardedJedis = shardedJedisPool.getResource();
            return shardedJedis.smembers(key);
        } catch (Exception ex) {
            logger.error("redis smembers error.", ex);
            returnResource(shardedJedis);
        } finally {
            returnResource(shardedJedis);
        }
        return null;
    }

    /**
     * 查找keys*
     */

    public Set<String> keys(String pattern) {
        ShardedJedis shardedJedis = null;
        Set<String> retList = new HashSet<>();
        try {
            shardedJedis = shardedJedisPool.getResource();
            Collection<Jedis> jedisCollection = shardedJedis.getAllShards();
            for(Jedis jedis : jedisCollection){
                retList.addAll(jedis.keys(pattern));
            }
        } catch (Exception ex) {
            logger.error("redis hkeys error.", ex);
            returnResource(shardedJedis);
        } finally {
            returnResource(shardedJedis);
        }
        return retList;
    }
    /**
     * 保存对象
     * */
    public boolean set(String key, Object value) {
        ShardedJedis shardedJedis = null;
        try {
            shardedJedis = shardedJedisPool.getResource();
            byte[] obj = SerializeUtil.serialize(value);
            if(null==obj)return false;
            shardedJedis.set(key.getBytes(), obj);
            return true;
        } catch (Exception ex) {
            logger.error("redis set error.", ex);
            returnResource(shardedJedis);
        } finally {
            returnResource(shardedJedis);
        }
        return false;
    }
    public Object get(String key) {
        return get(key,null);
    }
    /**
     * 取得对象
     * */
    public Object get(String key,Object defaultValue) {
        ShardedJedis shardedJedis = null;
        try {
            shardedJedis = shardedJedisPool.getResource();
            byte[] value = shardedJedis.get(key.getBytes());
            if (null==value)return defaultValue;

            return SerializeUtil.unserialize(value);
        } catch (Exception ex) {
            logger.error("redis get error.", ex);
            returnResource(shardedJedis);
        } finally {
            returnResource(shardedJedis);
        }

        return defaultValue;
    }
    /**
     * 删除对象
     * */
    public boolean del(String key) {
        ShardedJedis shardedJedis = null;
        try {
            shardedJedis = shardedJedisPool.getResource();
            return shardedJedis.del(key) >0 ;
        } catch (Exception ex) {
            logger.error("redis del error.", ex);
            returnResource(shardedJedis);
        } finally {
            returnResource(shardedJedis);
        }
        return false;
    }

    /**
     * 删除对象
     * */
    public boolean remove(String key) {
        ShardedJedis shardedJedis = null;
        try {
            shardedJedis = shardedJedisPool.getResource();
            return shardedJedis.del(key.getBytes()) >0 ;
        } catch (Exception ex) {
            logger.error("redis del error.", ex);
            returnResource(shardedJedis);
        } finally {
            returnResource(shardedJedis);
        }
        return false;
    }
    /**
     * 计数器-增加
     * */
    public long incr(String key) {
        ShardedJedis shardedJedis = null;
        try {
            shardedJedis = shardedJedisPool.getResource();
            return shardedJedis.incr(key);
        } catch (Exception ex) {
            logger.error("redis incr error.", ex);
            returnResource(shardedJedis);
        } finally {
            returnResource(shardedJedis);
        }
        return 0;
    }
    /**
     * 计数器-减少
     * */
    public long decr(String key) {
        ShardedJedis shardedJedis = null;
        try {
            shardedJedis = shardedJedisPool.getResource();
            return shardedJedis.decr(key);
        } catch (Exception ex) {
            logger.error("redis decr error.", ex);
            returnResource(shardedJedis);
        } finally {
            returnResource(shardedJedis);
        }
        return 0;
    }

    /**
     * value是否是列表成员
     * */
    public boolean sismember(String key,String value) {
        if (null==value)return false;
        ShardedJedis shardedJedis = null;
        try {
            shardedJedis = shardedJedisPool.getResource();
            return shardedJedis.sismember(key,value);
        } catch (Exception ex) {
            logger.error("redis sismember error.", ex);
            returnResource(shardedJedis);
        } finally {
            returnResource(shardedJedis);
        }
        return false;
    }
    /**
     * key是否存在
     * */
    public boolean exists(String key) {
        ShardedJedis shardedJedis = null;
        try {
            shardedJedis = shardedJedisPool.getResource();
            return shardedJedis.exists(key);
        } catch (Exception ex) {
            logger.error("redis exists error.", ex);
            returnResource(shardedJedis);
        } finally {
            returnResource(shardedJedis);
        }
        return false;
    }
}
