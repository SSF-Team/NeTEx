package com.chuhelan.netex.service.impl;

import com.chuhelan.netex.dao.OrderDao;
import com.chuhelan.netex.domain.Order;
import com.chuhelan.netex.domain.OrderUser;
import com.chuhelan.netex.domain.User;
import com.chuhelan.netex.service.OrderService;
import com.chuhelan.netex.util.Other;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

/**
 * @Version: 1.0
 * @Date: 2021/6/2 上午 08:27
 * @ClassName: PostServiceImpl
 * @Author: Stapxs
 * @Description TO DO
 **/

@Service
@Transactional
public class OrderServiceImpl implements OrderService {

    @Autowired
    OrderDao orderDao;

    /**
     * @Author Stapxs
     * @Description 通过 ID 寻找运单信息
     * @Date 上午 08:29 2021/6/2
     * @Param [id]
     * @return com.chuhelan.netex.domain.Post
    **/
    @Override
    public Order getOrder(String id) {
        return orderDao.getOrderInfo(id);
    }

    /**
     * @Author Stapxs
     * @Description 创建订单
     * @Date 下午 10:12 2021/6/3
     * @Param [id, createID, deliveryManID, sender, delivery, marks, type]
     * @return void
    **/
    @Override
    public void CreateOrder(String id, Integer createID, OrderUser sender, OrderUser delivery, String marks, String type) {
        orderDao.saveOrder(id, createID, null, new Date(),
                            sender.getName(), sender.getPhone(), sender.getAddress(),
                            delivery.getName(), delivery.getPhone(), delivery.getAddress(),
                            type, marks);
    }

    /**
     * @Author Stapxs
     * @Description 通过运单类型获取运单
     * @Date 下午 08:14 2021/6/6
     * @Param [uid, type]
     * @return com.chuhelan.netex.domain.Order[]
    **/
    @Override
    public Order[] getOrderByType(User user, String type) {
        Order[] all = null;
        switch (type) {
            case "wait": {
                Order[] order1 = orderDao.getOrderByTypeUID(user.getUser_id());
                Order[] order2 = orderDao.getOrderByTypePhone(user.getUser_phone());
                all = Other.concatenate(order1, order2);
                break;
            }
            case "run": {
                Order[] order1 = orderDao.getOrderByTypeUID1(user.getUser_id());
                Order[] order2 = orderDao.getOrderByTypePhone1(user.getUser_phone());
                all = Other.concatenate(order1, order2);
                break;
            }
            case "stay": {
                Order[] order1 = orderDao.getOrderByTypeUID2(user.getUser_id());
                Order[] order2 = orderDao.getOrderByTypePhone2(user.getUser_phone());
                all = Other.concatenate(order1, order2);
                break;
            }
            default:
                return null;
        }
        // 去重
        List<Order> now = new ArrayList<>();
        for(Order od:all) {
            boolean has = false;
            for(Order odf:now) {
                if (od.getOrder_id().equals(odf.getOrder_id())) {
                    has = true;
                    break;
                }
            }
            if(!has) {
                now.add(od);
            }
        }
        return now.toArray(new Order[now.size()]);
    }

    /**
     * @Author Stapxs
     * @Description 确认订单
     * @Date 上午 09:13 2021/6/7
     * @Param [uid, token, OrderID]
     * @return void
    **/
    @Override
    public void checkOrder(String OrderID) {
        orderDao.checkOrder(OrderID, new Date());
    }

    /**
     * @Author Stapxs
     * @Description 根据派件员 ID 获取未完成流程的运单
     * @Date 上午 10:36 2021/6/7
     * @Param [uid]
     * @return com.chuhelan.netex.domain.Order[]
    **/
    @Override
    public Order[] getOrderNotSend(Integer uid) {
        return orderDao.getOrderNotSend(uid);
    }

    /**
     * @Author Stapxs
     * @Description 结束订单当前状态
     * @Date 下午 10:21 2021/6/7
     * @Param [oid]
     * @return void
    **/
    @Override
    public void checkPassOrder(String oid) {
        System.out.println("操作 > 继续运单 > nextOrder > " + oid);
        Order order = orderDao.getOrderInfo(oid);
        if(order.getOrder_sendDate() == null) {
            System.out.println("操作 > 继续运单 > nextOrder > 设置为已发货");
            orderDao.setOrderSendDate(oid, new Date());
        } else {
            System.out.println("操作 > 继续运单 > nextOrder > 设置为已送达");
            orderDao.setOrderEndDate(oid, new Date());
        }
    }

    /*
     * @Author Stapxs
     * @Description 删除订单
     * @Date 上午 09:52 2021/6/4
     * @Param [id]
     * @return void
    **/
    @Override
    public void deleteOrder(String id) {
        orderDao.deleteOrder(id);
    }

    /*
     * @Author Stapxs
     * @Description 为订单分配快递员
     * @Date 上午 09:53 2021/6/4
     * @Param [oid, cid]
     * @return void
    **/
    @Override
    public void assignCourier(String oid, Integer cid) {
        orderDao.assignCourier(oid, cid);
    }
}
