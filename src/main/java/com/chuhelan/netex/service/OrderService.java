package com.chuhelan.netex.service;

import com.chuhelan.netex.domain.Order;
import com.chuhelan.netex.domain.OrderUser;

public interface OrderService {
    public Order PostInfo(String id);
    public void CreatePost(String id, OrderUser sender, OrderUser delivery, Integer deliveryManID, String Marks, String type);
}
