package com.chuhelan.netex.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * @Version: 1.0
 * @Date: 2021/6/2 上午 08:22
 * @ClassName: Post
 * @Author: Stapxs
 * @Description TO DO
 **/

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Order {
    private String order_id;
    private Integer order_createID;
    private Integer order_deliveryManID;
    private Date order_date;
    private Date order_sendDate;
    private Date order_deliveryDate;
    private String order_sendName;
    private String order_sendPhone;
    private String order_sendAddress;
    private String order_deliveryName;
    private String order_deliveryPhone;
    private String order_deliveryAddress;
    private String order_type;
    private String order_content;
}
