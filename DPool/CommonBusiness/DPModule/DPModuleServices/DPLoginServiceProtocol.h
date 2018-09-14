//
//  DPLoginServiceProtocol.h
//  GeihuiCould
//
//  Created by denDPhenglin on 2018/8/30.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CLModuleServiceProtocol.h"

@protocol DPLoginServiceProtocol <NSObject,CLModuleServiceProtocol>

+ (void)showLoginFromViewController:(UIViewController *)viewController animated:(BOOL)animated success:(void(^ _Nullable)(void))success;

+ (void)showLoginFromViewController:(UIViewController * _Nonnull)viewController success:(void(^ _Nullable)(void))success;

+ (void)showLoginFromViewController:(UIViewController * _Nonnull)viewController callback:(void(^ _Nullable)(BOOL result))callback;


@end
