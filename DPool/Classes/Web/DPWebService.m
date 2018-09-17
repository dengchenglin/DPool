

//
//  DPWebService.m
//  DPMain
//
//  Created by dengchenglin on 2018/7/9.
//  Copyright © 2018年 Property. All rights reserved.
//

#import "DPWebService.h"

#import "DPWebViewController.h"

@implementation DPWebService

CL_EXPORT_MODULE(DPWebServiceProtocol)

+ (UIViewController *_Nullable)webViewControllerWithUrl:(NSString *_Nullable)url title:(NSString *_Nullable)title{
    return [self webViewControllerWithUrl:url title:title needRefresh:YES];
}

+ (UIViewController *_Nullable)webViewControllerWithUrl:(NSString *_Nullable)url title:(NSString *_Nullable)title needRefresh:(BOOL)needRefresh{
    return [DPWebViewController webViewControllerWithUrl:url title:title needRefresh:needRefresh];
}

+ (void)showWebFromViewController:(UIViewController * _Nonnull)viewController url:(NSString * _Nonnull)url{
        [DPWebViewController showWebFromViewController:viewController url:url];
}


@end
