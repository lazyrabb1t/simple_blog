package com.mlxp.service.impl;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.mlxp.dao.AttachmentMapper;
import com.mlxp.define.HalalaDefine;
import com.mlxp.dto.EditorUploadExecution;
import com.mlxp.model.Attachment;
import com.mlxp.service.AttachmentService;
import com.mlxp.util.DateUtil;

@Service
public class AttachmentServiceImpl implements AttachmentService {

    @Autowired
    AttachmentMapper attchamentDao;

    @Override
    public int deleteByPrimaryKey(Integer attchamentId) {
        // TODO Auto-generated method stub
        return attchamentDao.deleteByPrimaryKey(attchamentId);
    }

    @Override
    public int insert(Attachment record) {
        // TODO Auto-generated method stub
        return attchamentDao.insert(record);
    }

    @Override
    public int insertSelective(Attachment record) {
        // TODO Auto-generated method stub
        return attchamentDao.insertSelective(record);
    }

    @Override
    public Attachment selectByPrimaryKey(Integer attchamentId) {
        // TODO Auto-generated method stub
        return attchamentDao.selectByPrimaryKey(attchamentId);
    }

    @Override
    public int updateByPrimaryKeySelective(Attachment record) {
        // TODO Auto-generated method stub
        return attchamentDao.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKey(Attachment record) {
        // TODO Auto-generated method stub
        return attchamentDao.updateByPrimaryKey(record);
    }

    @Override
    public boolean saveFile(MultipartFile file, String savepath, String relativepath, Integer type, Integer oriid) {

        if (!file.isEmpty()) {
            String filename = file.getOriginalFilename();
            String suffix = filename.substring(filename.lastIndexOf("."));
            String prefix = filename.substring(0, filename.lastIndexOf("."));
            File savingfile = new File(savepath, filename);
            // 判断路径是否存在，如果不存在就创建一个
            if (!savingfile.getParentFile().exists()) {
                savingfile.getParentFile().mkdirs();
            }
            SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
            Date d = DateUtil.getBeijingTime();
            // 将上传文件保存到一个目标文件当中
            String path = savepath + File.separator + prefix + "_" + df.format(d) + suffix;
            try {
                file.transferTo(new File(path));
                Attachment att = new Attachment();
                att.setFilename(filename);
                att.setOriid(oriid);
                att.setSavepath(relativepath + prefix + "_" + df.format(d) + suffix);
                att.setType(type);
                att.setSavetime(d);
                attchamentDao.insertSelective(att);
            } catch (IOException e) {
                return false;
            }
        } else {
            return false;
        }
        return true;
    }

    @Override
    public boolean deleteFile(HttpServletRequest request, Integer type, Integer oriid) {

        Attachment att = this.selectByOrigin(oriid, type);
        if (att != null) {
            File file = new File(request.getSession().getServletContext().getRealPath(att.getSavepath()));
            if (file.exists() && file.isFile()) {
                if (file.delete()&&this.deleteByOrigin(oriid, type)>0) {
//                    this.deleteByOrigin(oriid, type);
                } else {
                    return false;
                }
            } else {
                if (this.deleteByOrigin(oriid, type)<=0){
                    return false;
                }
            }
        }
        return true;
    }

    @Override
    public Attachment selectByOrigin(Integer oriid, Integer type) {
        // TODO Auto-generated method stub
        return attchamentDao.selectByOrigin(oriid, type);
    }

    @Override
    public int deleteByOrigin(Integer oriid, Integer type) {
        // TODO Auto-generated method stub
        return attchamentDao.deleteByOrigin(oriid, type);
    }
}
