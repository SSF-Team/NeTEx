<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.chuhelan.netex.util.*" %>
<%@ page import="com.chuhelan.netex.service.*" %>
<%@ page import="com.chuhelan.netex.domain.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>

<%
    // 获取传参
    String id = cookie.get(request, "id");          // Cookie 登录用户 ID
    String token = cookie.get(request, "token");    // Cookie 登录用户 token
    // Attribute 传参 Service 层对象
    /*
     理论上说 jsp 不该访问  Service 层方法，但是因为时间不够加上代码写的太乱了
     没办法只能复用 Service 层方法来加快编写速度
    */
    UserService userService = (UserService) request.getAttribute("UserService");
    OrderService orderService = (OrderService) request.getAttribute("OrderService");
    AddressService addressService = (AddressService) request.getAttribute("AddressService");
    WorkOrderService workOrderService = (WorkOrderService) request.getAttribute("WorkOrderService");
    String runCommand = (String) request.getAttribute("run");
    User user;
    Address[] addresses;
    PointInfo[] points;

    System.out.println("页面 > 初始化 > UserCenter > " + userService + " / " + orderService + " / " + addressService + " / " + workOrderService);

    // 全局变量
    String login = "";
    if(id != null && token != null) {
        login = userService.verificationToken(Integer.parseInt(id), token);
    }

    // 刷新 URL
    if(runCommand != null && runCommand.equals("reLoad")) {
        response.sendRedirect("/UserCenter");
        return;
    }
    // 验证登录
    if(login.equals("ok")) {
        // 获取用户信息
        user = userService.getUserInfoByToken(Integer.parseInt(id), token);
        // 获取地址簿
        addresses = addressService.getAddresses(Integer.parseInt(id), token);
        // 获取积分明细
        points = userService.getUserPoints(Integer.parseInt(id));
    } else {
        response.sendRedirect("/SignIn");
        return;
    }
%>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>用户中心|NeTEx中国</title>

    <!-- 样式表 -->
    <link rel="stylesheet" href="../../bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="../../index.css">
    <link rel="stylesheet" href="../../css/user_center.css">
    <link rel="stylesheet" href="../../css/order_verify.css">
    <script src="../../js/jquery-1.12.4.js"></script>
    <script src="../../js/jquery-ui.js"></script>
</head>
<script>
    // 使用 JQuery UI 实现的 TabView
    $(function () {
        $("#tabs").tabs();
    });
</script>
<body>
<!-- 顶栏 -->
<%
    out.println(htmls.header());
