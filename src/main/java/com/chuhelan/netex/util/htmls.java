package com.chuhelan.netex.util;

import com.chuhelan.netex.domain.Address;
import com.chuhelan.netex.domain.Order;
import com.chuhelan.netex.domain.User;
import com.chuhelan.netex.service.UserService;
import com.chuhelan.netex.service.impl.UserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.Nullable;

import javax.servlet.http.Cookie;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @Version: 1.0
 * @Date: 2021/5/27 上午 08:18
 * @ClassName: htmls
 * @Author: Stapxs
 * @Description TO DO
 **/
public class htmls {

    /**
     * @Author Stapxs
     * @Description 输出顶栏 HTML 代码
     * @Date 上午 08:18 2021/5/27
     * @Param []
     * @return void
    **/
    public static String header(Cookie[] cookies) {
        return header(cookies, false);
    }
    public static String header(Cookie[] cookies, boolean userCenter) {
        String id = "";
        String token = "";
        for(Cookie cookie:cookies) {
            if(cookie.getName().equals("id"))
                id = cookie.getValue();
            if(cookie.getName().equals("token"))
                token = cookie.getValue();
        }
        boolean logined = id != null && !id.equals("") && token != null && !token.equals("");

        if(!userCenter)
            logined = false;

        // 为了在所有页面统一显示顶栏，我们使用方法来返回顶栏的内容
        return "<header style=\"flex: 0 0 auto;\">\n" +
                "      <nav class=\"navbar navbar-expand-lg navbar-dark topbar\">\n" +
                "        <div>\n" +
                "           <a href=\"/\">\n"  +
                "               <img src=\"../../img/logo.svg\" style=\"width: 70px;\">\n" +
                "           </a>" +
                "          <span class=\"bartrademark\">®</span>\n" +
                "        </div>\n" +
                "        <button class=\"navbar-toggler\" type=\"button\" data-toggle=\"collapse\" data-target=\"#navbarNavDropdown\"\n" +
                "                aria-controls=\"navbarNavDropdown\" aria-expanded=\"false\" aria-label=\"Toggle navigation\">\n" +
                "          <span class=\"navbar-toggler-icon\"></span>\n" +
                "        </button>\n" +
                "        <div class=\"collapse navbar-collapse\" id=\"navbarNavDropdown\">\n" +
                "          <ul class=\"navbar-nav\">\n" +
                "            <li class=\"nav-item active\">\n" +
                "              <a class=\"nav-link active\" href=\"/\">首页</a>\n" +
                "            </li>\n" +
                "            <li class=\"nav-item active\">\n" +
                "              <a class=\"nav-link active\" href=\"/Order\">快速查询</a>\n" +
                "            </li>\n" +
//                "              <a class=\"nav-link dropdown-toggle active\" href=\"#\" id=\"DpdSevice\" data-toggle=\"dropdown\"\n" +
//                "                 aria-haspopup=\"true\" aria-expanded=\"false\">\n" +
//                "                物流服务\n" +
//                "              </a>\n" +
//                "              <div class=\"dropdown-menu\" aria-labelledby=\"DpdSevice\">\n" +
//                "                <a class=\"dropdown-item\" href=\"#\">个人寄件</a>\n" +
//                "                <a class=\"dropdown-item\" href=\"#\">大件服务</a>\n" +
//                "                <a class=\"dropdown-item\" href=\"#\">冷链服务</a>\n" +
//                "                <a class=\"dropdown-item\" href=\"#\">跨境服务</a>\n" +
//                "                <a class=\"dropdown-item\" href=\"#\">星际速递</a>\n" +
//                "              </div>\n" +
//                "            </li>\n" +
                "            <li class=\"nav-item active\">\n" +
                "              <a class=\"nav-link active\" href=\"/Shipping\">快速下单</a>\n" +
                "            </li>\n" +
                "          </ul>\n" +
                "        </div>\n" +
                "        <div class=\"form-inline\">\n" +
                "          <div class=\"dropdown\">\n" +
                "            <button class=\"btn barbtn\" type=\"button\" onclick=\"window.location.href='" + (logined ? "/LoginOut" : "/SignIn") + "'\">\n" +
                "              <svg aria-hidden=\"true\" focusable=\"false\" data-prefix=\"far\" data-icon=\"user-circle\"\n" +
                "                   class=\"svg-inline--fa fa-user-circle fa-w-16\" role=\"img\" xmlns=\"http://www.w3.org/2000/svg\"\n" +
                "                   viewBox=\"0 0 496 512\">\n" +
                "                <path fill=\"currentColor\"\n" +
                ( !logined ?
                        "                      d=\"M248 104c-53 0-96 43-96 96s43 96 96 96 96-43 96-96-43-96-96-96zm0 144c-26.5 0-48-21.5-48-48s21.5-48 48-48 48 21.5 48 48-21.5 48-48 48zm0-240C111 8 0 119 0 256s111 248 248 248 248-111 248-248S385 8 248 8zm0 448c-49.7 0-95.1-18.3-130.1-48.4 14.9-23 40.4-38.6 69.6-39.5 20.8 6.4 40.6 9.6 60.5 9.6s39.7-3.1 60.5-9.6c29.2 1 54.7 16.5 69.6 39.5-35 30.1-80.4 48.4-130.1 48.4zm162.7-84.1c-24.4-31.4-62.1-51.9-105.1-51.9-10.2 0-26 9.6-57.6 9.6-31.5 0-47.4-9.6-57.6-9.6-42.9 0-80.6 20.5-105.1 51.9C61.9 339.2 48 299.2 48 256c0-110.3 89.7-200 200-200s200 89.7 200 200c0 43.2-13.9 83.2-37.3 115.9z\"></path>\n":
                        "                      d=\"M497 273L329 441c-15 15-41 4.5-41-17v-96H152c-13.3 0-24-10.7-24-24v-96c0-13.3 10.7-24 24-24h136V88c0-21.4 25.9-32 41-17l168 168c9.3 9.4 9.3 24.6 0 34zM192 436v-40c0-6.6-5.4-12-12-12H96c-17.7 0-32-14.3-32-32V160c0-17.7 14.3-32 32-32h84c6.6 0 12-5.4 12-12V76c0-6.6-5.4-12-12-12H96c-53 0-96 43-96 96v192c0 53 43 96 96 96h84c6.6 0 12-5.4 12-12z\"></path>\n"
                )+
                "              </svg>\n" +
                "            </button>\n" +
                "          </div>\n" +
                "          <div class=\"dropdown\">\n" +
                "            <button class=\"btn barbtn\" type=\"button\" id=\"dropdownMenuButton1\" data-toggle=\"dropdown\"\n" +
                "                    aria-haspopup=\"true\" aria-expanded=\"false\">\n" +
                "              <svg aria-hidden=\"true\" focusable=\"false\" data-prefix=\"fas\" data-icon=\"search\"\n" +
                "                   class=\"svg-inline--fa fa-search fa-w-16\" role=\"img\" xmlns=\"http://www.w3.org/2000/svg\"\n" +
                "                   viewBox=\"0 0 512 512\">\n" +
                "                <path fill=\"currentColor\"\n" +
                "                      d=\"M505 442.7L405.3 343c-4.5-4.5-10.6-7-17-7H372c27.6-35.3 44-79.7 44-128C416 93.1 322.9 0 208 0S0 93.1 0 208s93.1 208 208 208c48.3 0 92.7-16.4 128-44v16.3c0 6.4 2.5 12.5 7 17l99.7 99.7c9.4 9.4 24.6 9.4 33.9 0l28.3-28.3c9.4-9.4 9.4-24.6.1-34zM208 336c-70.7 0-128-57.2-128-128 0-70.7 57.2-128 128-128 70.7 0 128 57.2 128 128 0 70.7-57.2 128-128 128z\"></path>\n"+
                "              </svg>\n" +
                "            </button>\n" +
                "            <div class=\"dropdown-menu dropdownbg\" aria-labelledby=\"dropdownMenuButton1\"\n" +
                "                 style=\"margin-top: -65px;margin-left: 50px;\">\n" +
                "              <input class=\"form-control\" type=\"search\" placeholder=\"搜索……\" aria-label=\"搜索\" style=\"width: 300px;\">\n" +
                "            </div>\n" +
                "          </div>\n" +
                "        </div>\n" +
                "      </nav>\n" +
                "    </header>";
    }

