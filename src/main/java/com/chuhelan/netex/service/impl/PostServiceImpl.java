package com.chuhelan.netex.service.impl;

import com.chuhelan.netex.dao.PostDao;
import com.chuhelan.netex.domain.Post;
import com.chuhelan.netex.service.PostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

/**
 * @Version: 1.0
 * @Date: 2021/6/2 上午 08:27
 * @ClassName: PostServiceImpl
 * @Author: Stapxs
 * @Description TO DO
 **/

@Service
@Transactional
public class PostServiceImpl implements PostService {
    @Autowired
    PostDao postDao;


    /**
     * @Author Stapxs
     * @Description 通过 ID 寻找运单信息
     * @Date 上午 08:29 2021/6/2
     * @Param [id]
     * @return com.chuhelan.netex.domain.Post
    *
     * @param id*/
    @Override
    public Post PostInfo(String id) {
        Optional<Post> userOptional =
                Optional.ofNullable(postDao.getPostInfo(id));
        if (userOptional.isPresent()) {
            Post post = userOptional.get();
            return post;
        }
        return null;
    }
}