%>
<!-- 主体 -->
<div class="main-body" style="flex: 1 0 auto;">
    <div id="tabs">
        <ul class="main-tab list-group">
            <li>
                <a href="#tabs-3" class="list-group-item list-group-item-action">
                    <div></div>
                    <svg aria-hidden="true" focusable="false" data-prefix="far" data-icon="id-card"
                         class="svg-inline--fa fa-id-card fa-w-18" role="img" xmlns="http://www.w3.org/2000/svg"
                         viewBox="0 0 576 512">
                        <path fill="currentColor"
                              d="M528 32H48C21.5 32 0 53.5 0 80v352c0 26.5 21.5 48 48 48h480c26.5 0 48-21.5 48-48V80c0-26.5-21.5-48-48-48zm0 400H303.2c.9-4.5.8 3.6.8-22.4 0-31.8-30.1-57.6-67.2-57.6-10.8 0-18.7 8-44.8 8-26.9 0-33.4-8-44.8-8-37.1 0-67.2 25.8-67.2 57.6 0 26-.2 17.9.8 22.4H48V144h480v288zm-168-80h112c4.4 0 8-3.6 8-8v-16c0-4.4-3.6-8-8-8H360c-4.4 0-8 3.6-8 8v16c0 4.4 3.6 8 8 8zm0-64h112c4.4 0 8-3.6 8-8v-16c0-4.4-3.6-8-8-8H360c-4.4 0-8 3.6-8 8v16c0 4.4 3.6 8 8 8zm0-64h112c4.4 0 8-3.6 8-8v-16c0-4.4-3.6-8-8-8H360c-4.4 0-8 3.6-8 8v16c0 4.4 3.6 8 8 8zm-168 96c35.3 0 64-28.7 64-64s-28.7-64-64-64-64 28.7-64 64 28.7 64 64 64z"></path>
                    </svg>
                    <span>我的资料</span>
                </a>
            </li>
            <li>
                <a href="#tabs-2" class="list-group-item list-group-item-action">
                    <div></div>
                    <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="coins"
                         class="svg-inline--fa fa-coins fa-w-16" role="img" xmlns="http://www.w3.org/2000/svg"
                         viewBox="0 0 512 512">
                        <path fill="currentColor"
                              d="M0 405.3V448c0 35.3 86 64 192 64s192-28.7 192-64v-42.7C342.7 434.4 267.2 448 192 448S41.3 434.4 0 405.3zM320 128c106 0 192-28.7 192-64S426 0 320 0 128 28.7 128 64s86 64 192 64zM0 300.4V352c0 35.3 86 64 192 64s192-28.7 192-64v-51.6c-41.3 34-116.9 51.6-192 51.6S41.3 334.4 0 300.4zm416 11c57.3-11.1 96-31.7 96-55.4v-42.7c-23.2 16.4-57.3 27.6-96 34.5v63.6zM192 160C86 160 0 195.8 0 240s86 80 192 80 192-35.8 192-80-86-80-192-80zm219.3 56.3c60-10.8 100.7-32 100.7-56.3v-42.7c-35.5 25.1-96.5 38.6-160.7 41.8 29.5 14.3 51.2 33.5 60 57.2z"></path>
                    </svg>
                    <span>我的积分</span>
                </a>
            </li>
            <li style="<%if(user.getUser_type() >= 1)out.print("display:none;");%>">
                <a href="#tabs-1" class="list-group-item list-group-item-action">
                    <div></div>
                    <svg aria-hidden="true" focusable="false" data-prefix="far" data-icon="question-circle"
                         class="svg-inline--fa fa-question-circle fa-w-16" role="img" xmlns="http://www.w3.org/2000/svg"
                         viewBox="0 0 512 512">
                        <path fill="currentColor"
                              d="M256 8C119.043 8 8 119.083 8 256c0 136.997 111.043 248 248 248s248-111.003 248-248C504 119.083 392.957 8 256 8zm0 448c-110.532 0-200-89.431-200-200 0-110.495 89.472-200 200-200 110.491 0 200 89.471 200 200 0 110.53-89.431 200-200 200zm107.244-255.2c0 67.052-72.421 68.084-72.421 92.863V300c0 6.627-5.373 12-12 12h-45.647c-6.627 0-12-5.373-12-12v-8.659c0-35.745 27.1-50.034 47.579-61.516 17.561-9.845 28.324-16.541 28.324-29.579 0-17.246-21.999-28.693-39.784-28.693-23.189 0-33.894 10.977-48.942 29.969-4.057 5.12-11.46 6.071-16.666 2.124l-27.824-21.098c-5.107-3.872-6.251-11.066-2.644-16.363C184.846 131.491 214.94 112 261.794 112c49.071 0 101.45 38.304 101.45 88.8zM298 368c0 23.159-18.841 42-42 42s-42-18.841-42-42 18.841-42 42-42 42 18.841 42 42z"></path>
                    </svg>
                    <span>常见问题</span>
                </a>
            </li>
            <li>
                <a href="#tabs-4" class="list-group-item list-group-item-action">
                    <div></div>
                    <svg aria-hidden="true" focusable="false" data-prefix="far" data-icon="question-circle"
                         class="svg-inline--fa fa-question-circle fa-w-16" role="img" xmlns="http://www.w3.org/2000/svg"
                         viewBox="0 0 512 512">
                        <path fill="currentColor"
                              d="M139.61 35.5a12 12 0 0 0-17 0L58.93 98.81l-22.7-22.12a12 12 0 0 0-17 0L3.53 92.41a12 12 0 0 0 0 17l47.59 47.4a12.78 12.78 0 0 0 17.61 0l15.59-15.62L156.52 69a12.09 12.09 0 0 0 .09-17zm0 159.19a12 12 0 0 0-17 0l-63.68 63.72-22.7-22.1a12 12 0 0 0-17 0L3.53 252a12 12 0 0 0 0 17L51 316.5a12.77 12.77 0 0 0 17.6 0l15.7-15.69 72.2-72.22a12 12 0 0 0 .09-16.9zM64 368c-26.49 0-48.59 21.5-48.59 48S37.53 464 64 464a48 48 0 0 0 0-96zm432 16H208a16 16 0 0 0-16 16v32a16 16 0 0 0 16 16h288a16 16 0 0 0 16-16v-32a16 16 0 0 0-16-16zm0-320H208a16 16 0 0 0-16 16v32a16 16 0 0 0 16 16h288a16 16 0 0 0 16-16V80a16 16 0 0 0-16-16zm0 160H208a16 16 0 0 0-16 16v32a16 16 0 0 0 16 16h288a16 16 0 0 0 16-16v-32a16 16 0 0 0-16-16z">
                        </path>
                    </svg>
                    <span>工单中心</span>
                </a>
            </li>
            <li style="<%if(user.getUser_type() >= 2)out.print("display:none;");%>">
                <a href="#tabs-5" class="list-group-item list-group-item-action">
                    <div></div>
                    <svg aria-hidden="true" focusable="false" data-prefix="far" data-icon="question-circle"
                         class="svg-inline--fa fa-question-circle fa-w-16" role="img" xmlns="http://www.w3.org/2000/svg"
                         viewBox="0 0 512 512">
                        <path fill="currentColor"
                              d="M624 352h-16V243.9c0-12.7-5.1-24.9-14.1-33.9L494 110.1c-9-9-21.2-14.1-33.9-14.1H416V48c0-26.5-21.5-48-48-48H48C21.5 0 0 21.5 0 48v320c0 26.5 21.5 48 48 48h16c0 53 43 96 96 96s96-43 96-96h128c0 53 43 96 96 96s96-43 96-96h48c8.8 0 16-7.2 16-16v-32c0-8.8-7.2-16-16-16zM160 464c-26.5 0-48-21.5-48-48s21.5-48 48-48 48 21.5 48 48-21.5 48-48 48zm320 0c-26.5 0-48-21.5-48-48s21.5-48 48-48 48 21.5 48 48-21.5 48-48 48zm80-208H416V144h44.1l99.9 99.9V256z"></path>
                    </svg>
                    <span>运单处理</span>
                </a>
            </li>
            <li style="<%if(user.getUser_type() != 3)out.print("display:none;");%>">
                <a href="#tabs-6" class="list-group-item list-group-item-action">
                    <div></div>
                    <svg aria-hidden="true" focusable="false" data-prefix="far" data-icon="question-circle"
                         class="svg-inline--fa fa-question-circle fa-w-16" role="img" xmlns="http://www.w3.org/2000/svg"
                         viewBox="0 0 512 512">
                        <path fill="currentColor"
                              d="M610.5 373.3c2.6-14.1 2.6-28.5 0-42.6l25.8-14.9c3-1.7 4.3-5.2 3.3-8.5-6.7-21.6-18.2-41.2-33.2-57.4-2.3-2.5-6-3.1-9-1.4l-25.8 14.9c-10.9-9.3-23.4-16.5-36.9-21.3v-29.8c0-3.4-2.4-6.4-5.7-7.1-22.3-5-45-4.8-66.2 0-3.3.7-5.7 3.7-5.7 7.1v29.8c-13.5 4.8-26 12-36.9 21.3l-25.8-14.9c-2.9-1.7-6.7-1.1-9 1.4-15 16.2-26.5 35.8-33.2 57.4-1 3.3.4 6.8 3.3 8.5l25.8 14.9c-2.6 14.1-2.6 28.5 0 42.6l-25.8 14.9c-3 1.7-4.3 5.2-3.3 8.5 6.7 21.6 18.2 41.1 33.2 57.4 2.3 2.5 6 3.1 9 1.4l25.8-14.9c10.9 9.3 23.4 16.5 36.9 21.3v29.8c0 3.4 2.4 6.4 5.7 7.1 22.3 5 45 4.8 66.2 0 3.3-.7 5.7-3.7 5.7-7.1v-29.8c13.5-4.8 26-12 36.9-21.3l25.8 14.9c2.9 1.7 6.7 1.1 9-1.4 15-16.2 26.5-35.8 33.2-57.4 1-3.3-.4-6.8-3.3-8.5l-25.8-14.9zM496 400.5c-26.8 0-48.5-21.8-48.5-48.5s21.8-48.5 48.5-48.5 48.5 21.8 48.5 48.5-21.7 48.5-48.5 48.5zM224 256c70.7 0 128-57.3 128-128S294.7 0 224 0 96 57.3 96 128s57.3 128 128 128zm201.2 226.5c-2.3-1.2-4.6-2.6-6.8-3.9l-7.9 4.6c-6 3.4-12.8 5.3-19.6 5.3-10.9 0-21.4-4.6-28.9-12.6-18.3-19.8-32.3-43.9-40.2-69.6-5.5-17.7 1.9-36.4 17.9-45.7l7.9-4.6c-.1-2.6-.1-5.2 0-7.8l-7.9-4.6c-16-9.2-23.4-28-17.9-45.7.9-2.9 2.2-5.8 3.2-8.7-3.8-.3-7.5-1.2-11.4-1.2h-16.7c-22.2 10.2-46.9 16-72.9 16s-50.6-5.8-72.9-16h-16.7C60.2 288 0 348.2 0 422.4V464c0 26.5 21.5 48 48 48h352c10.1 0 19.5-3.2 27.2-8.5-1.2-3.8-2-7.7-2-11.8v-9.2z">
                        </path>
                    </svg>
                    <span>管理员入口</span>
                </a>
            </li>
        </ul>
        <div class="right-view">
            <div id="tabs-3">
                <div class="name-card">
                    <div id="avatar" style="background-image: <%out.print("url(" + user.getUser_profile().replace("/", "/") + ")");%>;"></div>
                    <span><%out.print(user.getUser_name());%></span>
                </div>
                <div class="user-info">
                    <Span class="title">个人信息</Span>
                    <div class="hrs"></div>
                    <div id="user-info-box">
                        <p>
                            <em>姓名</em>
                            <span><%out.print(user.getUser_name());%></span>
                        </p>
                        <p>
                            <em>性别</em>
                            <span><%out.print(user.getUser_gender());%></span>
                        </p>
                        <p>
                            <em>邮箱</em>
                            <span><%out.print(user.getUser_email());%></span>
                        </p>
                        <p>
                            <em>手机</em>
                            <span><%out.print(user.getUser_phone());%></span>
                        </p>
                    </div>
                </div>
                <div class="user-addresses" style="<%if(user.getUser_type() >= 1)out.print("display:none;");%>">
                    <div style="height: 30px;line-height: 30px;position: absolute;">
                        <Span class="title">地址簿</Span>
                    </div>
                    <button onclick="openAddAddress(true)">
                        <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="plus"
                             class="svg-inline--fa fa-plus fa-w-14" role="img" xmlns="http://www.w3.org/2000/svg"
                             viewBox="0 0 448 512">
                            <path fill="currentColor"
                                  d="M416 208H272V64c0-17.67-14.33-32-32-32h-32c-17.67 0-32 14.33-32 32v144H32c-17.67 0-32 14.33-32 32v32c0 17.67 14.33 32 32 32h144v144c0 17.67 14.33 32 32 32h32c17.67 0 32-14.33 32-32V304h144c17.67 0 32-14.33 32-32v-32c0-17.67-14.33-32-32-32z"></path>
                        </svg>
                    </button>
                    <div id="add-search">
                        <input name="search" type="text" placeholder="查找地址簿">
                        <button>查找</button>
                    </div>
                    <div class="hrs"></div>
                    <table>
                        <thead>
                        <tr>
                            <td style="width: 150px">姓名</td>
                            <td style="width: 180px">联系方式</td>
                            <td style="width: 430px">地址</td>
                            <td style="width: 100px">操作</td>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            for(Address add: addresses) {
                                out.println(htmls.addressTr(add, Integer.parseInt(id), token));
                            }
                        %>
                        </tbody>
                    </table>
