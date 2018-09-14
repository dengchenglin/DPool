//
//  DPMainService.m
//  DPool
//
//  Created by dengchenglin on 2018/9/10.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPMainService.h"

#import "DPMainController.h"

@implementation DPMainService

CL_EXPORT_MODULE(DPMainServiceProtocol)

+ (UIViewController *)rootViewController{
    return [DPMainController new];
}

@end
