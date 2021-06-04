package com.chuhelan.netex.controller;

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
import com.chuhelan.netex.util.*;

import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
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

    // 纯文本 API
    @GetMapping("/OrderBaseInfo")
    public String getBasePostInfo(String id, Model model) {
        id = id.toUpperCase();
        Order orderInfo = orderService.getOrder(id);
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
                              Model model) throws UnsupportedEncodingException {
        System.out.println("操作 > createOrder > 创建订单 > " + sName + " / " + dName);
        System.out.println("操作 > createOrder > 创建订单 > " + sPhone + " / " + dPhone);
        System.out.println("操作 > createOrder > 创建订单 > " + sAddress + " / " + dAddress);
        sName = new String(sName.getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
        dName = new String(dName.getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
        sAddress = new String(sAddress.getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
        dAddress = new String(dAddress.getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
        orderMarks = new String(orderMarks.getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
        orderType = new String(orderType.getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
        if(sName.equals("") || sPhone.equals("") || sAddress.equals("") || dName.equals("") || dPhone.equals("") || dAddress.equals("") || weight.equals("")) {
            model.addAttribute("err", "请检查表单，表单项后星号为必填");
            return "shipping";
        }
        if(userID.equals("")) {
            model.addAttribute("err", "请登录");
            return "shipping";
        }
        // 检查输入合法性

        // 生成订单号
        String id = "NT";
        SimpleDateFormat sdf = new SimpleDateFormat("MMyy");
        do {
            id += sdf.format(new Date());
            id += (int) ((Math.random() * 9 + 1) * 100000);
            id += "A";
            // 订单号去重
        }while (orderService.getOrder(id) != null);

        System.out.println("操作 > createOrder > 订单号 > " + id);
        // 创建订单
        orderService.CreateOrder(id, Integer.parseInt(userID), new OrderUser(sName, sPhone, sAddress), new OrderUser(dName, dPhone, dAddress), orderMarks, orderType);
        // 计算距离
        System.out.println("操作 > createOrder > 计算订单距离 > " + sAddress + " / " + dAddress);
        String[][] info = new String[][] {
                new String[] {"address", sAddress},
                new String[] {"output", "json"},
                new String[] {"ak", "62WAvGClEExBObY1zU4ZuMMEYxVRmWdF"}
        };
        String get = http.result("http://api.map.baidu.com/geocoding/v3/", info);
        String[] startPoint = new String[] {
                get.substring(get.indexOf("\"lng\":") + 6, get.indexOf(",\"lat\":")),
                get.substring(get.indexOf("\"lat\":") + 6, get.indexOf("},\"precise\":"))
        };
        info = new String[][] {
                new String[] {"address", dAddress},
                new String[] {"output", "json"},
                new String[] {"ak", "62WAvGClEExBObY1zU4ZuMMEYxVRmWdF"}
        };
        get = http.result("http://api.map.baidu.com/geocoding/v3/", info);
        String[] endPoint = new String[] {
                get.substring(get.indexOf("\"lng\":") + 6, get.indexOf(",\"lat\":")),
                get.substring(get.indexOf("\"lat\":") + 6, get.indexOf("},\"precise\":"))
        };
        System.out.println("操作 > createOrder > 计算订单距离 > " + Arrays.toString(startPoint) + " / " + Arrays.toString(endPoint));
        Double distance = Math.sqrt(Double.parseDouble(endPoint[0]) - Double.parseDouble(startPoint[0]))*
                                    (Double.parseDouble(endPoint[0]) - Double.parseDouble(startPoint[0]))+
                                    (Double.parseDouble(endPoint[1]) - Double.parseDouble(startPoint[1]))*
                                    (Double.parseDouble(endPoint[1]) - Double.parseDouble(startPoint[1]));

        System.out.println("操作 > createOrder > 计算订单距离 > " + Math.round(distance));
        // 确认订单
        System.out.println("操作 > createOrder > 计算价格 > " + (int)(Math.round(distance) * 0.1 * Double.parseDouble(weight) * 2 + 20));
        model.addAttribute("id", id);
        model.addAttribute("orderService", orderService);
        model.addAttribute("money", (int)(Math.round(distance) * 0.1 * Double.parseDouble(weight) * 2 + 20));
        return "order_verify";
    }
    @PostMapping("/CancelOrder")
    public String cancelOrder(String uid, String oid, String tid, Model model) throws ParseException {
        System.out.println("操作 > cancelOrder > 取消订单 > " + uid + " / " + oid);
        // 验证登录
        if(userService.verificationToken(Integer.parseInt(uid), tid).equals("ok")) {
            // 验证订单是否为本人所有
            Order order = orderService.getOrder(oid);
            if(order != null && order.getOrder_createID() == Integer.parseInt(uid)) {
                orderService.deleteOrder(oid);
                return "index";
            } else {
                model.addAttribute("str", "订单不存在或订单所有权错误！");
                return "err_page";
            }
        } else {
            model.addAttribute("err", "验证登陆失败！");
            return "sign_in";
        }
    }
    @PostMapping("/VerifyOrder")
    public String verifyOrder(String uid, String oid, Model model) {
        System.out.println("操作 > verifyOrder > 确认订单 > " + uid + " / " + oid);
        // 验证订单是否为本人所有
        Order order = orderService.getOrder(oid);
        if(order != null && order.getOrder_createID() == Integer.parseInt(uid)) {
            // 分配快递员
            /*
             理论上说要给每个区域都分配快递员用于按地区分配
             但是我们这边给全国地区做分配肯定是不现实的
             所以我们在所有快递员里抽一个好了
             */
            User Courier = userService.getOneCourier();
            orderService.assignCourier(oid, Courier.getUser_id());
            return "index";
        } else {
            model.addAttribute("str", "订单不存在或订单所有权错误！");
            return "err_page";
        }
    }

}
