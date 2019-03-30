package com.mlxp.interceptor;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.mlxp.model.ViewLog;
import com.mlxp.service.ArticleService;
import com.mlxp.service.ViewLogService;
import com.mlxp.util.CookieUtil;
import com.mlxp.util.DateUtil;

public class PageViewCountInterceptor extends HandlerInterceptorAdapter {

    @Autowired
    private ViewLogService vlService;
    @Autowired
    private ArticleService articleService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        String path = request.getServletPath();
        if (InterceptionRule.viewRule(path)) {
            ViewLog vl = new ViewLog();
            vl.setIpaddress(InterceptionRule.getIPAddress(request));
            vl.setViewtime(DateUtil.getBeijingTime());
            // String requestUrl = request.getRequestURL().toString();//
            // 得到请求的URL地址

            String requestUri = request.getRequestURI();// 得到请求的资源
            String queryString = request.getQueryString();// 得到请求的URL地址中附带的参数
            if (queryString != null) {
                requestUri = requestUri + "?" + queryString;
            }
            vl.setUri(requestUri);
            String v = CookieUtil.getValue(request, "uv");
            if (null == v) {
                Date date = DateUtil.getBeijingTime();
                // 设置cookie有效时间到当天24点
                int maxAge = (int) ((DateUtil.getDayEndTime(date).getTime() - date.getTime()) / 1000);
                CookieUtil.addCookie(response, "uv", "# #", maxAge);
                vl.setViewtype(0);
            } else {
                vl.setViewtype(1);
            }
            vlService.insert(vl);
            // 1、若是查看文章则进行计数
            if (InterceptionRule.hitsRule(path)) {
                // 取得访问文章id
                String[] str = path.split("/");
                Integer articleId = Integer.parseInt(str[2]);
                articleService.updateHitsPlusOne(articleId);
            }
        }
        return true;
    }

}
