//
//  DPUserManager.m
//  GeihuiCould
//
//  Created by dengchenglin on 2018/8/30.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPUserManager.h"

#import "DPAppManager.h"

#define DP_USER_INFO  @"DP_USER_INFO"

@implementation DPUserManager

SINGLETON_FOR_CLASS_IMP(DPUserManager)

+ (void)registerUserWithInfo:(NSDictionary *)info{
    if(!info[@"cuid"])return;
    [DPUserManager sharedInstance].cuid = info[@"cuid"];
    
    [[NSUserDefaults standardUserDefaults]setValue:[DPUserManager sharedInstance].cuid forKey:DP_USER_INFO];

    
}



+ (void)logoutUser{
    [DPUserManager sharedInstance].cuid = nil;
    [[NSUserDefaults standardUserDefaults]setValue:nil forKey:DP_USER_INFO];
}




- (instancetype)init
{
    self = [super init];
    if (self) {
        _cuid = [[NSUserDefaults standardUserDefaults] objectForKey:DP_USER_INFO];
   
    }
    return self;
}

@end
