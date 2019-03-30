package com.mlxp.dao;

import org.apache.ibatis.annotations.Param;

import com.mlxp.model.Attachment;

public interface AttachmentMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Attachment record);

    int insertSelective(Attachment record);

    Attachment selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Attachment record);

    int updateByPrimaryKey(Attachment record);
    
    Attachment selectByOrigin(@Param("oriid") Integer oriid, @Param("type") Integer type);
    
    int deleteByOrigin(@Param("oriid") Integer oriid, @Param("type") Integer type);

}