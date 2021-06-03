package com.chuhelan.netex.controller;

import com.chuhelan.netex.domain.Address;
import com.chuhelan.netex.domain.Order;
import com.chuhelan.netex.domain.OrderUser;
import com.chuhelan.netex.domain.User;
import com.chuhelan.netex.service.OrderService;
import com.chuhelan.netex.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @Version: 1.0
 * @Date: 2021/6/2 上午 08:36
 * @ClassName: PostController
 * @Author: Stapxs
 * @Description TO DO
 **/

@Controller
public class OrderController {

    @Autowired
    OrderService orderService;
    @Autowired
    UserService userService;

    /*// 纯文本 API
    @GetMapping("/OrderInfo")
    public String getPostInfo(String postID, Integer userID, String token, Model model) throws ParseException {
        postID = postID.toUpperCase();
        System.out.println("操作 > 获取订单信息");
        String tokenBack = userService.verificationToken(userID, token);
        if(tokenBack.equals("ok")) {
            Order orderInfo = orderService.PostInfo(postID);
            SimpleDateFormat sdf = new SimpleDateFormat();
            sdf.applyPattern("yyyy-MM-dd");

            String back = "{";
            back += "\"ID\":\"" + orderInfo.getOrder_id() + "\",";
            back += "\"SenderID\":" + orderInfo.getOrder_sendUserID() + ",";
            back += "\"RecipientID\":" + orderInfo.getOrder_deliveryUserID() + ",";
            back += "\"DeliveryManID\":" + orderInfo.getOrder_deliveryManID() + ",";
            back += "\"InitiateDate\":\"" + sdf.format(orderInfo.getOrder_date()) + "\",";
            back += "\"SendDate\":\"" + sdf.format(orderInfo.getOrder_sendDate()) + "\",";
            back += "\"ReceivedDate\":\"" + sdf.format(orderInfo.getOrder_deliveryDate()) + "\",";
            back += "\"InitiateTime\":\"" + sdf.format(orderInfo.getOrder_date()) + "\",";
            back += "\"SenderAddID\":" + orderInfo.getOrder_sendAddressId() + ",";
            back += "\"RecipientAddID\":" + orderInfo.getOrder_deliveryAddressId();

            model.addAttribute("str", back + "}");
        } else {
            model.addAttribute("str", "{\"stat\":406, \"msg\":\"" + tokenBack + "\"}");
        }
        return "api";
    }*/
    @GetMapping("/OrderBaseInfo")
    public String getBasePostInfo(String id, Model model) {
        id = id.toUpperCase();
        Order orderInfo = orderService.PostInfo(id);
        SimpleDateFormat sdf = new SimpleDateFormat();
        sdf.applyPattern("yyyy-MM-dd");

        String back = "{";
        back += "\"ID\":\"" + orderInfo.getOrder_id() + "\",";
        back += "\"InitiateDate\":\"" + sdf.format(orderInfo.getOrder_date()) + "\",";
        back += "\"SendDate\":\"" + sdf.format(orderInfo.getOrder_sendDate()) + "\",";
        back += "\"ReceivedDate\":\"" + sdf.format(orderInfo.getOrder_deliveryDate()) + "\",";
        back += "\"InitiateTime\":\"" + sdf.format(orderInfo.getOrder_date()) + "\"";

        model.addAttribute("str", back + "}");

        return "api";
    }

    // 功能页跳转
    @PostMapping("/Create")
    public String createOrder(String userID,
                              String sName, String sPhone, String sAddress, String sSave,
                              String dName, String dPhone, String dAddress, String dSave,
                              String orderType, String orderMarks, String weight,
                              Model model) {
        System.out.println("操作 > createOrder > 创建订单 > " + sPhone + " / " + dPhone);
        if(sName.equals("") || sPhone.equals("") || sAddress.equals("") || dName.equals("") || dPhone.equals("") || dAddress.equals("") || weight.equals("")) {
            model.addAttribute("err", "请检查表单，表单项后星号为必填");
            return "shipping";
        }
        if(userID.equals("")) {
            model.addAttribute("err", "请登录");
            return "shipping";
        }
        // 检查输入合法性

        // 创建订单
        // 生成订单号
        String id = "NT";
        SimpleDateFormat sdf = new SimpleDateFormat("MMyy");
        do {
            id += sdf.format(new Date());
            id += (int) ((Math.random() * 9 + 1) * 100000);
            id += "A";
            // 订单号去重
        }while (orderService.PostInfo(id) != null);
        System.out.println("订单号：" + id);
        // 检查订单地址簿是否存在
        Address address = userService.fullAddress(Integer.parseInt(userID), sName, sPhone, sAddress);
        int senderAddID = address == null ? -1 : address.getAddress_id();
        address = userService.fullAddress(Integer.parseInt(userID), dName, dPhone, dAddress);
        int deliveryAddID = address == null ? -1 : address.getAddress_id();
        // 检查订单用户是否存在
        User user = userService.findUserByPhone(sPhone);
        int senderID = user == null ? -1 : user.getUser_id();
        user = userService.findUserByPhone(dPhone);
        int deliveryID = user == null ? -1 : user.getUser_id();
        // 保存地址簿

        // 保存订单
        System.out.println("用户信息状态：" + senderID + " / " + deliveryAddID);
        if(senderID != -1 && deliveryID != -1) {
            OrderUser sender = new OrderUser(senderID, senderAddID);
            OrderUser delivery = new OrderUser(deliveryID, deliveryAddID);
            orderService.CreatePost(id, sender, delivery, 1, orderMarks, orderType);
        }
        return "api";
    }

}
