package com.mlxp.service;

import java.util.List;

import com.mlxp.model.ArticleType;

public interface ArticleTypeService {
    int deleteByPrimaryKey(Integer id);

    int insert(ArticleType record);

    int insertSelective(ArticleType record);

    ArticleType selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ArticleType record);

    int updateByPrimaryKey(ArticleType record);

    List<ArticleType> listAll();

    int countAll();
}
