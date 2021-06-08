package com.chuhelan.netex.util;

import java.lang.reflect.Array;

/**
 * @Version: 1.0
 * @Date: 2021/6/6 下午 08:42
 * @ClassName: Other
 * @Author: Stapxs
 * @Description TO DO
 **/
public class Other {
    public static  <T> T[] concatenate(T[] a, T[] b) {
        int aLen = a.length;
        int bLen = b.length;

        @SuppressWarnings("unchecked")
        T[] c = (T[]) Array.newInstance(a.getClass().getComponentType(), aLen + bLen);
        System.arraycopy(a, 0, c, 0, aLen);
        System.arraycopy(b, 0, c, aLen, bLen);

        return c;
    }
}
