<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.chuhelan.netex.util.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>在线寄件</title>
</head>
<body>
<%
    out.println(htmls.header());
%>
<link rel="stylesheet" href="../../bootstrap/bootstrap.min.css">
<link rel="stylesheet" href="../../index.css">
<link rel="stylesheet" href="../../css/shipping.css">
<form class="out_form">
    <div class="out_div">
        <!--在线寄件-->
        <div class="shipping_online" style="padding-bottom: 10px;border-bottom: 1px solid #DCDCDC">
            <img src="../../img/shipping/online_shipping_hover.png" height="18" width="18"/>
            <a>在线寄件</a>
        </div>
        <div class="time_to_send">8:00 - 17:00下单，业务员当天收件，17点后下单次日收件。</div>
        <!--寄件人-->
        <div class="sendPerson_box">
            <div>
                <img src="../../img/shipping/send.png"/>
                <a>寄件人</a>
            </div>
        </div>
        <div class="delivery_info">
            <p class="f1 ship_p">
                <label class="inputName">姓名<i>*</i></label>
                <input class="inputs checkInput"
                       type="text" maxlength="10" placeholder="请输入姓名"
                       autocomplete="off" style="border: 1px solid rgba(0,0,0,0.15);">
            </p>
            <p class="f1 ship_p">
                <label class="inputName">电话<i>*</i></label>
                <input class="inputs checkInput"
                       type="text" maxlength="10" placeholder="收件人手机或固话"
                       autocomplete="off" style="border: 1px solid rgba(0,0,0,0.15);">
            </p>
            <p class="f1 ship_p">
                <label class="inputName">详细地址<i>*</i></label>
                <input class="inputs checkInput"
                       type="text" maxlength="30" placeholder="请输入您的详细地址（精确到门牌号）"
                       autocomplete="off" style="border: 1px solid rgba(0,0,0,0.15);">
            </p>
            <div class="f1 ship_p" style="margin-top: 20px">
                <input type="checkbox" autocomplete="off">
                <label>保存到常用地址簿</label>
            </div>
        </div>

        <!--收件人-->
        <div class="sendPerson_box">
            <div>
                <img src="../../img/shipping/Close.png"/>
                <a>收件人</a>
            </div>
        </div>
        <div class="delivery_info" style="margin-bottom: 0">
            <p class="f1 ship_p">
                <label class="inputName">姓名<i>*</i></label>
                <input class="inputs checkInput"
                       type="text" maxlength="10" placeholder="请输入姓名"
                       autocomplete="off" style="border: 1px solid rgba(0,0,0,0.15);">
            </p>
            <p class="f1 ship_p">
                <label class="inputName">电话<i>*</i></label>
                <input class="inputs checkInput"
                       type="text" maxlength="10" placeholder="收件人手机或固话"
                       autocomplete="off" style="border: 1px solid rgba(0,0,0,0.15);">
            </p>
            <p class="f1 ship_p">
                <label class="inputName">详细地址<i>*</i></label>
                <input class="inputs checkInput"
                       type="text" maxlength="30" placeholder="请输入您的详细地址（精确到门牌号）"
                       autocomplete="off" style="border: 1px solid rgba(0,0,0,0.15);">
            </p>
            <div class="f1 ship_p" style="margin-top: 20px">
                <input type="checkbox" autocomplete="off">
                <label>保存到常用地址簿</label>
            </div>
        </div>
        <!--物流信息和服务-->
        <div class="articleBox">
            <div class="articleInformation">
                <div class="articleTitle" style="margin-bottom: 20px">物品信息和服务</div>
                <div class="articleType">
                    <div class="f1 ship_p">
                        <label class="inputName">物品类型<i>*</i></label>
                        <input class="inputs closeType" type="text" value="文件票件"
                               readonly autocomplete="off">
                        <div class="closeTypeList" style="display: none;">
                            <span class="closeTypeListSpan">文件票件</span>
                            <span class="closeTypeListSpan">衣物</span>
                            <span class="closeTypeListSpan">食品</span>
                            <span class="closeTypeListSpan">工艺品</span>
                            <span class="closeTypeListSpan">书籍</span>
                            <span class="closeTypeListSpan">玩具乐器</span>
                            <span class="closeTypeListSpan">贵重品</span>
                            <span class="closeTypeListSpan">贵重品</span>
                        </div>
                    </div>
                    <p class="f1 ship_p" style="margin: 0 auto">
                        <em class="f1 inputName">预估重量</em>
                        <span class="weightBox">
                            <input class="weightRadio" type="radio" name="weight"
                                   id="one" value="1" checked autocomplete="off">
                        <label for="one" style="color: rgb(0,0,0);">1kg</label>
                        </span>
                        <span class="weightBox">
                            <input class="weightRadio" type="radio" name="weight" id="tow" value="2"
                                   autocomplete="off">
                            <label for="tow" style="color: rgb(0, 0, 0);">2kg</label>
                        </span>
                        <span class="weightBox">
                            <input class="weightRadio" type="radio" name="weight" id="three"
                                   value="3" autocomplete="off">
                            <label for="three" style="color: rgb(0, 0, 0);">3kg</label>
                        </span>
                        <span class="weightBox">
                            <input class="weightRadio" type="radio" name="weight" id="four"
                                   autocomplete="off"><label for="four" style="color: rgb(0, 0, 0);">其他</label>
                        </span>
                        <span class="weightBox">
                            <input class="inputs" type="text" style="width: 100px;height: 20px" placeholder="您预估的重量">
                            <label>kg</label>
                        </span>
                    </p>
                </div>
                <div class="serviceType">
                    <span class="inputName">备注</span>
                    <em class="cursorPointer serviceType_Remarks" activid="0">请多拿几个袋子</em>
                    <em class="cursorPointer serviceType_Remarks" activid="0">请拿个包装盒</em>
                    <em class="cursorPointer serviceType_Remarks" activid="0">快件很急，希望快点来揽件</em>
                </div>
                <div class="serviceType">
                    <label class="inputName"></label>
                    <textarea class="inputs remarks_text" type="text" placeholder="备注你想和快递小哥说的话（最多50个字符哦）"
                              maxlength="50"></textarea>
                </div>
            </div>

            <div class="submitBox">
<!--                <p class="estimateMoney" style="display: none;"><span class="money_num"></span><br>预估运费</p>-->
                <div class="save_addrBookBtn terms_div">
                    <input class="check termsCheck" id="termsCheck" type="checkbox"
                           autocomplete="off">
                    <span>
                        <label for="termsCheck">我已阅读并同意</label>
                    </span>
                    <a class="cursorPointer Prohibited">《违禁说明》</a>
                    <span>、</span>
                    <a class="cursorPointer Contract">《快件运单契约条款》</a>
                </div>
                <div class="cursorPointer submitBtn">提交订单</div>
                <p class="coverBtn"></p>
            </div>

        </div>
    </div>
</form>
<%
    out.println(htmls.footer());
%>
</body>
<script src="../../bootstrap/bootstrap.min.js"></script>
</html>