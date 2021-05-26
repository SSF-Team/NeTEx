package com.chuhelan.netex.service;

import com.chuhelan.netex.domain.User;

public interface UserService {
    public User findUserById(Integer id);
    public User findUserByMail(String email);

    public void loginUser(User user, String token, String dietime);
    public void regUser(String name, String phone, String mail, String password);
}