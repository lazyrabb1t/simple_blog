package com.mlxp.service;

import java.util.List;

import com.mlxp.dto.VisitMessage;
import com.mlxp.model.ViewLog;

public interface ViewLogService {

    int insert(ViewLog record);

    /**
     * @Description: 统计访问量
     * @param: viewType 0:UV,1:PV
     * @return: int 访问量
     */  
    int countAll(Integer viewType);

    /**
     * @Description: 统计几天前的访问量  
     * @param: viewType 0:UV,1:PV
     * @param: days 几天前 0：今天，1：昨天
     * @return: int 访问量
     * @throws   
     */  
    int countNDaysBefore(Integer viewType, Integer days);

    /**
     * @Description: 统计之前几的访问量的集合
     * @param:viewType 0:UV,1:PV
     * @param:days @param days 统计从几天算起，统计的天数
     * @return: int 访问量
     */  
    List<VisitMessage> countNDays(Integer viewType, Integer days);

}
