package com.chuhelan.netex.config;

import lombok.Data;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;

/**
 * @description:
 * @author: chuhelan
 * @create: 2021-05-18 08:40
 **/

@Component
@PropertySource("classpath:jdbc.properties")
@Data
public class JdbcConfig {
    @Value("${jdbc.driverClassName}")
    private String driver;
    @Value("${jdbc.url}")
    private String url;
    @Value("${jdbc.username}")
    private String name;
    @Value("${jdbc.password}")
    private String password;
}
