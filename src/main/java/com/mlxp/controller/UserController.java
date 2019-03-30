package com.mlxp.controller;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import sun.misc.BASE64Encoder;

import com.mlxp.define.HalalaDefine;
import com.mlxp.dto.Result;
import com.mlxp.model.Attachment;
import com.mlxp.model.User;
import com.mlxp.service.AttachmentService;
import com.mlxp.service.UserService;
import com.mlxp.util.CookieUtil;

@Controller
@RequestMapping("user")
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private AttachmentService attachmentService;

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    private Result<User> save(HttpServletRequest request, User user) {

        int flg = 0;
//        User currentUser = (User) request.getSession().getAttribute("currentuser");
        Integer userid = Integer.parseInt(CookieUtil.getValue(request, "userid"));
        user.setId(userid);
        flg = userService.updateByPrimaryKeySelective(user);
        Result<User> result = null;
        if (flg > 0) {
            // 创建一个通用的多部分解析器.
            CommonsMultipartResolver commonsMultipartResolver = new CommonsMultipartResolver(request.getSession().getServletContext());
            // 设置编码
            commonsMultipartResolver.setDefaultEncoding("utf-8");
            // 判断是否有文件上传
            if (commonsMultipartResolver.isMultipart(request)) {// 有文件上传
                // 上传文件路径
                String path = request.getSession().getServletContext().getRealPath(HalalaDefine.USER_ATTACHMENT_PATH);
                MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
                MultipartFile file = multipartRequest.getFile("pic1");
                if (attachmentService.deleteFile(request, HalalaDefine.USER_ATTACHMENT_TYPE, user.getId())) {
                    attachmentService.saveFile(file, path, HalalaDefine.USER_ATTACHMENT_PATH, HalalaDefine.USER_ATTACHMENT_TYPE, user.getId());
                }
            }
            result = new Result<User>(true, "已保存！");
        } else {
            result = new Result<User>(false, "系统出错，请稍后提交！");
        }
        return result;
    }

    @RequestMapping(value = "/form")
    private String form(HttpServletRequest request, Model model) {
        Integer userid = Integer.parseInt(CookieUtil.getValue(request, "userid"));
        User user = userService.selectByPrimaryKey(userid);
        user.setAccountname("account");
        user.setPassword("password");
        Attachment att = attachmentService.selectByOrigin(user.getId(), HalalaDefine.USER_ATTACHMENT_TYPE);
        model.addAttribute("attachment", att);
        model.addAttribute("user", user);
        return "blog/user_form";
    }

    @RequestMapping(value = "/changepwdform")
    private String changepwdform() {
        return "blog/user_changepwd_dialog";
    }
    
    @RequestMapping(value = "/changepwd")
    @ResponseBody
    private Result<User> changepwd(HttpServletRequest request,String oldpassword,String newpassword) {
        
        Result<User> result = null;
//        User currentUser = (User) request.getSession().getAttribute("currentuser");
        Integer userid = Integer.parseInt(CookieUtil.getValue(request, "userid"));
        User user = userService.selectByPrimaryKey(userid);
        String pwd = "";
        String newpwd = "";
        try {
            pwd = EncoderByMd5(oldpassword);
            newpwd = EncoderByMd5(newpassword);
        } catch (NoSuchAlgorithmException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        if(user.getPassword().equals(pwd)){
            user.setPassword(newpwd);
            userService.updateByPrimaryKeySelective(user);
            result = new Result<User>(true,"修改成功");
        }else{
            result = new Result<User>(false,"原密码不正确...");
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
