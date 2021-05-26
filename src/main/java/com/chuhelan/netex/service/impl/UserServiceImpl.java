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

    @Override
    public User findUserByMail(String email) {
        Optional<User> userOptional =
                Optional.ofNullable(userDao.findUserByMail(email));
        if (userOptional.isPresent()) {
            User user = userOptional.get();
            return user;
        }
        return null;
    }

    @Override
    public void loginUser(User user, String token, String dietime) {
        System.out.println("操作 > 登录 > LogginUser > " + token + "/" +dietime);
        userDao.loginUser(user.getUser_id(), token, dietime);
    }

    @Override
    public void regUser(String name, String phone, String mail, String password) {
        System.out.println("操作 > 注册 > RegUser");
        userDao.regUser(name, mail, password, phone);
    }
}