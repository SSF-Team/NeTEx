package com.chuhelan.netex.service.impl;

import com.chuhelan.netex.dao.UserDao;
import com.chuhelan.netex.domain.User;
import com.chuhelan.netex.service.UserService;
import lombok.SneakyThrows;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
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

    /**
     * @return com.chuhelan.netex.domain.User
     * @Author Stapxs
     * @Description 使用 ID 寻找用户
     * @Date 下午 05:10 2021/5/26
     * @Param [id]
     **/
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

    /**
     * @return com.chuhelan.netex.domain.User
     * @Author Stapxs
     * @Description 使用邮箱寻找用户
     * @Date 下午 05:10 2021/5/26
     * @Param [email]
     **/
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

    /**
     * @return void
     * @Author Stapxs
     * @Description 登录
     * @Date 下午 05:11 2021/5/26
     * @Param [user, token, dietime]
     **/
    @Override
    public void loginUser(User user, String token, String dietime) {
        System.out.println("操作 > 登录 > LogginUser > " + token + "/" + dietime);
        userDao.loginUser(user.getUser_id(), token, dietime);
    }

    /**
     * @return void
     * @Author Stapxs
     * @Description 注册
     * @Date 下午 05:11 2021/5/26
     * @Param [name, phone, mail, password]
     **/
    @Override
    public void regUser(String name, String phone, String mail, String password) {
        System.out.println("操作 > 注册 > RegUser");
        userDao.regUser(name, mail, password, phone);
    }

    /**
     * @return java.lang.String
     * @Author Stapxs
     * @Description 使用 token 验证登录
     * @Date 下午 05:11 2021/5/26
     * @Param [id, token]
     **/
    @Override
    public String verificationToken(Integer id, String token) throws ParseException {
        // 检索用户信息
        User user = findUserById(id);
        // 验证登录
        if (user != null && user.getUser_token().equals(token)) {
            // 验证 token 有效性
            // 获取时间
            SimpleDateFormat sdf = new SimpleDateFormat();
            sdf.applyPattern("yyyyMMdd");
            Date tokenTime = sdf.parse(user.getUser_dtime());
            Date date = new Date();
            if (date.compareTo(tokenTime) < 0) {
                return "ok";
            } else {
                return "err - 验证登陆失败（登录超时）";
            }
        } else {
            return "err - 验证登陆失败（登录无效）";
        }
    }

    @SneakyThrows
    @Override
    public User getUserInfoByToken(Integer id, String token) {
        System.out.println("getUserInfoByToken");
        Optional<User> userOptional =
                Optional.ofNullable(userDao.getUserInfoByToken(id, token));
        if (userOptional.isPresent()) {
            User user = userOptional.get();
            if (verificationToken(id, token).equals("ok")){
                return user;
            }
            else{
                return null;
            }
        }
        return null;
    }
}