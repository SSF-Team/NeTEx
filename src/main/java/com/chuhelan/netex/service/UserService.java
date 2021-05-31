package com.chuhelan.netex.service;

import com.chuhelan.netex.domain.Address;
import com.chuhelan.netex.domain.User;

import java.text.ParseException;

public interface UserService {
    public User findUserById(Integer id);
    public User findUserByMail(String email);

    public void loginUser(User user, String token, String dietime);
    public void regUser(String name, String phone, String mail, String password);
    public String verificationToken(Integer id, String token) throws ParseException;
    public Address[] getAddresses(Integer id, String token) throws ParseException;
}