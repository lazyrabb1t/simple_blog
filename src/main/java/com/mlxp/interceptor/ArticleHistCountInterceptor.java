package com.mlxp.interceptor;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.mlxp.dto.HitsMesage;
import com.mlxp.service.ArticleService;
import com.mlxp.util.DateUtil;

public class ArticleHistCountInterceptor extends HandlerInterceptorAdapter {

    @Autowired
    private ArticleService articleService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        //获取请求路径
        String path = request.getServletPath();
        // 1、若是查看文章则进行计数
        if (InterceptionRule.hitsRule(path)) {
            //取得访问文章id
            String[] str = path.split("/");
            Integer articleId = Integer.parseInt(str[2]);
//            System.out.println(path);
            //取得访问ip
            String ip = InterceptionRule.getIPAddress(request);
            //访问时间
            Date currentDate = DateUtil.getBeijingTime();
            //从内存中获取访问信息
            Map<String, Map<Integer,HitsMesage>> contextData = (Map<String, Map<Integer,HitsMesage>>) request.getSession().getServletContext().getAttribute("articleHitsMessage");
            Map<Integer,HitsMesage> map = null;
            if (contextData == null) {
                //第一次访问则创建新的记录
                contextData = new HashMap<String, Map<Integer,HitsMesage>>();
                map = new HashMap<Integer, HitsMesage>();
            } else {
                //非第一次访问
                if (contextData.containsKey(ip)) {
                    //若记录中包含该IP记录
                    map = contextData.get(ip);
                    //判断访问id
                    if (map.containsKey(articleId)) {
                        HitsMesage hitsMesage = map.get(articleId);
                        // 上一次访问该文章距离当前的小时数
                        long time = (currentDate.getTime() - hitsMesage.getLastHitsTime().getTime()) / (1000 * 60 * 60);
                        if (time < 24) {
                            // 若是一天之内访问的
//                            System.out.println("+0");
                            return true;
                        }
                    }
                }else{
                    map = new HashMap<Integer, HitsMesage>();
                }
            }
            HitsMesage temp = new HitsMesage();
            temp.setHitsId(articleId);
            temp.setIp(ip);
            temp.setLastHitsTime(currentDate);
            map.put(articleId, temp);
            contextData.put(ip, map);
            request.getSession().getServletContext().setAttribute("articleHitsMessage", contextData);
            articleService.updateHitsPlusOne(articleId);
//            System.out.println("+1");
        }
        return true;
    }
}
