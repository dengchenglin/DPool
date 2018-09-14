//
//  DPModuleServiceManager.h
//  GeihuiCould
//
//  Created by denDPhenglin on 2018/8/30.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DPModuleServiceProtocol.h"

@interface DPModuleServiceManager : NSObject

//远程服务映射表
+ (NSDictionary *)moduleMap;

+ (Class<CLModuleServiceProtocol>)serviceForStr:(NSString *)serviceStr;

+ (Class<DPMainServiceProtocol>)mainService;
+ (Class<DPHomeServiceProtocol>)homeService;
+ (Class<DPTemplateServiceProtocol>)templateService;
+ (Class<DPSetServiceProtocol>)setService;
+ (Class<DPLoginServiceProtocol>)loginService;
+ (Class<DPWebServiceProtocol>)webService;

+ (Class<DPConfigServiceProtocol>)configService;

@end
