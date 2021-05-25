package com.chuhelan.netex.controller;

import com.chuhelan.netex.domain.User;
import com.chuhelan.netex.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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

    @PostMapping("/signin")
    public String login(User user, Model model, HttpSession session) {
        String username = user.getUser_name();
        String password = user.getUser_password();
        if (username != null && password != null && )) {
            session.setAttribute("user", user);
            return "redirect:main";
        }
        model.addAttribute("msg", "用户名或密码错误，请重新登录！");
        return "login";
    }
}
