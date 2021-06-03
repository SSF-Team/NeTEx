package com.chuhelan.netex.service;

import com.chuhelan.netex.domain.Address;
import com.chuhelan.netex.domain.User;
import org.springframework.lang.Nullable;

import java.text.ParseException;

public interface UserService {
    public User findUserById(Integer id);
    public User findUserByMail(String email);
    public User findUserByPhone(String phone);
    public User getUserInfoByToken(Integer id, String token) throws ParseException;
    public void loginUser(User user, String token, String dietime);
    public void regUser(String name, String phone, String mail, String password);
    public String verificationToken(Integer id, String token) throws ParseException;
    public Address[] getAddresses(Integer id, String token) throws ParseException;
    public Address getAddressById(Integer id, @Nullable Integer uid, @Nullable String token) throws ParseException;
    public Address fullAddress(Integer id, String name, String phone, String address);
}