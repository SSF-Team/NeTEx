package com.chuhelan.netex.service;

import com.chuhelan.netex.domain.Address;

import java.text.ParseException;

/**
 * @Version: 1.0
 * @Date: 2021/6/4 下午 09:36
 * @ClassName: AddressService
 * @Author: Stapxs
 * @Description TO DO
 **/
public interface AddressService {

    public Address[] getAddresses(Integer id, String token) throws ParseException;
    public Address findAddressByID(Integer id);
    public void deleteAddress(Integer id);
}