<%--                    <div id="add-page-bar">--%>
<%--                        <button>--%>
<%--                            <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="chevron-left"--%>
<%--                                 class="svg-inline--fa fa-chevron-left fa-w-10" role="img"--%>
<%--                                 xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 512">--%>
<%--                                <path fill="currentColor"--%>
<%--                                      d="M34.52 239.03L228.87 44.69c9.37-9.37 24.57-9.37 33.94 0l22.67 22.67c9.36 9.36 9.37 24.52.04 33.9L131.49 256l154.02 154.75c9.34 9.38 9.32 24.54-.04 33.9l-22.67 22.67c-9.37 9.37-24.57 9.37-33.94 0L34.52 272.97c-9.37-9.37-9.37-24.57 0-33.94z"></path>--%>
<%--                            </svg>--%>
<%--                        </button>--%>
<%--                        <button style="background: #F9893C;color: #fff;padding-bottom: 3px;"><span>0</span></button>--%>
<%--                        <button>--%>
<%--                            <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="chevron-right"--%>
<%--                                 class="svg-inline--fa fa-chevron-right fa-w-10" role="img"--%>
<%--                                 xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 512">--%>
<%--                                <path fill="currentColor"--%>
<%--                                      d="M285.476 272.971L91.132 467.314c-9.373 9.373-24.569 9.373-33.941 0l-22.667-22.667c-9.357-9.357-9.375-24.522-.04-33.901L188.505 256 34.484 101.255c-9.335-9.379-9.317-24.544.04-33.901l22.667-22.667c9.373-9.373 24.569-9.373 33.941 0L285.475 239.03c9.373 9.372 9.373 24.568.001 33.941z"></path>--%>
<%--                            </svg>--%>
<%--                        </button>--%>
<%--                        <div style="width: 100%;"><span style="float: right;margin-right: 5px;">共 0 页</span></div>--%>
<%--                    </div>--%>
                </div>
            </div>
            <div id="tabs-2" style="display: flex;">
                <div class="point-show">
                    我的积分
                    <div id="point-main"><span><%out.print(user.getUser_point());%></span></div>
                    <button onclick="location='/ClockIn?uid=<%=id%>&tid=<%=token%>'">立即签到</button>
                    <div class="hrs" style="border-color: #fff;border-top: 1px solid;margin: 0;margin-top: 80px;"></div>
                    <div style="text-align: left;padding: 0 2px;">
                        <span>可用积分</span>
                        <span style="float:right;"><%out.print(user.getUser_point());%></span>
                    </div>
                </div>
                <div class="point-info">
                    <div id="point" class="point">
                        <div>
                            <label>积分明细</label>
                        </div>
                        <div class="pointList">
                            <table>
                                <tr>
                                    <td style="padding: 0;">+50</td>
                                    <td style="padding: 0;">注册获取</td>
                                    <td style="padding: 0;">2021-06-01</td>
                                </tr>
                                <%
                                    for(PointInfo info : points) {
                                        out.println(htmls.pointDetail(info.getPoints_change(), info.getPoints_content(), info.getPoints_time()));
                                    }
                                %>
                            </table>
                        </div>
                    </div>
                </div>
                <img class="redemption" src="../../img/user_center/scan.png">
            </div>

            <div id="tabs-1">
                <div class="user-info">
                    <Span class="title">常见问题</Span>
                    <div class="hrs"></div>
                    <div id="user-info-box">
                        <div class="accordion" id="accordionExample">
                            <div class="card">
                                <div class="card-header" id="headingOne">
                                    <h2 class="mb-0">
                                        <button class="btn" type="button" data-toggle="collapse"
                                                data-target="#collapseOne" aria-expanded="true"
                                                aria-controls="collapseOne">
                                            国际件开通的国家有哪些？
                                        </button>
                                    </h2>
                                </div>

                                <div id="collapseOne" class="collapse show" aria-labelledby="headingOne"
                                     data-parent="#accordionExample">
                                    <div class="card-body">
                                        目前我司已经开通到韩国、美国、泰国、蒙古、越南、澳大利亚、俄罗斯、马来西亚、日本、新加坡、印度尼西亚、柬埔寨、加拿大、墨西哥、缅甸、阿联酋、斯里兰卡、巴基斯坦、菲律宾国家的快递~其它国家地区暂不支持收寄个人件，后续如开通其它国家或地区，会在官网第一时间公布相关信息。

                                        （注：西藏、玉树藏族自治州、果洛藏族自治州、黄南藏族自治州暂不支持国际件）
                                    </div>
                                </div>
                            </div>
                            <div class="card">
                                <div class="card-header" id="headingTwo">
                                    <h2 class="mb-0">
                                        <button class="btn collapsed" type="button" data-toggle="collapse"
                                                data-target="#collapseTwo" aria-expanded="false"
                                                aria-controls="collapseTwo">
                                            申请月结需要满足哪些条件？
                                        </button>
                                    </h2>
                                </div>
                                <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo"
                                     data-parent="#accordionExample">
                                    <div class="card-body">
                                        <h6>申请我司月结的条件为：</h6>
                                        <h6>1、有固定的经营场所或居住场所</h6>
                                        <h6>2、凡申请按月结计算运费，前一个月结算的运费以及寄件量要求以地区标准为准</h6>
                                        <h6>3、在顺丰服务范围内注册的具有独立法人资格的企业、社会团体、持有营业执照的单位及个体户或持有有效证件的个人，且企业或个人信誉度良好</h6>
                                        <h6>PS:详情以您所在地区点部核实为准</h6>
                                    </div>
                                </div>
                            </div>
                            <div class="card">
                                <div class="card-header" id="headingThree">
                                    <h2 class="mb-0">
                                        <button class="btn collapsed" type="button" data-toggle="collapse"
                                                data-target="#collapseThree" aria-expanded="false"
                                                aria-controls="collapseThree">
                                            怎么申请电子发票？
                                        </button>
                                    </h2>
                                </div>
                                <div id="collapseThree" class="collapse" aria-labelledby="headingThree"
                                     data-parent="#accordionExample">
                                    <div class="card-body">
                                        大部分城市已开通电子发票自助申请，付款方在支付运费约1个工作日后即可通过微信公众号申请：“我”—“我的钱包”—“发票申请”—输入或勾选运单号—申请发票。
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
            <!--工单中心页面-->
            <div id="tabs-4">
                <script>
                    $(function () {
                        $("#tabNew").tabs();
                    });
                </script>

                <!--工单中心页面-->
                <div id="tabNew" class="tabNew" style="padding: 0">
                    <ul>
                        <%if(user.getUser_type() < 2)out.println("<li><a href=\"#tabNew-1\">创建工单</a></li>");%>
                        <%if(user.getUser_type() == 2)out.println("<li><a href=\"#tabNew-2\">待处理</a></li>");%>
                        <%if(user.getUser_type() < 2)out.println("<li><a href=\"#tabNew-3\">我创建的</a></li>");%>
                    </ul>
                    <!--创建工单-->
                    <div id="tabNew-1" style="<%if(user.getUser_type() >= 2)out.print("display:none;");%>">
                        <%
                            if(user.getUser_type() < 2) {
                                out.println("<div class=\"createOrder user-info\">\n" +
                                        "                            <Span class=\"title\">检索运单</Span>\n" +
                                        "                            <div id=\"add-search\" style=\"margin-bottom: 0\">\n" +
                                        "                                <input id=\"search_order\" name=\"search\" type=\"text\" placeholder=\"输入订单号\" oninput=\"this.style.border ='1px #00000024 solid';this.style.color = '#000'\">\n" +
                                        "                                <button onclick=\"getOrderInfo(document.getElementById('search_order').value);return false;\">查找</button>\n" +
                                        "                            </div>\n" +
                                        "                            <div id=\"search_box\" class=\"two_list\" style=\"display: none;\" name=\"search_order_box\">\n" +
                                        "                                <div class=\"hrs\"></div>\n" +
                                        "                                <p>\n" +
                                        "                                    <em>订单号</em>\n" +
                                        "                                    <span id=\"search_id\">id</span>\n" +
                                        "                                </p>\n" +
                                        "                                <p>\n" +
                                        "                                    <em>下单日期</em>\n" +
                                        "                                    <span id=\"search_create\">createDate</span>\n" +
                                        "                                </p>\n" +
                                        "                                <p>\n" +
                                        "                                    <em>发件地址</em>\n" +
                                        "                                    <span id=\"search_sendAdd\">deliveryMan</span>\n" +
                                        "                                </p>\n" +
                                        "                                <p>\n" +
                                        "                                    <em>收件地址</em>\n" +
                                        "                                    <span id=\"search_deliveryAdd\">deliveryMan</span>\n" +
                                        "                                </p>\n" +
                                        "                                <p>\n" +
                                        "                                    <em>发件日期</em>\n" +
                                        "                                    <span id=\"search_send\">sendDate</span>\n" +
                                        "                                </p>\n" +
                                        "                                <p>\n" +
                                        "                                    <em>送达日期</em>\n" +
                                        "                                    <span id=\"search_delivery\">deliveryDate</span>\n" +
                                        "                                </p>\n" +
                                        "                                <p>\n" +
                                        "                                    <em>派送员</em>\n" +
                                        "                                    <span id=\"search_deliveryMan\">deliveryMan</span>\n" +
                                        "                                </p>\n" +
                                        "                                <p>\n" +
                                        "                                    <em>运单类型</em>\n" +
                                        "                                    <span id=\"search_type\">orderType</span>\n" +
                                        "                                </p>\n" +
                                        "                                <p>\n" +
                                        "                                    <em>运单备注</em>\n" +
                                        "                                    <span id=\"search_marks\">orderMarks</span>\n" +
                                        "                                </p>\n" +
                                        "                            </div>\n" +
                                        "                        </div>");
                            }
                        %>
                        <div class="createOrder">
                            <form action="/CreateWorkOrder" method="post">
                                <input name="uid" value="<%=id%>" style="display: none;">
                                <input name="tid" value="<%=token%>" style="display: none;">
                                <div>
                                    <label><i>*</i>工单编号</label>
                                    <input placeholder="[自动生成]" readonly="readonly">
                                    <label>运单编号</label>
                                    <input name="oid" placeholder="请输入您13位运单号" type="text">
                                </div>
                                <div>
                                    <label><i>*</i>备&emsp;注</label>
                                    <textarea name="str" placeholder="你可以在这里提交服务咨询、详细探讨功能需求以及运单疑问的反馈，如反馈运单疑问请在上方运单编号中填写编号。如有需要可以使用上方的运单检索快速查询运单。"></textarea>
                                </div>
                                <div style="text-align: center">
                                    <button type="submit">提交</button>
                                </div>
                            </form>
                        </div>
                    </div>
                    <!--待处理的-->
                    <%
                        if(user.getUser_type() == 2) {
                            // 检索运单
                            out.println("<div class=\"createOrder user-info\">\n" +
                                    "                            <Span class=\"title\">检索运单</Span>\n" +
                                    "                            <div id=\"add-search\" style=\"margin-bottom: 0\">\n" +
                                    "                                <input id=\"search_order\" name=\"search\" type=\"text\" placeholder=\"输入订单号\" oninput=\"this.style.border ='1px #00000024 solid';this.style.color = '#000'\">\n" +
                                    "                                <button onclick=\"getOrderInfo(document.getElementById('search_order').value);return false;\">查找</button>\n" +
                                    "                            </div>\n" +
                                    "                            <div id=\"search_box\" class=\"two_list\" style=\"display: none;\" name=\"search_order_box\">\n" +
                                    "                                <div class=\"hrs\"></div>\n" +
                                    "                                <p>\n" +
                                    "                                    <em>订单号</em>\n" +
                                    "                                    <span id=\"search_id\">id</span>\n" +
                                    "                                </p>\n" +
                                    "                                <p>\n" +
                                    "                                    <em>下单日期</em>\n" +
                                    "                                    <span id=\"search_create\">createDate</span>\n" +
                                    "                                </p>\n" +
                                    "                                <p>\n" +
                                    "                                    <em>发件地址</em>\n" +
                                    "                                    <span id=\"search_sendAdd\">deliveryMan</span>\n" +
                                    "                                </p>\n" +
                                    "                                <p>\n" +
                                    "                                    <em>收件地址</em>\n" +
                                    "                                    <span id=\"search_deliveryAdd\">deliveryMan</span>\n" +
                                    "                                </p>\n" +
                                    "                                <p>\n" +
                                    "                                    <em>发件日期</em>\n" +
                                    "                                    <span id=\"search_send\">sendDate</span>\n" +
                                    "                                </p>\n" +
                                    "                                <p>\n" +
                                    "                                    <em>送达日期</em>\n" +
                                    "                                    <span id=\"search_delivery\">deliveryDate</span>\n" +
                                    "                                </p>\n" +
                                    "                                <p>\n" +
                                    "                                    <em>派送员</em>\n" +
                                    "                                    <span id=\"search_deliveryMan\">deliveryMan</span>\n" +
                                    "                                </p>\n" +
                                    "                                <p>\n" +
                                    "                                    <em>运单类型</em>\n" +
                                    "                                    <span id=\"search_type\">orderType</span>\n" +
                                    "                                </p>\n" +
                                    "                                <p>\n" +
                                    "                                    <em>运单备注</em>\n" +
                                    "                                    <span id=\"search_marks\">orderMarks</span>\n" +
                                    "                                </p>\n" +
                                    "                            </div>\n" +
                                    "                        </div>");
                            // 输出表单头
                            out.println("<div id=\"tabNew-2\" class=\"waitFixing\">\n" +
                                    "                        <table>\n" +
                                    "                            <tr>\n" +
                                    "                                <th>运单</th>\n" +
                                    "                                <th>创建时间</th>\n" +
                                    "                                <th>联系人</th>\n" +
                                    "                                <th>电话</th>\n" +
                                    "                                <th>备注</th>\n" +
                                    "                                <th>状态</th>\n" +
                                    "                            </tr>");
                            // 输出表单
                            WorkOrder[] workOrders = workOrderService.getAllNoCloseOrder();
                            for (WorkOrder wd : workOrders) {
                                out.println(htmls.workOrderTr((wd.getWorkOrder_orderId() == null || wd.getWorkOrder_orderId().equals("")) ? "无" : wd.getWorkOrder_orderId(), wd.getWorkOrder_date(), user.getUser_name(), user.getUser_phone(), wd.getWorkOrder_content(), wd.getWorkOrder_endContent(), wd.getWorkOrder_endWay(), true, wd.getWorkOrder_id()));
                            }
                            // 输出表单尾
                            out.println("\n" +
                                    "                        </table>\n" +
                                    "                    </div>");
                        }
                    %>
                    <!--我创建的工单-->
                    <%
                        // 输出表单头
                        if(user.getUser_type() < 2) {
                            out.println("<div id=\"tabNew-3\" class=\"waitFixing\">\n" +
                                    "                        <table>\n" +
                                    "                            <tr>\n" +
                                    "                                <th>运单</th>\n" +
                                    "                                <th>创建时间</th>\n" +
                                    "                                <th>联系人</th>\n" +
                                    "                                <th>电话</th>\n" +
                                    "                                <th>备注</th>\n" +
                                    "                                <th>状态</th>\n" +
                                    "                            </tr>");
                            // 输出表单
                            WorkOrder[] workOrders = workOrderService.getAddWOrder(Integer.parseInt(id));
                            for (WorkOrder wd : workOrders) {
                                out.println(htmls.workOrderTr((wd.getWorkOrder_orderId() == null || wd.getWorkOrder_orderId().equals("")) ? "无" : wd.getWorkOrder_orderId(), wd.getWorkOrder_date(), user.getUser_name(), user.getUser_phone(), wd.getWorkOrder_content(), wd.getWorkOrder_endContent(), wd.getWorkOrder_endWay(), false, null));
                            }
                            // 输出表单尾
                            out.println("\n" +
                                    "                        </table>\n" +
                                    "                    </div>");
                        }
                    %>
                </div>
            </div>
            <!--运单处理页面-->
            <div id="tabs-5">
                <script>
                    $(function () {
                        $("#delivery").tabs();
                    });
                </script>
                <form id="delivery" class="tabNew">
                    <ul>
                        <li><a href="#delivery-1">待配送</a></li>
                        <%if(user.getUser_type() == 0)out.println("<li><a href=\"#delivery-2\">运输中</a></li>");%>
                        <%if(user.getUser_type() == 0)out.println("<li><a href=\"#delivery-3\">已送达</a></li>");%>
                    </ul>
                    <div id="delivery-1" class="waitDelivering">
                        <table>
                            <%
                                if(user.getUser_type() == 0) {
                                    out.println("\n" +
                                            "                            <tr>\n" +
                                            "                                <th>快递单号</th>\n" +
                                            "                                <th>类型</th>\n" +
                                            "                                <th>收货地址</th>\n" +
                                            "                                <th>备注</th>\n" +
                                            "                            </tr>");
                                    Order[] orders = orderService.getOrderByType(user, "wait");
                                    for(Order order:orders) {
                                        out.print(htmls.orderTr(order, user, "wait", userService));
                                    }
                                } else if(user.getUser_type() == 1) {
                                    out.println("\n" +
                                            "                            <tr>\n" +
                                            "                                <th>快递单号</th>\n" +
                                            "                                <th>类型</th>\n" +
                                            "                                <th>收货地址</th>\n" +
                                            "                                <th>状态</th>\n" +
                                            "                            </tr>");
                                    Order[] orders = orderService.getOrderNotSend(Integer.parseInt(id));
                                    for(Order order:orders) {
                                        out.print(htmls.orderTr(order, user, "waitsend", userService));
                                    }
                                }
                            %>
                        </table>
                    </div>
                    <div id="delivery-2" class="waitDelivering" <%if(user.getUser_type() > 0)out.print("Style=\"display:none;\"");%>>
                        <table>
                            <tr>
                                <th>快递单号</th>
                                <th>类型</th>
                                <th>收货地址</th>
                                <th>派送员</th>
                            </tr>
                            <%
                                if(user.getUser_type() <= 2) {
                                    Order[] orders = orderService.getOrderByType(user, "run");
                                    for(Order order:orders) {
                                        out.print(htmls.orderTr(order, user, "run", userService));
                                    }
                                }
                            %>
                        </table>
                    </div>
                    <div id="delivery-3" class="waitDelivering" <%if(user.getUser_type() > 0)out.print("Style=\"display:none;\"");%>>
                        <table>
                            <tr>
                                <th>快递单号</th>
                                <th>类型</th>
                                <th>地址</th>
                                <th>状态</th>
                            </tr>
                            <%
                                if(user.getUser_type() <= 2) {
                                    Order[] orders = orderService.getOrderByType(user, "stay");
                                    for(Order order:orders) {
                                        out.print(htmls.orderTr(order, user, "stay", userService));
                                    }
                                }
                            %>
                        </table>
                    </div>
                </form>
            </div>
            <!--管理员入口-->
            <div id="tabs-6">
                <p>管理员入口</p>
            </div>
        </div>
    </div>
