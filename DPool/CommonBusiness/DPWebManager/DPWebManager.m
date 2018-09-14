//
//  WebManager.m
//  GeihuiWang
//
//  Created by dengchenglin on 2018/7/5.
//  Copyright © 2018年 qianmeng. All rights reserved.
//

#import "DPWebManager.h"

#import <WebKit/WebKit.h>

@interface DPWebManager()

@property (nonatomic, strong)WKWebView *webView;

@end

@implementation DPWebManager

+ (instancetype)shareInstance{
    static DPWebManager *manager = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        manager = [[DPWebManager alloc]init];
    });
    return manager;
}

+ (void)initWebUA{
  
    [[self shareInstance] initWebViewUA];

}

- (void)initWebViewUA{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    NSString *oldAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    NSLog(@"old agent :%@", oldAgent);
    //add my info to the new agent
    NSString *newAgent = [oldAgent stringByAppendingPathComponent:[NSString stringWithFormat:@"DPool/%@",[[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"]]];
    NSLog(@"new agent :%@", newAgent);
    //regist the new agent
    NSDictionary *dictionnary = [[NSDictionary alloc] initWithObjectsAndKeys:newAgent, @"UserAgent", nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionnary];
}

- (void)initWKWebViewUA{
     self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];


    [_webView evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id result, NSError * _Nullable error) {
   
            //1）获取默认userAgent：
        NSString *oldUA = result;   //直接获取为nil
            //2）设置userAgent：添加额外的信息
        NSString *newUA = [NSString stringWithFormat:@"%@/Geihui/4.9.9", oldUA];
        NSDictionary *dictNU = [NSDictionary dictionaryWithObjectsAndKeys:newUA, @"UserAgent", nil];
        [[NSUserDefaults standardUserDefaults] registerDefaults:dictNU];
        
      
    }];
//    NSURL *url = [NSURL URLWithString:@"http://www.928w.com:10080/go/redirect?uid=5&id=60&t=s&rtp=1&skip_jump_notice=1&nojdapp=1"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url
//                                             cachePolicy:NSURLRequestUseProtocolCachePolicy
//                                         timeoutInterval:10.f];
//    [self.webView loadRequest:request];

}

@end
