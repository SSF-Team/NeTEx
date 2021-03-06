~~~
停止更新：因为实训已经结束了，这玩意基本上将不会再次做任何更新改动。
~~~

# NeTEx
Java 企业级框架开发实训作业 - NeTEx （神系星际）物流社交管理系统

## 简介
这是个实训作业，一个后端基于 Spring + Spring MVC + Mybatis，前端使用 Bootstrap + JQueryUI 的简易物流管理系统。

代码并不是特别好，有不少考虑不当，不符合规范的地方。还有一些小 BUG 和毛病。

## 为什么是神系星际物流社交管理系统
#### 因为一开始我们在构思功能的时候：

[Chuhelan](https://github.com/chuhelan) ：我们有仓储服务、大件服务、冷链服务还有啥？

[AC_Farther](https://github.com/ACFather) ： （写思维导图）空间站

[Stapx Steve](https://github.com/Stapxs)：好，加上

#### 然后在制作功能的时候：

[AC_Farther](https://github.com/ACFather) ： 我们用啥管理用户

[Stapx Steve](https://github.com/Stapxs)：我们没有管理员（注：当初构思并没有管理员账户）

[AC_Farther](https://github.com/ACFather) ： 是上帝！

[Stapx Steve](https://github.com/Stapxs)：好，加上

## 功能
- [x] 登录注册
- - [x] 登录
- - [x] 注册
- - [X] 身份验证

- [x] 用户中心
- - [x] 普通用户
- - - [x] 个人信息显示 / 修改
- - - [x] 地址簿显示 / 添加 / 删除
- - - [x] 头像修改
- - - [x] 签到
- - - [x] 工单提交 / 查询
- - - [x] 运单显示 / 详细信息显示 / 签收
- - [ ] 快递员
- - - [x] 个人信息显示 / 修改
- - - [x] 签到
- - - [x] 工单提交 / 查询
- - - [ ] 待处理运单显示 / 详细信息显示 / 打印票面（未完成） / 更改运单状态
- - [x] 客服
- - - [x] 个人信息显示 / 修改
- - - [x] 签到
- - - [x] 待处理工单显示 / 处理（完成，驳回）

- - [ ] 管理员
- - - [ ] 用户显示 / 删除 / 重置密码 / 新建 / 修改权限
- - - [ ] 订单显示 / 删除 / 详细信息显示
- - - [ ] 工单显示 / 处理（完成，驳回）处理（完成，驳回） / 删除

- [x] 运单查询
- - [x] 运单信息（仅普通用户以上）
- - [x] 运单跟踪底图（普通用户以下显示低精度地图）
- - [ ] 运费查询

- [x] 在线寄件

## 使用
Java 项目使用的是 IntelliJ IDEA 2020.3.2 (Ultimate Edition)，请在运行前修改 ```src/main/resources/jdbc.properties``` 文件内的 JDBC 数据库连接相关参数。
数据库结构参见最新的 Releases.

## 作者
[Stapx Steve](https://github.com/Stapxs)

[Chuhelan](https://github.com/chuhelan)

## 协助
[AC_Farther](https://github.com/ACFather)

[YY805](https://github.com/YY805)
