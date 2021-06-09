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

function showChangeInfo() {
    if(document.getElementById("user-info-box-a").style.display === "none") {
        document.getElementById("user-info-box-a").style.display = "unset";
        document.getElementById("user-info-box-ex").style.display = "none";
        document.getElementById("user-info-box-ex-b").style.display = "none";
    } else {
        document.getElementById("user-info-box-a").style.display = "none";
        document.getElementById("user-info-box-ex").style.display = "unset";
        document.getElementById("user-info-box-ex-b").style.display = "unset";
    }
}