package com.chuhelan.netex.util;

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
    public static String header() {
        // 为了在所有页面统一显示顶栏，我们使用方法来返回顶栏的内容
        return "<header>\n" +
                "      <nav class=\"navbar navbar-expand-lg navbar-dark topbar\">\n" +
                "        <div>\n" +
                "          <img src=\"../../img/logo.svg\" style=\"width: 70px;\">\n" +
                "          <span class=\"bartrademark\">®</span>\n" +
                "        </div>\n" +
                "        <button class=\"navbar-toggler\" type=\"button\" data-toggle=\"collapse\" data-target=\"#navbarNavDropdown\"\n" +
                "                aria-controls=\"navbarNavDropdown\" aria-expanded=\"false\" aria-label=\"Toggle navigation\">\n" +
                "          <span class=\"navbar-toggler-icon\"></span>\n" +
                "        </button>\n" +
                "        <div class=\"collapse navbar-collapse\" id=\"navbarNavDropdown\">\n" +
                "          <ul class=\"navbar-nav\">\n" +
                "            <li class=\"nav-item active\">\n" +
                "              <a class=\"nav-link active\" href=\"#\">首页</a>\n" +
                "            </li>\n" +
                "            <li class=\"nav-item dropdown\">\n" +
                "              <a class=\"nav-link dropdown-toggle active\" href=\"#\" id=\"DpdSevice\" data-toggle=\"dropdown\"\n" +
                "                 aria-haspopup=\"true\" aria-expanded=\"false\">\n" +
                "                物流服务\n" +
                "              </a>\n" +
                "              <div class=\"dropdown-menu\" aria-labelledby=\"DpdSevice\">\n" +
                "                <a class=\"dropdown-item\" href=\"#\">个人寄件</a>\n" +
                "                <a class=\"dropdown-item\" href=\"#\">大件服务</a>\n" +
                "                <a class=\"dropdown-item\" href=\"#\">冷链服务</a>\n" +
                "                <a class=\"dropdown-item\" href=\"#\">跨境服务</a>\n" +
                "                <a class=\"dropdown-item\" href=\"#\">星际速递</a>\n" +
                "              </div>\n" +
                "            </li>\n" +
                "          </ul>\n" +
                "        </div>\n" +
                "        <div class=\"form-inline\">\n" +
                "          <div class=\"dropdown\">\n" +
                "            <button class=\"btn barbtn\" type=\"button\" onclick=\"window.location.href='/SignIn'\">\n" +
                "              <svg aria-hidden=\"true\" focusable=\"false\" data-prefix=\"far\" data-icon=\"user-circle\"\n" +
                "                   class=\"svg-inline--fa fa-user-circle fa-w-16\" role=\"img\" xmlns=\"http://www.w3.org/2000/svg\"\n" +
                "                   viewBox=\"0 0 496 512\">\n" +
                "                <path fill=\"currentColor\"\n" +
                "                      d=\"M248 104c-53 0-96 43-96 96s43 96 96 96 96-43 96-96-43-96-96-96zm0 144c-26.5 0-48-21.5-48-48s21.5-48 48-48 48 21.5 48 48-21.5 48-48 48zm0-240C111 8 0 119 0 256s111 248 248 248 248-111 248-248S385 8 248 8zm0 448c-49.7 0-95.1-18.3-130.1-48.4 14.9-23 40.4-38.6 69.6-39.5 20.8 6.4 40.6 9.6 60.5 9.6s39.7-3.1 60.5-9.6c29.2 1 54.7 16.5 69.6 39.5-35 30.1-80.4 48.4-130.1 48.4zm162.7-84.1c-24.4-31.4-62.1-51.9-105.1-51.9-10.2 0-26 9.6-57.6 9.6-31.5 0-47.4-9.6-57.6-9.6-42.9 0-80.6 20.5-105.1 51.9C61.9 339.2 48 299.2 48 256c0-110.3 89.7-200 200-200s200 89.7 200 200c0 43.2-13.9 83.2-37.3 115.9z\"></path>\n" +
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
                "                      d=\"M505 442.7L405.3 343c-4.5-4.5-10.6-7-17-7H372c27.6-35.3 44-79.7 44-128C416 93.1 322.9 0 208 0S0 93.1 0 208s93.1 208 208 208c48.3 0 92.7-16.4 128-44v16.3c0 6.4 2.5 12.5 7 17l99.7 99.7c9.4 9.4 24.6 9.4 33.9 0l28.3-28.3c9.4-9.4 9.4-24.6.1-34zM208 336c-70.7 0-128-57.2-128-128 0-70.7 57.2-128 128-128 70.7 0 128 57.2 128 128 0 70.7-57.2 128-128 128z\"></path>\n" +
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
        return "<footer>\n" +
                "        <div class=\"info\">\n" +
                "          <div style=\"width: calc(100% - 500px);\">\n" +
                "            <span id=\"title\">NeTEx China Group</span>\n" +
                "            <div id=\"sevlink\">\n" +
                "              <a>免责声明</a>\n" +
                "              <a>使用条款</a>\n" +
                "              <a>无障碍访问</a>\n" +
                "              <a>Cookie 设置</a>\n" +
                "            </div>\n" +
                "          </div>\n" +
                "          <div>\n" +
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
}
