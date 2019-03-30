package com.mlxp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.mlxp.dto.VisitMessage;
import com.mlxp.model.ViewLog;

public interface ViewLogMapper {

    int countAll(@Param("viewType")Integer viewType);

    int countNDaysBefore(@Param("viewType")Integer viewType, @Param("days") Integer days);

    List<VisitMessage> countNDays(@Param("viewType") Integer viewType, @Param("days") Integer days);

    int insertSelective(ViewLog record);
}