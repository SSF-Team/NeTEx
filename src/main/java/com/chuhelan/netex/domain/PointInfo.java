package com.chuhelan.netex.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * @Version: 1.0
 * @Date: 2021/6/4 下午 10:34
 * @ClassName: PointInfo
 * @Author: Stapxs
 * @Description TO DO
 **/

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class PointInfo {
    private Integer points_id;
    private Integer points_userId;
    private Date points_time;
    private Integer points_change;
    private String points_content;
}
