package com.mlxp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.page.PageMethod;
import com.mlxp.dao.ArticleMapper;
import com.mlxp.model.Article;
import com.mlxp.service.ArticleService;

/**
 * @author admin
 *
 */
/**
 * @author admin
 *
 */
@Service
public class ArticleServiceImpl implements ArticleService {

    @Autowired
    ArticleMapper articleDao;

    @Override
    public int deleteByPrimaryKey(Integer articleId) {
        // TODO Auto-generated method stub
        return articleDao.deleteByPrimaryKey(articleId);
    }

    @Override
    public int insert(Article record) {
        // TODO Auto-generated method stub
        return articleDao.insert(record);
    }

    @Override
    public int insertSelective(Article record) {
        // TODO Auto-generated method stub
        return articleDao.insertSelective(record);
    }

    @Override
    public Article selectByPrimaryKey(Integer articleId) {
        // TODO Auto-generated method stub
        return articleDao.selectByPrimaryKey(articleId);
    }

    @Override
    public int updateByPrimaryKeySelective(Article record) {
        // TODO Auto-generated method stub
        return articleDao.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKeyWithBLOBs(Article record) {
        // TODO Auto-generated method stub
        return articleDao.updateByPrimaryKeyWithBLOBs(record);
    }

    @Override
    public int updateByPrimaryKey(Article record) {
        // TODO Auto-generated method stub
        return articleDao.updateByPrimaryKey(record);
    }

    @Override
    public List<Article> listAll() {
        // TODO Auto-generated method stub
        return articleDao.listAll();
    }

    @Override
    public List<Article> listAllWithType() {
        // TODO Auto-generated method stub
        return articleDao.listAllWithType();
    }

    @Override
    public List<Article> listByArticleSelective(Article article) {
        // TODO Auto-generated method stub
        return articleDao.listByArticleSelective(article);
    }

    @Override
    public int updateLikedPlusOne(Integer articleId) {
        // TODO Auto-generated method stub
        return articleDao.updateLikedPlusOne(articleId);
    }

    @Override
    public int updateLikedSubOne(Integer articleId) {
        // TODO Auto-generated method stub
        return articleDao.updateLikedSubOne(articleId);
    }

    @Override
    public int updateHitsPlusOne(Integer articleId) {
        // TODO Auto-generated method stub
        return articleDao.updateHitsPlusOne(articleId);
    }

    @Override
    public int countAll() {
        // TODO Auto-generated method stub
        return articleDao.countAll();
    }

    @Override
    public int countAllHits() {
        // TODO Auto-generated method stub
        return articleDao.countAllHits();
    }

    @Override
    public int countAllLiked() {
        // TODO Auto-generated method stub
        return articleDao.countAllLiked();
    }

    @Override
    public List<Article> listEliteArticles(Integer num) {
        // TODO Auto-generated method stub
        Article a = new Article();
        a.setIselite(1);
        PageMethod.orderBy("update_time desc");
        PageMethod.startPage(1, num);

        return articleDao.listByArticleSelective(a);
    }

    @Override
    public List<Article> listPublishedArticles(Integer currentPage, Integer num) {
        // TODO Auto-generated method stub
        PageMethod.startPage(currentPage, num);
        // 按照是否置顶,更新时间排序
        PageMethod.orderBy("ontop desc,update_time desc");
        // PageHelper.orderBy("update_time desc");
        Article record = new Article();
        record.setIspublish(1);
        return articleDao.listByArticleSelective(record);
    }

    @Override
    public List<Article> listArticlesByType(Integer currentPage, Integer num, Integer typeid) {
        // TODO Auto-generated method stub
        PageMethod.startPage(currentPage, num);
        PageMethod.orderBy("update_time desc");
        List<Article> list = null;
        Article record = new Article();
        record.setIspublish(1);
        if (typeid.equals(-1)) {
            list = articleDao.listByArticleSelective(record);
        } else {
            record.setBelongType(typeid);
            list = articleDao.listByArticleSelective(record);
        }
        return list;
    }
}
