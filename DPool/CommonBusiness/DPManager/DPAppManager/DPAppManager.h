//
//  GCAppManager.h
//  GeihuiCould
//
//  Created by dengchenglin on 2018/8/30.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DPAppManager : NSObject

SINGLETON_FOR_CLASS_DEF(DPAppManager)

@property (nonatomic, copy) NSString *loginToken;

@property (nonatomic, copy) NSString *authOverTime;//授权token超时时间

@property (nonatomic, assign) BOOL logined; //app登录状态

@property (nonatomic, copy) NSString *clause_url;//服务条款

+ (BOOL)logined;

+ (void)logout;

+ (NSString *)authToken;//授权token

+ (void)saveAuthToken:(NSString *)token;

+ (BOOL)isAuthOverTime;//授权是否超时

@end
