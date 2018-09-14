//
//  DPModuleManager.h
//  GeihuiCould
//
//  Created by denDPhenglin on 2018/8/30.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DPModuleManager : NSObject

+ (UIViewController *_Nullable)mainViewController;

+ (void)showLoginFromViewController:(UIViewController * _Nonnull)viewController animated:(BOOL)animated success:(void(^ _Nullable)(void))success;

+ (void)showLoginFromViewController:(UIViewController * _Nonnull)viewController success:(void(^ _Nullable)(void))success;

+ (void)showLoginFromViewController:(UIViewController * _Nonnull)viewController callback:(void(^ _Nullable)(BOOL result))callback;

+ (void)showWebFromViewController:(UIViewController * _Nonnull)viewController url:(NSString * _Nonnull)url;


@end
