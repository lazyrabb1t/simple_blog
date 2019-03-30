package com.mlxp.service;

import java.util.List;

import com.mlxp.model.Article;

public interface ArticleService {
    int deleteByPrimaryKey(Integer articleId);

    int insert(Article record);

    int insertSelective(Article record);

    Article selectByPrimaryKey(Integer articleId);

    int updateByPrimaryKeySelective(Article record);

    int updateByPrimaryKeyWithBLOBs(Article record);

    int updateByPrimaryKey(Article record);

    List<Article> listAll();

    List<Article> listAllWithType();

    List<Article> listByArticleSelective(Article article);

    int updateLikedPlusOne(Integer articleId);

    int updateLikedSubOne(Integer articleId);

    int updateHitsPlusOne(Integer articleId);

    int countAll();

    int countAllHits();

    int countAllLiked();

    /**
     * @param num
     * @return 推荐的文章列表
     */
    List<Article> listEliteArticles(Integer num);

    /**
     * @param currentPage
     * @param num
     * @return 发布的文章列表
     */
    List<Article> listPublishedArticles(Integer currentPage, Integer num);

    /**
     * @param currentPage
     * @param num
     * @return 发布的文章列表
     */
    List<Article> listArticlesByType(Integer currentPage, Integer num, Integer typeid);
}
