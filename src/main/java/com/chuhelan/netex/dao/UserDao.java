package com.chuhelan.netex.dao;

import com.chuhelan.netex.domain.Address;
import com.chuhelan.netex.domain.PointInfo;
import com.chuhelan.netex.domain.User;
import org.apache.ibatis.annotations.*;

import java.util.Date;

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
    @Select("select * from netex_user where user_email=#{phone}")
    public User findUserByPhone(String phone);
    @Select("select * from netex_user where user_type=1")
    public User[] findAllCourier();
    @Select("select * from netex_address where address_userID=#{id}")
    public Address[] getUserAddresses(Integer id);
    @Select("select * from netex_address where address_id=#{id}")
    public Address getAddress(Integer id);
    @Select("select * from netex_user where user_id=#{id}")
    public User getUserInfoByToken(Integer id);
    @Select("select * from netex_points where points_userId=#{id}")
    public PointInfo[] getUserPoints(Integer id);
    @Select("select * from netex_points where points_userId=#{id} and points_time=#{date}")
    public PointInfo getUserPointByTime(@Param("id") Integer id, @Param("date") Date date);


    // Update

    @Update("update netex_user set user_token=#{token}, user_dtime=#{dtime} where user_id=#{id}")
    public void loginUser(@Param("id") Integer id, @Param("token") String token, @Param("dtime") String dtime);
    @Update("update netex_user set user_point=#{num} where user_id=#{id}")
    public void changePoint(@Param("id") Integer id, @Param("num") Integer num);
    @Update("update netex_user set user_name=#{name}, user_gender=#{gender}, user_email=#{mail}, user_phone=#{phone} where user_id=#{uid}")
    public void updateUserInfo(@Param("uid") Integer uid, @Param("name") String name, @Param("gender") String gender, @Param("mail") String mail, @Param("phone") String phone);
    @Update("update netex_user set user_profile=#{add} where user_id=#{id}")
    public void updateProfile( @Param("id") Integer id, @Param("add") String add);

    // Insert

    @Insert("insert into netex_user ( user_name, user_profile, user_email, user_password, user_phone ) values ( #{name}, '', #{mail}, #{password}, #{phone} );")
    public void regUser(@Param("name") String name, @Param("mail") String mail, @Param("password") String password, @Param("phone") String phone);
    @Insert("insert into netex_points ( points_userId, points_time, points_change, points_content ) values ( #{id}, #{time}, #{num}, #{info} )")
    public void addPointInfo(@Param("id") Integer id, @Param("time") Date time, @Param("num") Integer num, @Param("info") String info);
    @Insert("insert into netex_address ( address_userID, address_name, address_phone, address_content ) values ( #{uid}, #{name}, #{phone}, #{address} )")
    public void addAddress(@Param("uid") Integer uid, @Param("name") String name, @Param("phone") String phone, @Param("address") String address);

    // Delete

    @Delete("delete from netex_address where address_id=#{id}")
    public void deleteAddress(Integer id);
}