</div>
<!-- 弹窗 -->
<div class="pop" id="addressPop" style="visibility: collapse;">
    <div>
        <div>
            <button onclick="return openAddAddress(false)">
                <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" baseProfile="full" width="76" height="76" viewBox="0 0 76.00 76.00" enable-background="new 0 0 76.00 76.00" xml:space="preserve">
	                <path fill="#000000" fill-opacity="1" stroke-width="0.2" stroke-linejoin="round" d="M 26.9166,22.1667L 37.9999,33.25L 49.0832,22.1668L 53.8332,26.9168L 42.7499,38L 53.8332,49.0834L 49.0833,53.8334L 37.9999,42.75L 26.9166,53.8334L 22.1666,49.0833L 33.25,38L 22.1667,26.9167L 26.9166,22.1667 Z "/>
                </svg>
            </button>
        </div>
        <div>
            <!-- 添加地址表单 -->

        </div>
    </div>
</div>
<div class="pop" id="workOrderPop" style="visibility: collapse;">
    <div>
        <div>
            <button onclick="return openWorkOrder(false, null)">
                <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" baseProfile="full" width="76" height="76" viewBox="0 0 76.00 76.00" enable-background="new 0 0 76.00 76.00" xml:space="preserve">
	                <path fill="#000000" fill-opacity="1" stroke-width="0.2" stroke-linejoin="round" d="M 26.9166,22.1667L 37.9999,33.25L 49.0832,22.1668L 53.8332,26.9168L 42.7499,38L 53.8332,49.0834L 49.0833,53.8334L 37.9999,42.75L 26.9166,53.8334L 22.1666,49.0833L 33.25,38L 22.1667,26.9167L 26.9166,22.1667 Z "/>
                </svg>
            </button>
        </div>
        <div class="deal-order-main" style="text-align: center;">
            <!-- 处理工单 -->
            <form method="get" action="/DetalWorkOrder">
                <input name="uid" value="<%=id%>" style="display: none;">
                <input name="tid" value="<%=token%>" style="display: none;">
                <input id="deal-order-woid" name="woid" value="" style="display: none;">
                <div class="pop-title">
                    <div>
                        <svg aria-hidden="true" focusable="false" data-prefix="far" data-icon="edit" class="svg-inline--fa fa-edit fa-w-18" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512"><path fill="currentColor" d="M402.3 344.9l32-32c5-5 13.7-1.5 13.7 5.7V464c0 26.5-21.5 48-48 48H48c-26.5 0-48-21.5-48-48V112c0-26.5 21.5-48 48-48h273.5c7.1 0 10.7 8.6 5.7 13.7l-32 32c-1.5 1.5-3.5 2.3-5.7 2.3H48v352h352V350.5c0-2.1.8-4.1 2.3-5.6zm156.6-201.8L296.3 405.7l-90.4 10c-26.2 2.9-48.5-19.2-45.6-45.6l10-90.4L432.9 17.1c22.9-22.9 59.9-22.9 82.7 0l43.2 43.2c22.9 22.9 22.9 60 .1 82.8zM460.1 174L402 115.9 216.2 301.8l-7.3 65.3 65.3-7.3L460.1 174zm64.8-79.7l-43.2-43.2c-4.1-4.1-10.8-4.1-14.8 0L436 82l58.1 58.1 30.9-30.9c4-4.2 4-10.8-.1-14.9z"></path></svg>
                    </div>
                    <span> 处理工单</span>
                </div>
                <div class="hrs" style="margin: auto;"></div>
                <div class="deal-order">
                    <span style="margin-top: 10px;"><i>*</i>处理工单</span>
                    <div>
                        <input id="item1" type="radio" name="way" value="ok">
                        <label for="item1"><span>完成工单</span></label>
                    </div>
                    <div>
                        <input id="item2" type="radio" name="way" value="no" checked>
                        <label for="item2"><span>驳回工单</span></label>
                    </div>
                </div>
                <div style="text-align: left;margin-top: 10px;margin-left: 20px;">
                    <label><i>*</i> 回 执</label>
                    <textarea name="str" placeholder="处理回执"></textarea>
                </div>
                <button type="submit">提&nbsp;&nbsp;&nbsp;交</button>
            </form>
        </div>
    </div>
