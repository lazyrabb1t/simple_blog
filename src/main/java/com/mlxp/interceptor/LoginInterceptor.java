package com.mlxp.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        String path = request.getServletPath();
        // 1、若是login相关或前台则return true
        if (!InterceptionRule.loginRule(path)) {
            return true;
        }
        // 2、如果用户已经登录 放行
        if (request.getSession().getAttribute("currentuser") != null) {
            // 更好的实现方式的使用cookie
            return true;
        }
        // if(CookieUtil.getValue(request, "currentuser")!= null){
        // return true;
        // }
        // 3、重定向到登录页面
        PrintWriter out = response.getWriter();
        StringBuilder builder = new StringBuilder();
        builder.append("<script type=\"text/javascript\" charset=\"UTF-8\">");
        builder.append("window.top.location.href='" + request.getContextPath() + "/login/index';");
        builder.append("</script>");
        out.print(builder.toString());
        out.close();
        return false;
    }
}
