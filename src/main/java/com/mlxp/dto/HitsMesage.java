package com.mlxp.dto;

import java.util.Date;

public class HitsMesage {

    private String ip;

    private Date lastHitsTime;

    private Integer hitsId;

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public Date getLastHitsTime() {
        return lastHitsTime;
    }

    public void setLastHitsTime(Date lastHitsTime) {
        this.lastHitsTime = lastHitsTime;
    }

    public Integer getHitsId() {
        return hitsId;
    }

    public void setHitsId(Integer hitsId) {
        this.hitsId = hitsId;
    }
}
