package com.chuhelan.netex.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * @Version: 1.0
 * @Date: 2021/6/5 下午 04:19
 * @ClassName: WorkOrder
 * @Author: Stapxs
 * @Description TO DO
 **/

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class WorkOrder {
    private Integer workOrder_id;
    private Integer workOrder_userID;
    private String workOrder_orderId;
    private Date workOrder_date;
    private Date workOrder_dieDate;
    private String workOrder_content;
    private String workOrder_endContent;
    private Integer workOrder_serviceID;
    private Integer workOrder_endWay;
}
