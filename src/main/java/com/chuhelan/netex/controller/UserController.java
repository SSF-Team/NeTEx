package com.chuhelan.netex.controller;

import com.chuhelan.netex.domain.User;
import com.chuhelan.netex.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

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
    public String findUserById(Integer id , Model model){
        User user = userService.findUserById(id);
        model.addAttribute("user",user);
        return "user";
    }
}
