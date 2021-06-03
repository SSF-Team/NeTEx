package com.chuhelan.netex.controller;

import com.chuhelan.netex.service.OrderService;
import com.chuhelan.netex.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @Version: 1.0
 * @Date: 2021/6/2 上午 11:32
 * @ClassName: PageController
 * @Author: Stapxs
 * @Description TO DO
 **/

@Controller
public class PageController {
    @Autowired
    OrderService orderService;
    @Autowired
    UserService userService;

    // 页面指向
    @RequestMapping("Order")
    public String OrderPage(Model model) {
        model.addAttribute("UserService", userService);
        model.addAttribute("PostService", orderService);
        return "oneline";
    }
    @RequestMapping("Shipping")
    public String Shipping() {
        return "shipping";
    }
    @RequestMapping("SignIn")
    public String LoginPage(Model model) {
        model.addAttribute("UserService", userService);
        return "sign_in";
    }
    @RequestMapping("SignUp")
    public String RegPage() {
        return "sign_up";
    }
}
