package com.chuhelan.netex.dao;

import com.chuhelan.netex.domain.WorkOrder;
import org.apache.ibatis.annotations.*;

import java.util.Date;

/**
 * @Version: 1.0
 * @Date: 2021/6/5 下午 04:14
 * @ClassName: WorkOrderDao
 * @Author: Stapxs
 * @Description TO DO
 **/

@Mapper
public interface WorkOrderDao {

    // Select

    @Select("select * from netex_workorder where workOrder_userID=#{id}")
    public WorkOrder[] getAllWOrderByUID(Integer id);
    @Select("select * from netex_workorder where workOrder_endWay=0")
    public WorkOrder[] getAllNoCloseOrder();

    // Update

    @Update("update netex_workorder set workOrder_dieDate=#{endDate}, workOrder_endContent=#{backStr}, workOrder_serviceID=#{serviceID}, workOrder_endWay=#{way} where workOrder_id=#{workOrderID}")
    public void detalWorkOrder(@Param("workOrderID") Integer workOrderID, @Param("endDate") Date endDate, @Param("backStr") String backStr, @Param("serviceID") Integer serviceID, @Param("way") Integer way);

    // Insert

    @Insert("insert into netex_workorder ( workOrder_userID, workOrder_orderId, workOrder_date, workOrder_content ) values ( #{uid}, #{oid}, #{date}, #{content} )")
    public void addWorkOrder(@Param("uid") Integer uid, @Param("oid") String oid, @Param("date") Date date, @Param("content") String content);
}
