//
//  DPWebViewController.m
//  DPMain
//
//  Created by dengchenglin on 2018/7/5.
//  Copyright © 2018年 Property. All rights reserved.
//

#import "DPWebViewController.h"

#import <JavaScriptCore/JavaScriptCore.h>

@interface DPWebViewController ()<UIWebViewDelegate>

@property (nonatomic, strong)UIWebView *webView;

@end

@implementation DPWebViewController

+ (UIViewController *_Nullable)webViewControllerWithUrl:(NSString *_Nullable)url title:(NSString *_Nullable)title{
    DPWebViewController *vc = [DPWebViewController new];
    vc.url = url;
    vc.s_title = title;
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

- (void)setUpUI{
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
    else{
        UIButton *reloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [reloadBtn setFrame:CGRectMake(0, 0, 30, 30)];
        [reloadBtn setImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
        reloadBtn.imageEdgeInsets = UIEdgeInsetsMake(3, 3, 3, 3 );
        UIBarButtonItem *reloadItem = [[UIBarButtonItem alloc]initWithCustomView:reloadBtn];
        self.navigationItem.rightBarButtonItem = reloadItem;
        @weakify(self);
        [reloadBtn touchUpInsideSubscribeNext:^(id x) {
            @strongify(self);
            [self.webView reload];
        }];
    }

}


- (void)login{
    [DPModuleManager showLoginFromViewController:self callback:nil];
}

- (void)request{
    [MBProgressHUD showMBProgressHudOnView:self.view];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
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
    
    //设置标题
    self.navigationItem.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    JSContext *context = [_webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //页面关闭
    @weakify(self);
    context[@"dpShare"] = ^() {
        dispatch_async(dispatch_get_main_queue(), ^{
            @strongify(self);
            NSArray *args = [JSContext currentArguments];
            JSValue *jsVal = [args objectAtIndex:0];
            NSString *jsStr = [jsVal toString];
            NSDictionary *shareData = [jsStr jsonValueDecoded];
            dispatch_async(dispatch_get_main_queue(), ^{
               [[DPModuleServiceManager configService] shareInfo:shareData];
            });
            
        });
    };
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}



@end
