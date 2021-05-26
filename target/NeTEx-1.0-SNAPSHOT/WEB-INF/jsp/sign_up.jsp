<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>开设NeTEx托运账户|NeTEx中国</title>

    <!-- 样式表 -->
    <link rel="stylesheet" href="../../bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="../../index.css">
    <link rel="stylesheet" href="../css/sign_up.css">
    <script src="../../bootstrap/bootstrap.min.js"></script>
</head>
<script type="text/javascript">
    function trip(obj, trip) {
        document.getElementById(obj).innerHTML = "<b>" + trip + "</b>";
    }

    function checkForm() {

        var trip = document.getElementsByName("em");
        var tripV = trip.innerHTML();

        //校验邮箱:/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(\.[a-zA-Z0-9_-])+/
        var inputEmail = document.getElementById("email");
        var uEmail = inputEmail.value;
        if (!/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(\.[a-zA-Z0-9_-])+/.test(uEmail)) {
            trip("email_trip", "邮箱不合法!!");
            return false;
        } else {
            trip("email_trip", "OK!!");
        }

        //获取用户名输入项
        var userNname = document.getElementById("user_name");
        var uName = userNname.value;
        if (uName.length < 1 || uName.length > 10) {
            trip("name_trip", "账号长度为1-10位!!");
            return false;
        } else {
            trip("name_trip", "OK!!");

        }

        var inputPhoneNumber = document.getElementById("phoneNumber");
        var uPhoneNumber = inputPhoneNumber.value;
        if (!/^[1][3,4,5,7,8,9][0-9]{9}$/.test(uPhoneNumber)) {
            trip("phoneNumber_trip", "手机号格式不正确");
            return false;
        } else {
            trip("phoneNumber_trip", "手机号格式正确");
            return true;
        }

        //密码长度大于6 和确认必须一致
        var password = document.getElementById("password");
        var userPass = password.value;
        if (userPass.length < 6) {
            trip("password_trip", "密码要>6位!!");
            return false;
        } else {
            trip("password_trip", "OK!!");
        }

        //获取确认密码框的值 var
        var surePassword = document.getElementById("surePassword");
        var surePass = surePassword.value;
        if (userPass != surePass) {
            trip("surePassword_trip", "两次密码不一致!!");
            return false;
        }
        1

        return true;
    }

    function submitT() {
        if (checkForm()) {
            return true;
        } else {
            return false;
        }
    }
</script>
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
            <button class="btn barbtn" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true"
                    aria-expanded="false">
                <svg aria-hidden="true" focusable="false" data-prefix="far" data-icon="user-circle"
                     class="svg-inline--fa fa-user-circle fa-w-16" role="img" xmlns="http://www.w3.org/2000/svg"
                     viewBox="0 0 496 512">
                    <path fill="currentColor"
                          d="M248 104c-53 0-96 43-96 96s43 96 96 96 96-43 96-96-43-96-96-96zm0 144c-26.5 0-48-21.5-48-48s21.5-48 48-48 48 21.5 48 48-21.5 48-48 48zm0-240C111 8 0 119 0 256s111 248 248 248 248-111 248-248S385 8 248 8zm0 448c-49.7 0-95.1-18.3-130.1-48.4 14.9-23 40.4-38.6 69.6-39.5 20.8 6.4 40.6 9.6 60.5 9.6s39.7-3.1 60.5-9.6c29.2 1 54.7 16.5 69.6 39.5-35 30.1-80.4 48.4-130.1 48.4zm162.7-84.1c-24.4-31.4-62.1-51.9-105.1-51.9-10.2 0-26 9.6-57.6 9.6-31.5 0-47.4-9.6-57.6-9.6-42.9 0-80.6 20.5-105.1 51.9C61.9 339.2 48 299.2 48 256c0-110.3 89.7-200 200-200s200 89.7 200 200c0 43.2-13.9 83.2-37.3 115.9z"></path>
                </svg>
            </button>
            <div class="dropdown-menu dropdownbg" aria-labelledby="dropdownMenuButton">
                <input class="form-control" type="text" placeholder=" 账号" aria-label="账号"
                       style="width: 200px;margin: 0 5px;">
                <input class="form-control" type="password" placeholder=" 密码" aria-label="密码"
                       style="width: 200px;margin: 0 5px;margin-top: 5px;">
                <button type="button" class="btn btn-light">登录</button>
                <a style="line-height: 10px;">忘记密码？</a>
            </div>
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

<!--开设账户-->
<div class="setBanner">
    <div class="word_left">
        <p>开通账户</p>
        <div>
            <p>运用我们的服务和解决方案，以满足您所有的运输要求。点在下方注册 NeTEx 托运账户。开始注册！</p>
            <p>在线开设NeTEx企业月结账户，即可 享受额外的 100 元运费券!</p>
        </div>
    </div>
</div>

<!--这边开始写代码-->
<!--注册表-->
<div class="register">
    <div id="loginDiv">
        <form action="">
            <h3>立即注册，有机会享受最低可至六折* 运费！</h3>
            <h4>请填写以下信息， 之后我们的客户服务代表将联系您， 以协助您开设账户。 个人寄件者，请致电联邦快递国际客服热线了解最新政策。</h4>
            <div class="filed">
                <div class="word_filed">
                    <p>
                        用&nbsp;户&nbsp;名&nbsp;&nbsp;:
                        <input id="user_name" type="text" autofocus required>
                        <label id="name_trip"></label>
                        手机号码:
                        <input id="phoneNumber" type="text" required>
                        <label id="phoneNumber_trip"></label>

                    </p>
                    <p>
                        电子邮件:
                        <input id="email" type="email" required>
                        <label id="email_trip"></label>
                        &emsp;&emsp;&emsp;&nbsp;邮政编码:
                        <input id="postcode" type="text" required>
                        <label id="postcode_trip"></label>
                    </p>
                    <p>
                        密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码:
                        <input id="password" type="password" autofocus required>
                        <label id="password_trip"></label>
                        &emsp;&emsp;&emsp;&nbsp;确认密码:
                        <input id="surePassword" type="password" autofocus required>
                        <label id="surePassword_trip"></label>
                    </p>


                    <p style="text-align: center;">
                        <input type="submit" class="button" onblur="checkForm()" onclick="return submitT()" value="提交">
                    </p>
                </div>
                <div class="pic_filed">
                    <div>请设置您的头像</div>
                    <img src="../../img/sign_up/netex_personal.jpg"/><br>
                    <input type="button" class="personalPic" value="上传头像">
                </div>
            </div>
        </form>
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