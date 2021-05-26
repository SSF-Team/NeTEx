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
    <nav class="navbar navbar-expand-lg navbar-dark topbar">
        <div>
            <img src="img/logo.svg" style="width: 70px;">
            <span class="bartrademark">®</span>
        </div>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNavDropdown">
          <ul class="navbar-nav">
            <li class="nav-item active">
              <a class="nav-link active" href="#">首页</a>
            </li>
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle active" href="#" id="DpdSevice" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
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
              <button class="btn barbtn" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                  <svg aria-hidden="true" focusable="false" data-prefix="far" data-icon="user-circle" class="svg-inline--fa fa-user-circle fa-w-16" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 496 512"><path fill="currentColor" d="M248 104c-53 0-96 43-96 96s43 96 96 96 96-43 96-96-43-96-96-96zm0 144c-26.5 0-48-21.5-48-48s21.5-48 48-48 48 21.5 48 48-21.5 48-48 48zm0-240C111 8 0 119 0 256s111 248 248 248 248-111 248-248S385 8 248 8zm0 448c-49.7 0-95.1-18.3-130.1-48.4 14.9-23 40.4-38.6 69.6-39.5 20.8 6.4 40.6 9.6 60.5 9.6s39.7-3.1 60.5-9.6c29.2 1 54.7 16.5 69.6 39.5-35 30.1-80.4 48.4-130.1 48.4zm162.7-84.1c-24.4-31.4-62.1-51.9-105.1-51.9-10.2 0-26 9.6-57.6 9.6-31.5 0-47.4-9.6-57.6-9.6-42.9 0-80.6 20.5-105.1 51.9C61.9 339.2 48 299.2 48 256c0-110.3 89.7-200 200-200s200 89.7 200 200c0 43.2-13.9 83.2-37.3 115.9z"></path></svg>
              </button>
              <div class="dropdown-menu dropdownbg" aria-labelledby="dropdownMenuButton">
                <form action="/Login" method="post">
                  <input class="form-control" type="text" name="email" placeholder=" 账号" aria-label="账号" style="width: 200px;margin: 0 5px;">
                  <input class="form-control" type="password" name="password" placeholder=" 密码" aria-label="密码" style="width: 200px;margin: 0 5px;margin-top: 5px;">
                  <input class="form-control" type="text" name="back" content="user" style="display: none;">
                  <button type="submit" class="btn btn-light">登录</button>
                </form>
                <a style="line-height: 10px;">忘记密码？</a>
              </div>
            </div>
            <div class="dropdown">
              <button class="btn barbtn" type="button" id="dropdownMenuButton1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                  <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="search" class="svg-inline--fa fa-search fa-w-16" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path fill="currentColor" d="M505 442.7L405.3 343c-4.5-4.5-10.6-7-17-7H372c27.6-35.3 44-79.7 44-128C416 93.1 322.9 0 208 0S0 93.1 0 208s93.1 208 208 208c48.3 0 92.7-16.4 128-44v16.3c0 6.4 2.5 12.5 7 17l99.7 99.7c9.4 9.4 24.6 9.4 33.9 0l28.3-28.3c9.4-9.4 9.4-24.6.1-34zM208 336c-70.7 0-128-57.2-128-128 0-70.7 57.2-128 128-128 70.7 0 128 57.2 128 128 0 70.7-57.2 128-128 128z"></path></svg>
              </button>
              <div class="dropdown-menu dropdownbg" aria-labelledby="dropdownMenuButton1" style="margin-top: -65px;margin-left: 50px;">
                <input class="form-control" type="search" placeholder="搜索……" aria-label="搜索" style="width: 300px;">
              </div>
            </div>
        </div>
      </nav>
      <!-- 轮播图和查单搜索框-->
      <div id="mslide" class="carousel slide mainslide" data-ride="carousel">
        <ol class="carousel-indicators">
          <li data-target="#mslide" data-slide-to="0" class="active"></li>
          <li data-target="#mslide" data-slide-to="1"></li>
          <li data-target="#mslide" data-slide-to="2"></li>
        </ol>
        <div class="carousel-inner">
          <div class="carousel-item active">
            <img src="test.jpg" class="d-block">
          </div>
          <div class="carousel-item">
            <img src="test.jpg" class="d-block">
          </div>
          <div class="carousel-item">
            <img src="test.jpg" class="d-block">
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
          <input class="form-control" type="search" placeholder="查询运单号，使用英文逗号分隔" aria-label="搜索">
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
                <svg class="octicon octicon-mark-github v-align-middle" height="32" viewBox="0 0 16 16" version="1.1" width="32" aria-hidden="true"><path fill-rule="evenodd" d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27.68 0 1.36.09 2 .27 1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.013 8.013 0 0016 8c0-4.42-3.58-8-8-8z"></path></svg>
              </a>
            </div>
          </div>
        </div>
        <div class="buton">
          <span>@NeTEx 2021</span>
          <span style="float: right;"><a rel="nofollow" href="http://www.beian.miit.gov.cn" target="_blank">苏ICP备 20015498号</a> - netex.chuhelan.com</span>
        </div>
      </footer>

    <script src="bootstrap/jquery-3.4.1.slim.min.js"></script>
    <script src="bootstrap/bootstrap.min.js"></script>
</body>

</html>