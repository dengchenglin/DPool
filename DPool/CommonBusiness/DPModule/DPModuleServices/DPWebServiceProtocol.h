//
//  DPWebServiceProtocol.h
//  DPool
//
//  Created by dengchenglin on 2018/9/13.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CLModuleServiceProtocol.h"

@protocol DPWebServiceProtocol <NSObject,CLModuleServiceProtocol>

+ (UIViewController *_Nullable)webViewControllerWithUrl:(NSString *_Nullable)url title:(NSString *_Nullable)title;

+ (void)showWebFromViewController:(UIViewController * _Nonnull)viewController url:(NSString * _Nonnull)url;


@end
