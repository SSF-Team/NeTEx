package com.chuhelan.netex.controller;

import com.chuhelan.netex.domain.Address;
import com.chuhelan.netex.service.AddressService;
import com.chuhelan.netex.service.OrderService;
import com.chuhelan.netex.service.WorkOrderService;
import com.chuhelan.netex.util.*;

import java.nio.charset.StandardCharsets;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;
import com.chuhelan.netex.domain.User;
import com.chuhelan.netex.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.jws.WebParam;
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
    @Autowired
    OrderService orderService;
    @Autowired
    AddressService addressService;
    @Autowired
    WorkOrderService workOrderService;

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

    // 实际功能 API
    @PostMapping("/Login")
    public String LoginPass(String email, String password, String back, String accept, Model model) {
        System.out.println("操作 > 登录 > LogginPass > " + email + " / " + password + " / " + back + " / " +accept);
        if(accept == null) {
            if(back != null) {
                model.addAttribute("err", "请勾选隐私政策");
                return "sign_in";
            } else {
                model.addAttribute("str", "{\"stat\":302, \"msg\":\"请勾选隐私政策\"}");
                return "api";
            }
        }
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
                model.addAttribute("msg", "ok");
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
        name = new String(name.getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
        // 验证用户是否存在
        User user = userService.findUserByMail(email);
        if(user == null) {
            // 账号不存在，开始注册流程
            // 检查数据合法性
            boolean isNOlegalitys = !legality.mail(email) && !legality.mobile(phone) && !legality.name(name) && !legality.password(password);
            System.out.println("操作 > 注册 > RegPass > 输入合法性：" + isNOlegalitys);
            if(isNOlegalitys) {
                if(back != null) {
                    return "sign_up";
                } else {
                    model.addAttribute("str", "{\"stat\":406, \"msg\":\"参数不合法。\"}");
                    return "api";
                }
            }
            // 写数据库
            userService.regUser(name, phone, email, password);
            if(back != null) {
                model.addAttribute("ok", "注册完成");
                return back;
            } else {
                model.addAttribute("str", "{\"stat\":200, \"msg\":\"注册完成。\"}");
                return "api";
            }
        } else {
            if(back != null) {
                model.addAttribute("err", "账号已存在，请直接登录");
                return back;
            } else {
                model.addAttribute("str", "{\"stat\":406, \"msg\":\"账号已存在，请直接登录\"}");
                return "api";
            }
        }
    }
  
    // 纯文本 API
    @GetMapping("/UserInfo")
    public String getUserInfoByToken(Integer id ,String token, Model model) throws ParseException {
        User user = userService.getUserInfoByToken(id,token);
        if(user.getUser_id() != -1) {
            String back = "{";
            back += "\"name\":\"" + user.getUser_name() + "\",";
            back += "\"gender\":\"" + user.getUser_gender() + "\",";
            back += "\"mail\":\"" + user.getUser_email() + "\",";
            back += "\"phone\":\"" + user.getUser_phone() + "\"";
            back += "}";
            model.addAttribute("str", back);
            return "api";
        } else {
            model.addAttribute("str", "{\"stat\":500, \"msg\":\"" + user.getUser_name() + "\"}");
            return "api";
        }
    }
    @GetMapping("/ClockIn")
    public String ClockIn(Integer uid, String tid, @Nullable String back, Model model) throws ParseException {
        // 验证 token
        if(userService.verificationToken(uid, tid).equals("ok")) {
            // 判断今天有没有签到过
            if(userService.getPointByTime(uid, new Date()) == null) {
                userService.ChangePoint(uid,userService.getUserInfoByToken(uid, tid).getUser_point() + 5);
                userService.addPointInfo(uid, new Date(), 5, "签到奖励");
            } else {
                if(back == null) {
                    model.addAttribute("err", "今天签到过啦");
                } else {
                    model.addAttribute("str", "{\"stat\":403, \"msg\":\"今天签到过啦\"}");
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

}