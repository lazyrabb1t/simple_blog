package com.mlxp.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageInfo;
import com.mlxp.define.HalalaDefine;
import com.mlxp.model.Article;
import com.mlxp.model.User;
import com.mlxp.service.ArticleService;
import com.mlxp.service.AttachmentService;
import com.mlxp.service.UserService;
import com.mlxp.util.RedisUtil;
import com.mlxp.util.WebUtil;

@Controller
public class SimpleController {

    @Autowired
    private ArticleService articleService;
    @Autowired
    private AttachmentService attachmentService;
    @Autowired
    private UserService userService;
    @Autowired
    private RedisUtil redisUtil;
    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    @RequestMapping(value = "/simple")
    private String simpleindex(Model model) {
        return "web/simple/index";
    }

    @RequestMapping(value = "/web/simplelist")
    private String simplelist(Model model, @RequestParam(value = "cp", defaultValue = "1") Integer currentPage) {

        User user = userService.selectByPrimaryKey(HalalaDefine.LAZYRABBIT_ID);

        // PageInfo<Article> pageInfo = (PageInfo<Article>)
        // redisTemplate.opsForValue().get("simplelist");
        PageInfo<Article> pageInfo = (PageInfo<Article>) redisUtil.get2("simplelist");
        if (pageInfo == null) {
            List<Article> list = articleService.listPublishedArticles(currentPage, HalalaDefine.ARTICLE_LIST_SIZE);
            pageInfo = new PageInfo<Article>(WebUtil.getContent(list, HalalaDefine.ARTICLE_CONTENT_SIZE_SIMPLE));
            // redisTemplate.opsForValue().set("simplelist", pageInfo);
            redisUtil.set2("simplelist", pageInfo);

        }
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("lol", user.getLol());
        return "web/simple/list";
    }

    @RequestMapping(value = "/web/simplemore")
    @ResponseBody
    private List<Article> simplemore(Model model, @RequestParam(value = "cp", defaultValue = "1") Integer currentPage) {

        List<Article> list = articleService.listPublishedArticles(currentPage, HalalaDefine.ARTICLE_LIST_SIZE);
        return WebUtil.getContent(list, HalalaDefine.ARTICLE_CONTENT_SIZE_SIMPLE);
    }

    @RequestMapping(value = "/web/{articleId}/simpledetail", method = RequestMethod.GET)
    private String simpledetail(@PathVariable("articleId") Integer articleId, Model model) {

        Article article = articleService.selectByPrimaryKey(articleId);
        if (article != null) {
            // 对代码进行高亮处理
            article.setContent(WebUtil.syntaxCode(article.getContent()));
            article.setAttachment(attachmentService.selectByOrigin(articleId, HalalaDefine.ARTICLE_ATTACHMENT_TYPE));
        }
        model.addAttribute("article", article);
        return "web/simple/article";
    }

    @RequestMapping(value = "/web/simplelistbytype")
    private String simplelistByType(Model model, @RequestParam(value = "cp", defaultValue = "1") Integer currentPage,
            @RequestParam(value = "typeid", defaultValue = "1") Integer typeid, @RequestParam(value = "type", defaultValue = "发生了什么？") String type) {

        List<Article> list = null;
        if (typeid.equals(-1)) {
            list = articleService.listPublishedArticles(currentPage, HalalaDefine.ARTICLE_LIST_SIZE_SIMPLE);
        } else {
            list = articleService.listArticlesByType(currentPage, HalalaDefine.ARTICLE_LIST_SIZE_SIMPLE, typeid);
        }
        PageInfo<Article> pageInfo = new PageInfo<Article>(WebUtil.getContent(list, 200));
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("type", type);
        model.addAttribute("typeid", typeid);
        return "web/simple/listbytype";
    }
}
