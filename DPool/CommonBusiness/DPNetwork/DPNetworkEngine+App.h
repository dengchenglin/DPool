//
//  DPNetworkEngine+App.h
//  DPool
//
//  Created by dengchenglin on 2018/9/11.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPNetworkEngine.h"

@interface DPNetworkEngine (App)

- (void)tabbarInfoWithCallback:(DPResponseBlock)callback;

- (void)upgradeWithCallback:(DPResponseBlock)callback;

- (void)userInfoWithPuid:(NSString *)puid callback:(DPResponseBlock)callback;

@end
