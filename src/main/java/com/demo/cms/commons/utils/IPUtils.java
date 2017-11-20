package com.demo.cms.commons.utils;

import java.net.Inet6Address;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.util.Enumeration;

/**
 * Created by demo on 2017/7/17.
 */
public class IPUtils {
    public static String getInternalIp() {
        try {
            InetAddress addr = getLocalHostAddress();
            return addr.getHostAddress().toString();//获得本机
        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }
    }

    public static InetAddress getLocalHostAddress() {
        try {
            for (Enumeration<NetworkInterface> nis = NetworkInterface
                    .getNetworkInterfaces(); nis.hasMoreElements();) {
                NetworkInterface ni = nis.nextElement();
                if (ni.isLoopback() || ni.isVirtual() || !ni.isUp())
                    continue;
                for (Enumeration<InetAddress> ias = ni.getInetAddresses(); ias.hasMoreElements();) {
                    InetAddress ia = ias.nextElement();
                    if (ia instanceof Inet6Address) continue;
                    return ia;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
