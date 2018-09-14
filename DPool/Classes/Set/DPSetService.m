//
//  DPSetService.m
//  DPool
//
//  Created by dengchenglin on 2018/9/10.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPSetService.h"

#import "DPSetViewController.h"

@implementation DPSetService

CL_EXPORT_MODULE(DPSetServiceProtocol)

+ (UIViewController *)rootViewController{
    return [DPSetViewController new];
}

@end
