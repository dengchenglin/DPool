//
//  DPTemplateService.m
//  DPool
//
//  Created by dengchenglin on 2018/9/10.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPTemplateService.h"

#import "DPTemplateViewController.h"

@implementation DPTemplateService

CL_EXPORT_MODULE(DPTemplateServiceProtocol)

+ (UIViewController *)rootViewController{
    return [DPTemplateViewController new];
}

@end