</div>
<div class="pop" id="workOrderBackPop" style="visibility: collapse;">
    <div style="min-height: auto;width: 30%;">
        <div>
            <button onclick="return openWorkOrderBack(false, null)">
                <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" baseProfile="full" width="76" height="76" viewBox="0 0 76.00 76.00" enable-background="new 0 0 76.00 76.00" xml:space="preserve">
	                <path fill="#000000" fill-opacity="1" stroke-width="0.2" stroke-linejoin="round" d="M 26.9166,22.1667L 37.9999,33.25L 49.0832,22.1668L 53.8332,26.9168L 42.7499,38L 53.8332,49.0834L 49.0833,53.8334L 37.9999,42.75L 26.9166,53.8334L 22.1666,49.0833L 33.25,38L 22.1667,26.9167L 26.9166,22.1667 Z "/>
                </svg>
            </button>
        </div>
        <div class="deal-order-main" style="text-align: center;">
            <!-- 处理工单 -->
            <div class="pop-title">
                <div>
                    <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="info" class="svg-inline--fa fa-info fa-w-6" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 192 512"><path fill="currentColor" d="M20 424.229h20V279.771H20c-11.046 0-20-8.954-20-20V212c0-11.046 8.954-20 20-20h112c11.046 0 20 8.954 20 20v212.229h20c11.046 0 20 8.954 20 20V492c0 11.046-8.954 20-20 20H20c-11.046 0-20-8.954-20-20v-47.771c0-11.046 8.954-20 20-20zM96 0C56.235 0 24 32.235 24 72s32.235 72 72 72 72-32.235 72-72S135.764 0 96 0z"></path></svg>                </div>
                <span> 处理结果</span>
            </div>
            <div class="hrs" style="margin: auto;"></div>
            <div style="margin-top: 20px;"><span id="work-order-endWay"></span></div>
            <button onclick="return openWorkOrderBack(false, null)">确&nbsp;&nbsp;&nbsp;定</button>
        </div>
    </div>
