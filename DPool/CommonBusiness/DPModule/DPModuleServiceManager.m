//
//  DPModuleServiceManager.m
//  GeihuiCould
//
//  Created by denDPhenglin on 2018/8/30.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPModuleServiceManager.h"

#import "CLModuleManager.h"

@implementation DPModuleServiceManager

+ (NSDictionary *)moduleMap{
    return @{@"dp_main":[self mainService],
             @"dp_home":[self homeService],
             @"dp_template":[self templateService],
             @"dp_set":[self setService],
             @"dp_login":[self loginService],
             @"dp_web":[self webService]
             };
}

+ (Class<CLModuleServiceProtocol>)serviceForStr:(NSString *)serviceStr{
    return [self moduleMap][serviceStr];
}

+ (Class<DPMainServiceProtocol>)mainService{
    return [CLModuleManager moduleServiceForProtocol:@protocol(DPMainServiceProtocol)];
}
+ (Class<DPHomeServiceProtocol>)homeService{
    return [CLModuleManager moduleServiceForProtocol:@protocol(DPHomeServiceProtocol)];
}
+ (Class<DPTemplateServiceProtocol>)templateService{
    return [CLModuleManager moduleServiceForProtocol:@protocol(DPTemplateServiceProtocol)];
}
+ (Class<DPSetServiceProtocol>)setService{
    return [CLModuleManager moduleServiceForProtocol:@protocol(DPSetServiceProtocol)];
}

+ (Class<DPLoginServiceProtocol>)loginService{
    return [CLModuleManager moduleServiceForProtocol:@protocol(DPLoginServiceProtocol)];
}

+ (Class<DPWebServiceProtocol>)webService{
    return [CLModuleManager moduleServiceForProtocol:@protocol(DPWebServiceProtocol)];
}

+ (Class<DPConfigServiceProtocol>)configService{
    return [CLModuleManager moduleServiceForProtocol:@protocol(DPConfigServiceProtocol)];
}

@end
