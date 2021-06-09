package com.chuhelan.netex.service;

import com.chuhelan.netex.domain.Address;
import com.chuhelan.netex.domain.PointInfo;
import com.chuhelan.netex.domain.User;
import org.springframework.lang.Nullable;

import java.awt.dnd.DropTarget;
import java.text.ParseException;
import java.util.Date;

public interface UserService {
    public User findUserById(Integer id);
    public User findUserByMail(String email);
    public User findUserByPhone(String phone);
    public User getUserInfoByToken(Integer id, String token) throws ParseException;
    public void updateUserInfo(Integer uid, String name, String gender, String mail, String phone);

    public User getOneCourier();

    public void loginUser(User user, String token, String dietime);
    public void regUser(String name, String phone, String mail, String password);
    public String verificationToken(Integer id, String token) throws ParseException;

    public PointInfo[] getUserPoints(Integer id);
    public void ChangePoint(Integer id, Integer num);
    public PointInfo getPointByTime(Integer id, Date date);
    public void addPointInfo(Integer id, Date date, Integer num, String info);

    public void updateProfile(Integer id ,String address);
}