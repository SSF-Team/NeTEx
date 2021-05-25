package com.chuhelan.netex.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;


/**
 * @description:
 * @author: chuhelan
 * @create: 2021-05-18 08:42
 **/

@Configuration
@ComponentScan("com.chuhelan.netex.controller")
@EnableWebMvc
public class AppServiceConfig implements WebMvcConfigurer {
    //配置jsp视图解析器
    @Override
    public void configureViewResolvers(ViewResolverRegistry registry) {
        registry.jsp("/WEB-INF/jsp/",".jsp");
    }
    //配置静态资源处理
    @Override
    public void
    configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer)
    {
        configurer.enable();
    }
    //文件上传配置
    @Bean
    public CommonsMultipartResolver getMultiparResolver(){
        CommonsMultipartResolver multipartResolver=new
                CommonsMultipartResolver();
        multipartResolver.setDefaultEncoding("UTF-8");
        return multipartResolver;
    }
}
