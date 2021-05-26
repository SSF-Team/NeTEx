<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.chuhelan.netex.util.*" %>

<%
    if(request.getAttribute("id") != null && request.getAttribute("token") != null) {
        // 更新 Cookie
        cookie.set(response, "id", request.getAttribute("id").toString(), 60*60*24*6);
        cookie.set(response, "token", request.getAttribute("token").toString(), 60*60*24*6);
    }
    if(request.getAttribute("err") != null) {
        switch (request.getAttribute("err").toString()) {
            case "账号或密码错误":
            case "验证登陆失败":{
                // 删除 cookie
                cookie.remove(response, "id");
                cookie.remove(response, "token");
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>登陆NeTEx托运账户|NeTEx中国</title>

    <!-- 样式表 -->
    <link rel="stylesheet" href="../../bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="../../index.css">
    <link rel="stylesheet" href="../css/sign_in.css">
    <script src="../../bootstrap/bootstrap.min.js"></script>
</head>
<body>
<!-- 顶栏 -->
<nav class="navbar navbar-expand-lg navbar-dark topbar">
    <div>
        <img src="../../img/logo.svg" style="width: 70px;">
        <span class="bartrademark">®</span>
    </div>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown"
            aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNavDropdown">
        <ul class="navbar-nav">
            <li class="nav-item active">
                <a class="nav-link active" href="#">首页</a>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle active" href="#" id="DpdSevice" data-toggle="dropdown"
                   aria-haspopup="true" aria-expanded="false">
                    物流服务
                </a>
                <div class="dropdown-menu" aria-labelledby="DpdSevice">
                    <a class="dropdown-item" href="#">个人寄件</a>
                    <a class="dropdown-item" href="#">大件服务</a>
                    <a class="dropdown-item" href="#">冷链服务</a>
                    <a class="dropdown-item" href="#">跨境服务</a>
                    <a class="dropdown-item" href="#">星际速递</a>
                </div>
            </li>
        </ul>
    </div>
    <div class="form-inline">
        <div class="dropdown">
            <button class="btn barbtn" type="button">
                <svg aria-hidden="true" focusable="false" data-prefix="far" data-icon="user-circle"
                     class="svg-inline--fa fa-user-circle fa-w-16" role="img" xmlns="http://www.w3.org/2000/svg"
                     viewBox="0 0 496 512">
                    <path fill="currentColor"
                          d="M248 104c-53 0-96 43-96 96s43 96 96 96 96-43 96-96-43-96-96-96zm0 144c-26.5 0-48-21.5-48-48s21.5-48 48-48 48 21.5 48 48-21.5 48-48 48zm0-240C111 8 0 119 0 256s111 248 248 248 248-111 248-248S385 8 248 8zm0 448c-49.7 0-95.1-18.3-130.1-48.4 14.9-23 40.4-38.6 69.6-39.5 20.8 6.4 40.6 9.6 60.5 9.6s39.7-3.1 60.5-9.6c29.2 1 54.7 16.5 69.6 39.5-35 30.1-80.4 48.4-130.1 48.4zm162.7-84.1c-24.4-31.4-62.1-51.9-105.1-51.9-10.2 0-26 9.6-57.6 9.6-31.5 0-47.4-9.6-57.6-9.6-42.9 0-80.6 20.5-105.1 51.9C61.9 339.2 48 299.2 48 256c0-110.3 89.7-200 200-200s200 89.7 200 200c0 43.2-13.9 83.2-37.3 115.9z"></path>
                </svg>
            </button>
        </div>
        <div class="dropdown">
            <button class="btn barbtn" type="button" id="dropdownMenuButton1" data-toggle="dropdown"
                    aria-haspopup="true" aria-expanded="false">
                <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="search"
                     class="svg-inline--fa fa-search fa-w-16" role="img" xmlns="http://www.w3.org/2000/svg"
                     viewBox="0 0 512 512">
                    <path fill="currentColor"
                          d="M505 442.7L405.3 343c-4.5-4.5-10.6-7-17-7H372c27.6-35.3 44-79.7 44-128C416 93.1 322.9 0 208 0S0 93.1 0 208s93.1 208 208 208c48.3 0 92.7-16.4 128-44v16.3c0 6.4 2.5 12.5 7 17l99.7 99.7c9.4 9.4 24.6 9.4 33.9 0l28.3-28.3c9.4-9.4 9.4-24.6.1-34zM208 336c-70.7 0-128-57.2-128-128 0-70.7 57.2-128 128-128 70.7 0 128 57.2 128 128 0 70.7-57.2 128-128 128z"></path>
                </svg>
            </button>
            <div class="dropdown-menu dropdownbg" aria-labelledby="dropdownMenuButton1"
                 style="margin-top: -65px;margin-left: 50px;">
                <input class="form-control" type="search" placeholder="搜索……" aria-label="搜索" style="width: 300px;">
            </div>
        </div>
    </div>
</nav>
<!--这边开始写代码-->

<div class="top_banner">
    <div class="loginOption">
        <div class="alert alert-danger errbar alert-dismissible fade show" role="alert" style="
        <%
            if(request.getAttribute("err") != null) {
                out.println("\">" + request.getAttribute("err").toString());
            } else {
                out.println("display: none;\">");
            }
        %>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <!--logo界面-->
        <div class="logoBanner">
            <img src="../../img/sign_in/netex.svg"/>
        </div>
        <!--登录-->
        <form action="/Login" method="post">
            <div class="emailBox">
                <p>
                    <label class="icon_label icon_code"></label>
                    <input name="email" type="text" placeholder="请输入您的邮箱地址">
                </p>
                <p>
                    <label class="icon_label icon_pwd"></label>
                    <input name="password" type="password" placeholder="请输入密码">
                </p>
            </div>
            <!-- 我同意-->
            <p class="privacy">
                <input class="goCheck" id="goCheck" autocomplete="off" type="checkbox">
                <label for="goCheck">我同意</label>
                <a class="privacy_herf" target="_blank" href="#" >《NeTEx隐私政策》</a>
            </p>
            <input name="back" type="text" value="sign_in" style="display: none;">
            <button type="submit" class="cursorPointer sign_in_Btn">立&nbsp;即&nbsp;登&nbsp;录</button>
        </form>
    </div>
</div>
<!--合伙伙伴-->
<div class="partnerBox">
    <div class="partner">
        <h2 class="platforTitle">客户与伙伴</h2>
        <div class="partnerList">
            <p class="partnerList_p">
                <a>
                    <img src="../../img/sign_in/link1.png" alt>
                </a>
                <a>
                    <img src="../../img/sign_in/link2.png" alt>
                </a>
                <a>
                    <img src="../../img/sign_in/link3.png" alt>
                </a>
                <a>
                    <img src="../../img/sign_in/link4.png" alt>
                </a>
                <a>
                    <img src="../../img/sign_in/link5.png" alt>
                </a>
            </p>
            <p class="partnerList_p">
                <a>
                    <img src="../../img/sign_in/link6.png" alt>
                </a>
                <a>
                    <img src="../../img/sign_in/link7.png" alt>
                </a>
                <a>
                    <img src="../../img/sign_in/link8.png" alt>
                </a>
                <a>
                    <img src="../../img/sign_in/link9.png" alt>
                </a>
                <a>
                    <img src="../../img/sign_in/link10.png" alt>
                </a>
            </p>
        </div>
    </div>
</div>
</div>
<!--这边开始写代码-->

<footer>
    <div class="info">
        <div style="width: calc(100% - 500px);">
            <span id="title">NeTEx China Group</span>
            <div id="sevlink">
                <a>免责声明</a>
                <a>使用条款</a>
                <a>无障碍访问</a>
                <a>Cookie 设置</a>
            </div>
        </div>
        <div>
            <span id="title">联系我们</span>
            <div id="findus">
                <a href="https://github.com/SSF-Team/NeTEx/issues" target="_blank">
                    <svg class="octicon octicon-mark-github v-align-middle" height="32" viewBox="0 0 16 16"
                         version="1.1" width="32" aria-hidden="true">
                        <path fill-rule="evenodd"
                              d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27.68 0 1.36.09 2 .27 1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.013 8.013 0 0016 8c0-4.42-3.58-8-8-8z"></path>
                    </svg>
                </a>
            </div>
        </div>
    </div>
    <div class="buton">
        <span>@NeTEx 2021</span>
        <span style="float: right;"><a rel="nofollow" href="http://www.beian.miit.gov.cn" target="_blank">苏ICP备 20015498号</a> - netex.chuhelan.com</span>
    </div>
</footer>

<script src="../../bootstrap/jquery-3.4.1.slim.min.js"></script>
<script src="../../bootstrap/bootstrap.min.js"></script>
</body>
</html>