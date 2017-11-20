package com.demo.cms.commons.status;

/**
 * Created by demo on 2017/6/1.
 */
public enum Status {
    /**
     * 正常
     */
    NORMAL {
        public Integer getValue() {
            return 0;
        }

        public String getName() {
            return "启用";
        }
    },
    /**
     * 删除
     */
    DELETE {
        public Integer getValue() {
            return 1;
        }

        public String getName() {
            return "停用";
        }
    };

    public abstract Integer getValue();

    public abstract String getName();




    /**
     * 返回状态列表
     * */
    public static Status[] all(){
        return Status.values();
    }

    /**
     * 查找返回状态名称
     * */
    public static String findName(Integer value){
        if (Status.DELETE.getValue() == value){
            return Status.DELETE.getName();
        }else if (Status.NORMAL.getValue() == value){
            return Status.NORMAL.getName();
        }else {
            return "";
        }
    }
}
