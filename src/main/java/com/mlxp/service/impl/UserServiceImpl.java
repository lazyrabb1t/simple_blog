package com.mlxp.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mlxp.dao.UserMapper;
import com.mlxp.model.User;
import com.mlxp.service.UserService;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    UserMapper userDao;

    @Override
    public int deleteByPrimaryKey(Integer userId) {
        // TODO Auto-generated method stub
        return userDao.deleteByPrimaryKey(userId);
    }

    @Override
    public int insert(User record) {
        // TODO Auto-generated method stub
        return userDao.insert(record);
    }

    @Override
    public int insertSelective(User record) {
        // TODO Auto-generated method stub
        return userDao.insertSelective(record);
    }

    @Override
    public User selectByPrimaryKey(Integer userId) {
        // TODO Auto-generated method stub
        return userDao.selectByPrimaryKey(userId);
    }

    @Override
    public int updateByPrimaryKeySelective(User record) {
        // TODO Auto-generated method stub
        return userDao.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKey(User record) {
        // TODO Auto-generated method stub
        return userDao.updateByPrimaryKey(record);
    }

    @Override
    public User selectByAccountname(String accountname) {
        // TODO Auto-generated method stub
        return userDao.selectByAccountname(accountname);
    }
}
