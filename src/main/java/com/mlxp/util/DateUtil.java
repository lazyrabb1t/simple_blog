package com.mlxp.util;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.TimeZone;

public class DateUtil {

    /**
     * 取北京时间
     * 
     * @return
     */
    public static Date getBeijingTime() {
        TimeZone time = TimeZone.getTimeZone("GMT+8"); //设置为东八区
        time = TimeZone.getDefault();// 这个是国际化所用的
        TimeZone.setDefault(time);// 设置时区
        Calendar calendar = Calendar.getInstance();// 获取实例
        Date date = calendar.getTime(); //获取Date对象
        return date;
    }

    /**
     * 获取指定时间的那天 23:59:59.999 的时间
     * 
     * @param date
     * @return
     */
    public static Date getDayEndTime(final Date date) {
        Calendar c = Calendar.getInstance();
        c.setTime(date);
        c.set(Calendar.HOUR_OF_DAY, 23);
        c.set(Calendar.MINUTE, 59);
        c.set(Calendar.SECOND, 59);
        c.set(Calendar.MILLISECOND, 999);
        return c.getTime();
    }

    /**
     * 获取当前日期N天前的日期
     * 
     * @param date
     * @return
     */
    public static String getOtherDayTime(int n) {
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
        Calendar lastDate = Calendar.getInstance();
        lastDate.roll(Calendar.DAY_OF_YEAR, -n);//日期回滚n天
        return sdf.format(lastDate.getTime());
    }

    /**
     * 获取当前日期N天前的日期
     * 
     * @param date
     * @return
     */
    public static List<String> getOtherDayList(int n) {
        List<String> list = new ArrayList<String>();
        for(int i = n-1;i>=0;i--){
            list.add(getOtherDayTime(i));
        }
        return list;
    }
    public static void main(String[] args) {
        List<String> list = getOtherDayList(30);
        for(String str:list){
            System.out.println(str);
        }
    }
}
