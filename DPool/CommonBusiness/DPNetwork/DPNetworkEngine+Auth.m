//
//  DPNetworkEngine+Auth.m
//  DPool
//
//  Created by dengchenglin on 2018/9/11.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPNetworkEngine+Auth.h"


#define DP_APP_NAME                @"dragonpool_app"
#define DP_APP_PASSWORD            @"Dpool_secret"

@implementation DPNetworkEngine (Auth)

- (void)authWithCallback:(DPResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:DP_APP_NAME forKey:@"app_name"];
    [params setValue:DP_APP_PASSWORD forKey:@"app_password"];
    [self postWithPath:PATH_POOL_AUTH params:params showHud:NO callback:^(id data, DPNetError error, NSString *msg) {
        if(!error){
            NSString *token = data[@"token"];
            if(token.length){
                [DPAppManager saveAuthToken:token];
                [DPAppManager sharedInstance].authOverTime = data[@"over_time"];
            }
        }
        if(callback){
            callback(data,error,msg);
        }
    }];
}

@end
