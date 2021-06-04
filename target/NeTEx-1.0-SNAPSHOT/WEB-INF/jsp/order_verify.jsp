<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.chuhelan.netex.util.*" %>
<%@ page import="com.chuhelan.netex.service.OrderService" %>
<%@ page import="com.chuhelan.netex.domain.Order" %>
<!DOCTYPE html>

<%
    // 获取传参 oid
    String orderID = (String) request.getAttribute("id");
    Integer money = (Integer) request.getAttribute("money");
    OrderService orderService = (OrderService) request.getAttribute("orderService");

    // 获取 cookie 参数
    String id = cookie.get(request, "id");
    String token = cookie.get(request, "token");

    // 全局参数
    Order orderInfo = null;

    // 获取订单详情
    if(orderID != null && orderService != null) {
        orderInfo = orderService.getOrder(orderID);
    }
%>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>确认账单|NeTEx中国</title>

    <!-- 样式表 -->
    <link rel="stylesheet" href="../../bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="../../index.css">
    <link rel="stylesheet" href="../../css/order_verify.css">
</head>
<body>
<!-- 顶栏 -->
<%
    out.println(htmls.header());
%>
<!--主体-->
<div class="main">
    <div>
        <div class="envelope">
            <h2>确认订单</h2>
            <h6><%out.print(orderID);%></h6>
            <div>
                <p>寄件人：<span><%out.print(orderInfo.getOrder_sendName());%></span></p>
                <p>联系方式：<span><%out.print(orderInfo.getOrder_sendPhone());%></span></p>
                <p>地址：<span><%out.print(orderInfo.getOrder_sendAddress());%></span></p>
            </div>
            <div style="border-top: 1px dashed #c2c2c2;margin-top: 20px;">
                <p>收件人：<span><%out.print(orderInfo.getOrder_deliveryName());%></span></p>
                <p>联系方式：<span><%out.print(orderInfo.getOrder_deliveryPhone());%></span></p>
                <p>地址：<span><%out.print(orderInfo.getOrder_deliveryAddress());%></span></p>
            </div>
            <div style="border-top: 1px dashed #c2c2c2;margin-top: 20px;">
                <p>结算金额：<span><%out.print(money);%></span></p>
            </div>
            <div class="end-button">
                <form method="post" action="/VerifyOrder">
                    <input name="uid" value="<%out.print(id);%>" style="display: none;">
                    <input name="oid" value="<%out.print(orderID);%>" style="display: none;">
                    <button style="margin-left: -104px;" type="commit">确认</button>
                </form>
            </div>
            <div class="end-button">
                <form method="post" action="/CancelOrder">
                    <label>
                        <input name="uid" value="<%out.print(id);%>" style="display: none;">
                        <input name="oid" value="<%out.print(orderID);%>" style="display: none;">
                        <input name="tid" value="<%out.print(token);%>" style="display: none;">
                    </label>
                    <button style="margin-left: 16px;background-color: #a9a9a9;" type="commit">取消</button>
                </form>
            </div>

        </div>
        <div class="envelope-png"></div>
    </div>
</div>
<!--底栏-->
<%
    out.println(htmls.footer());
%>

<script src="../../bootstrap/jquery-3.4.1.slim.min.js"></script>
<script src="../../bootstrap/bootstrap.min.js"></script>
</body>
</html>