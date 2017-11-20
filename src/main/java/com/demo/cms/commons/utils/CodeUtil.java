package com.demo.cms.commons.utils;


import com.demo.cms.commons.redis.Redis;
import com.demo.cms.commons.redis.RedisKey;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by demo on 2017/7/11.
 */
public class CodeUtil {
    private static Redis redis = SpringContextHolder.getBean(Redis.class);

    private static SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyMMdd");

    public final static String CODE_PREFIX_STUNUM = "BYSNC";    //学号
    public final static String CODE_PREFIX_ORDER = "BYDD";      //订单编号
    public final static String CODE_PREFIX_CONTRACT = "BYHT";   //合同编号
    public final static String CODE_PREFIX_PAYBILL = "BYPB";    //收款单编号
    public final static String CODE_PREFIX_FINANCIAL = "BYFC";  //财务编号
    public final static String CODE_PREFIX_PRODUCT = "BYSP";    //商品
    public final static String CODE_PREFIX_EMPLOYEE = "BYYG";    //员工
    public final static String CODE_PREFIX_SYSUSER = "BYSU";    //员工

    private static String codeDate;


    /**
     * 生成编码
     * @return
     */
    public static synchronized String genOrderNo(String prefix) {
        String str = simpleDateFormat.format(new Date());
        if (codeDate == null || !codeDate.equals(str)) {
            codeDate = str;
        }

        long code = Long.parseLong((codeDate)) * 10000;
        code += redis.incr(RedisKey.CODE_INDEX+prefix);
        return prefix + code;
    }

}
