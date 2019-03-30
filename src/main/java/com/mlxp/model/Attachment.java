package com.mlxp.model;

import java.io.Serializable;
import java.util.Date;

public class Attachment implements Serializable {
    /**
     * 
     */
    private static final long serialVersionUID = 1L;

    private Integer id;

    private Integer type;

    private Integer oriid;

    private String filename;

    private String savepath;

    private Date savetime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Integer getOriid() {
        return oriid;
    }

    public void setOriid(Integer oriid) {
        this.oriid = oriid;
    }

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename == null ? null : filename.trim();
    }

    public String getSavepath() {
        return savepath;
    }

    public void setSavepath(String savepath) {
        this.savepath = savepath == null ? null : savepath.trim();
    }

    public Date getSavetime() {
        return savetime;
    }

    public void setSavetime(Date savetime) {
        this.savetime = savetime;
    }
}