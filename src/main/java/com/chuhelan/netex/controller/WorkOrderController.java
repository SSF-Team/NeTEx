package com.chuhelan.netex.controller;

import com.chuhelan.netex.service.AddressService;
import com.chuhelan.netex.service.OrderService;
import com.chuhelan.netex.service.UserService;
import com.chuhelan.netex.service.WorkOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;

import java.nio.charset.StandardCharsets;
import java.text.ParseException;

/**
 * @Version: 1.0
 * @Date: 2021/6/5 下午 04:14
 * @ClassName: WordOrderController
 * @Author: Stapxs
 * @Description TO DO
 **/

@Controller
public class WorkOrderController {

    @Autowired
    OrderService orderService;
    @Autowired
    UserService userService;
    @Autowired
    AddressService addressService;
    @Autowired
    WorkOrderService workOrderService;

    @PostMapping("/CreateWorkOrder")
    public String createWorkOrder(Integer uid, String tid, @Nullable String oid, String str, Model model) throws ParseException {
        str = new String(str.getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
        if(str == null) {
            model.addAttribute("err", "表单为空");
        }
        // 验证登录
        if(userService.verificationToken(uid, tid).equals("ok")) {
            // 保存工单
            workOrderService.addWorkOrder(uid, oid, str);
            model.addAttribute("msg", "提交成功");
        } else {
            model.addAttribute("err", "验证登陆失败");
        }
        model.addAttribute("UserService", userService);
        model.addAttribute("OrderService", orderService);
        model.addAttribute("AddressService", addressService);
        model.addAttribute("WorkOrderService", workOrderService);
        model.addAttribute("run", "reLoad");
        return "user_center";
    }
}
