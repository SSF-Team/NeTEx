package com.chuhelan.netex.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * @description:
 * @author: chuhelan
 * @create: 2021-05-31 13:51
 **/

@Controller
public class FileUploadController {
    //@RequestParam("uploadfile") 将name=file控件得到的文件封装成CommonsMultipartFile 对象

    @RequestMapping("/fileUpload")
    public String handleFormUpload(@RequestParam("name") String name,
                                   @RequestParam("uploadfile") List<MultipartFile> uploadfile,
                                   HttpSession session,
                                   Model model) {
        List<String> fileList = new ArrayList<>();
        if (!uploadfile.isEmpty() && uploadfile.size() > 0) {
            for (MultipartFile file : uploadfile) {
//获得上传文件的原始名称
                String orginalFilename = file.getOriginalFilename();
                System.out.println("长传文件原始名称：" + orginalFilename);
//设置上传文件的保存地址目录
                String
                        realPath = session.getServletContext().getRealPath("/upload");
                System.out.println("realPath:" + realPath);
//采用uuid重命名上传文件；格式为：上传人_uuid_原始文件名
                String newFilename = name + "_" +
                        UUID.randomUUID() + "_" + orginalFilename;
                fileList.add(newFilename);
                File destFile = new File(realPath + "\\" + newFilename);
//此处用来看路径是否正确
                System.out.println("destFile:" + destFile);
//使用MultipartFile接口的方法完成文件上传到指定位置
                try {
                    file.transferTo(destFile);
                } catch (IOException e) {
                    e.printStackTrace();
                    return "error";
                }
            }
            model.addAttribute("name", name);
            model.addAttribute("fileList", fileList);
            return "showUpload";
        } else {
            return "error";
        }
    }
}