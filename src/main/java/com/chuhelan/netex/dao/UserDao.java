package com.chuhelan.netex.dao;

import com.chuhelan.netex.domain.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

/**
 * @description:
 * @author: chuhelan
 * @create: 2021-05-25 08:31
 **/

@Mapper
public interface UserDao {
    @Select("select * from netex_user where user_id=#{id}")
    public User findUserById(Integer id);
}