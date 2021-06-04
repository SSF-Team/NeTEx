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

    // Insert

    @Insert("insert into netex_order ( order_id, order_createID, order_deliveryManID, order_date, order_sendName, order_sedPhone, order_sendAddress, order_deliveryName, order_deliveryPhone, order_deliveryAddress, order_type, order_content ) values ( #{oid}, #{cid}, #{did}, #{cdate}, #{sname}, #{sphone}, #{saddress}, #{dname}, #{dphone}, #{daddress}, #{type}, #{marks} )")
    public void saveOrder(@Param("oid") String oid, @Param("cid") Integer cid, @Param("did") Integer did, @Param("cdate") Date cdate, @Param("sname") String sname, @Param("sphone") String sphone, @Param("saddress") String saddress, @Param("dname") String dname, @Param("dphone") String dphone, @Param("daddress") String daddress, @Param("type") String type, @Param("marks") String marks);

    // Update

    @Update("update netex_order set order_deliveryManID=#{cid} where order_id=#{oid}")
    public void assignCourier(@Param("oid") String oid, @Param("cid") Integer cid);

    // Delete

    @Delete("delete from netex_order where order_id=#{id}")
    public void deleteOrder(String id);
}
