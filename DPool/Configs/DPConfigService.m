//
//  ConfigService.m
//  DPool
//
//  Created by dengchenglin on 2018/9/10.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPConfigService.h"

#import "KeyboardManager.h"

#import "DPNetworkEngine+Auth.h"

#import "DPNetworkEngine+App.h"

#import "DPWebManager.h"

#import "UMShareManager.h"

#import "DPWebViewController.h"

#import "AFNetworkReachabilityManager.h"

@implementation DPConfigService

CL_EXPORT_MODULE(DPConfigServiceProtocol)

+ (void)config{
    [self configKeyWindow];
    [KeyboardManager config];
    //授权token 接口会自动缓存
    [DPRequest authWithCallback:nil];
    //检测是否更新
    [self checkUpdate];
    //webView配置UA
     [DPWebManager initWebUA];
    
    
    [UMShareManager config];
    
    [self listeningNetwork];
 
}

//检测更新
+ (void)checkUpdate{
    [DPRequest upgradeWithCallback:^(id data, DPNetError error, NSString *msg) {
        NSNumber *isupdate = data[@"isupdate"];
        NSNumber *force = data[@"force"];
        if(isupdate.boolValue){
            [DPAlertView showUpdateViewWithTitle:data[@"title"] didClick:^(NSUInteger index) {
                if(index == 1){
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:data[@"url"]]];
                }
                else{
                    if(force.boolValue){
                        exit(0);
                    }
                }
            }];
        }
    }];
}

+ (void)shareInfo:(NSDictionary *)info{
    [UMShareManager shareInfo:info];
}


+ (void)configKeyWindow{
    NSNumber *is_use_html5 = [[NSUserDefaults standardUserDefaults]objectForKey:@"dp_use_html"];
    NSString *web_url = [[NSUserDefaults standardUserDefaults]objectForKey:@"dp_web_url"];
    if(is_use_html5.boolValue){
        [self configWebWindowWithUrl:web_url];
    }
    else{
        [self configMainWindow];
    }
    
    [DPRequest switchInfoWithCallback:^(id data, DPNetError error, NSString *msg) {
        NSNumber *is_use_html5 = data[@"is_use_html5"];
        NSString *web_url = data[@"web_url"];
        [[NSUserDefaults standardUserDefaults]setObject:is_use_html5 forKey:@"dp_use_html"];
        UIViewController *rootVc = [UIApplication sharedApplication].keyWindow.rootViewController;
        if(is_use_html5.boolValue){
            if(![rootVc isKindOfClass:[DPWebViewController class]]){
                [self configWebWindowWithUrl:web_url];
            }
            [[NSUserDefaults standardUserDefaults]setObject:web_url forKey:@"dp_web_url"];
        }
        else{
            if(![rootVc isKindOfClass:[UITabBarController class]]){
                [self configMainWindow];
            }
        }
    }];
}

+ (void)configWebWindowWithUrl:(NSString *)url{
    Class<DPWebServiceProtocol> webService = ( Class<DPWebServiceProtocol>)[DPModuleServiceManager serviceForStr:@"dp_web"];
    UIViewController *rootVc = [webService webViewControllerWithUrl:url title:nil needRefresh:NO];
    [UIApplication sharedApplication].keyWindow.rootViewController = rootVc;
}
+ (void)configMainWindow{
    [UIApplication sharedApplication].keyWindow.rootViewController = [[DPModuleServiceManager mainService] rootViewController];
}

+ (void)listeningNetwork
{
    AFNetworkReachabilityManager *reachabiltyManager = [AFNetworkReachabilityManager sharedManager];
    
    [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if(status == AFNetworkReachabilityStatusReachableViaWiFi || status == AFNetworkReachabilityStatusReachableViaWWAN)
        {
            [self configKeyWindow];
        }

    }];
    [reachabiltyManager startMonitoring];
    
}

@end
