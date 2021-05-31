<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.chuhelan.netex.util.*" %>

<%
    if (request.getAttribute("id") != null && request.getAttribute("token") != null) {
        // 更新 Cookie
        cookie.set(response, "id", request.getAttribute("id").toString(), 60 * 60 * 24 * 6);
        cookie.set(response, "token", request.getAttribute("token").toString(), 60 * 60 * 24 * 6);
    }
    if (request.getAttribute("err") != null) {
        switch (request.getAttribute("err").toString()) {
            case "账号或密码错误":
            case "验证登陆失败": {
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
<%
    out.println(htmls.header());
%>
<!--这边开始写代码-->

<div class="top_banner">
    <div class="loginOption">
        <div class="alert
        <%
        if(request.getAttribute("ok") != null) {
            out.println("alert-success");
        } else {
            out.println("alert-danger");
        }
        %>
          errbar alert-dismissible fade show" role="alert" style="
            <%
            if(request.getAttribute("err") != null) {
                out.println("background=#60c378;\">" + request.getAttribute("err").toString());
            } else if(request.getAttribute("ok") != null) {
                out.println("\">" + request.getAttribute("ok").toString());
            } else {
                out.println("display: none;\">");
            }
        %>
                <button type=" button
        " class="close" data-dismiss="alert" aria-label="Close">
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
            <input checked class="goCheck" id="goCheck" autocomplete="off" type="checkbox" name="accept">
            <label for="goCheck">我同意</label>
            <a class="privacy_herf" target="_blank" href="#">《NeTEx隐私政策》</a>
        </p>
        <input name="back" type="text" value="sign_in" style="display: none;">
        <button type="submit" class="cursorPointer sign_in_Btn">立&nbsp;即&nbsp;登&nbsp;录</button>
        <%--有疑问？--%>
        <div class="have_problems">
            <a href="https://www.baidu.com/s?wd=%E5%BF%98%E8%AE%B0%E5%AF%86%E7%A0%81%E6%80%8E%E4%B9%88%E5%8A%9E%E5%9C%A8%E7%BA%BF%E7%AD%89%E6%80%A5"
               target="_blank">忘记密码</a>
            <a href="/SignUp">立即注册</a>
        </div>
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

<%
    out.println(htmls.footer());
%>

<script src="../../bootstrap/jquery-3.4.1.slim.min.js"></script>
<script src="../../bootstrap/bootstrap.min.js"></script>
</body>
</html>