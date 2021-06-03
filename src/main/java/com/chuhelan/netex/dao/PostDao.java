package com.chuhelan.netex.dao;

import com.chuhelan.netex.domain.Order;
import com.chuhelan.netex.domain.OrderUser;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.Date;

/**
 * @Version: 1.0
 * @Date: 2021/6/2 上午 08:26
 * @ClassName: PostDao
 * @Author: Stapxs
 * @Description TO DO
 **/

@Mapper
public interface PostDao {

    // Select

    @Select("select * from netex_order where order_id=#{postID}")
    public Order getPostInfo(String postID);

    // Insert

    @Insert("insert into netex_order ( order_id, order_date, order_sendUserID, order_sendAddressId, order_deliveryUserID, order_deliveryAddressId, order_deliveryManID, order_content, order_type) values ( #{id}, #{date}, #{sender.getUserID()}, #{sender.getAddress()}, #{delivery.getUserID()}, #{delivery.getAddress()}, #{deliveryManID}, #{Marks}, #{type} )")
    public void createPostW1W2(@Param("id") String id, @Param("date") Date date, @Param("sender") OrderUser sender, @Param("delivery") OrderUser delivery, @Param("deliveryManID") Integer deliveryManID, @Param("Marks") String Marks, @Param("type") String type);
}
