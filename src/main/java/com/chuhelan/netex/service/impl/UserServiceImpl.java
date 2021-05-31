package com.chuhelan.netex.service.impl;

import com.chuhelan.netex.dao.UserDao;
import com.chuhelan.netex.domain.Address;
import com.chuhelan.netex.domain.User;
import com.chuhelan.netex.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
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
     * @Author Stapxs
     * @Description 使用 ID 寻找用户
     * @Date 下午 05:10 2021/5/26
     * @Param [id]
     * @return com.chuhelan.netex.domain.User
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
     * @Author Stapxs
     * @Description 使用邮箱寻找用户
     * @Date 下午 05:10 2021/5/26
     * @Param [email]
     * @return com.chuhelan.netex.domain.User
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
     * @Author Stapxs
     * @Description 登录
     * @Date 下午 05:11 2021/5/26
     * @Param [user, token, dietime]
     * @return void
    **/
    @Override
    public void loginUser(User user, String token, String dietime) {
        System.out.println("操作 > 登录 > LogginUser > " + token + "/" +dietime);
        userDao.loginUser(user.getUser_id(), token, dietime);
    }

    /**
     * @Author Stapxs
     * @Description 注册
     * @Date 下午 05:11 2021/5/26
     * @Param [name, phone, mail, password]
     * @return void
    **/
    @Override
    public void regUser(String name, String phone, String mail, String password) {
        System.out.println("操作 > 注册 > RegUser");
        userDao.regUser(name, mail, password, phone);
    }

    /**
     * @Author Stapxs
     * @Description 使用 token 验证登录
     * @Date 下午 05:11 2021/5/26
     * @Param [id, token]
     * @return java.lang.String
    **/
    @Override
    public String verificationToken(Integer id, String token) throws ParseException {
        System.out.println("操作 > 验证 Token");
        // 检索用户信息
        User user = findUserById(id);
        // 验证登录
        if(user != null && user.getUser_token().equals(token)) {
            // 验证 token 有效性
            // 获取时间
            SimpleDateFormat sdf = new SimpleDateFormat();
            sdf.applyPattern("yyyyMMdd");
            Date tokenTime = sdf.parse(user.getUser_dtime());
            Date date = new Date();
            if(date.compareTo(tokenTime) < 0) {
                return "ok";
            } else {
                return "err - 验证登陆失败（登录超时）";
            }
        } else {
            return "err - 验证登陆失败（登录无效）";
        }
    }

    /**
     * @Author Stapxs
     * @Description 获取用户地址信息
     * @Date 上午 08:34 2021/5/31
     * @Param [id, token]
     * @return java.lang.String
    **/
    @Override
    public Address[] getAddresses(Integer id, String token) throws ParseException {
        System.out.println("操作 > 获取用户地址");
        String passToken = verificationToken(id, token);
        if(passToken.equals("ok")) {
            Address[] addresses = userDao.getUserAddresses(id);
            System.out.println("操作 > 获取用户地址 > 地址列表为：");
            System.out.println(Arrays.toString(addresses));
            return addresses;
        } else {
            // 返回填充报错的 Address 数组
            return new Address[] {
                    new Address(-1, "", "", passToken)
            };
        }
    }
}