//
//  DPModuleManager.m
//  GeihuiCould
//
//  Created by denDPhenglin on 2018/8/30.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPModuleManager.h"

#import "CLModuleManager.h"

#import "DPModuleServiceManager.h"

@implementation DPModuleManager

+ (UIViewController *)mainViewController{
    
   return [[DPModuleServiceManager mainService] rootViewController];
}

+ (void)showLoginFromViewController:(UIViewController * _Nonnull)viewController animated:(BOOL)animated success:(void(^ _Nullable)(void))success{
    Class<DPLoginServiceProtocol> loginService = [CLModuleManager moduleServiceForProtocol:@protocol(DPLoginServiceProtocol)];
    [loginService showLoginFromViewController:viewController animated:NO  success:success];
}

+ (void)showLoginFromViewController:(UIViewController * _Nonnull)viewController success:(void(^ _Nullable)(void))success{
    Class<DPLoginServiceProtocol> loginService = [CLModuleManager moduleServiceForProtocol:@protocol(DPLoginServiceProtocol)];
    [loginService showLoginFromViewController:viewController success:success];
}

+ (void)showLoginFromViewController:(UIViewController * _Nonnull)viewController callback:(void(^ _Nullable)(BOOL result))callback{
    Class<DPLoginServiceProtocol> loginService = [CLModuleManager moduleServiceForProtocol:@protocol(DPLoginServiceProtocol)];
    [loginService showLoginFromViewController:viewController callback:callback];
}

+ (void)showWebFromViewController:(UIViewController * _Nonnull)viewController url:(NSString * _Nonnull)url{
    Class<DPWebServiceProtocol> webService = [CLModuleManager moduleServiceForProtocol:@protocol(DPWebServiceProtocol)];
    [webService showWebFromViewController:viewController url:url];
}



@end
