package com.demo.cms.commons.utils;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.util.StringUtils;

import javax.crypto.Cipher;
import javax.servlet.http.HttpServletRequest;
import java.security.GeneralSecurityException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


/**
 * Created by demo on 2016-07-01.
 */
public class Utils {

    //private static final ObjectMapper mapper = new ObjectMapper();

    public static SimpleDateFormat dayDateFormat = new SimpleDateFormat("yyyy-MM-dd");
    public static SimpleDateFormat timeDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    public static SimpleDateFormat weixinDateFormat = new SimpleDateFormat("yyyyMMddHHmmss");

    public static SimpleDateFormat yearFormat = new SimpleDateFormat("yyyy");
    public static SimpleDateFormat monthDayFormat = new SimpleDateFormat("MM月dd日");

    public static String writeValueAsString(Object o)throws Exception {
        ObjectMapper mapper = new ObjectMapper();
        return mapper.writeValueAsString(o);
    }

    public static <T> T readValue(String src, Class<T> t)throws Exception {
        ObjectMapper mapper = new ObjectMapper();
        return mapper.readValue(src, t);
    }
    public static List<Map<String,Object>> readListMapValue(String src){
        ObjectMapper mapper = new ObjectMapper();
        try {
            return mapper.readValue(src, new ArrayList<HashMap<String,Object>>().getClass());
        }catch (Exception e){
            return null;
        }
    }

    public static String getCurrentDay(){
        return dayDateFormat.format(new Date(System.currentTimeMillis()));
    }

    public static long getDayTime(){
        final Calendar instance = Calendar.getInstance();
        instance.add(Calendar.DATE, 1);
        instance.set(Calendar.HOUR_OF_DAY, 0);
        instance.set(Calendar.SECOND,0);
        instance.set(Calendar.MINUTE,0);
        instance.set(Calendar.MILLISECOND,0);
        return instance.getTimeInMillis();
    }

    public static String getCurrentTime(){
        return timeDateFormat.format(new Date(System.currentTimeMillis()));
    }

    public static String getWXTime(Date date){
        return weixinDateFormat.format(date);
    }


    public static boolean isMobile(String str) {
        if (StringUtils.isEmpty(str))return false;
        boolean b = false;
        if(str.length()!=11)return b;

        Pattern p = null;
        Matcher m = null;

        p = Pattern.compile("^[1][3,4,5,7,8][0-9]{9}$"); // 验证手机号
        m = p.matcher(str);
        b = m.matches();
        return b;
    }

    public static boolean isPassword(String str) {
        if(str==null || str.length()<6 || str.length()>12)return false;
        else return true;
    }
    public static boolean isEmail(String email){
        if (StringUtils.isEmpty(email)) return false;

        Pattern p =  Pattern.compile("\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*");//复杂匹配
        Matcher m = p.matcher(email);
        return m.matches();
    }
    public static boolean isNumber(String str){
        if (null==str || "".equals(str)) return false;
        Pattern p =  Pattern.compile("^\\d{6,}$");//6位数字
        Matcher m = p.matcher(str);
        return m.matches();
    }

    public static boolean checkIdCard(String number){
        Pattern p = Pattern.compile("([1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X))");
        Matcher m = p.matcher(number);
        return m.matches();
    }

    public static boolean isCode(String str){
        if (null==str || "".equals(str)) return false;
        Pattern p =  Pattern.compile("^\\d{4,}$");//4位数字
        Matcher m = p.matcher(str);
        return m.matches();
    }

    public static String changeHTML2Brief(String htm) {
        if (null == htm) return htm;
        htm = htm.replaceAll("<\\s*[pP]\\s*>", "");
        htm = htm.replaceAll("(\\s*(&nbsp;)*(　)*(<\\s*[bB][rR]\\s*[/]?\\s*>)+\\s*(&nbsp;)*(　)*)+", ";;br/;;");
        htm = htm.replaceAll("<[^<>]*>", "");
        htm = htm.replaceAll("(\\s*(&nbsp;)*(　)*(;;br/;;)+\\s*(&nbsp;)*(　)*)+", "");
        htm = htm.replaceAll("^<br/>", "");
        htm = htm.replaceAll("&ldquo;", "'");
        htm = htm.replaceAll("&rdquo;", "'");
        htm = htm.replaceAll(" ", "");
        htm = htm.replaceAll("&nbsp;", " ");
        //特殊字符
        String regEx="[`~!@#$%^&*()+=|{}':;',//[//].<>/?~！@#￥%……&*（）——+|{}【】‘；：”“’。，、？]";
        Pattern pattern = Pattern.compile(regEx);
        Matcher matcher = pattern.matcher(htm);
        return matcher.replaceAll("").trim();
    }

    public static String getIpAddr(HttpServletRequest request) {
        String ip = request.getHeader("x-forwarded-for");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        if(ip.indexOf(",")>=0){
            return ip.split(",")[0];
        }
        return ip;
    }

    public static boolean isMoblieAgent(HttpServletRequest request) {
        String[] mobileAgents = { "iphone", "android", "phone", "mobile", "wap", "netfront", "java", "opera mobi",
                "opera mini", "ucweb", "windows ce", "symbian", "series", "webos", "sony", "blackberry", "dopod",
                "nokia", "samsung", "palmsource", "xda", "pieplus", "meizu", "midp", "cldc", "motorola", "foma",
                "docomo", "up.browser", "up.link", "blazer", "helio", "hosin", "huawei", "novarra", "coolpad", "webos",
                "techfaith", "palmsource", "alcatel", "amoi", "ktouch", "nexian", "ericsson", "philips", "sagem",
                "wellcom", "bunjalloo", "maui", "smartphone", "iemobile", "spice", "bird", "zte-", "longcos",
                "pantech", "gionee", "portalmmm", "jig browser", "hiptop", "benq", "haier", "^lct", "320x320",
                "240x320", "176x220","voda", "wap-", "wapa", "wapi", "wapp", "wapr", "webc", "winw", "winw",
                "xda", "xda-", "Googlebot-Mobile" };
        if (request.getHeader("User-Agent") != null) {
            for (String mobileAgent : mobileAgents) {
                if (request.getHeader("User-Agent").toLowerCase().indexOf(mobileAgent) >= 0) {

                    return true;
                }
            }
        }
        return false;
    }


    public static Date getOrderEndTime(int hour){
        Calendar calendar = Calendar.getInstance();
        calendar.setTimeInMillis(System.currentTimeMillis());
        int dayhour = calendar.get(Calendar.HOUR_OF_DAY);
        calendar.set(Calendar.HOUR_OF_DAY, dayhour + hour);
        return calendar.getTime();
    }

    /**
     * 初始向量的方法, 全部为0. 这里的写法适合于其它算法,针对AES算法的话,IV值一定是128位的(16字节).
     *
     * @param fullAlg
     * @return
     */
    private static byte[] initIv(String fullAlg) throws GeneralSecurityException {
        Cipher cipher = Cipher.getInstance(fullAlg);
        int blockSize = cipher.getBlockSize();
        byte[] iv = new byte[blockSize];
        for (int i = 0; i < blockSize; ++i) {
            iv[i] = 0;
        }
        return iv;
    }
}
