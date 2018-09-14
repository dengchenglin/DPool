//
//  DPLogigViewController.m
//  DPool
//
//  Created by dengchenglin on 2018/9/10.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPLoginViewController.h"

#import "DPForgetPasswordViewController.h"

#import "DPRegisterViewController.h"

#import "DPLoginView.h"

#import "DPNetworkEngine+Login.h"

@interface DPLoginViewController ()

@property (nonatomic, strong) DPLoginView *loginView;

@property (nonatomic, strong) DPLoginViewModel *viewModel;
@end

@implementation DPLoginViewController

- (DPLoginView *)loginView{
    if(!_loginView){
        _loginView = [[DPLoginView alloc]initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBAR_HEIGHT)];
        [self.view addSubview:_loginView];
    }
    return _loginView;
}

- (DPLoginViewModel *)viewModel{
    if(!_viewModel){
        _viewModel = [DPLoginViewModel new];
    }
    return _viewModel;
}

- (void)setUpUI{
    self.title = @"登录";

}

- (void)bindViewModel{
    [self.loginView bindViewModel:self.viewModel];
    
}

- (void)setUpEvent{
    
    @weakify(self)
    [self.loginView.registerBtn touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        [self.navigationController pushViewController:[DPRegisterViewController new] animated:YES];
    }];
    [self.loginView.forgetpwdBtn touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        [self.navigationController pushViewController:[DPForgetPasswordViewController new] animated:YES];
    }];
    [self.loginView.loginBtn touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        if(!self.viewModel.username.length){
            [DPAlertView showErrorViewWithTitle:@"请输入邮箱"];
            return ;
        }
        if(!self.viewModel.password.length){
            [DPAlertView showErrorViewWithTitle:@"请输入密码"];
            return ;
        }
        [DPRequest loginWithEmail:self.viewModel.username password:self.viewModel.password callback:^(id data, DPNetError error,NSString *msg) {
            if(!error){
                [MBProgressHUD showMBProgressHudWithTitle:msg hideAfterDelay:1.0];
                if(self.callback){
                    self.callback(YES);
                }
                [[NSNotificationCenter defaultCenter]postNotificationName:DP_NOTIFITION_LOGIN object:nil];
                [self back];
            }
        }];
    }];
}

- (void)back{
    [super back];
    if(![DPAppManager logined]){
        if(self.callback){
            self.callback(NO);
        }
    }
}

- (void)dealloc
{
    
}

@end
