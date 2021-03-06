package com.chuhelan.netex.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Version: 1.0
 * @Date: 2021/6/3 下午 04:42
 * @ClassName: OrderUser
 * @Author: Stapxs
 * @Description TO DO
 **/

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class OrderUser {
    private String name;
    private String phone;
    private String address;
}