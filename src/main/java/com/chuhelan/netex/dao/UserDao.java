package com.chuhelan.netex.dao;

import com.chuhelan.netex.domain.Address;
import com.chuhelan.netex.domain.User;
import org.apache.ibatis.annotations.*;

/**
 * @description:
 * @author: chuhelan
 * @create: 2021-05-25 08:31
 **/

@Mapper
public interface UserDao {

    // Select

    @Select("select * from netex_user where user_id=#{id}")
    public User findUserById(Integer id);

    @Select("select * from netex_user where user_email=#{email}")
    public User findUserByMail(String email);

    @Select("select * from netex_address where address_userID=#{id}")
    public Address[] getUserAddresses(Integer id
                                      
    @Select("select * from netex_user where user_token=#{user_token} and user_id=#{id}")
    public User getUserInfoByToken(Integer id, String token);
                                      

    // Update

    @Update("update netex_user set user_token=#{token}, user_dtime=#{dtime} where user_id=#{id}")
    public void loginUser(@Param("id") Integer id, @Param("token") String token, @Param("dtime") String dtime);

    // insert

    @Insert("insert into netex_user ( user_name, user_profile, user_email, user_password, user_phone ) values ( #{name}, '', #{mail}, #{password}, #{phone} );")
    public void regUser(@Param("name") String name, @Param("mail") String mail, @Param("password") String password, @Param("phone") String phone);
}