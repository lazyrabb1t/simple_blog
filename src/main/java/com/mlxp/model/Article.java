package com.mlxp.model;

import java.io.Serializable;
import java.util.Date;

public class Article implements Serializable {
    /**
     * 
     */
    private static final long serialVersionUID = 1L;

    private Integer articleId;

    private String tittle;

    private String author;

    private Integer belongType;

    private Integer ispublish;

    private Integer iselite;

    private Integer ontop;

    private Integer liked;

    private Integer hits;

    private Date createTime;

    private Date updateTime;

    private String content;

    private ArticleType articleType;

    private String stringTime;

    private Attachment attachment;

    public String getTittle() {
        return tittle;
    }

    public void setTittle(String tittle) {
        this.tittle = tittle == null ? null : tittle.trim();
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author == null ? null : author.trim();
    }

    public Integer getBelongType() {
        return belongType;
    }

    public void setBelongType(Integer belongType) {
        this.belongType = belongType;
    }

    public Integer getIspublish() {
        return ispublish;
    }

    public void setIspublish(Integer ispublish) {
        this.ispublish = ispublish;
    }

    public Integer getIselite() {
        return iselite;
    }

    public void setIselite(Integer iselite) {
        this.iselite = iselite;
    }

    public Integer getOntop() {
        return ontop;
    }

    public void setOntop(Integer ontop) {
        this.ontop = ontop;
    }

    public Integer getHits() {
        return hits;
    }

    public void setHits(Integer hits) {
        this.hits = hits;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    public Integer getArticleId() {
        return articleId;
    }

    public void setArticleId(Integer articleId) {
        this.articleId = articleId;
    }

    public ArticleType getArticleType() {
        return articleType;
    }

    public void setArticleType(ArticleType articleType) {
        this.articleType = articleType;
    }

    public Attachment getAttachment() {
        return attachment;
    }

    public void setAttachment(Attachment attachment) {
        this.attachment = attachment;
    }

    public Integer getLiked() {
        return liked;
    }

    public void setLiked(Integer liked) {
        this.liked = liked;
    }

    public String getStringTime() {
        return stringTime;
    }

    public void setStringTime(String stringTime) {
        this.stringTime = stringTime;
    }
}