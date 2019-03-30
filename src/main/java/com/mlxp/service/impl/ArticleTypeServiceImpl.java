package com.mlxp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mlxp.dao.ArticleTypeMapper;
import com.mlxp.model.ArticleType;
import com.mlxp.service.ArticleTypeService;

@Service
public class ArticleTypeServiceImpl implements ArticleTypeService {

    @Autowired
    ArticleTypeMapper articleDao;

    @Override
    public int deleteByPrimaryKey(Integer id) {
        // TODO Auto-generated method stub
        return articleDao.deleteByPrimaryKey(id);
    }

    @Override
    public int insert(ArticleType record) {
        // TODO Auto-generated method stub
        return articleDao.insert(record);
    }

    @Override
    public int insertSelective(ArticleType record) {
        // TODO Auto-generated method stub
        return articleDao.insertSelective(record);
    }

    @Override
    public ArticleType selectByPrimaryKey(Integer id) {
        // TODO Auto-generated method stub
        return articleDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(ArticleType record) {
        // TODO Auto-generated method stub
        return articleDao.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKey(ArticleType record) {
        // TODO Auto-generated method stub
        return articleDao.updateByPrimaryKey(record);
    }

    @Override
    public List<ArticleType> listAll() {
        // TODO Auto-generated method stub
        return articleDao.listAll();
    }

    @Override
    public int countAll() {
        // TODO Auto-generated method stub
        return articleDao.countAll();
    }

}
