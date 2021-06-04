package com.chuhelan.netex.service;

import com.chuhelan.netex.domain.Order;
import com.chuhelan.netex.domain.OrderUser;

public interface OrderService {
    public Order getOrder(String id);
    public void deleteOrder(String id);
    public void assignCourier(String oid, Integer cid);
    public void CreateOrder(String id, Integer createID, OrderUser sender, OrderUser delivery, String marks, String type);
}
