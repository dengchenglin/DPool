//
//  CLNetworkConst.h
//  YMKMain
//
//  Created by dengchenglin on 2018/6/28.
//  Copyright © 2018年 Property. All rights reserved.
//

#ifndef CLNetworkConst_h
#define CLNetworkConst_h

// 网络请求类型
typedef NS_ENUM(NSUInteger, CLRequestTaskType) {
    Upload = 0,
    Download
};

// 网络请求类型
typedef NS_ENUM(NSUInteger, CLRequestMethodType) {
    GET = 0,
    POST,
    HEAD,
    PUT,
    PATCH ,
    DELETE
};

// 请求的序列化格式
typedef NS_ENUM(NSUInteger, CLRequestSerializerType) {
    RequestHTTP = 0,
    RequestJSON,
    RequestPlist
};

// 请求返回的序列化格式
typedef NS_ENUM(NSUInteger, CLResponseSerializerType) {
    ResponseHTTP = 0,
    ResponseJSON,
    ResponsePlist,
    ResponseXML
};


// 请求进度回调
typedef void(^CLProgressBlock)(NSProgress * __nullable progress);
// 请求结果回调
typedef void(^CLCallbackBlock)(id __nonnull request, id __nullable responseObject, NSError * __nullable error);

#endif /* CLNetworkConst_h */
