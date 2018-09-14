//
//  DPNetworkEngine+Auth.h
//  DPool
//
//  Created by dengchenglin on 2018/9/11.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPNetworkEngine.h"

#define PATH_POOL_AUTH             @"/api/public/v3/auth"

@interface DPNetworkEngine (Auth)

/*
 * 授权
 */
- (void)authWithCallback:(DPResponseBlock)callback;

@end