    /**
     * @Author Stapxs
     * @Description 输出底栏 HTML 代码
     * @Date 上午 08:25 2021/5/27
     * @Param []
     * @return java.lang.String
    **/
    public static String footer() {
        // 同上
        return "<footer style=\"flex: 0 0 auto;\">\n" +
                "        <div class=\"info\">\n" +
                "          <div id=\"info-main\">\n" +
                "            <span id=\"title\">NeTEx China Group</span>\n" +
                "            <div id=\"sevlink\">\n" +
                "              <a>免责声明</a>\n" +
                "              <a>使用条款</a>\n" +
                "              <a>无障碍访问</a>\n" +
                "              <a>Cookie 设置</a>\n" +
                "            </div>\n" +
                "          </div>\n" +
                "          <div id=\"find-us\">\n" +
                "            <span id=\"title\">联系我们</span>\n" +
                "            <div id=\"findus\">\n" +
                "              <a href=\"https://github.com/SSF-Team/NeTEx/issues\" target=\"_blank\">\n" +
                "                <svg class=\"octicon octicon-mark-github v-align-middle\" height=\"32\" viewBox=\"0 0 16 16\" version=\"1.1\" width=\"32\" aria-hidden=\"true\"><path fill-rule=\"evenodd\" d=\"M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27.68 0 1.36.09 2 .27 1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.013 8.013 0 0016 8c0-4.42-3.58-8-8-8z\"></path></svg>\n" +
                "              </a>\n" +
                "            </div>\n" +
                "          </div>\n" +
                "        </div>\n" +
                "        <div class=\"buton\">\n" +
                "          <span>@NeTEx 2021</span>\n" +
                "          <span style=\"float: right;\"><a rel=\"nofollow\" href=\"http://www.beian.miit.gov.cn\" target=\"_blank\">苏ICP备 20015498号</a> - netex.chuhelan.com</span>\n" +
                "        </div>\n" +
                "      </footer>";
    }