</div>
<div class="pop" id="orderRunPop" style="visibility: collapse;">
    <div style="width: 35%;">
        <div>
            <button onclick="return openSendControl(false, null, null)">
                <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" baseProfile="full" width="76" height="76" viewBox="0 0 76.00 76.00" enable-background="new 0 0 76.00 76.00" xml:space="preserve">
	                <path fill="#000000" fill-opacity="1" stroke-width="0.2" stroke-linejoin="round" d="M 26.9166,22.1667L 37.9999,33.25L 49.0832,22.1668L 53.8332,26.9168L 42.7499,38L 53.8332,49.0834L 49.0833,53.8334L 37.9999,42.75L 26.9166,53.8334L 22.1666,49.0833L 33.25,38L 22.1667,26.9167L 26.9166,22.1667 Z "/>
                </svg>
            </button>
        </div>
        <div class="deal-order-main" style="text-align: center;">
            <!-- 处理工单 -->
            <div class="pop-title">
                <div>
                    <svg aria-hidden="true" focusable="false" data-prefix="far" data-icon="edit" class="svg-inline--fa fa-edit fa-w-18" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512"><path fill="currentColor" d="M402.3 344.9l32-32c5-5 13.7-1.5 13.7 5.7V464c0 26.5-21.5 48-48 48H48c-26.5 0-48-21.5-48-48V112c0-26.5 21.5-48 48-48h273.5c7.1 0 10.7 8.6 5.7 13.7l-32 32c-1.5 1.5-3.5 2.3-5.7 2.3H48v352h352V350.5c0-2.1.8-4.1 2.3-5.6zm156.6-201.8L296.3 405.7l-90.4 10c-26.2 2.9-48.5-19.2-45.6-45.6l10-90.4L432.9 17.1c22.9-22.9 59.9-22.9 82.7 0l43.2 43.2c22.9 22.9 22.9 60 .1 82.8zM460.1 174L402 115.9 216.2 301.8l-7.3 65.3 65.3-7.3L460.1 174zm64.8-79.7l-43.2-43.2c-4.1-4.1-10.8-4.1-14.8 0L436 82l58.1 58.1 30.9-30.9c4-4.2 4-10.8-.1-14.9z"></path></svg>
                </div>
                <span> 更新运单状态</span>
            </div>
            <div class="hrs" style="margin: auto;"></div>
            <div style="display: flex;">
                <span style="margin-top: 25px;margin-left: 20px;margin-right: 20px;">运单信息</span>
                <button id="order-info-s" style="height: 35px;width: 100px;font-size: 13px;" onclick="return false">运单信息</button>
                <button style="height: 35px;width: 100px;font-size: 13px;margin-left: 15px;" onclick="return false">打印票面</button>
            </div>
            <div style="display: flex;">
                <span style="margin-top: 25px;margin-left: 20px;margin-right: 20px;">操作运单</span>
                <form action="/NextOrder" method="get">
                    <input name="uid" value="<%=id%>" style="display: none;">
                    <input name="tid" value="<%=token%>" style="display: none;">
                    <input id="deal-order-next" name="oid" style="display: none;">
                    <button style="height: 35px;width: 150px;font-size: 13px;">结束当前流程</button>
                </form>
            </div>
            <div style="padding: 20px 40px;font-size: 15px;">
                <span>* 结束当前流程将会将运单标记为下一步，如运单当前“未派送”将更新为“派送中”。</span>
            </div>
        </div>
    </div>
