<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.chuhelan.netex.util.*" %>
<%@ page import="com.chuhelan.netex.service.UserService" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="com.chuhelan.netex.service.OrderService" %>
<%@ page import="com.chuhelan.netex.domain.Order" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.GregorianCalendar" %>

<%
    // TODO 代码写太 jb 乱了重新整理一遍打上注释

    // 获取传参
    String orderID = request.getParameter("id");     // Get 方法订单号
    String id = cookie.get(request, "id");          // Cookie 登录用户 ID
    String token = cookie.get(request, "token");    // Cookie 登录用户 token
    System.out.println("页面 > 基础信息 > oneline > " + orderID);
    // Attribute 传参 Service 层对象
    /*
     理论上说 jsp 不该访问  Service 层方法，但是因为时间不够加上代码写的太乱了
     没办法只能复用 Service 层方法来加快编写速度
    */
    UserService userService = (UserService) request.getAttribute("UserService");
    OrderService orderService = (OrderService) request.getAttribute("PostService");

    // 全局变量
    String back = "err";                    // 登录验证返回值
    Order orderInfo = new Order();          // 订单信息

    // 运单相关全局变量
    String startAdd2 = null;                // 起点（市）
    String endAdd2 = null;                  // 终点（市）
    String startDate = "等待发件";           // 发件时间
    String endDate = startDate;             // 预计到达时间
    String[] startPoint = new String[2];    // 起点坐标
    String[] endPoint = new String[2];      // 终点坐标


    // 获取订单信息
    if(orderID != null)
    {
        orderID = orderID.toUpperCase();      // 格式化订单号（全大写）
        // 验证登录
        System.out.println("页面 > 验证登陆 > oneline > " + id + " / " + token);
        if(id != null && token != null) {
            try {
                back = userService.verificationToken(Integer.parseInt(id), token);
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }

        // 获取运单信息
        orderInfo = orderService.getOrder(orderID);
        if(orderInfo == null) {
            // 获取失败清空订单号
            orderID = null;
        } else {
            // 初始化运单信息

            /*
             因为讲运单和地址库绑定的方式太过繁琐
             决定将运单地址详细信息直接存储在运单里不与地址库相关
             */
            // 运单粗略起始结束地址（市)
            String add = orderInfo.getOrder_sendAddress();
            startAdd2 = add.substring(add.indexOf("省") + 1, add.indexOf("市") + 1);
            add = orderInfo.getOrder_deliveryAddress();
            endAdd2  = add.substring(add.indexOf("省") + 1, add.indexOf("市") + 1);
            // 运单运输时间段
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
            if(orderInfo.getOrder_sendDate() != null) {
                startDate = sdf.format(orderInfo.getOrder_sendDate());
                Calendar calendar = new GregorianCalendar();
                calendar.setTime(orderInfo.getOrder_sendDate());
                calendar.add(Calendar.DATE, 1);     // 预计到达就草率的 +1 好了
                endDate = sdf.format(calendar.getTime());
            }

            // 收件人 / 寄件人信息
            /*
                这里显示的是存储在 OrderInfo 里的运单联系信息，和用户不绑定
                因为不是所有收件人 / 寄件人都会注册平台账户
            */

            // 地图坐标信息
            // 获取两点位置
            /*
                如果用户没有登录只会获取到不精确的地址（市）
            */
            add = orderInfo.getOrder_sendAddress();
            String add1 = add.substring(add.indexOf("市") + 1);
            add = orderInfo.getOrder_deliveryAddress();
            String add2 = add.substring(add.indexOf("市") + 1);
            if(back.equals("ok")) {
                add1 = orderInfo.getOrder_sendAddress();
                add2 = orderInfo.getOrder_deliveryAddress();
            }
            System.out.println("页面 > 地址信息 > oneline >" + add1 + " / " + add2);
            // 请求百度逆向定位 API 获取地址对应经纬度（百度坐标系）
            String[][] info1 = new String[][] {
                    new String[] {"address", add1},
                    new String[] {"output", "json"},
                    new String[] {"ak", "62WAvGClEExBObY1zU4ZuMMEYxVRmWdF"}
            };
            String[][] info2 = new String[][] {
                    new String[] {"address", add2},
                    new String[] {"output", "json"},
                    new String[] {"ak", "62WAvGClEExBObY1zU4ZuMMEYxVRmWdF"}
            };
            String get = http.result("http://api.map.baidu.com/geocoding/v3/", info1);
            // 解析 JSON
            startPoint = new String[] {
                    get.substring(get.indexOf("\"lng\":") + 6, get.indexOf(",\"lat\":")),
                    get.substring(get.indexOf("\"lat\":") + 6, get.indexOf("},\"precise\":"))
            };
            get = http.result("http://api.map.baidu.com/geocoding/v3/", info2);
            endPoint = new String[] {
                    get.substring(get.indexOf("\"lng\":") + 6, get.indexOf(",\"lat\":")),
                    get.substring(get.indexOf("\"lat\":") + 6, get.indexOf("},\"precise\":"))
            };
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>在线服务|NeTEx中国</title>

    <!-- 样式表 -->
    <link rel="stylesheet" href="../../bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="../../index.css">
    <link rel="stylesheet" href="../../css/online.css">
    <script src="../../js/jquery-1.12.4.js"></script>
    <script src="../../js/jquery-ui.js"></script>
    <!-- 百度地图 js -->
    <script type="text/javascript" src="https://api.map.baidu.com/api?type=webgl&v=1.0&ak=62WAvGClEExBObY1zU4ZuMMEYxVRmWdF"></script>
</head>
<script>
    // 使用 JQuery UI 实现的 TabView
    $( function() {
        $( "#tabs" ).tabs();
    } );
</script>
<body>
<!-- 顶栏 -->
<%
    out.println(htmls.header());
%>
<!-- 主体 -->
<div class="main">
    <div id="tabs">
        <ul class="main-tab list-group">
            <li>
                <a href="#tabs-1" onclick="location.href='/Shipping';" target="_blank" class="list-group-item list-group-item-action">
                    <div></div>
                    <svg aria-hidden="true" focusable="false" data-prefix="far" data-icon="paper-plane" class="svg-inline--fa fa-paper-plane fa-w-16" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path fill="currentColor" d="M440 6.5L24 246.4c-34.4 19.9-31.1 70.8 5.7 85.9L144 379.6V464c0 46.4 59.2 65.5 86.6 28.6l43.8-59.1 111.9 46.2c5.9 2.4 12.1 3.6 18.3 3.6 8.2 0 16.3-2.1 23.6-6.2 12.8-7.2 21.6-20 23.9-34.5l59.4-387.2c6.1-40.1-36.9-68.8-71.5-48.9zM192 464v-64.6l36.6 15.1L192 464zm212.6-28.7l-153.8-63.5L391 169.5c10.7-15.5-9.5-33.5-23.7-21.2L155.8 332.6 48 288 464 48l-59.4 387.3z"></path></svg>
                    <span>在线寄件</span>
                </a>
            </li>
            <li>
                <a href="#tabs-1" class="list-group-item list-group-item-action">
                    <div></div>
                    <svg aria-hidden="true" focusable="false" data-prefix="far" data-icon="file" class="svg-inline--fa fa-file fa-w-12" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512"><path fill="currentColor" d="M369.9 97.9L286 14C277 5 264.8-.1 252.1-.1H48C21.5 0 0 21.5 0 48v416c0 26.5 21.5 48 48 48h288c26.5 0 48-21.5 48-48V131.9c0-12.7-5.1-25-14.1-34zM332.1 128H256V51.9l76.1 76.1zM48 464V48h160v104c0 13.3 10.7 24 24 24h104v288H48z"></path></svg>
                    <span>信息查询</span>
                </a>
            </li>
        </ul>
        <div class="right-view">
            <div id="tabs-1">
                <div class="main-card">
                    <div>
                        <Span class="title">运单查询</Span>
                        <div class="hrs"></div>
                        <div class="alert alert-danger alert-dismissible fade show" role="alert" style="border-radius: 50px;background: #DE002E;color: #fff;<%if(orderID != null && request.getParameter("id") == null)out.print("display:none;");%>">
                            运单号不存在！
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <form action="/Order" method="get">
                            <div class="order-search">
                                <input value="<%if(orderID != null){out.print(orderID);}%>" name="id" type="text" placeholder="查找运单号">
                                <button>查找</button>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="main-card" style="<%if(orderID==null || !back.equals("ok"))out.print("display:none;");%>">
                    <div class="order-info">
                        <Span class="title">运单信息</Span>
                        <div class="hrs"></div>
                        <div id="info-run">
                            <span style="float: left;"><%out.print(startAdd2);%></span>
                            <div></div>
                            <span style="float: right;margin-top: -20px;"><%out.print(endAdd2);%></span>
                        </div>
                        <div id="info-time">
                            <span style="float: left;"><%out.print(startDate);%></span>
                            <span style="float: right;"><%out.print(endDate);%></span>
                        </div>
                        <div id="info-info">
                            <div>
                                <div>
                                        <em>寄件人</em>
                                        <span><%if(back.equals("ok") && orderID != null)out.print(orderInfo.getOrder_sendName());%></span>
                                        <em style="margin-left: 20%;">收件人</em>
                                        <span><%if(back.equals("ok") && orderID != null)out.print(orderInfo.getOrder_deliveryName());%></span>
                                </div>
                            </div>
                            <div style="text-align: center;margin-top: 10px;">
                                <span>运单备注：</span>
                                <span><%if(back.equals("ok"))out.print(orderInfo.getOrder_content());%></span>

                            </div>
                        </div>
                    </div>
                </div>
                <div class="main-card" style="<%if(orderID == null)out.print("visibility: hidden;");%>">
                    <div>
                        <Span class="title">运单跟踪</Span>
                        <div class="hrs"></div>
                        <div class="map">
                            <div id="container"></div>
                            <div id="bar">
                                <div style="display: flex;">
                                    <span><%out.print(startAdd2);%></span>
                                    <div id="run-line"></div>
                                    <span><%out.print(endAdd2);%></span>
                                </div>
                                <div id="order-infos">
                                    <span><%
                                        if(orderInfo.getOrder_deliveryDate() == null)
                                            out.print("运输中");
                                        else
                                            out.print("已签收");
                                    %></span>
                                    <span>运单号 <%if(orderID != null){out.print(orderID);}%></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 弹窗 -->
<div class="pop">
    <div id="pop-main">

    </div>
</div>
<!-- 底栏 -->
<%
    out.println(htmls.footer());
%>
<script>
    // 地图加载相关代码
    var map = new BMapGL.Map("container");
    // map.centerAndZoom(new BMapGL.Point(116.404, 39.915), 11);

    var p1 = new BMapGL.Point(<%out.print(startPoint[0] + "," + startPoint[1]);%>);
    var p2 = new BMapGL.Point(<%out.print(endPoint[0] + "," + endPoint[1]);%>);

    var driving = new BMapGL.DrivingRoute(map, {renderOptions:{map: map, autoViewport: true}});
    map.enableScrollWheelZoom(true);
    driving.search(p1, p2);
</script>
<script src="../../bootstrap/bootstrap.min.js"></script>
</body>
</html>