package com.mlxp.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

import com.mlxp.model.Attachment;

public interface AttachmentService {

    int deleteByPrimaryKey(Integer id);

    int insert(Attachment record);

    int insertSelective(Attachment record);

    Attachment selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Attachment record);

    int updateByPrimaryKey(Attachment record);

    boolean saveFile(MultipartFile file, String savepath, String relativepath, Integer type, Integer oriid);

    Attachment selectByOrigin(Integer oriid, Integer type);

    int deleteByOrigin(Integer oriid, Integer type);

    boolean deleteFile(HttpServletRequest request, Integer type, Integer oriid);
}
