package com.demo.cms.commons.redis;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.ShardedJedis;
import redis.clients.jedis.ShardedJedisPool;

import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

public class Redis{
    private final Logger logger = LoggerFactory.getLogger(Redis.class);

    private ShardedJedisPool shardedJedisPool;

    public Redis(ShardedJedisPool shardedJedisPool) {
        logger.info("shardedJedisPool:"+shardedJedisPool);
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
     * 取得对象
     * */
    public String get(String key,String v,String f) {
        ShardedJedis shardedJedis = null;
        try {
            shardedJedis = shardedJedisPool.getResource();
            String value = shardedJedis.get(key);

            return value;
        } catch (Exception ex) {
            logger.error("redis get error.", ex);
            returnResource(shardedJedis);
        } finally {
            returnResource(shardedJedis);
        }

        return v;
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

    /**
     * 进队列
     * */
    public boolean rpush(String key, Object value) {
        ShardedJedis shardedJedis = null;
        try {
            shardedJedis = shardedJedisPool.getResource();
            byte[] obj = SerializeUtil.serialize(value);
            if(null==obj)return false;
            shardedJedis.rpush(key.getBytes(), obj);
            return true;
        } catch (Exception ex) {
            logger.error("redis set error.", ex);
            returnResource(shardedJedis);
        } finally {
            returnResource(shardedJedis);
        }
        return false;
    }
    /**
     * 出队列
     * */
    public Object lpop(String key,Object defaultValue) {
        ShardedJedis shardedJedis = null;
        try {
            shardedJedis = shardedJedisPool.getResource();
            byte[] value = shardedJedis.lpop(key.getBytes());
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
     * 队列长度
     * */
    public Long llen(String key) {
        ShardedJedis shardedJedis = null;
        try {
            shardedJedis = shardedJedisPool.getResource();
            return shardedJedis.llen(key.getBytes());
        } catch (Exception ex) {
            logger.error("redis get error.", ex);
            returnResource(shardedJedis);
        } finally {
            returnResource(shardedJedis);
        }

        return 0L;
    }

    /**
     * 计数器-增加定量
     * */
    public long incrBy(String key, long integer) {
        ShardedJedis shardedJedis = null;
        try {
            shardedJedis = shardedJedisPool.getResource();
            return shardedJedis.incrBy(key, integer);
        } catch (Exception ex) {
            logger.error("redis incr error.", ex);
            returnResource(shardedJedis);
        } finally {
            returnResource(shardedJedis);
        }
        return 0;
    }

    /**
     * 计数器-减少定量
     * */
    public long decrBy(String key, long integer) {
        ShardedJedis shardedJedis = null;
        try {
            shardedJedis = shardedJedisPool.getResource();
            return shardedJedis.decrBy(key, integer);
        } catch (Exception ex) {
            logger.error("redis decr error.", ex);
            returnResource(shardedJedis);
        } finally {
            returnResource(shardedJedis);
        }
        return 0;
    }

    public Long setnx(String key,String v) {
        ShardedJedis shardedJedis = null;
        try {
            shardedJedis = shardedJedisPool.getResource();
            return shardedJedis.setnx(key,v);

        } catch (Exception ex) {
            logger.error("redis get error.", ex);
            returnResource(shardedJedis);
        } finally {
            returnResource(shardedJedis);
        }

        return 0L;
    }

    public String getSet(String key,String v) {
        ShardedJedis shardedJedis = null;
        try {
            shardedJedis = shardedJedisPool.getResource();
            return shardedJedis.getSet(key,v);

        } catch (Exception ex) {
            logger.error("redis get error.", ex);
            returnResource(shardedJedis);
        } finally {
            returnResource(shardedJedis);
        }
        return null;
    }

    public String getStr(String key) {
        ShardedJedis shardedJedis = null;
        try {
            shardedJedis = shardedJedisPool.getResource();
            return shardedJedis.get(key);
        } catch (Exception ex) {
            logger.error("redis get error.", ex);
            returnResource(shardedJedis);
        } finally {
            returnResource(shardedJedis);
        }

        return null;
    }
}
