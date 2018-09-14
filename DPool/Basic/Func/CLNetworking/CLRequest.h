//
//  CLRequest.h
//  YMKMain
//
//  Created by dengchenglin on 2018/6/28.
//  Copyright © 2018年 Property. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CLNetworkConst.h"

@interface CLRequest : NSObject

@property (nonatomic, copy, readonly) NSString *baseUrl;

@property (nonatomic, copy, readonly) NSString *path;

@property (nonatomic, assign, readonly) NSTimeInterval timeoutInterval;

@property (nonatomic, assign, readonly) NSURLRequestCachePolicy cachePolicy;

@property (nonatomic, assign, readonly) BOOL useGlobalParams;

@property (nonatomic, copy, readonly) NSDictionary <NSString *,id>*params;

@property (nonatomic, copy, readonly) CLCallbackBlock callBack;

@property (nonatomic, copy, readonly) CLProgressBlock progressCallBack;

+ (instancetype)request;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (NSString *)identifier;


//该baseUrl会覆盖config中的baseURL
- (__kindof CLRequest *(^)(NSString *baseUrl))setBaseUrl;

- (__kindof CLRequest *(^)(NSString *path))setPath;

- (__kindof CLRequest *(^)(NSTimeInterval timeoutInterval))setTimeoutInterval;

- (__kindof CLRequest *(^)(NSTimeInterval cachePolicy))setCachePolicy;

- (__kindof CLRequest *(^)(BOOL useGlobalParams))setUseGlobalParams;

- (__kindof CLRequest *(^)(NSDictionary<NSString *, id> *params))setParams;

- (__kindof CLRequest *(^)(CLCallbackBlock callBack))setCallBack;

- (__kindof CLRequest *(^)(CLProgressBlock progressCallBack))setProgressCallBack;

- (void)start;

- (void)cancel;

- (void)resume;

- (void)pause;

@end
