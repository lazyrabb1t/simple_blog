package com.mlxp.dto;

import java.util.List;

public class HighChartsData {

    private String name;
    private List<Integer> data;

    public HighChartsData() {
        super();
    }
    public HighChartsData(String name, List<Integer> data) {
        super();
        this.name = name;
        this.data = data;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    public List<Integer> getData() {
        return data;
    }
    public void setData(List<Integer> data) {
        this.data = data;
    }
}
