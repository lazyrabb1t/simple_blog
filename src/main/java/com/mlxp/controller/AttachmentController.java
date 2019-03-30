package com.mlxp.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.mlxp.define.HalalaDefine;
import com.mlxp.dto.EditorUploadExecution;
import com.mlxp.dto.Result;
import com.mlxp.model.Article;
import com.mlxp.model.Attachment;
import com.mlxp.service.AttachmentService;
import com.mlxp.util.DateUtil;

@Controller
@RequestMapping("/attachment")
public class AttachmentController {

    @Autowired
    private AttachmentService attachmentService;

    @RequestMapping(value = "/imgupload", method = RequestMethod.POST)
    @ResponseBody
    private EditorUploadExecution index(HttpServletRequest request, MultipartFile upload_file) {
        EditorUploadExecution uploadExec = null;
        if (!upload_file.isEmpty()) {
            // 上传文件路径
            String path = request.getSession().getServletContext().getRealPath("/uploadfile/editor_img/");
            // 上传文件名
            String filename = upload_file.getOriginalFilename();
            String suffix = filename.substring(filename.lastIndexOf("."));
            String prefix = filename.substring(0, filename.lastIndexOf("."));
            SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
            File filepath = new File(path, filename);
            // 判断路径是否存在，如果不存在就创建一个
            if (!filepath.getParentFile().exists()) {
                filepath.getParentFile().mkdirs();
            }
            // 将上传文件保存到一个目标文件当中
            String savepath = path + File.separator + prefix + "_" + df.format(DateUtil.getBeijingTime()) + suffix;
            try {
                upload_file.transferTo(new File(savepath));
            } catch (IOException e) {
                // TODO Auto-generated catch block
                uploadExec = new EditorUploadExecution(false, "上传失败！" + e.getMessage());
                e.printStackTrace();
            }
            uploadExec = new EditorUploadExecution(savepath, true);

        } else {
            uploadExec = new EditorUploadExecution(false, "上传失败！");
        }
        return uploadExec;
    }

    @RequestMapping(value = "/deleteArticleAttachment", method = RequestMethod.GET)
    @ResponseBody
    private Result<Attachment> deleteArticleAttachment(HttpServletRequest request, @RequestParam(value = "id", defaultValue = "0") Integer articleId) {
        Result<Attachment> result = null;
        if(attachmentService.deleteFile(request, HalalaDefine.ARTICLE_ATTACHMENT_TYPE, articleId)){
            result= new Result<Attachment>(true,"删除成功！");
        }else{
            result= new Result<Attachment>(false,"删除失败！");
        }
        return result;
    }
}
