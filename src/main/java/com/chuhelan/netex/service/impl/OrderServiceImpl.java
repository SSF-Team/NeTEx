package com.chuhelan.netex.service.impl;

import com.chuhelan.netex.dao.PostDao;
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
    PostDao postDao;

    /**
     * @Author Stapxs
     * @Description 通过 ID 寻找运单信息
     * @Date 上午 08:29 2021/6/2
     * @Param [id]
     * @return com.chuhelan.netex.domain.Post
    **/
    @Override
    public Order PostInfo(String id) {
        Optional<Order> userOptional =
                Optional.ofNullable(postDao.getPostInfo(id));
        if (userOptional.isPresent()) {
            Order order = userOptional.get();
            return order;
        }
        return null;
    }

    /**
     * @Author Stapxs
     * @Description 创建订单
     * @Date 下午 04:47 2021/6/3
     * @Param [id, sender, delivery, deliveryManID, Marks, type]
     * @return void
    **/
    @Override
    public void CreatePost(String id, OrderUser sender, OrderUser delivery, Integer deliveryManID, String marks, String type) {
        if(sender.getUserID() != null && delivery.getUserID() != null) {
            postDao.createPostW1W2(id, new Date(), sender, delivery, deliveryManID, marks, type);
        }
    }
}
