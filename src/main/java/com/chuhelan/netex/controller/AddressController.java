package com.chuhelan.netex.controller;

import com.chuhelan.netex.domain.Address;
import com.chuhelan.netex.domain.User;
import com.chuhelan.netex.service.AddressService;
import com.chuhelan.netex.service.OrderService;
import com.chuhelan.netex.service.UserService;
import com.chuhelan.netex.service.WorkOrderService;
import com.chuhelan.netex.util.legality;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

/**
 * @Version: 1.0
 * @Date: 2021/6/4 下午 09:35
 * @ClassName: AddressController
 * @Author: Stapxs
 * @Description TO DO
 **/

@Controller
public class AddressController {

    @Autowired
    UserService userService;
    @Autowired
    OrderService orderService;
    @Autowired
    AddressService addressService;
    @Autowired
    WorkOrderService workOrderService;

    // 实际功能 API
    @GetMapping("/DeleteAdd")
    public String deleteAddress(Integer aid, Integer uid, String tid, @Nullable String back, Model model) throws ParseException {
        System.out.println("操作 > 删除地址 > deleteAddress > " + aid + " / " + back);
        // 验证 token
        if(userService.verificationToken(uid, tid).equals("ok")) {
            // 验证地址簿拥有权
            Address add = addressService.findAddressByID(aid);
            if(add != null && add.getAddress_userID().equals(uid)) {
                // 删除
                addressService.deleteAddress(aid);
            } else {
                if(back == null) {
                    model.addAttribute("err", "地址簿不存在或权限错误！");
                } else {
                    model.addAttribute("str", "{\"stat\":403, \"msg\":\"地址簿不存在或权限错误！\"}");
                }
            }
        } else {
            if(back == null) {
                model.addAttribute("err", "验证登陆失败");
            } else {
                model.addAttribute("str", "{\"stat\":403, \"msg\":\"验证登陆失败\"}");
            }
        }
        if(back == null) {
            model.addAttribute("UserService", userService);
            model.addAttribute("OrderService", orderService);
            model.addAttribute("AddressService", addressService);
            model.addAttribute("WorkOrderService", workOrderService);
            model.addAttribute("run", "reLoad");
            return "user_center";
        } else {
            return "api";
        }
    }
    @GetMapping("/AddAdd")
    public String addAddress(Integer uid, String tid, String name, String phone, String address, String back, Model model) throws ParseException {
        System.out.println("操作 > 添加地址 > addAddress > " + uid);
        // 验证 token
        if(userService.verificationToken(uid, tid).equals("ok")) {
            // 添加
            addressService.addAddress(uid, name, phone, address);
        } else {
            if(back == null) {
                model.addAttribute("err", "验证登陆失败");
            } else {
                model.addAttribute("str", "{\"stat\":403, \"msg\":\"验证登陆失败\"}");
            }
        }
        if(back == null) {
            model.addAttribute("UserService", userService);
            model.addAttribute("OrderService", orderService);
            model.addAttribute("AddressService", addressService);
            model.addAttribute("WorkOrderService", workOrderService);
            model.addAttribute("run", "reLoad");
            return "user_center";
        } else {
            return "api";
        }
    }

    // 纯文本 API
    @GetMapping("/UserAddress")
    public String UserAddress(Integer id, String token, Model model) throws ParseException {
        Address[] addresses = addressService.getAddresses(id, token);
        if (addresses[0].getAddress_id() != -1) {
            StringBuilder back = new StringBuilder("[");
            for (Address add : addresses) {
                back.append("{");
                back.append("\"id\":").append(add.getAddress_id()).append(",");
                back.append("\"name\":\"").append(add.getAddress_name()).append("\",");
                back.append("\"phone\":\"").append(add.getAddress_phone()).append("\",");
                back.append("\"address\":\"").append(add.getAddress_content()).append("\"");
                back.append("},");
            }
            back = new StringBuilder(back.substring(0, back.length() - 1));
            back.append("]");
            model.addAttribute("str", back.toString());
            return "api";
        } else {
            model.addAttribute("str", "{\"stat\":500, \"msg\":\"" + addresses[0].getAddress_content() + "\"}");
            return "api";
        }
    }
}
