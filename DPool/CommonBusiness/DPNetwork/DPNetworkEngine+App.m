//
//  DPNetworkEngine+App.m
//  DPool
//
//  Created by dengchenglin on 2018/9/11.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPNetworkEngine+App.h"

#define PATH_APPS_BOTTOM_BUTTON     DP_API_APPS_PATH(bottom-button)

#define PATH_APPS_UPGRADE           DP_API_APPS_PATH(upgrade)

#define PATH_APPS_USERINFO           DP_API_APPS_PATH(userinfo)

#define PATH_APPS_SWITCH_INFO           DP_API_APPS_PATH(switchinfo)

@implementation DPNetworkEngine (App)

- (void)tabbarInfoWithCallback:(DPResponseBlock)callback{
    [self postWithPath:PATH_APPS_BOTTOM_BUTTON params:nil showHud:NO callback:callback];
}

- (void)upgradeWithCallback:(DPResponseBlock)callback{
    [self postWithPath:PATH_APPS_UPGRADE params:nil showHud:NO callback:callback];
}

- (void)userInfoWithPuid:(NSString *)puid callback:(DPResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:puid forKey:@"puid"];
    [params setValue:@"www.dpool" forKey:@"channel"];
    [self postWithPath:PATH_APPS_USERINFO params:params callback:callback];
}

- (void)switchInfoWithCallback:(DPResponseBlock)callback{
       [self postWithPath:PATH_APPS_SWITCH_INFO params:nil callback:callback];
}

@end
