package com.chuhelan.netex.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Version: 1.0
 * @Date: 2021/5/31 上午 08:39
 * @ClassName: Address
 * @Author: Stapxs
 * @Description TO DO
 **/

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Address {
    private Integer address_id;
    private String address_name;
    private String address_phone;
    private String address_content;

    public Address(String substring) {
        this.address_content = substring;
    }
}