</div>
<div class="pop" id="orderInfoPop" style="visibility: collapse;">
    <div style="background: transparent;-moz-box-shadow: 0 0 0 #dfdfdf00;-webkit-box-shadow: 0 0 0 #dfdfdf00;box-shadow: 0 0 0 #dfdfdf00;">
        <div class="envelope">
            <h2>订单信息</h2>
            <h6></h6>
            <div style="border-top: 1px dashed #c2c2c2;margin-top: 20px;">
                <p>下单日期：<span id="oif_createDate"></span></p>
                <p>派送日期：<span id="oif_sendDate"></span></p>
                <p>送达日期：<span id="oif_endDate"></span></p>
            </div>
            <div style="border-top: 1px dashed #c2c2c2;margin-top: 20px;">
                <p>寄件人：<span id="oif_sendName"></span></p>
                <p>联系方式：<span id="oif_sendPhone"></span></p>
                <p>地址：<span id="oif_sendAddress"></span></p>
            </div>
            <div style="border-top: 1px dashed #c2c2c2;margin-top: 20px;">
                <p>收件人：<span id="oif_getName"></span></p>
                <p>联系方式：<span id="oif_getPhone"></span></p>
                <p>地址：<span id="oif_getAddress"></span></p>
            </div>
            <div style="border-top: 1px dashed #c2c2c2;margin-top: 20px;">
                <p>派送员：<span id="oif_sendMan"></span></p>
            </div>
            <div class="end-button">
                <button onclick="openOrderInfo(false, null)">确认</button>
            </div>
        </div>
        <div style="margin: 0 auto;" class="envelope-png"></div>
    </div>
</div>
<div class="pop" id="orderCheckPop" style="visibility: collapse;">
    <div style="min-height: 250px;">
        <div>
            <button onclick="return openOrderCheck(false, null)">
                <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" baseProfile="full" width="76" height="76" viewBox="0 0 76.00 76.00" enable-background="new 0 0 76.00 76.00" xml:space="preserve">
	                <path fill="#000000" fill-opacity="1" stroke-width="0.2" stroke-linejoin="round" d="M 26.9166,22.1667L 37.9999,33.25L 49.0832,22.1668L 53.8332,26.9168L 42.7499,38L 53.8332,49.0834L 49.0833,53.8334L 37.9999,42.75L 26.9166,53.8334L 22.1666,49.0833L 33.25,38L 22.1667,26.9167L 26.9166,22.1667 Z "/>
                </svg>
            </button>
        </div>
        <div class="deal-order-main" style="text-align: center;">
            <!-- 处理工单 -->
            <form method="get" action="/CheckOrder">
                <input name="uid" value="<%=id%>" style="display: none;">
                <input name="tid" value="<%=token%>" style="display: none;">
                <input id="deal-order-oid" name="oid" value="" style="display: none;">
                <div class="pop-title">
                    <div><svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="archive" class="svg-inline--fa fa-archive fa-w-16" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path fill="currentColor" d="M32 448c0 17.7 14.3 32 32 32h384c17.7 0 32-14.3 32-32V160H32v288zm160-212c0-6.6 5.4-12 12-12h104c6.6 0 12 5.4 12 12v8c0 6.6-5.4 12-12 12H204c-6.6 0-12-5.4-12-12v-8zM480 32H32C14.3 32 0 46.3 0 64v48c0 8.8 7.2 16 16 16h480c8.8 0 16-7.2 16-16V64c0-17.7-14.3-32-32-32z"></path></svg>                    </div>
                    <span> 确认运单</span>
                </div>
                <div class="hrs" style="margin: auto;"></div>
                <div style="padding: 20px 50px;"><span>点击下方按钮将此运单标记为已收件，如有必要请在快递员当面检验快递完整性，确保无误后进行操作。</span></div>
                <button type="submit">确认收件</button>
            </form>
        </div>
    </div>
