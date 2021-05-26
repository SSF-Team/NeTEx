package com.chuhelan.netex.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;
import com.chuhelan.netex.domain.User;
import com.chuhelan.netex.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

/**
 * @description:
 * @author: chuhelan
 * @create: 2021-05-25 08:31
 **/

@Controller
public class UserController {

    @Autowired
    UserService userService;

    @RequestMapping("/UserById")
    public String findUserById(Integer id, Model model) {
        User user = userService.findUserById(id);
        model.addAttribute("user", user);
        return "user";
    }

    @PostMapping("/Login")
    public String LoginPass(String email, String password, String back, Model model) {
        // 检索用户信息
        User user = userService.findUserByMail(email);
        // 验证登录
        if(user != null && user.getUser_password().equals(password)) {
            // 生成 token
            String token = UUID.randomUUID().toString().replace("-", "").toLowerCase();
            // 获取时间
            SimpleDateFormat sdf = new SimpleDateFormat();
            sdf.applyPattern("yyyyMMdd");
            Date date = new Date(new Date().getTime() + 518400000);
            String time = sdf.format(date);
            if(back != null) {
                model.addAttribute("user", user);
                return back;
            } else {
                model.addAttribute("str", "{\"stat\":20, \"id\":" + user.getUser_id() + ",\"token\":\"" + token + "\", \"dietime\":" + time);
                return "api";
            }
        }
        return "../../index";
    }
}
