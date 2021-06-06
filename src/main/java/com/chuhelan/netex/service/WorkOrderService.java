package com.chuhelan.netex.service;

import com.chuhelan.netex.domain.WorkOrder;

import java.util.Date;

/**
 * @Version: 1.0
 * @Date: 2021/6/5 下午 05:00
 * @ClassName: WorkOrderService
 * @Author: Stapxs
 * @Description TO DO
 **/
public interface WorkOrderService {
    public void addWorkOrder(Integer uid, String oid, String content);
    public WorkOrder[] getAddWOrder(Integer id);
    public WorkOrder[] getAllNoCloseOrder();
    public void detalWorkOrder(Integer workOrderID, Date die, String backStr, Integer serviceID, Integer way);
}
