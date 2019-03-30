package com.mlxp.model;

import java.io.Serializable;
import java.util.Date;

public class ViewLog implements Serializable {
    /**
     * 
     */
    private static final long serialVersionUID = 1L;

    private Integer id;

    private String uri;

    private String ipaddress;

    private Integer viewtype;

    private Date viewtime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUri() {
        return uri;
    }

    public void setUri(String uri) {
        this.uri = uri == null ? null : uri.trim();
    }

    public String getIpaddress() {
        return ipaddress;
    }

    public void setIpaddress(String ipaddress) {
        this.ipaddress = ipaddress == null ? null : ipaddress.trim();
    }

    public Integer getViewtype() {
        return viewtype;
    }

    public void setViewtype(Integer viewtype) {
        this.viewtype = viewtype;
    }

    public Date getViewtime() {
        return viewtime;
    }

    public void setViewtime(Date viewtime) {
        this.viewtime = viewtime;
    }
}