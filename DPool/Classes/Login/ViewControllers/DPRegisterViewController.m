//
//  DPRegisterViewController.m
//  DPool
//
//  Created by dengchenglin on 2018/9/11.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPRegisterViewController.h"

#import "DPRegisterView.h"

#import "DPNetworkEngine+Login.h"

@interface DPRegisterViewController ()

@property (nonatomic, strong) DPRegisterView *registerView;

@property (nonatomic, strong) DPRegisterViewModel *viewModel;

@end

@implementation DPRegisterViewController

- (DPRegisterView *)registerView{
    if(!_registerView){
        _registerView = [[DPRegisterView alloc]initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBAR_HEIGHT)];
        [self.view addSubview:_registerView];
    }
    return _registerView;
}

- (DPRegisterViewModel *)viewModel{
    if(!_viewModel){
        _viewModel = [DPRegisterViewModel new];
    }
    return _viewModel;
}

- (void)setUpUI{
    self.title = @"注册";
}

- (void)bindViewModel{
    [self.registerView bindViewModel:self.viewModel];
}

- (void)setUpEvent{
    
    //发送验证码
    @weakify(self)
    [self.registerView.sendCodeBtn touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        if(!self.viewModel.email.length){
            [DPAlertView showErrorViewWithTitle:@"请输入邮箱"];
            return ;
        }
        [DPRequest sendEmailWithEmail:self.viewModel.email type:SendEmailRegister callback:^(id data, DPNetError error, NSString *msg) {
            if(!error){
                [self.registerView.sendCodeBtn startTimer];
                [MBProgressHUD showMBProgressHudWithTitle:msg hideAfterDelay:1.0];
            }
        }];
    }];

    //注册
    [self.registerView.registerBtn touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        if(!self.viewModel.email.length){
            [DPAlertView showErrorViewWithTitle:@"请输入邮箱"];
            return ;
        }
        if(!self.viewModel.password.length){
            [DPAlertView showErrorViewWithTitle:@"请输入密码"];
            return ;
        }
        if(!self.viewModel.rpwd.length){
            [DPAlertView showErrorViewWithTitle:@"请输入确认密码"];
            return ;
        }
        if(!self.viewModel.code.length){
            [DPAlertView showErrorViewWithTitle:@"请输入验证码"];
            return ;
        }
        [DPRequest registerWithEmail:self.viewModel.email password:self.viewModel.password rpwd:self.viewModel.rpwd code:self.viewModel.code callback:^(id data, DPNetError error, NSString *msg) {
            if(!error){
                [MBProgressHUD showMBProgressHudWithTitle:msg hideAfterDelay:1.0];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }];
    }];
}

@end
