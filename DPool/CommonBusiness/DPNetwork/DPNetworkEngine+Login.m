//
//  DPNetworkEngine+Login.m
//  DPool
//
//  Created by dengchenglin on 2018/9/10.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPNetworkEngine+Login.h"

#define PATH_POOL_LOGIN            DP_API_PUBLIC_PATH(login)

#define PATH_POOL_REGISTER         DP_API_APPS_PATH(register)

#define PATH_POOL_SEND_EMAIL       DP_API_PUBLIC_PATH(sendEmail)

#define PATH_POOL_SEND_RESET       DP_API_PUBLIC_PATH(reset)

#define PATH_POOL_SEND_LOGOUT      DP_API_PUBLIC_PATH(logout)



typedef struct _SendEmailTypeTypeDictionary{
    __unsafe_unretained NSString   *sendEmailTypeTypeStr;
    SendEmailType  sendEmailTypeType;
}SendEmailTypeDictionary;

static const SendEmailTypeDictionary  SendEmailTypes[] = {
    {@"register",        SendEmailRegister},
    {@"forget",          SendEmailForget},
    {@"wallet_address",    SendEmailWalletAddress},
};

NSString *GetSendEmailStrForType(SendEmailType type){
    NSString *sendEmailTypeStr = nil;
    for(int i = 0;i < sizeof(SendEmailTypes)/sizeof(SendEmailTypeDictionary);i++){
        if(type == SendEmailTypes[i].sendEmailTypeType){
            sendEmailTypeStr = SendEmailTypes[i].sendEmailTypeTypeStr;
        }
    }
    return sendEmailTypeStr;
}

@implementation DPNetworkEngine (Login)

- (void)loginWithEmail:(NSString *)email password:(NSString *)password  callback:(DPResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:email forKey:@"email"];
    [params setValue:password forKey:@"password"];
    [self postWithPath:PATH_POOL_LOGIN params:params callback:^(id data, DPNetError error, NSString *msg) {
        if(!error){
            [DPAppManager sharedInstance].loginToken = data[@"login_token"];
            [DPUserManager registerUserWithInfo:data[@"first_sub"]];
        }
        if(callback){
            callback(data,error,msg);
        }
    }];
}

- (void)registerWithEmail:(NSString *)email password:(NSString *)password rpwd:(NSString *)rpwd code:(NSString *)code callback:(DPResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:email forKey:@"email"];
    [params setValue:password forKey:@"password"];
    [params setValue:rpwd forKey:@"rpwd"];
    [params setValue:code forKey:@"code"];
    [self postWithPath:PATH_POOL_REGISTER params:params callback:callback];
}

- (void)sendEmailWithEmail:(NSString *)email type:(SendEmailType)type callback:(DPResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:email forKey:@"email"];
    [params setValue:GetSendEmailStrForType(type) forKey:@"type"];
    [self postWithPath:PATH_POOL_SEND_EMAIL params:params callback:callback];
}

- (void)resetWithEmail:(NSString *)email password:(NSString *)password rpwd:(NSString *)rpwd code:(NSString *)code callback:(DPResponseBlock)callback{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:email forKey:@"email"];
    [params setValue:password forKey:@"password"];
    [params setValue:rpwd forKey:@"rpwd"];
    [params setValue:code forKey:@"code"];
    [self postWithPath:PATH_POOL_SEND_RESET params:params callback:callback];
}

- (void)logoutWithCallback:(DPResponseBlock)callback{
    [self postWithPath:PATH_POOL_SEND_LOGOUT params:nil callback:callback];
}

@end
