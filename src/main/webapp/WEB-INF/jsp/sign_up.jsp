<%@ page import="com.chuhelan.netex.util.htmls" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>开设NeTEx托运账户|NeTEx中国</title>

    <!-- 样式表 -->
    <link rel="stylesheet" href="../../bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="../../index.css">
    <link rel="stylesheet" href="../../css/sign_up.css">
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
<%
    out.println(htmls.header());
%>

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
        <form action="/Register" method="post">
            <h3>立即注册，有机会享受最低可至六折* 运费！</h3>
            <h4>请填写以下信息， 之后我们的客户服务代表将联系您， 以协助您开设账户。 个人寄件者，请致电联邦快递国际客服热线了解最新政策。</h4>
            <div class="filed">
                <div class="word_filed">
                    <p>
                        用&nbsp;户&nbsp;名&nbsp;&nbsp;:
                        <input name="name" id="user_name" type="text" autofocus required>
                        <label id="name_trip"></label>
                        手机号码:
                        <input name="phone" id="phoneNumber" type="text" required>
                        <label id="phoneNumber_trip"></label>

                    </p>
                    <p>
                        电子邮件:
                        <input name="email" id="email" type="email" required>
                        <label id="email_trip"></label>
                        &emsp;&emsp;&emsp;&nbsp;邮政编码:
                        <input name="postCode" id="postcode" type="text" required>
                        <label id="postcode_trip"></label>
                    </p>
                    <p>
                        密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码:
                        <input name="password" id="password" type="password" autofocus required>
                        <label id="password_trip"></label>
                        &emsp;&emsp;&emsp;&nbsp;确认密码:
                        <input id="surePassword" type="password" autofocus required>
                        <label id="surePassword_trip"></label>
                    </p>
                    <input name="back" type="text" value="sign_in" style="display: none;">
                    <p style="text-align: center;">
                        <input type="submit" class="button" onblur="checkForm()" onclick="return submitT()" value="提交">
                    </p>
                </div>
<%--                <div class="pic_filed">--%>
<%--                    <div>请设置您的头像</div>--%>
<%--                    <img src="../../img/sign_up/netex_personal.jpg"/><br>--%>
<%--                    <input type="button" class="personalPic" value="上传头像">--%>
<%--                </div>--%>
            </div>
        </form>
    </div>
</div>


<!--这边开始写代码-->
<%
    out.println(htmls.footer());
%>

<script src="../../bootstrap/jquery-3.4.1.slim.min.js"></script>
<script src="../../bootstrap/bootstrap.min.js"></script>
</body>
</html>