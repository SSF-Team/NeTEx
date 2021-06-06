package com.chuhelan.netex.service.impl;

import com.chuhelan.netex.dao.WorkOrderDao;
import com.chuhelan.netex.domain.WorkOrder;
import com.chuhelan.netex.service.WorkOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;

/**
 * @Version: 1.0
 * @Date: 2021/6/5 下午 05:01
 * @ClassName: WorkOrderServiceImpl
 * @Author: Stapxs
 * @Description TO DO
 **/

@Service
@Transactional
public class WorkOrderServiceImpl implements WorkOrderService {

    @Autowired
    WorkOrderDao workOrderDao;

    /**
     * @Author Stapxs
     * @Description 创建工单
     * @Date 下午 07:11 2021/6/5
     * @Param [uid, oid, content]
     * @return void
    **/
    @Override
    public void addWorkOrder(Integer uid, String oid, String content) {
        workOrderDao.addWorkOrder(uid, oid, new Date(), content);
    }

    /**
     * @Author Stapxs
     * @Description 根据用户 ID 获取所有工单
     * @Date 下午 07:11 2021/6/5
     * @Param [id]
     * @return com.chuhelan.netex.domain.WorkOrder[]
    **/
    @Override
    public WorkOrder[] getAddWOrder(Integer id) {
        return workOrderDao.getAllWOrderByUID(id);
    }

    /**
     * @Author Stapxs
     * @Description 获取所有没有处理的工单
     * @Date 上午 11:49 2021/6/6
     * @Param []
     * @return com.chuhelan.netex.domain.WorkOrder[]
    **/
    @Override
    public WorkOrder[] getAllNoCloseOrder() {
        return workOrderDao.getAllNoCloseOrder();
    }

    /**
     * @Author Stapxs
     * @Description 处理工单
     * @Date 下午 02:05 2021/6/6
     * @Param [die, backStr, serviceID]
     * @return void
    **/
    @Override
    public void detalWorkOrder(Integer workOrderID, Date die, String backStr, Integer serviceID, Integer way) {
        workOrderDao.detalWorkOrder(workOrderID, die, backStr, serviceID, way);
    }
}