    /**
     * @Author Stapxs
     * @Description 输出地址簿 tr 列表
     * @Date 下午 10:41 2021/6/4
     * @Param [address, id, token]
     * @return java.lang.String
    **/
    public static String addressTr(Address address, Integer id, String token) {
        return "<tr>\n" +
                "                            <td>" + address.getAddress_name() + "</td>\n" +
                "                            <td>" + address.getAddress_phone() + "</td>\n" +
                "                            <td>" + address.getAddress_content() + "</td>\n" +
                "                            <td>\n" +
                "                                <div style=\"text-align: center;\">\n" +
//                "                                <div style=\"display: flex;\">\n" +
//                "                                    <button onclick=\"\">\n" +
//                "                                        <svg aria-hidden=\"true\" focusable=\"false\" data-prefix=\"far\" data-icon=\"edit\"\n" +
//                "                                             class=\"svg-inline--fa fa-edit fa-w-18\" role=\"img\"\n" +
//                "                                             xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 576 512\">\n" +
//                "                                            <path fill=\"currentColor\"\n" +
//                "                                                  d=\"M402.3 344.9l32-32c5-5 13.7-1.5 13.7 5.7V464c0 26.5-21.5 48-48 48H48c-26.5 0-48-21.5-48-48V112c0-26.5 21.5-48 48-48h273.5c7.1 0 10.7 8.6 5.7 13.7l-32 32c-1.5 1.5-3.5 2.3-5.7 2.3H48v352h352V350.5c0-2.1.8-4.1 2.3-5.6zm156.6-201.8L296.3 405.7l-90.4 10c-26.2 2.9-48.5-19.2-45.6-45.6l10-90.4L432.9 17.1c22.9-22.9 59.9-22.9 82.7 0l43.2 43.2c22.9 22.9 22.9 60 .1 82.8zM460.1 174L402 115.9 216.2 301.8l-7.3 65.3 65.3-7.3L460.1 174zm64.8-79.7l-43.2-43.2c-4.1-4.1-10.8-4.1-14.8 0L436 82l58.1 58.1 30.9-30.9c4-4.2 4-10.8-.1-14.9z\"></path>\n" +
//                "                                        </svg>\n" +
//                "                                    </button>\n" +
                "                                    <button onclick=\"location='/DeleteAdd?uid=" + id + "&tid=" + token + "&aid=" + address.getAddress_id() + "'\">\n" +
                "                                        <svg aria-hidden=\"true\" focusable=\"false\" data-prefix=\"far\"\n" +
                "                                             data-icon=\"trash-alt\" class=\"svg-inline--fa fa-trash-alt fa-w-14\"\n" +
                "                                             role=\"img\" xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 448 512\">\n" +
                "                                            <path fill=\"currentColor\"\n" +
                "                                                  d=\"M268 416h24a12 12 0 0 0 12-12V188a12 12 0 0 0-12-12h-24a12 12 0 0 0-12 12v216a12 12 0 0 0 12 12zM432 80h-82.41l-34-56.7A48 48 0 0 0 274.41 0H173.59a48 48 0 0 0-41.16 23.3L98.41 80H16A16 16 0 0 0 0 96v16a16 16 0 0 0 16 16h16v336a48 48 0 0 0 48 48h288a48 48 0 0 0 48-48V128h16a16 16 0 0 0 16-16V96a16 16 0 0 0-16-16zM171.84 50.91A6 6 0 0 1 177 48h94a6 6 0 0 1 5.15 2.91L293.61 80H154.39zM368 464H80V128h288zm-212-48h24a12 12 0 0 0 12-12V188a12 12 0 0 0-12-12h-24a12 12 0 0 0-12 12v216a12 12 0 0 0 12 12z\"></path>\n" +
                "                                        </svg>\n" +
                "                                    </button>\n" +
                "                                </div>\n" +
                "                            </td>\n" +
                "                        </tr>";
    }

