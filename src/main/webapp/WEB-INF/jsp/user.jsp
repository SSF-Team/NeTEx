<%--
  Created by IntelliJ IDEA.
  User: wmp231316
  Date: 25/5/2021
  Time: 上午8:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<span>用户名：${user.user_name}</span><br>
<img src="${user.user_profile}" style="height: 200px;width:200px;border-radius: 100%; box-shadow: 0px 0px 12px #E0E0E0"><br>
<%--<span>地址：${user.user_address}</span><br>--%>
<span>邮箱：${user.user_email}</span><br>
<span>电话：${user.user_phone}</span><br>

</body>
</html>
