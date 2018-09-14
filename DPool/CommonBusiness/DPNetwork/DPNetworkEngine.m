//
//  DPNetworkengine.m
//  GeihuiCould
//
//  Created by dengchenglin on 2018/9/3.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPNetworkEngine.h"

#import "CLNetworking.h"

#import <CommonCrypto/CommonHMAC.h>

#import <objc/runtime.h>

#import "DPNetworkEngine+Auth.h"

static int request_vc_key;

@implementation DPNetworkEngine

+ (instancetype)sharedInstance{
    static DPNetworkEngine *networkEngine = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        networkEngine = [[DPNetworkEngine alloc]init];
    });
    return networkEngine;
}

+ (NSString *)baseUrl{
    return [CLNetworkManager shareInstance].config.request.baseUrl;
}

+ (void)initialize{
    [CLNetworkManager setupConfig:^(CLNetworkConfig *config) {
        
        config.request.baseUrl = DP_API_FORMAL_BASE_URL;
        
        config.responseSerializerType = ResponseJSON;
        config.request.requestTimeoutInterval = 15;
    }];
}



- (void)postWithPath:(NSString *)path params:(NSDictionary *)params callback:(DPResponseBlock)callback{
    [self postWithPath:path params:params showHud:YES callback:callback];
}


- (void)postWithPath:(NSString *)path params:(NSDictionary *)params showHud:(BOOL)showHud callback:(DPResponseBlock)callback{
    //检查授权token是否有值和是否过期
    if([DPAppManager isAuthOverTime] && [DPAppManager authToken] && ![path isEqualToString:PATH_POOL_AUTH]){
        [self authWithCallback:^(id data, DPNetError error, NSString *msg) {
            if(!error){
                [self postWithPath:path params:params showHud:showHud callback:callback];
            }
        }];
        return;
    }
    
    
    NSDictionary *refactorParams = [self refactorParams:params];
    DBLog(@"url is --%@\n\n params is --%@\n\n" ,[NSString stringWithFormat:@"%@/%@",[CLNetworkManager shareInstance].config.request.baseUrl,path],refactorParams);
    CLURLRequest *request = [CLURLRequest request].setMethod(POST).setPath(path).setParams(refactorParams).setCallBack(^(CLURLRequest * __nonnull request, id __nullable responseObject, NSError * __nullable error){
        UIViewController *currentVC = objc_getAssociatedObject(request, &request_vc_key);
        [MBProgressHUD hideHUDForView:currentVC.view animated:YES];
        DBLog(@"responseObject is --%@\n\n",responseObject);
        if(error){
            DBLog(@"error is --%@\n\n",error);
            if(callback){
                [MBProgressHUD showMBProgressHudWithTitle:@"网络错误,请稍后再试" hideAfterDelay:1.0];
                callback(nil,DPNetErrorNet,nil);
            }
        }
        else{
            if(responseObject){
                NSNumber *status = responseObject[@"status"];
                if(status.integerValue == 1){
                    if(callback){
                        callback(responseObject[@"data"],DPNetErrorNone,responseObject[@"msg"]);
                    }
                }
                else{
                    NSString *info = responseObject[@"msg"];
                    [MBProgressHUD showMBProgressHudWithTitle:info hideAfterDelay:1.5];
                    if(callback){
                        callback(responseObject,DPNetErrorStatus,responseObject[@"msg"]);
                    }
                }
            }
            else{
                if(callback){
                    callback(responseObject,DPNetErrorData,responseObject[@"msg"]);
                }
            }
        }
    });
    [request start];
    UIViewController *currentVC = [UIUtil getCurrentViewController];
    if(showHud){
        [MBProgressHUD showMBProgressHudOnView:currentVC.view];
    }
    objc_setAssociatedObject(request, &request_vc_key, currentVC, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}






- (NSDictionary *)refactorParams:(NSDictionary *)params{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:params];
    [dic setValuesForKeysWithDictionary:[self getPublicParam]];
    return dic.copy;
}
//公共字符串
- (NSDictionary *)getPublicParam
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:[[NSUserDefaults standardUserDefaults] objectForKey:DP_APNS_TOKEN] forKey:@"aps_token"];
    [dic setValue:@"ios" forKey:@"device_type"];
    [dic setValue:[[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] forKey:@"app_version"];
    [dic setValue:[[UIDevice currentDevice].identifierForVendor UUIDString] forKey:@"device_id"];
    [dic setValue:[UIDevice currentDevice].systemVersion forKey:@"device_id"];
    [dic setValue:[DateUtil getNowDateTimestamp] forKey:@"app_time"];
    [dic setValue:[DPAppManager authToken] forKey:@"token"];
    return dic.copy;
}

@end
