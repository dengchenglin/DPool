

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
    return [DPWebViewController webViewControllerWithUrl:url title:title];
}

+ (void)showWebFromViewController:(UIViewController * _Nonnull)viewController url:(NSString * _Nonnull)url{
        [DPWebViewController showWebFromViewController:viewController url:url];
}


@end