</div>
<!-- 底栏 -->
<%
    out.println(htmls.footer());
%>

<script>
    function openAddAddress(isOpen) {
        if(isOpen) {
            document.getElementById("addressPop").style.visibility = "visible";
        } else {
            document.getElementById("addressPop").style.visibility = "collapse";
        }
        return false;
    }

    function openOrderCheck(isOpen, id) {
        if(isOpen) {
            document.getElementById("deal-order-oid").value = id;
            document.getElementById("orderCheckPop").style.visibility = "visible";
        } else {
            document.getElementById("deal-order-oid").value = "";
            document.getElementById("orderCheckPop").style.visibility = "collapse";
        }
        return false;
    }

    function openOrderInfo(isOpen, oid) {
        if(isOpen) {
            if(oid === "" || oid == null) {
                document.getElementById("search_box").style.display = "none"
            }
            // 获取 cookie 中的用户信息
            let id = null;
            let token = null;
            const ca = document.cookie.split(';');
            for(let i=0; i<ca.length; i++)
            {
                const c = ca[i].trim();
                if(c.split('=')[0] === "id")
                    id = c.split('=')[1]
                if(c.split('=')[0] === "token")
                    token = c.split('=')[1]
            }
            // 请求 API
            fetch('/GetOrderAll?uid=' + id + "&token=" + token + "&oid=" + oid)
                .then(response => response.json())
                .then(data => {
                    if(data.stat === 200) {
                        // 请求正常
                        document.getElementById("oif_createDate").innerHTML = data.createDate;
                        document.getElementById("oif_sendDate").innerHTML = data.sendDate === "null"?"未派送":data.sendDate;
                        document.getElementById("oif_endDate").innerHTML = data.deliveryDate === "null"?"未送达":data.deliveryDate;
                        document.getElementById("oif_sendName").innerHTML = data.sendName;
                        document.getElementById("oif_sendPhone").innerHTML = data.sendPhone;
                        document.getElementById("oif_sendAddress").innerHTML = data.sendAddress;
                        document.getElementById("oif_getName").innerHTML = data.deliveryName;
                        document.getElementById("oif_getPhone").innerHTML = data.deliveryPhone;
                        document.getElementById("oif_getAddress").innerHTML = data.deliveryAddress;
                        document.getElementById("oif_sendMan").innerHTML = data.deliveryMan;
                    }
                })
                .catch(console.error)

            document.getElementById("orderInfoPop").style.visibility = "visible";
        } else {
            document.getElementById("oif_createDate").innerHTML = "";
            document.getElementById("oif_sendDate").innerHTML = "";
            document.getElementById("oif_endDate").innerHTML = "";
            document.getElementById("oif_sendName").innerHTML = "";
            document.getElementById("oif_sendPhone").innerHTML = "";
            document.getElementById("oif_sendAddress").innerHTML = "";
            document.getElementById("oif_getName").innerHTML = "";
            document.getElementById("oif_getPhone").innerHTML = "";
            document.getElementById("oif_getAddress").innerHTML = "";
            document.getElementById("oif_sendMan").innerHTML = "";

            document.getElementById("orderInfoPop").style.visibility = "collapse";
        }
        return false
    }

    function openWorkOrder(isOpen, id) {
        if(isOpen) {
            document.getElementById("deal-order-woid").value = id;
            document.getElementById("workOrderPop").style.visibility = "visible";
        } else {
            document.getElementById("deal-order-woid").value = "";
            document.getElementById("workOrderPop").style.visibility = "collapse";
        }
        return false;
    }

    function openWorkOrderBack(isOpen, info) {
        if(isOpen && info != null && info !== "") {
            document.getElementById("work-order-endWay").innerHTML = info;
            document.getElementById("workOrderBackPop").style.visibility = "visible";
        } else {
            document.getElementById("work-order-endWay").innerHTML = "";
            document.getElementById("workOrderBackPop").style.visibility = "collapse";
        }
    }

    function getOrderInfo(oid) {
        if(oid === "" || oid == null) {
            document.getElementById("search_box").style.display = "none"
        }
        // 获取 cookie 中的用户信息
        let id = null;
        let token = null;
        const ca = document.cookie.split(';');
        for(let i=0; i<ca.length; i++)
        {
            const c = ca[i].trim();
            if(c.split('=')[0] === "id")
                id = c.split('=')[1]
            if(c.split('=')[0] === "token")
                token = c.split('=')[1]
        }
        // 请求 API
        fetch('/GetOrder?uid=' + id + "&token=" + token + "&oid=" + oid)
            .then(response => response.json())
            .then(data => {
                if(data.stat === 200) {
                    // 请求正常
                    document.getElementById("search_id").innerHTML = oid
                    document.getElementById("search_deliveryMan").innerHTML = data.deliveryMan
                    document.getElementById("search_create").innerHTML = data.createDate
                    document.getElementById("search_send").innerHTML = data.sendDate
                    document.getElementById("search_delivery").innerHTML = data.deliveryDate
                    document.getElementById("search_sendAdd").innerHTML = data.sendAddress
                    document.getElementById("search_deliveryAdd").innerHTML = data.deliveryAddress
                    document.getElementById("search_type").innerHTML = data.orderType
                    document.getElementById("search_marks").innerHTML = data.orderMarks

                    document.getElementById("search_box").style.display = "unset"
                } else if(data.stat === 404) {
                    // 运单不存在
                    document.getElementById("search_box").style.display = "none"

                    document.getElementById("search_order").style.border = "1px #e60000 solid"
                    document.getElementById("search_order").style.color = "#f00"
                    document.getElementById("search_order").value = "运单不存在"
                }
            })
            .catch(console.error)
    }

    function openSendControl(isOpen, oid, ods) {
        if(isOpen) {
            console.log(oid);
            document.getElementById("deal-order-next").value = oid;
            document.getElementById("orderRunPop").style.visibility = "visible";
            document.getElementById("order-info-s").onclick = function()
            {
                console.log(oid)
                openOrderInfo(true, oid)
                return false
            };
        } else {
            document.getElementById("deal-order-next").value = "";
            document.getElementById("orderRunPop").style.visibility = "collapse";
            document.getElementById("order-info-s").onclick = function(){};
        }
    }
</script>

<script src="../../bootstrap/bootstrap.min.js"></script>
</body>
</html>