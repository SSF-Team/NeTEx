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
    out.println(htmls.header(request.getCookies()));
%>
<link rel="stylesheet" href="../../bootstrap/bootstrap.min.css">
<link rel="stylesheet" href="../../index.css">
<link rel="stylesheet" href="../../css/shipping.css">
<form class="out_form" action="/Create" method="post" onsubmit="return checkForm()" id="create">
    <input name="userID" value="<%out.print(cookie.get(request, "id"));%>" style="display:none;"></input>
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
                <input class="inputs checkInput" name="sName"
                       type="text" maxlength="10" placeholder="请输入姓名"
                       autocomplete="off">
            </p>
            <p class="f1 ship_p">
                <label class="inputName">电话<i>*</i></label>
                <input class="inputs checkInput" name="sPhone"
                       type="text" maxlength="11" placeholder="寄件人手机或固话"
                       autocomplete="off">
            </p>
            <p class="f1 ship_p">
                <label class="inputName">详细地址<i>*</i></label>
                <input class="inputs checkInput" name="sAddress"
                       type="text" maxlength="30" placeholder="请输入您的详细地址（精确到门牌号）"
                       autocomplete="off">
            </p>
            <div class="f1 ship_p" style="margin-top: 20px">
                <input type="checkbox" autocomplete="off" name="sSave">
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
                <input class="inputs checkInput" name="dName"
                       type="text" maxlength="11" placeholder="请输入姓名"
                       autocomplete="off">
            </p>
            <p class="f1 ship_p">
                <label class="inputName">电话<i>*</i></label>
                <input class="inputs checkInput" name="dPhone"
                       type="text" maxlength="11" placeholder="收件人手机或固话"
                       autocomplete="off">
            </p>
            <p class="f1 ship_p">
                <label class="inputName">详细地址<i>*</i></label>
                <input class="inputs checkInput" name="dAddress"
                       type="text" maxlength="30" placeholder="请输入您的详细地址（精确到门牌号）"
                       autocomplete="off">
            </p>
            <div class="f1 ship_p" style="margin-top: 20px">
                <input type="checkbox" autocomplete="off" name="dSave">
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
                        <select class="inputs" name="orderType">
                            <option value="文件票件">文件票件</option>
                            <option value="衣物">衣物</option>
                            <option value="食品">食品</option>
                            <option value="工艺品">工艺品</option>
                            <option value="书籍">书籍</option>
                            <option value="玩具乐器">玩具乐器</option>
                            <option value="贵重品">贵重品</option>
                            <option value="其他">其他</option>
                        </select>
                    </div>
                    <p class="f1 ship_p" style="margin: 0 auto">
                        <label class="inputName">预估重量<i>*</i></label>
                        <span class="weightBox">
                            <input class="inputs" type="text" style="width: 100px;height: 20px" name="weight" placeholder="预估重量">
                            <label>kg</label>
                        </span>
                    </p>
                </div>
                <div class="serviceType">
                    <span class="inputName">备注</span>
                    <em class="cursorPointer serviceType_Remarks" onclick="addRemarks('请多拿几个袋子')">请多拿几个袋子</em>
                    <em class="cursorPointer serviceType_Remarks" onclick="addRemarks('请拿个包装盒')">请拿个包装盒</em>
                    <em class="cursorPointer serviceType_Remarks" onclick="addRemarks('快件很急，希望快点来揽件')">快件很急，希望快点来揽件</em>
                </div>
                <div class="serviceType">
                    <label class="inputName"></label>
                    <textarea id="Remarks" class="inputs remarks_text" type="text" name="orderMarks"
                              placeholder="备注你想和快递小哥说的话（最多50个字符哦）"
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
                <button class="cursorPointer submitBtn" type="submit" onclick="return checkForm()">提交订单</button>
                <p class="coverBtn"></p>
            </div>

        </div>
    </div>
</form>
<%
    out.println(htmls.footer());
%>
</body>
<script>
    <%
    if(request.getAttribute("err") != null) {
        out.print("alert(\"" + request.getAttribute("err") + "\")");
    }
    %>
    function addRemarks(thing) {
        const ths = document.getElementById("Remarks").value;
        if(ths.length < 50) {
            if (ths != null && ths !== "" && ths !== undefined) {
                document.getElementById("Remarks").value = ths + "，" + thing;
            } else {
                document.getElementById("Remarks").value = thing;
            }
        }
    }

    function checkForm() {
        // 检查表单
        if(!document.getElementById("termsCheck").checked){
            alert("请同意《违禁说明》及《快件运单契约条款》")
            return false;
        }
    }
</script>
<script src="../../bootstrap/bootstrap.min.js"></script>
</html>