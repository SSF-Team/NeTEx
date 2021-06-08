package com.chuhelan.netex.dao;

import com.chuhelan.netex.domain.Order;
import org.apache.ibatis.annotations.*;

import java.util.Date;

/**
 * @Version: 1.0
 * @Date: 2021/6/2 上午 08:26
 * @ClassName: PostDao
 * @Author: Stapxs
 * @Description TO DO
 **/

@Mapper
public interface OrderDao {

    // Select

    @Select("select * from netex_order where order_id=#{orderID}")
    public Order getOrderInfo(String orderID);
    @Select("select * from netex_order where order_deliveryManID=#{uid} and ( order_sendDate is null or order_deliveryDate is null)")
    public Order[] getOrderNotSend(Integer uid);

    @Select("select * from netex_order where order_createID=#{uid} and order_sendDate is null")
    public Order[] getOrderByTypeUID(Integer uid);
    @Select("select * from netex_order where order_deliveryPhone=#{dPhone} and order_sendDate is null")
    public Order[] getOrderByTypePhone(String dPhone);
    @Select("select * from netex_order where order_createID=#{uid} and order_deliveryDate is null and order_sendDate is not null")
    public Order[] getOrderByTypeUID1(Integer uid);
    @Select("select * from netex_order where order_deliveryPhone=#{dPhone} and order_deliveryDate is null and order_sendDate is not null")
    public Order[] getOrderByTypePhone1(String dPhone);
    @Select("select * from netex_order where order_createID=#{uid} and order_deliveryDate is not null and order_sendDate is not null")
    public Order[] getOrderByTypeUID2(Integer uid);
    @Select("select * from netex_order where order_deliveryPhone=#{dPhone} and order_deliveryDate is not null and order_sendDate is not null")
    public Order[] getOrderByTypePhone2(String dPhone);

    // Insert

    @Insert("insert into netex_order ( order_id, order_createID, order_deliveryManID, order_date, order_sendName, order_sedPhone, order_sendAddress, order_deliveryName, order_deliveryPhone, order_deliveryAddress, order_type, order_content ) values ( #{oid}, #{cid}, #{did}, #{cdate}, #{sname}, #{sphone}, #{saddress}, #{dname}, #{dphone}, #{daddress}, #{type}, #{marks} )")
    public void saveOrder(@Param("oid") String oid, @Param("cid") Integer cid, @Param("did") Integer did, @Param("cdate") Date cdate, @Param("sname") String sname, @Param("sphone") String sphone, @Param("saddress") String saddress, @Param("dname") String dname, @Param("dphone") String dphone, @Param("daddress") String daddress, @Param("type") String type, @Param("marks") String marks);

    // Update

    @Update("update netex_order set order_deliveryManID=#{cid} where order_id=#{oid}")
    public void assignCourier(@Param("oid") String oid, @Param("cid") Integer cid);
    @Update("update netex_order set order_pickDate=#{date} where order_id=#{oid}")
    public void checkOrder(@Param("oid") String oid, @Param("date") Date date);

    @Update("update netex_order set order_sendDate=#{date} where order_id=#{oid}")
    public void setOrderSendDate(@Param("oid") String oid, @Param("date") Date date);
    @Update("update netex_order set order_deliveryDate=#{date} where order_id=#{oid}")
    public void setOrderEndDate(@Param("oid") String oid, @Param("date") Date date);

    // Delete

    @Delete("delete from netex_order where order_id=#{id}")
    public void deleteOrder(String id);
}
