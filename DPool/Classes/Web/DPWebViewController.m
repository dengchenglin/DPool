//
//  DPWebViewController.m
//  DPMain
//
//  Created by dengchenglin on 2018/7/5.
//  Copyright © 2018年 Property. All rights reserved.
//

#import "DPWebViewController.h"

#import <JavaScriptCore/JavaScriptCore.h>

#import "UIScrollView+CLRefresh.h"

#import "NSTimer+YYAdd.h"

@interface DPWebViewController ()<UIWebViewDelegate>

@property (nonatomic, strong)UIWebView *webView;

@property (nonatomic, copy)NSString *n_url;

@property (nonatomic, strong)UIButton *backBtn;

@property (nonatomic, assign)BOOL needRefresh;

@end

@implementation DPWebViewController

+ (UIViewController *_Nullable)webViewControllerWithUrl:(NSString *_Nullable)url title:(NSString *_Nullable)title needRefresh:(BOOL)needRefresh{
    DPWebViewController *vc = [DPWebViewController new];
    vc.url = url;
    vc.s_title = title;
    vc.needRefresh = needRefresh;
    return vc;
}

+ (void)showWebFromViewController:(UIViewController * _Nonnull)viewController url:(NSString * _Nonnull)url{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        DPWebViewController *vc = [DPWebViewController new];
        vc.url = url;
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        [viewController presentViewController:nav animated:YES completion:nil];
        
        DBLog(@"web usl is ---- %@\n\n",vc.url);
    });

}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _needRefresh = YES;
    }
    return self;
}

- (void)setUpUI{
    self.title = _s_title;
    _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    _webView.delegate = self;
    _webView.scalesPageToFit = YES;
    _webView.backgroundColor = [UIColor whiteColor];
    _webView.scrollView.showsVerticalScrollIndicator = NO;
    _webView.autoresizesSubviews = NO; //自动调整大小
    _webView.autoresizingMask=(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
    [self.view addSubview:_webView];
    

    if([_s_title isEqualToString:@"首页"]){
          [self setRightButtonWithImageName:@"user" imageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5) selector:@selector(login)];
    }
    
    @weakify(self);
    [_backBtn touchUpInsideSubscribeNext:^(id x) {
        @strongify(self);
        if([self.webView canGoBack]){
            [self.webView goBack];
        }
    }];

    if(_needRefresh){
        [self.webView.scrollView addHeaderRefreshWithCallBack:^{
            @strongify(self)
            [self request];
        }];
    }


    self.n_url = [self.url urlAddCompnentForValue:[DPUserManager sharedInstance].cuid key:@"cuid"];
    [[[NSNotificationCenter defaultCenter]rac_addObserverForName:DP_NOTIFITION_LOGIN object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        if([DPAppManager logined]){
            self.n_url = [self.url urlAddCompnentForValue:[DPAppManager sharedInstance].email key:@"account"];
            [self request];
        }
    }];
    
}

- (void)login{
    [DPModuleManager showLoginFromViewController:self callback:nil];
}

- (void)request{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [NSTimer scheduledTimerWithTimeInterval:0.2 block:^(NSTimer *timer) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.n_url]]];
    } repeats:NO];

}

- (void)back{
    if([self.webView canGoBack]){
        [self.webView goBack];
    }
    else{
        [super back];
    }
}


#pragma makr - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self.webView.scrollView endRefreshing];
    //设置标题
    self.navigationItem.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    JSContext *context = [_webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //页面关闭

    context[@"dpShare"] = ^() {
        NSArray *args = [JSContext currentArguments];
        JSValue *jsVal = [args objectAtIndex:0];
        NSString *jsStr = [jsVal toString];
        NSDictionary *shareData = [jsStr jsonValueDecoded];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[DPModuleServiceManager configService] shareInfo:shareData];
        });
        
    };
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self.webView.scrollView endRefreshing];
}

@end