    /**
     * @Author Stapxs
     * @Description 输出积分详情列表
     * @Date 下午 06:49 2021/6/5
     * @Param [change, info, date]
     * @return java.lang.String
    **/
    public static String pointDetail(Integer change, String info, Date date) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return "<tr>\n" +
                "                                    <td style=\"padding:0;\">" + (change > 0 ? "+" : "-") + change + "</td>\n" +
                "                                    <td style=\"padding:0;\">" + info + "</td>\n" +
                "                                    <td style=\"padding:0;\">" + sdf.format(date) + "</td>\n" +
                "                                </tr>";
    }

    /**
     * @Author Stapxs
     * @Description 输出我创建的工单列表
     * @Date 下午 06:58 2021/6/5
     * @Param [orderID, date, name, phone, str, nowWay]
     * @return java.lang.String
    **/
    public static String workOrderTr(String orderID, Date date, String name, String phone, String str, String backStr, Integer nowWay, boolean isSev, Integer workOrderID) {
        /*
         工单状态
         0 - 待处理
         1 - 处理完成
         2 - 驳回
        */
        String[] way = new String[] {"待处理", "#4D148C", "M256 8C119 8 8 119 8 256s111 248 248 248 248-111 248-248S393 8 256 8zm0 448c-110.5 0-200-89.5-200-200S145.5 56 256 56s200 89.5 200 200-89.5 200-200 200zm61.8-104.4l-84.9-61.7c-3.1-2.3-4.9-5.9-4.9-9.7V116c0-6.6 5.4-12 12-12h32c6.6 0 12 5.4 12 12v141.7l66.8 48.6c5.4 3.9 6.5 11.4 2.6 16.8L334.6 349c-3.9 5.3-11.4 6.5-16.8 2.6z"};
        if(nowWay == 1) {
            way = new String[] {"处理完成", "green", "M256 8C119.033 8 8 119.033 8 256s111.033 248 248 248 248-111.033 248-248S392.967 8 256 8zm0 48c110.532 0 200 89.451 200 200 0 110.532-89.451 200-200 200-110.532 0-200-89.451-200-200 0-110.532 89.451-200 200-200m140.204 130.267l-22.536-22.718c-4.667-4.705-12.265-4.736-16.97-.068L215.346 303.697l-59.792-60.277c-4.667-4.705-12.265-4.736-16.97-.069l-22.719 22.536c-4.705 4.667-4.736 12.265-.068 16.971l90.781 91.516c4.667 4.705 12.265 4.736 16.97.068l172.589-171.204c4.704-4.668 4.734-12.266.067-16.971z"};
        } else if(nowWay == 2) {
            way = new String[] {"驳回", "red", "M256 8C119 8 8 119 8 256s111 248 248 248 248-111 248-248S393 8 256 8zm0 448c-110.5 0-200-89.5-200-200S145.5 56 256 56s200 89.5 200 200-89.5 200-200 200zm101.8-262.2L295.6 256l62.2 62.2c4.7 4.7 4.7 12.3 0 17l-22.6 22.6c-4.7 4.7-12.3 4.7-17 0L256 295.6l-62.2 62.2c-4.7 4.7-12.3 4.7-17 0l-22.6-22.6c-4.7-4.7-4.7-12.3 0-17l62.2-62.2-62.2-62.2c-4.7-4.7-4.7-12.3 0-17l22.6-22.6c4.7-4.7 12.3-4.7 17 0l62.2 62.2 62.2-62.2c4.7-4.7 12.3-4.7 17 0l22.6 22.6c4.7 4.7 4.7 12.3 0 17z"};
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return "<tr title=\"" + way[0] + "\" onclick=\"" + (isSev ? "openWorkOrder(true, " + workOrderID + ")" : "openWorkOrderBack(true, '" + backStr + "')") + "\">\n" +
                "                                <td>" + orderID + "</td>\n" +
                "                                <td>" + sdf.format(date) + "</td>\n" +
                "                                <td>" + name + "</td>\n" +
                "                                <td>" + phone + "</td>\n" +
                "                                <td>" + str + "</td>\n" +
                "                                <td style=\"color: " + way[1] + "\">\n" +
                "                                   <svg style=\"width: 20px;\" aria-hidden=\"true\" focusable=\"false\" data-prefix=\"far\" data-icon=\"clock\" class=\"svg-inline--fa fa-clock fa-w-16\" role=\"img\" xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 512 512\">\n" +
                "                                       <path fill=\"currentColor\" d=\"" + way[2] + "\"></path>\n" +
                "                                   </svg>" +
                "                                </td>\n" +
                "                            </tr>";
    }

    /**
     * @Author Stapxs
     * @Description 输出运单列表
     * @Date 下午 07:59 2021/6/6
     * @Param [order, user]
     * @return java.lang.String
    **/
    public static String orderTr(Order order, User user, String OutType, UserService userService) {
        switch (OutType) {
            case "wait": {
                String clickFun = user.getUser_type() == 2 ? "" : "openOrderInfo(true, '" + order.getOrder_id().trim() + "')";
                return "<tr onclick=\"" + clickFun + "\">\n" +
                        "                                <td>" + order.getOrder_id() + "</td>\n" +
                        "                                <td>" + order.getOrder_type() + "</td>\n" +
                        "                                <td>" + order.getOrder_deliveryAddress() + "</td>\n" +
                        "                                <td>" + order.getOrder_content() + "</td>\n" +
                        "                            </tr>";
            }
            case "waitsend": {
                String orderNow = "";
                String icon = "";
                if(order.getOrder_deliveryDate() == null) {
                    orderNow = "2";
                    icon = "M544 192h-16L419.22 56.02A64.025 64.025 0 0 0 369.24 32H155.33c-26.17 0-49.7 15.93-59.42 40.23L48 194.26C20.44 201.4 0 226.21 0 256v112c0 8.84 7.16 16 16 16h48c0 53.02 42.98 96 96 96s96-42.98 96-96h128c0 53.02 42.98 96 96 96s96-42.98 96-96h48c8.84 0 16-7.16 16-16v-80c0-53.02-42.98-96-96-96zM160 432c-26.47 0-48-21.53-48-48s21.53-48 48-48 48 21.53 48 48-21.53 48-48 48zm72-240H116.93l38.4-96H232v96zm48 0V96h89.24l76.8 96H280zm200 240c-26.47 0-48-21.53-48-48s21.53-48 48-48 48 21.53 48 48-21.53 48-48 48z";
                }
                if(order.getOrder_sendDate() == null) {
                    orderNow = "1";
                    icon = "M32 448c0 17.7 14.3 32 32 32h384c17.7 0 32-14.3 32-32V160H32v288zm160-212c0-6.6 5.4-12 12-12h104c6.6 0 12 5.4 12 12v8c0 6.6-5.4 12-12 12H204c-6.6 0-12-5.4-12-12v-8zM480 32H32C14.3 32 0 46.3 0 64v48c0 8.8 7.2 16 16 16h480c8.8 0 16-7.2 16-16V64c0-17.7-14.3-32-32-32z";
                }
                String clickFun = "openSendControl(true, '" + order.getOrder_id().trim() + "', '" + orderNow + "')";
                return "<tr onclick=\"" + clickFun + "\">\n" +
                        "                                <td>" + order.getOrder_id() + "</td>\n" +
                        "                                <td>" + order.getOrder_type() + "</td>\n" +
                        "                                <td>" + order.getOrder_deliveryAddress() + "</td>\n" +
                        "                                <td style=\"color:#000;\">\n" +
                        "                                   <svg style=\"width: 20px;\" aria-hidden=\"true\" focusable=\"false\" data-prefix=\"far\" data-icon=\"check-circle\" class=\"svg-inline--fa fa-check-circle fa-w-16\" role=\"img\" xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 512 512\"><path fill=\"currentColor\" d=\"" + icon + "\"></path></svg>\n" +
                        "                                </td>\n" +
                        "                            </tr>";
            }
            case "run": {
                String clickFun = "openOrderInfo(true, '" + order.getOrder_id().trim() + "')";
                return "<tr onclick=\"" + clickFun + "\">\n" +
                        "                                <td>" + order.getOrder_id() + "</td>\n" +
                        "                                <td>" + order.getOrder_type() + "</td>\n" +
                        "                                <td>" + order.getOrder_deliveryAddress() + "</td>\n" +
                        "                                <td>" + userService.findUserById(order.getOrder_deliveryManID()).getUser_name() + "</td>\n" +
                        "                            </tr>";
            }
            case "stay": {
                String clickFun = order.getOrder_pickDate() == null ? "openOrderCheck(true, '" + order.getOrder_id().trim() + "')":"";
                return "<tr onclick=\"" + clickFun + "\">\n" +
                        "                                <td>" + order.getOrder_id() + "</td>\n" +
                        "                                <td>" + order.getOrder_type() + "</td>\n" +
                        "                                <td>" + order.getOrder_deliveryAddress() + "</td>\n" +
                        "                                <td style=\"color:" + (order.getOrder_pickDate() == null ? "red" : "green") + ";\">\n" +
                        "                                   <svg style=\"width: 20px;\" aria-hidden=\"true\" focusable=\"false\" data-prefix=\"far\" data-icon=\"check-circle\" class=\"svg-inline--fa fa-check-circle fa-w-16\" role=\"img\" xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 512 512\"><path fill=\"currentColor\" d=\"M256 8C119.033 8 8 119.033 8 256s111.033 248 248 248 248-111.033 248-248S392.967 8 256 8zm0 48c110.532 0 200 89.451 200 200 0 110.532-89.451 200-200 200-110.532 0-200-89.451-200-200 0-110.532 89.451-200 200-200m140.204 130.267l-22.536-22.718c-4.667-4.705-12.265-4.736-16.97-.068L215.346 303.697l-59.792-60.277c-4.667-4.705-12.265-4.736-16.97-.069l-22.719 22.536c-4.705 4.667-4.736 12.265-.068 16.971l90.781 91.516c4.667 4.705 12.265 4.736 16.97.068l172.589-171.204c4.704-4.668 4.734-12.266.067-16.971z\"></path></svg>\n" +
                        "                                </td>\n" +
                        "                            </tr>";
            }
        }
        return "";
    }
}
