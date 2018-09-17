//
//  DPAppManager.m
//  GeihuiCould
//
//  Created by dengchenglin on 2018/8/30.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPAppManager.h"

#import "DPUserManager.h"

#import "KeychainTool.h"

#define DP_AUTH_TOKEN  @"DP_AUTH_TOKEN"

#define DP_LOGIN_TOKEN @"DP_LOGIN_TOKEN"

#define DP_AUTH_OVER_TIME @"DP_AUTH_OVER_TIME"

@implementation DPAppManager

SINGLETON_FOR_CLASS_IMP(DPAppManager)

+ (BOOL)logined{
    return [DPUserManager sharedInstance].cuid?YES:NO;
}

+ (void)logout{
    [KeychainTool delete:DP_LOGIN_TOKEN];
    [DPAppManager sharedInstance].loginToken = nil;
    [DPAppManager sharedInstance].email = nil;
    [DPUserManager logoutUser] ;
 
}

+ (NSString *)authToken{
    return [KeychainTool load:DP_AUTH_TOKEN];
}

+ (void)saveAuthToken:(NSString *)token{
    [KeychainTool save:DP_AUTH_TOKEN data:token];
}

+ (BOOL)isAuthOverTime{
    if(![DPAppManager sharedInstance].authOverTime)return YES;
    NSTimeInterval nowTime = [[DateUtil getNowDateTimestamp] doubleValue];
    NSTimeInterval overTime = [[DPAppManager sharedInstance].authOverTime doubleValue];
    return nowTime >= overTime;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _loginToken = [[NSUserDefaults standardUserDefaults] objectForKey:DP_LOGIN_TOKEN];
        _authOverTime = [KeychainTool load:DP_AUTH_OVER_TIME];
    }
    return self;
}

- (void)setLoginToken:(NSString *)loginToken{
    _loginToken = loginToken;
    [[NSUserDefaults standardUserDefaults] setValue:_loginToken forKey:DP_LOGIN_TOKEN];
}

- (void)setAuthOverTime:(NSString *)authOverTime{
    _authOverTime = authOverTime;
    [KeychainTool save:DP_AUTH_OVER_TIME data:_authOverTime];
}



@end
