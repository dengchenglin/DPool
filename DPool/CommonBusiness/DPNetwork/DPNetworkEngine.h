//
//  DPNetworkengine.h
//  GeihuiCould
//
//  Created by dengchenglin on 2018/9/3.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DP_API_FORMAL_BASE_URL   @"https://api-functest.qubtc.com"

#define DP_API_PUBLIC_PATH(path) @"/api/public/v3/pool/"#path""

#define DP_API_APPS_PATH(path) @"/api/public/v3/apps/"#path""

#define DPRequest [DPNetworkEngine sharedInstance]

typedef NS_ENUM(NSInteger,DPNetError) {
    DPNetErrorNone = 0, //请求成功
    DPNetErrorNet ,     //网络错误
    DPNetErrorStatus,   //请求状态出错，一般是参数出错
    DPNetErrorData,     //数据解析失败
    DPNetErrorTimeOut   //请求超时
};


typedef void(^DPResponseBlock) (id data,DPNetError error,NSString *msg);

@interface DPNetworkEngine : NSObject

+ (instancetype)sharedInstance;

+ (NSString *)baseUrl;

- (void)postWithPath:(NSString *)path params:(NSDictionary *)params callback:(DPResponseBlock)callback;

- (void)postWithPath:(NSString *)path params:(NSDictionary *)params showHud:(BOOL)showHud callback:(DPResponseBlock)callback;

@end
