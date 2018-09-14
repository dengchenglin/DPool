//
//  DPUserManager.m
//  GeihuiCould
//
//  Created by dengchenglin on 2018/8/30.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPUserManager.h"

#import "DPAppManager.h"

@implementation DPUserManager

SINGLETON_FOR_CLASS_IMP(DPUserManager)

+ (void)registerUserWithInfo:(NSDictionary *)info{
    if(!info)return;
    DPUser *user = [DPUser yy_modelWithDictionary:info];
    [DPUserManager sharedInstance].user = user;
    [info writeToFile:[self userPath] atomically:YES];
}

+ (void)logoutUser{
    [DPUserManager sharedInstance].user = nil;
    [[NSFileManager defaultManager] removeItemAtPath:[self userPath] error:nil];
}


+ (NSString *)userPath{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    return [path stringByAppendingPathComponent:@"dp_user.plist"];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSDictionary *info = [[NSDictionary alloc]initWithContentsOfFile:[self.class userPath]];
         [self.class registerUserWithInfo:info];
    }
    return self;
}

@end
