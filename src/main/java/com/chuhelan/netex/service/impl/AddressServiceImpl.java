package com.chuhelan.netex.service.impl;

import com.chuhelan.netex.dao.UserDao;
import com.chuhelan.netex.domain.Address;
import com.chuhelan.netex.service.AddressService;
import com.chuhelan.netex.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.ParseException;
import java.util.Arrays;
import java.util.Optional;

/**
 * @Version: 1.0
 * @Date: 2021/6/4 下午 09:37
 * @ClassName: AddressServiceImpl
 * @Author: Stapxs
 * @Description TO DO
 **/

@Service
@Transactional
public class AddressServiceImpl implements AddressService {

    @Autowired
    UserDao userDao;
    @Autowired
    UserService userService;

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
        String passToken = userService.verificationToken(id, token);
        if (passToken.equals("ok")) {
            Address[] addresses = userDao.getUserAddresses(id);
            System.out.println("操作 > 获取用户地址 > 地址列表为：");
            System.out.println(Arrays.toString(addresses));
            return addresses;
        } else {
            // 返回填充报错的 Address 数组
            return new Address[]{
                    new Address(-1, -1, "", "", passToken)
            };
        }
    }

    /**
     * @Author Stapxs
     * @Description 根据 ID 获取地址
     * @Date 下午 09:01 2021/6/4
     * @Param [id]
     * @return com.chuhelan.netex.domain.Address
     **/
    @Override
    public Address findAddressByID(Integer id) {
        Optional<Address> userOptional =
                Optional.ofNullable(userDao.getAddress(id));
        return userOptional.orElse(null);
    }

    /**
     * @Author Stapxs
     * @Description 删除地址簿的一个地址
     * @Date 下午 08:58 2021/6/4
     * @Param [id]
     * @return void
     **/
    @Override
    public void deleteAddress(Integer id) {
        userDao.deleteAddress(id);
    }

    /**
     * @Author Stapxs
     * @Description 添加地址
     * @Date 上午 10:28 2021/6/9
     * @Param [uid, name, phone, address]
     * @return void
    **/
    @Override
    public void addAddress(Integer uid, String name, String phone, String address) {
        userDao.addAddress(uid, name, phone, address);
    }
}
