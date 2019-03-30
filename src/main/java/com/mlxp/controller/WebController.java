package com.mlxp.controller;

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

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.github.pagehelper.page.PageMethod;
import com.mlxp.define.HalalaDefine;
import com.mlxp.dto.Result;
import com.mlxp.model.Article;
import com.mlxp.model.ArticleType;
import com.mlxp.model.Attachment;
import com.mlxp.model.User;
import com.mlxp.service.ArticleService;
import com.mlxp.service.ArticleTypeService;
import com.mlxp.service.AttachmentService;
import com.mlxp.service.UserService;
import com.mlxp.util.WebUtil;

@Controller
public class WebController {

    @Autowired
    private ArticleService articleService;
    @Autowired
    private ArticleTypeService articleTypeService;
    @Autowired
    private AttachmentService attachmentService;
    @Autowired
    private UserService userService;

    @RequestMapping(value = "/")
    private String index(Model model, HttpServletRequest request,
            @RequestParam(value = "cp", defaultValue = "1") Integer currentPage) {
        globalContent(model);
        // 获取文章列表
        List<Article> list = WebUtil
                .getAttachments(articleService.listPublishedArticles(currentPage, HalalaDefine.ARTICLE_LIST_SIZE),attachmentService);
        PageInfo<Article> pageInfo = new PageInfo<Article>(WebUtil.getContent(list, HalalaDefine.ARTICLE_CONTENT_SIZE));
        model.addAttribute("pageInfo", pageInfo);
        return "web/major/index";
    }

    @RequestMapping(value = "/tags/{typeid}")
    private String listByType(Model model, @RequestParam(value = "cp", defaultValue = "1") Integer currentPage,
            @PathVariable("typeid") Integer typeid) {
        globalContent(model);
        List<Article> list = null;
        ArticleType at = null;
        // 获取列表
        if (typeid == 0) {
            list = articleService.listPublishedArticles(currentPage, HalalaDefine.ARTICLE_LIST_SIZE_SIMPLE);
            at = new ArticleType();
            at.setId(0);
            at.setType("我全都要");
        } else {
            at = articleTypeService.selectByPrimaryKey(typeid);
            list = articleService.listArticlesByType(currentPage, HalalaDefine.ARTICLE_LIST_SIZE_SIMPLE, typeid);
        }
        PageInfo<Article> pageInfo = new PageInfo<Article>(WebUtil.getContent(list, HalalaDefine.ARTICLE_CONTENT_SIZE_SIMPLE));
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("tag", at);
        return "web/major/listbytype";
    }

    @RequestMapping(value = "/search")
    private String search(Model model, @RequestParam(value = "cp", defaultValue = "1") Integer currentPage,
            @RequestParam(value = "keyword", defaultValue = "") String keyword) {
        globalContent(model);
        PageMethod.startPage(currentPage, 10);
        PageMethod.orderBy("update_time desc");
        List<Article> list = null;
        Article record = new Article();
        record.setIspublish(1);
        if (keyword.equals("")) {
            list = articleService.listByArticleSelective(record);
        } else {
            record.setTittle(keyword);
            list = articleService.listByArticleSelective(record);
        }
        PageInfo<Article> pageInfo = new PageInfo<Article>(WebUtil.getContent(list, HalalaDefine.ARTICLE_CONTENT_SIZE_SIMPLE));
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("keyword", keyword);
        return "web/major/listbykw";
    }

    @RequestMapping(value = "/detail/{articleId}", method = RequestMethod.GET)
    private String detail(@PathVariable("articleId") Integer articleId, Model model) {
        globalContent(model);
        Article article = articleService.selectByPrimaryKey(articleId);
        if (article != null) {
            // 代码高亮显示
            article.setContent(WebUtil.syntaxCode(article.getContent()));
            article.setAttachment(attachmentService.selectByOrigin(articleId, HalalaDefine.ARTICLE_ATTACHMENT_TYPE));
        }
        model.addAttribute("article", article);
        return "web/major/article";
    }

    @RequestMapping(value = "/web/liked", method = RequestMethod.POST)
    @ResponseBody
    private Result<Article> liked(Model model, @RequestParam(value = "id", defaultValue = "-1") Integer articleId) {
        Result<Article> result = null;
        if (!articleId.equals(-1) && articleService.updateLikedPlusOne(articleId) > 0) {
            result = new Result<Article>(true, "操作成功");
        } else {
            result = new Result<Article>(false, "操作失败");
        }
        return result;
    }

    @RequestMapping(value = "/web/regret", method = RequestMethod.POST)
    @ResponseBody
    private Result<Article> regret(Model model, @RequestParam(value = "id", defaultValue = "-1") Integer articleId) {
        Result<Article> result = null;
        if (!articleId.equals(-1) && articleService.updateLikedSubOne(articleId) > 0) {
            result = new Result<Article>(true, "操作成功");
        } else {
            result = new Result<Article>(false, "操作失败");
        }
        return result;
    }

    /**
     * 设置侧边栏等通用内容
     * 
     * @param model
     */
    private void globalContent(Model model) {
        // 文章类型
        List<ArticleType> typeList = articleTypeService.listAll();
        // 推荐文章
        List<Article> iseliteList = WebUtil.getAttachments(articleService.listEliteArticles(2),attachmentService);
        // 头像
        Attachment att = attachmentService.selectByOrigin(HalalaDefine.LAZYRABBIT_ID,
                HalalaDefine.USER_ATTACHMENT_TYPE);
        // 用户信息 获得LOL自定义内容
        User user = userService.selectByPrimaryKey(HalalaDefine.LAZYRABBIT_ID);
        if (att != null) {
            model.addAttribute("profilepicture", att.getSavepath());
        }

        model.addAttribute("lol", user.getLol());
        model.addAttribute("typeList", typeList);
        model.addAttribute("iseliteList", iseliteList);
    }
}
