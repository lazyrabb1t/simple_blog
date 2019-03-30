package com.mlxp.model;

import java.io.Serializable;

public class User implements Serializable {
    /**
     * 
     */
    private static final long serialVersionUID = 1L;

    private Integer id;

    private String accountname;

    private String password;

    private String username;

    private String lol;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getAccountname() {
        return accountname;
    }

    public void setAccountname(String accountname) {
        this.accountname = accountname == null ? null : accountname.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username == null ? null : username.trim();
    }

    public String getLol() {
        return lol;
    }

    public void setLol(String lol) {
        this.lol = lol == null ? null : lol.trim();
    }
}