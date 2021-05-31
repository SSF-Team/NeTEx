package com.chuhelan.netex.controller;

import com.chuhelan.netex.domain.Address;
import com.chuhelan.netex.util.*;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;
import com.chuhelan.netex.domain.User;
import com.chuhelan.netex.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

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

    // 以下 API 功能仅用于测试
    @RequestMapping("/UserById")
    public String findUserById(Integer id, Model model) {
        User user = userService.findUserById(id);
        model.addAttribute("user", user);
        return "user";
    }
    @PostMapping("/VerToken")
    public String VerToken(Integer id, String token, Model model) throws ParseException {
        model.addAttribute("str", "{\"msg\":\"" + userService.verificationToken(id, token) + "\"}");
        return "api";
    }

    // 页面指向
    @RequestMapping("SignIn")
    public String LoginPage() {
        return "sign_in";
    }
    @RequestMapping("SignUp")
    public String RegPage() {
        return "sign_up";
    }

    // 实际功能 API
    @PostMapping("/Login")
    public String LoginPass(String email, String password, String back, Model model) {
        System.out.println("操作 > 登录 > LogginPass > " + email + " / " + password + " / " + back);
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
            // 写数据库
            userService.loginUser(user, token, time);
            // 返回
            System.out.println("操作 > 登录 > LogginPass > 登陆成功");
            if(back != null) {
                model.addAttribute("id", user.getUser_id());
                model.addAttribute("token", token);
                return back;
            } else {
                model.addAttribute("str", "{\"stat\":200, \"id\":" + user.getUser_id() + ",\"token\":\"" + token + "\", \"dietime\":" + time + "}");
                return "api";
            }
        } else {
            if(back != null) {
                model.addAttribute("err", "账号或密码错误");
                return "sign_in";
            } else {
                model.addAttribute("str", "{\"stat\":302, \"msg\":\"账号或密码错误\"}");
                return "api";
            }
        }
    }
    @PostMapping("/Register")
    public String RegPass(String email, String name, String password, String phone, String back, Model model) {
        System.out.println("操作 > 注册 > RegPass > " + email + " / " + name + " / " + password + " / " + phone);
        // 验证用户是否存在
        User user = userService.findUserByMail(email);
        if(user == null) {
            // 账号不存在，开始注册流程
            // 检查数据合法性
            boolean isNOlegalitys = !legality.mail(email) && !legality.mobile(phone) && !legality.name(name) && !legality.password(password);
            System.out.println("操作 > 注册 > RegPass > 输入合法性：" + isNOlegalitys);
            if(isNOlegalitys) {
                if(back != null) {
                    return "";
                } else {
                    model.addAttribute("str", "{\"stat\":406, \"msg\":\"参数不合法。\"}");
                    return "api";
                }
            }
            // 写数据库
            userService.regUser(name, phone, email, password);
            if(back != null) {
                return "";
            } else {
                model.addAttribute("str", "{\"stat\":200, \"msg\":\"注册完成。\"}");
                return "api";
            }
        } else {
            if(back != null) {
                model.addAttribute("err", "账号已存在。");
                return back;
            } else {
                model.addAttribute("str", "{\"stat\":406, \"msg\":\"账号已存在。\"}");
                return "api";
            }
        }
    }

  
    // 纯文本 API
    @GetMapping("/UserAddress")
    public String UserAddress(Integer id, String token, Model model) throws ParseException {
        Address[] addresses = userService.getAddresses(id, token);
        if(addresses[0].getAddress_id() != -1) {
            StringBuilder back = new StringBuilder("[");
            for (Address add: addresses) {
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
        } else {
            model.addAttribute("str", "{\"stat\":500, \"msg\":\"" + addresses[0].getAddress_content() + "\"}");
            return "api";
        }
      
    @GetMapping("/getInfo")
    public String getUserInfoByToken(Integer id ,String token, Model model){
        User user = userService.getUserInfoByToken(id,token);
        model.addAttribute("user", user);
        return "api";
    }
}
