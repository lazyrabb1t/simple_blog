package com.mlxp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mlxp.dao.ViewLogMapper;
import com.mlxp.dto.VisitMessage;
import com.mlxp.model.ViewLog;
import com.mlxp.service.ViewLogService;

@Service
public class ViewLogServiceImpl implements ViewLogService {

    @Autowired
    ViewLogMapper viewLogDao;

    @Override
    public int insert(ViewLog record) {
        // TODO Auto-generated method stub
        return viewLogDao.insertSelective(record);
    }

    @Override
    public List<VisitMessage> countNDays(Integer viewType, Integer days) {
        // TODO Auto-generated method stub
        return viewLogDao.countNDays(viewType, days-1);
    }

    @Override
    public int countAll(Integer viewType) {
        // TODO Auto-generated method stub
        return viewLogDao.countAll(viewType);
    }

    @Override
    public int countNDaysBefore(Integer viewType, Integer days) {
        // TODO Auto-generated method stub
        return viewLogDao.countNDaysBefore(viewType, days);
    }


}
