package com.chuhelan.netex.controller;

import com.chuhelan.netex.domain.Post;
import com.chuhelan.netex.service.PostService;
import com.chuhelan.netex.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.text.ParseException;
import java.text.SimpleDateFormat;

/**
 * @Version: 1.0
 * @Date: 2021/6/2 上午 08:36
 * @ClassName: PostController
 * @Author: Stapxs
 * @Description TO DO
 **/

@Controller
public class PostController {

    @Autowired
    PostService postService;
    @Autowired
    UserService userService;

    // 纯文本 API
    @GetMapping("/PostInfo")
    public String getPostInfo(String postID, Integer userID, String token, Model model) throws ParseException {
        System.out.println("操作 > 获取订单信息");
        String tokenBack = userService.verificationToken(userID, token);
        if(tokenBack.equals("ok")) {
            Post postInfo = postService.PostInfo(postID);
            SimpleDateFormat sdf = new SimpleDateFormat();
            sdf.applyPattern("yyyy-MM-dd");

            String back = "{";
            back += "\"ID\":\"" + postInfo.getOrder_id() + "\",";
            back += "\"SenderID\":" + postInfo.getOrder_sendUserID() + ",";
            back += "\"RecipientID\":" + postInfo.getOrder_deliveryUserID() + ",";
            back += "\"DeliveryManID\":" + postInfo.getOrder_deliveryManID() + ",";
            back += "\"InitiateDate\":\"" + sdf.format(postInfo.getOrder_date()) + "\",";
            back += "\"SendDate\":\"" + sdf.format(postInfo.getOrder_sendDate()) + "\",";
            back += "\"ReceivedDate\":\"" + sdf.format(postInfo.getOrder_deliveryDate()) + "\",";
            back += "\"InitiateTime\":\"" + sdf.format(postInfo.getOrder_date()) + "\",";
            back += "\"SenderAddID\":" + postInfo.getOrder_sendAddressId() + ",";
            back += "\"RecipientAddID\":" + postInfo.getOrder_deliveryAddressId();

            model.addAttribute("str", back + "}");
        } else {
            model.addAttribute("str", "{\"stat\":406, \"msg\":\"" + tokenBack + "\"}");
        }
        return "api";
    }
    @GetMapping("/PostBaseInfo")
    public String getBasePostInfo(String id, Model model) {
        Post postInfo = postService.PostInfo(id);
        SimpleDateFormat sdf = new SimpleDateFormat();
        sdf.applyPattern("yyyy-MM-dd");

        String back = "{";
        back += "\"ID\":\"" + postInfo.getOrder_id() + "\",";
        back += "\"InitiateDate\":\"" + sdf.format(postInfo.getOrder_date()) + "\",";
        back += "\"SendDate\":\"" + sdf.format(postInfo.getOrder_sendDate()) + "\",";
        back += "\"ReceivedDate\":\"" + sdf.format(postInfo.getOrder_deliveryDate()) + "\",";
        back += "\"InitiateTime\":\"" + sdf.format(postInfo.getOrder_date()) + "\"";

        model.addAttribute("str", back + "}");

        return "api";
    }

}
