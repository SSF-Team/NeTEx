package com.chuhelan.netex.dao;

import com.chuhelan.netex.domain.Post;
import com.chuhelan.netex.domain.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

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
    public Post getPostInfo(String postID);

}
