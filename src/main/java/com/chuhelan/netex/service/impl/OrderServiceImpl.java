package com.chuhelan.netex.service.impl;

import com.chuhelan.netex.dao.OrderDao;
import com.chuhelan.netex.domain.Order;
import com.chuhelan.netex.domain.OrderUser;
import com.chuhelan.netex.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
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
        Optional<Order> userOptional = Optional.ofNullable(orderDao.getOrderInfo(id));
        return userOptional.orElse(null);
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
