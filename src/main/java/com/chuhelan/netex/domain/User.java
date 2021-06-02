package com.chuhelan.netex.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @description:
 * @author: chuhelan
 * @create: 2021-05-25 08:31
 **/

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class User {
    private Integer user_id;
    private String user_name;
    private String user_gender;
    private String user_profile;
    private String user_email;
    private String user_password;
    private String user_phone;
    private Integer user_point;
    private String user_token;
    private String user_dtime;

    public User(int i, String passToken) {
        this.user_id = i;
        this.user_name = passToken;
    }
}