//
//  DPNetworkEngine+Login.h
//  DPool
//
//  Created by dengchenglin on 2018/9/10.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPNetworkEngine.h"

typedef NS_ENUM(NSInteger,SendEmailType) {
    SendEmailRegister = 0,  //注册
    SendEmailForget,        //找回密码
    SendEmailWalletAddress  //钱包地址
};//发送邮箱验证码类型

@interface DPNetworkEngine (Login)

/*
 * 登录
 */
- (void)loginWithEmail:(NSString *)email password:(NSString *)password  callback:(DPResponseBlock)callback;

/*
 * 注册
 */
- (void)registerWithEmail:(NSString *)email password:(NSString *)password rpwd:(NSString *)rpwd code:(NSString *)code callback:(DPResponseBlock)callback;

/*
 * 发送邮箱验证码
 */
- (void)sendEmailWithEmail:(NSString *)email type:(SendEmailType)type callback:(DPResponseBlock)callback;

/*
 * 找回密码
 */
- (void)resetWithEmail:(NSString *)email password:(NSString *)password rpwd:(NSString *)rpwd code:(NSString *)code callback:(DPResponseBlock)callback;

/*
 * 退出
 */
- (void)logoutWithCallback:(DPResponseBlock)callback;
@end
