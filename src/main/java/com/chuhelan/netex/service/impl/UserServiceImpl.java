package com.chuhelan.netex.service.impl;

import com.chuhelan.netex.dao.UserDao;
import com.chuhelan.netex.domain.Address;
import com.chuhelan.netex.domain.PointInfo;
import com.chuhelan.netex.domain.User;
import com.chuhelan.netex.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.Optional;
import java.util.Random;

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
        System.out.println("操作 > 获取用户 > findUserById > " + id);
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
     * @Author Stapxs
     * @Description 使用手机号寻找用户
     * @Date 下午 04:36 2021/6/3
     * @Param [phone]
     * @return com.chuhelan.netex.domain.User
    **/
    public User findUserByPhone(String phone) {
        Optional<User> userOptional =
                Optional.ofNullable(userDao.findUserByPhone(phone));
        if (userOptional.isPresent()) {
            User user = userOptional.get();
            return user;
        }
        return null;
    }

    @Override
    public User getOneCourier() {
        User[] users = userDao.findAllCourier();
        Integer one = new Random().nextInt(users.length);
        return users[one];
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
        System.out.println("操作 > 验证 Token");
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

    /**
     * @Author Stapxs
     * @Description 获取用户的积分明细
     * @Date 下午 10:39 2021/6/4
     * @Param [id]
     * @return com.chuhelan.netex.domain.PointInfo[]
    **/
    @Override
    public PointInfo[] getUserPoints(Integer id) {
        return userDao.getUserPoints(id);
    }

    /**
     * @Author Stapxs
     * @Description 修改积分
     * @Date 下午 10:51 2021/6/4
     * @Param [num]
     * @return void
    **/
    @Override
    public void ChangePoint(Integer id, Integer num) {
        userDao.changePoint(id, num);
    }

    /**
     * @Author Stapxs
     * @Description 根据时间获取积分详情
     * @Date 下午 11:01 2021/6/4
     * @Param [id, date]
     * @return com.chuhelan.netex.domain.PointInfo
    **/
    @Override
    public PointInfo getPointByTime(Integer id, Date date) {
        return userDao.getUserPointByTime(id ,date);
    }

    /**
     * @Author Stapxs
     * @Description 添加积分详情
     * @Date 下午 11:13 2021/6/4
     * @Param [id, date, num, info]
     * @return void
    **/
    @Override
    public void addPointInfo(Integer id, Date date, Integer num, String info) {
        userDao.addPointInfo(id, date, num, info);
    }

    /**
     * @Author Stapxs
     * @Description 更新用户头像
     * @Date 上午 09:23 2021/6/9
     * @Param [id, address]
     * @return void
    **/
    @Override
    public void updateProfile(Integer id, String address) {
        userDao.updateProfile(id, address);
    }

    @Override
    public User getUserInfoByToken(Integer id, String token) throws ParseException {
        System.out.println("getUserInfoByToken");
        Optional<User> userOptional =
                Optional.ofNullable(userDao.getUserInfoByToken(id));
        if (userOptional.isPresent()) {
            User user = userOptional.get();
            String passToken = verificationToken(id, token);
            if (passToken.equals("ok")){
                return user;
            }
            else{
                // 返回填充错误信息的 User 对象
                return new User(-1, passToken);
            }
        }
        return null;
    }

    /**
     * @Author Stapxs
     * @Description 更新个人信息
     * @Date 上午 10:25 2021/6/8
     * @Param [name, gender, mail, phone]
     * @return void
    **/
    @Override
    public void updateUserInfo(Integer uid, String name, String gender, String mail, String phone) {
        userDao.updateUserInfo(uid, name, gender, mail, phone);
    }

}