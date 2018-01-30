package com.demo.cms.commons.database;

public class DynamicDataSourceHolder {
    public static final ThreadLocal<String> holder = new ThreadLocal<>();

    public static void putDataSource(String name) {
        holder.set(name);
    }

    public static String getDataSource() {
        return holder.get();
    }

    public static void removeDataSource() {
        holder.remove();
    }
}
