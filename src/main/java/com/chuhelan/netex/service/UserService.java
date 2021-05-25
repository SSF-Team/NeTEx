package com.chuhelan.netex.service;

import com.chuhelan.netex.domain.User;

public interface UserService {
    public User findUserById(Integer id);

    public User signin(String email,String password);
}