package com.chuhelan.netex.service.impl;

import com.chuhelan.netex.dao.UserDao;
import com.chuhelan.netex.domain.User;
import com.chuhelan.netex.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

/**
 * @description:
 * @author: chuhelan
 * @create: 2021-05-25 08:32
 **/

@Service
@Transactional
public class UserServiceImpl implements UserService {
    @Autowired
    UserDao userDao;

    @Override
    public User findUserById(Integer id) {
        Optional<User> userOptional =
                Optional.ofNullable(userDao.findUserById(id));
        if (userOptional.isPresent()) {
            User user = userOptional.get();
            return user;
        }
        return null;
    }

    @Autowired


    @Override
    public User signin(String email, String password) {
        Optional<User> userOption =
                Optional.ofNullable(userDao.signin(email,password));
        if(userOption.isPresent()){
            User user
        }
        return null;
    }

}