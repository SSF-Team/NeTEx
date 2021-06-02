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
public class Post {
    private String order_id;
    private Date order_date;
    private Date order_sendDate;
    private Integer order_sendUserID;
    private Integer order_sendAddressId;
    private Date order_deliveryDate;
    private Integer order_deliveryUserID;
    private Integer order_deliveryAddressId;
    private Integer order_deliveryManID;
    private String order_content;
}
