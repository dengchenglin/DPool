//
//  DPUserManager.h
//  GeihuiCould
//
//  Created by dengchenglin on 2018/8/30.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DPUser.h"

@interface DPUserManager : NSObject

SINGLETON_FOR_CLASS_DEF(DPUserManager)

@property (nonatomic, strong) DPUser *user;

+ (void)registerUserWithInfo:(id)info;

+ (void)logoutUser;

@end
