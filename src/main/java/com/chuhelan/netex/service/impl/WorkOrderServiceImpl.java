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
}
