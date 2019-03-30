package com.mlxp.dao;

import java.util.List;

import com.mlxp.model.Article;

public interface ArticleMapper {
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

}