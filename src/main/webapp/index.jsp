<%@ page import="com.chuhelan.netex.util.htmls" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="cn">
<head>
    <meta charset="UTF-8">
    <title>NeTEx - 可能是全宇宙最快的星际物流</title>

    <!-- 响应式触发 -->
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- 样式表 -->
    <link rel="stylesheet" href="bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="index.css">
</head>
<body>
    <!-- 顶栏 -->
    <%
      out.println(htmls.header());
    %>

      <!-- 轮播图和查单搜索框-->
      <div id="mslide" class="carousel slide mainslide" data-ride="carousel">
        <ol class="carousel-indicators">
          <li data-target="#mslide" data-slide-to="0" class="active"></li>
          <li data-target="#mslide" data-slide-to="1"></li>
          <li data-target="#mslide" data-slide-to="2"></li>
        </ol>
        <div class="carousel-inner">
          <div class="carousel-item active">
            <img src="/img/indexBanner.jpg" class="d-block">
          </div>
          <div class="carousel-item">
            <img src="/img/indexBanner.jpg" class="d-block">
          </div>
          <div class="carousel-item">
            <img src="/img/indexBanner.jpg" class="d-block">
          </div>
        </div>
        <a class="carousel-control-prev" href="#mslide" role="button" data-slide="prev">
          <span class="carousel-control-prev-icon" aria-hidden="true"></span>
          <span class="sr-only">上一张</span>
        </a>
        <a class="carousel-control-next" href="#mslide" role="button" data-slide="next">
          <span class="carousel-control-next-icon" aria-hidden="true"></span>
          <span class="sr-only">下一张</span>
        </a>
        <!-- 搜索框 -->
        <div class="seachbar">
          <form action="/Order" method="get">
            <input class="form-control" name="id" type="search" placeholder="查询运单号，使用英文逗号分隔" aria-label="搜索">
          </form>
          <div>
            <div>
              <div>
                <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="clock" class="svg-inline--fa fa-clock fa-w-16" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path fill="currentColor" d="M256,8C119,8,8,119,8,256S119,504,256,504,504,393,504,256,393,8,256,8Zm92.49,313h0l-20,25a16,16,0,0,1-22.49,2.5h0l-67-49.72a40,40,0,0,1-15-31.23V112a16,16,0,0,1,16-16h32a16,16,0,0,1,16,16V256l58,42.5A16,16,0,0,1,348.49,321Z"></path></svg>
              </div>
              <span>运费查询</span>
            </div>
            <div>
              <div>
                <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="map-marked-alt" class="svg-inline--fa fa-map-marked-alt fa-w-18" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512"><path fill="currentColor" d="M288 0c-69.59 0-126 56.41-126 126 0 56.26 82.35 158.8 113.9 196.02 6.39 7.54 17.82 7.54 24.2 0C331.65 284.8 414 182.26 414 126 414 56.41 357.59 0 288 0zm0 168c-23.2 0-42-18.8-42-42s18.8-42 42-42 42 18.8 42 42-18.8 42-42 42zM20.12 215.95A32.006 32.006 0 0 0 0 245.66v250.32c0 11.32 11.43 19.06 21.94 14.86L160 448V214.92c-8.84-15.98-16.07-31.54-21.25-46.42L20.12 215.95zM288 359.67c-14.07 0-27.38-6.18-36.51-16.96-19.66-23.2-40.57-49.62-59.49-76.72v182l192 64V266c-18.92 27.09-39.82 53.52-59.49 76.72-9.13 10.77-22.44 16.95-36.51 16.95zm266.06-198.51L416 224v288l139.88-55.95A31.996 31.996 0 0 0 576 426.34V176.02c0-11.32-11.43-19.06-21.94-14.86z"></path></svg>
              </div>
              <span>配送范围</span>
            </div>
            <div>
              <div>
                <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="paper-plane" class="svg-inline--fa fa-paper-plane fa-w-16" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path fill="currentColor" d="M476 3.2L12.5 270.6c-18.1 10.4-15.8 35.6 2.2 43.2L121 358.4l287.3-253.2c5.5-4.9 13.3 2.6 8.6 8.3L176 407v80.5c0 23.6 28.5 32.9 42.5 15.8L282 426l124.6 52.2c14.2 6 30.4-2.9 33-18.2l72-432C515 7.8 493.3-6.8 476 3.2z"></path></svg>
              </div>
              <span>我要寄件</span>
            </div>
          </div>
        </div>
      </div>
      <!-- 核心服务 -->
      <div class="notice">
        <span id="title">核心服务</span><br>
        <span id="subtitle">宇宙领先的技术驱动的供应链解决方案及物流服务供应商</span>
        <div style="display: flex;justify-content: center;align-items: center;margin-top: 10px;margin-bottom: 20px;">
          <div class="srcards">
            <div class="card" id="card" style="width: 190px;">
              <img src="img/save-sev.png" class="card-img-top" alt="仓储服务">
              <div class="card-body">
                <h5 class="card-title">仓储服务</h5>
              </div>
            </div>
          </div>
          <div class="srcards">
            <div class="card" id="card" style="width: 190px;">
              <img src="img/big-sev.png" class="card-img-top" alt="大件服务">
              <div class="card-body">
                <h5 class="card-title">大件服务</h5>
              </div>
            </div>
          </div>
          <div class="srcards">
            <div class="card" id="card" style="width: 190px;">
              <img src="img/cold-sev.png" class="card-img-top" alt="冷链服务">
              <div class="card-body">
                <h5 class="card-title">冷链服务</h5>
              </div>
            </div>
          </div>
          <div class="srcards">
            <div class="card" id="card" style="width: 190px;">
              <img src="img/word-sev.png" class="card-img-top" alt="跨境服务">
              <div class="card-body">
                <h5 class="card-title">跨境服务</h5>
              </div>
            </div>
          </div>
          <div class="srcards">
            <div class="card" id="card" style="width: 190px;">
              <img src="img/space-sev.png" class="card-img-top" alt="星际服务">
              <div class="card-body">
                <h5 class="card-title">星际服务</h5>
              </div>
            </div>
          </div>
        </div>
        <div id="hrs"></div>
      </div>
      <!-- 重要内容 / 公告 -->
      <div class="notice">
        <span id="title">重要信息</span><br>
        <span id="subtitle">了解更多和我们相关的全新消息！</span>
        <div class="list-group" id="listmain">
          <a href="#" class="list-group-item list-group-item-action">新冠不停运！星际快运限时打折！</a>
          <a href="#" class="list-group-item list-group-item-action">短信骗局“ 下载我们的应用程序以跟踪您的包裹 ”</a>
          <a href="#" class="list-group-item list-group-item-action">关注“ NeTEx 邮件列表 ”快速获取最新内容</a>
          <a href="#" class="list-group-item list-group-item-action">分享您的快件到 Outel 社区，最高赢得 50 元快递减免！</a>
        </div>
      </div>

      <%
        out.println(htmls.footer());
      %>

    <script src="bootstrap/jquery-3.4.1.slim.min.js"></script>
    <script src="bootstrap/bootstrap.min.js"></script>
</body>

</html>