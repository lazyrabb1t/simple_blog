package com.mlxp.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.github.pagehelper.page.PageMethod;
import com.mlxp.define.HalalaDefine;
import com.mlxp.dto.Result;
import com.mlxp.model.Article;
import com.mlxp.model.ArticleType;
import com.mlxp.model.Attachment;
import com.mlxp.service.ArticleService;
import com.mlxp.service.ArticleTypeService;
import com.mlxp.service.AttachmentService;
import com.mlxp.util.CookieUtil;
import com.mlxp.util.DateUtil;

@Controller
@RequestMapping("/article")
public class ArticleController {

    @Autowired
    private ArticleService articleService;
    @Autowired
    private ArticleTypeService articleTypeService;
    @Autowired
    private AttachmentService attachmentService;

    @RequestMapping(value = "/form", method = RequestMethod.GET)
    private String form(Model model, @RequestParam(value = "id", defaultValue = "0") Integer articleId, @RequestParam(value = "type", defaultValue = "0") Integer operateType) {
        if (!articleId.equals(0)) {
            Article article = articleService.selectByPrimaryKey(articleId);
            model.addAttribute("article", article);
            if (operateType.equals(0)) {
                Attachment att = attachmentService.selectByOrigin(articleId, HalalaDefine.ARTICLE_ATTACHMENT_TYPE);
                model.addAttribute("attachment", att);
            }
        }
        if (operateType.equals(0)) {
            List<ArticleType> list = articleTypeService.listAll();
            model.addAttribute("typelist", list);
            return "blog/atricle_form";
        } else {
            return "blog/atricle_setting_dialog";
        }
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    private String list(Model model, @RequestParam(value = "cp", defaultValue = "1") Integer currentPage, @RequestParam(value = "option", defaultValue = "option1") String option) {
        PageMethod.startPage(currentPage, 5);
        PageMethod.orderBy("update_time desc");
        Article record = new Article();
        List<Article> list = null;
        if ("option2".equals(option)) {
            // 草稿
            record.setIspublish(0);
            list = articleService.listByArticleSelective(record);
        } else if ("option3".equals(option)) {
            // 置顶
            record.setOntop(1);
            list = articleService.listByArticleSelective(record);
        } else if ("option4".equals(option)) {
            // 推荐
            record.setIselite(1);
            list = articleService.listByArticleSelective(record);
        } else if ("option5".equals(option)) {
            // 全部
            list = articleService.listByArticleSelective(record);
        } else {
            // 发布
            record.setIspublish(1);
            list = articleService.listByArticleSelective(record);
        }
        PageInfo<Article> pageInfo = new PageInfo<Article>(list);
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("option", option);
        return "blog/atricle_list";
    }

    @RequestMapping(value = "/typelist", method = RequestMethod.GET)
    private String typelist(Model model) {
        List<ArticleType> list = articleTypeService.listAll();
        model.addAttribute("list", list);
        return "blog/atricle_type_dialog";
    }

    @RequestMapping(value = "/typesave", method = RequestMethod.POST)
    @ResponseBody
    private Result<ArticleType> typesave(Model model, @RequestParam(value = "newtype") String newtype) {
        ArticleType at = new ArticleType();
        at.setType(newtype);
        int flg = 0;
        flg = articleTypeService.insertSelective(at);
        Result<ArticleType> result = null;
        if (flg > 0) {
            result = new Result<ArticleType>(true, "添加成功！");
        } else {
            result = new Result<ArticleType>(false, "系统出错，请稍后提交！");
        }
        return result;
    }

    @RequestMapping(value = "/typedelete", method = RequestMethod.GET)
    @ResponseBody
    private Result<ArticleType> typedelete(Model model, @RequestParam(value = "id") Integer id) {
        int flg = 0;
        flg = articleTypeService.deleteByPrimaryKey(id);
        Result<ArticleType> result = null;
        if (flg > 0) {
            result = new Result<ArticleType>(true, "删除成功！");
        } else {
            result = new Result<ArticleType>(false, "系统出错，请稍后提交！");
        }
        return result;
    }

    @RequestMapping(value = "/typeedit", method = RequestMethod.POST)
    @ResponseBody
    private Result<ArticleType> typeedit(Model model, ArticleType articleType) {
        int flg = 0;
        flg = articleTypeService.updateByPrimaryKeySelective(articleType);
        Result<ArticleType> result = null;
        if (flg > 0) {
            result = new Result<ArticleType>(true, "修改成功！");
        } else {
            result = new Result<ArticleType>(false, "系统出错，请稍后提交！");
        }
        return result;
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    private Result<Article> save(HttpServletRequest request, Article article) {

        int flg = 0;
        // request.setAttribute("currentuser", CookieUtil.getValue(request,
        // "currentuser"));
        // User user = (User) request.getSession().getAttribute("currentuser");
        if (article.getArticleId() == null) {

            article.setAuthor(CookieUtil.getValue(request, "currentuser"));
            article.setLiked(0);
            article.setHits(0);
            article.setCreateTime(DateUtil.getBeijingTime());
            article.setUpdateTime(DateUtil.getBeijingTime());
            article.setOntop(0);
            article.setIselite(0);
            flg = articleService.insertSelective(article);
        } else {
            article.setUpdateTime(DateUtil.getBeijingTime());
            flg = articleService.updateByPrimaryKeySelective(article);
//            System.out.println(article.getContent());
        }
        Result<Article> result = null;
        if (flg > 0) {
            result = new Result<Article>(true, article);
            // 创建一个通用的多部分解析器.
            CommonsMultipartResolver commonsMultipartResolver = new CommonsMultipartResolver(request.getSession().getServletContext());
            // 设置编码
            commonsMultipartResolver.setDefaultEncoding("utf-8");
            // 判断是否有文件上传
            if (commonsMultipartResolver.isMultipart(request)) {// 有文件上传
                // 上传文件路径
                String path = request.getSession().getServletContext().getRealPath(HalalaDefine.ARTICLE_ATTACHMENT_PATH);
                MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
                MultipartFile file = multipartRequest.getFile("pic1");
                // // 获取multiRequest 中所有的文件名
                // Iterator<String> iter = multipartRequest.getFileNames();
                // while (iter.hasNext()) {
                // MultipartFile imageFile =
                // multipartRequest.getFile(iter.next().toString());
                // }
                if (attachmentService.deleteFile(request, HalalaDefine.ARTICLE_ATTACHMENT_TYPE, article.getArticleId())) {
                    attachmentService.saveFile(file, path, HalalaDefine.ARTICLE_ATTACHMENT_PATH, HalalaDefine.ARTICLE_ATTACHMENT_TYPE, article.getArticleId());
                }
            }
        } else {
            result = new Result<Article>(false, "系统出错，请稍后提交！");
        }
        return result;
    }

    @RequestMapping(value = "/setting", method = RequestMethod.POST)
    @ResponseBody
    private Result<Article> setting(HttpServletRequest request, Article article) {
        int flg = 0;
        if (article.getArticleId() != null) {
            flg = articleService.updateByPrimaryKeySelective(article);
        }
        Result<Article> result = null;
        if (flg > 0) {
            result = new Result<Article>(true, article);
        } else {
            result = new Result<Article>(false, "系统出错，请稍后提交！");
        }
        return result;
    }

    @RequestMapping(value = "/delete", method = RequestMethod.GET)
    @ResponseBody
    private Result<Article> delete(HttpServletRequest request, @RequestParam(value = "id", defaultValue = "0") Integer articleId) {
        int flg = articleService.deleteByPrimaryKey(articleId);
        Result<Article> result = null;
        if (flg > 0) {
            if (attachmentService.deleteFile(request, HalalaDefine.ARTICLE_ATTACHMENT_TYPE, articleId)) {
                result = new Result<Article>(true, "删除成功！");
            } else {
                result = new Result<Article>(true, "相关附件未能成功删除！");
            }
        } else {
            result = new Result<Article>(false, "删除失败！");
        }
        return result;
    }

    @RequestMapping(value = "/{articleId}/detail", method = RequestMethod.GET)
    private String detail(@PathVariable("articleId") Integer articleId, Model model) {
        Article article = articleService.selectByPrimaryKey(articleId);
        model.addAttribute("article", article);
        return "web/detail";
    }
}
