package com.chuhelan.netex.util;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @Version: 1.0
 * @Date: 2021/5/26 上午 10:02
 * @ClassName: cookie
 * @Author: Stapxs
 * @Description TO DO
 **/
public class cookie {
    public static void set(HttpServletResponse response, String name, String value, Integer time) {
        Cookie addCookie = new Cookie(name,value);
        addCookie.setMaxAge(time);
        response.addCookie(addCookie);
    }

    public static void remove(HttpServletResponse response, String name) {
        Cookie addCookie = new Cookie(name,"");
        addCookie.setMaxAge(0);
        response.addCookie(addCookie);
    }
}
