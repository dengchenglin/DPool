//
//  DPLoginService.m
//  DPool
//
//  Created by dengchenglin on 2018/9/10.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPLoginService.h"

#import "DPLoginViewController.h"

@implementation DPLoginService

CL_EXPORT_MODULE(DPLoginServiceProtocol)

+ (UIViewController *)rootViewController{
    return [DPLoginViewController new];
}

+ (void)showLoginFromViewController:(UIViewController *)viewController animated:(BOOL)animated success:(void(^ _Nullable)(void))success{
    DPLoginViewController *login = [DPLoginViewController new];
    [login setCallback:^(BOOL result) {
        if(result && success)success();
    }];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:login];
    [viewController presentViewController:nav animated:animated completion:nil];
}

+ (void)showLoginFromViewController:(UIViewController *)viewController success:(void(^ _Nullable)(void))success{
    DPLoginViewController *login = [DPLoginViewController new];
    [login setCallback:^(BOOL result) {
        if(result && success)success();
    }];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:login];
    [viewController presentViewController:nav animated:YES completion:nil];
}

+ (void)showLoginFromViewController:(UIViewController * _Nonnull)viewController callback:(void(^ _Nullable)(BOOL result))callback{
    DPLoginViewController *login = [DPLoginViewController new];
    login.callback = callback;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:login];
    [viewController presentViewController:nav animated:YES completion:nil];
}

@end
