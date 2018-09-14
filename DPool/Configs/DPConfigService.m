//
//  ConfigService.m
//  DPool
//
//  Created by dengchenglin on 2018/9/10.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPConfigService.h"

#import "KeyboardManager.h"

#import "DPNetworkEngine+Auth.h"

#import "DPNetworkEngine+App.h"

#import "DPWebManager.h"

@implementation DPConfigService

CL_EXPORT_MODULE(DPConfigServiceProtocol)

+ (void)config{
    [KeyboardManager config];
    //授权token 接口会自动缓存
    [DPRequest authWithCallback:nil];
    //检测是否更新
    [self checkUpdate];
    //webView配置UA
    [DPWebManager initWebUA];
 
}

//检测更新
+ (void)checkUpdate{
    [DPRequest upgradeWithCallback:^(id data, DPNetError error, NSString *msg) {
        NSNumber *number = data[@"isupdate"];
        if(number.boolValue == 1){
            [DPAlertView showNoticeViewWithTitle:data[@"title"] didClick:^(NSUInteger index) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:data[@"url"]]];
             
            }];
        }
    }];
}

@end
