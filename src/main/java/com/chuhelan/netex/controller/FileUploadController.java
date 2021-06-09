package com.chuhelan.netex.controller;

import com.chuhelan.netex.service.AddressService;
import com.chuhelan.netex.service.OrderService;
import com.chuhelan.netex.service.UserService;
import com.chuhelan.netex.service.WorkOrderService;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.List;
import java.util.UUID;

/**
 * @description:
 * @author: chuhelan
 * @create: 2021-05-31 13:47
 **/

@Controller
public class FileUploadController {

    @Autowired
    UserService userService;
    @Autowired
    OrderService orderService;
    @Autowired
    AddressService addressService;
    @Autowired
    WorkOrderService workOrderService;

    @RequestMapping("/ChangeAvatar")
    public String fileUpload(String back, HttpServletRequest request, Model model) throws Exception {
        System.out.println("操作 > 上传头像 > fileUpload");
        Cookie[] cookies = request.getCookies();
        Integer uid = -1;
        String tid = "";
        for(Cookie cookie:cookies) {
            if(cookie.getName().equals("id")) {
                uid = Integer.parseInt(cookie.getValue());
            }
            if(cookie.getName().equals("token")) {
                tid = cookie.getValue();
            }
        }
        // 验证登录
        if(userService.verificationToken(uid, tid).equals("ok")) {
            // 使用fileupload组件完成文件上传
            // 上传的位置
            String path = request.getSession().getServletContext().getRealPath("/uploads/avatars/");
            String filename = "";
            System.out.println(path);
            // 判断，该路径是否存在
            File file = new File(path);
            if (!file.exists()) {
                // 创建该文件夹
                file.mkdirs();
            }

            // 解析request对象，获取上传文件项
            DiskFileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);
            // 解析request
            List<FileItem> items = upload.parseRequest(request);
            // 遍历
            for (FileItem item : items) {
                // 进行判断，当前item对象是否是上传文件项
                if (item.isFormField()) {
                    // 说明普通表单向
                    if(back == null) {
                        model.addAttribute("err", "操作异常（提交类型错误）");
                    } else {
                        model.addAttribute("str", "{\"stat\":403, \"msg\":\"操作异常（提交类型错误）\"}");
                    }
                } else {
                    // 说明上传文件项
                    // 获取上传文件的名称
                    filename = item.getName();
                    // 修改文件名
                    filename = uid + filename.substring(filename.lastIndexOf("."));
                    // 判断，文件是否存在
                    File arcFile = new File(path + filename);
                    if(arcFile.exists()) {
                        // 删除文件
                        arcFile.delete();
                    }
                    // 完成文件上传
                    item.write(new File(path, filename));
                    // 删除临时文件
                    item.delete();

                    // 保存头像地址
                    userService.updateProfile(uid, "/uploads/avatars/" + filename);

                    // 返回
                    if(back == null) {
                        model.addAttribute("msg", "操作成功");
                    } else {
                        model.addAttribute("str", "{\"stat\":200, \"msg\":\"操作成功\"}");
                    }
                }
            }
        } else {
            if (back == null) {
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

    @RequestMapping("file")
    public String filePage() {
        return "file";
    }

}
