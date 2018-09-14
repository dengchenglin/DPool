//
//  DPHomeService.m
//  DPool
//
//  Created by dengchenglin on 2018/9/10.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPHomeService.h"

#import "DPHomeViewController.h"

@implementation DPHomeService

CL_EXPORT_MODULE(DPHomeServiceProtocol)

+ (UIViewController *)rootViewController{
    return [DPHomeViewController new];
}

@end
