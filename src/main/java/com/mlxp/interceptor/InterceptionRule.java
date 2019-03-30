package com.mlxp.interceptor;

import javax.servlet.http.HttpServletRequest;

/**
 * @author admin
 *
 */
public class InterceptionRule {

    /**
     * 是否需要进行登录拦截
     * @param url
     * @return
     */
    public static boolean loginRule(String url){
        if(url.contains("/article/")||url.contains("/attachment/")||
                url.contains("/user/")||url.contains("/main/")){
            return true;
        }else{
            return false;
        }
    }

    /**
     * 是否是文章页
     * @param url
     * @return
     */
    public static boolean hitsRule(String url){
        if(url.contains("/detail/")||url.contains("/simpledetail")){
            return true;
        }else{
            return false;
        }
    }

    /**
     * 是否进行访问统计
     * @param url
     * @return
     */
    public static boolean viewRule(String url){
        if(url.contains("/article/")||url.contains("/attachment/")||
                url.contains("/user/")||url.contains("/main/")||url.contains("/login/")
                ||url.equals("/web/liked")||url.equals("/web/regret")||url.equals("/simple")){
            return false;
        }else{
            return true;
        }
    }
    
    /**
     * @param request
     * @return ip
     */
    public static String getIPAddress(HttpServletRequest request) {
        String ip = null;

        // X-Forwarded-For：Squid 服务代理
        String ipAddresses = request.getHeader("X-Forwarded-For");

        if (ipAddresses == null || ipAddresses.length() == 0 || "unknown".equalsIgnoreCase(ipAddresses)) {
            // Proxy-Client-IP：apache 服务代理
            ipAddresses = request.getHeader("Proxy-Client-IP");
        }

        if (ipAddresses == null || ipAddresses.length() == 0 || "unknown".equalsIgnoreCase(ipAddresses)) {
            // WL-Proxy-Client-IP：weblogic 服务代理
            ipAddresses = request.getHeader("WL-Proxy-Client-IP");
        }

        if (ipAddresses == null || ipAddresses.length() == 0 || "unknown".equalsIgnoreCase(ipAddresses)) {
            // HTTP_CLIENT_IP：有些代理服务器
            ipAddresses = request.getHeader("HTTP_CLIENT_IP");
        }

        if (ipAddresses == null || ipAddresses.length() == 0 || "unknown".equalsIgnoreCase(ipAddresses)) {
            // X-Real-IP：nginx服务代理
            ipAddresses = request.getHeader("X-Real-IP");
        }

        // 有些网络通过多层代理，那么获取到的ip就会有多个，一般都是通过逗号（,）分割开来，并且第一个ip为客户端的真实IP
        if (ipAddresses != null && ipAddresses.length() != 0) {
            ip = ipAddresses.split(",")[0];
        }

        // 还是不能获取到，最后再通过request.getRemoteAddr();获取
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ipAddresses)) {
            ip = request.getRemoteAddr();
        }
        return ip;
    }
}
