package com.mlxp.controller;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mlxp.dto.Result;
import com.mlxp.model.User;
import com.mlxp.service.UserService;
import com.mlxp.util.CookieUtil;
import com.mlxp.util.DateUtil;

import sun.misc.BASE64Encoder;

@Controller
@RequestMapping("login")
public class LoginController {

    @Autowired
    private UserService userservice;

    @RequestMapping(value = "/index")
    private String index() {
        return "blog/login";
    }

    @RequestMapping(value = "/out")
    private String logout(HttpServletRequest request, HttpServletResponse response) {
        // request.getSession().removeAttribute("currentuser");
        CookieUtil.removeCookie(response, "currentuser");
        return "blog/login";
    }

    @RequestMapping("/check")
    @ResponseBody
    public Result<User> checkLogin(String accountname, String password, ModelMap model, HttpServletRequest request, HttpServletResponse response)
            throws NoSuchAlgorithmException, UnsupportedEncodingException {
        Result<User> result = null;
        if (accountname == null || password == null) {
            result = new Result<User>(false, "请输入用户名和密码！");
        } else {
            User user = userservice.selectByAccountname(accountname);
            if (user == null) {
                result = new Result<User>(false, "用户不存在！");
            } else {
                if (EncoderByMd5(password).equals(user.getPassword())) {
                    result = new Result<User>(true, "登录成功！");
                    user.setAccountname("account");
                    user.setPassword("password");
                    // 设置cookie有效时间到当天24点
                    Date date = DateUtil.getBeijingTime();
                    int maxAge = (int) ((DateUtil.getDayEndTime(date).getTime() - date.getTime()) / 1000);
                    CookieUtil.addCookie(response, "currentuser", user.getUsername(), maxAge);
                    CookieUtil.addCookie(response, "userid", user.getId().toString(), maxAge);
                    request.getSession().setAttribute("currentuser", user);
                } else {
                    result = new Result<User>(false, "密码错误！");
                }
            }
        }
        return result;
    }

    public String EncoderByMd5(String str) throws NoSuchAlgorithmException, UnsupportedEncodingException {
        // 确定计算方法
        MessageDigest md5 = MessageDigest.getInstance("MD5");
        BASE64Encoder base64en = new BASE64Encoder();
        // 加密后的字符串
        String newstr = base64en.encode(md5.digest(str.getBytes("utf-8")));
        return newstr;
    }
}
