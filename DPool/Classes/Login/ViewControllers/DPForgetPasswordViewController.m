//
//  DPForgetPasswordViewController.m
//  DPool
//
//  Created by anchao on 2018/9/11.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPForgetPasswordViewController.h"

#import "DPForgetpwdView.h"

#import "DPNetworkEngine+Login.h"

@interface DPForgetPasswordViewController ()

@property (nonatomic, strong) DPForgetpwdView * passwordView;

@property (nonatomic, strong)DPForgetpwdViewModel  *viewModel;
@end

@implementation DPForgetPasswordViewController

- (DPForgetpwdView *)passwordView{
    if(!_passwordView){
        _passwordView = [[DPForgetpwdView alloc]initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBAR_HEIGHT)];
        [self.view addSubview:_passwordView];
    }
    return _passwordView;
}

- (DPForgetpwdViewModel *)viewModel{
    if(!_viewModel){
        _viewModel = [DPForgetpwdViewModel new];
    }
    return _viewModel;
}
-(void)setUpUI{
    self.title = @"忘记密码";
}

- (void)bindViewModel{
    [self.passwordView bindViewModel:self.viewModel];
}

- (void)setUpEvent{
    @weakify(self)
    [self.passwordView.sendCodeBtn touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        if(!self.viewModel.email.length){
            [DPAlertView showErrorViewWithTitle:@"请输入邮箱"];
            return ;
        }
        [DPRequest sendEmailWithEmail:self.viewModel.email type:SendEmailForget callback:^(id data, DPNetError error, NSString *msg) {
            if(!error){
                [self.passwordView.sendCodeBtn startTimer];
                [MBProgressHUD showMBProgressHudWithTitle:msg hideAfterDelay:1.0];
            }
        }];
    }];
    
    [self.passwordView.registerBtn touchUpInsideSubscribeNext:^(id x) {
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
        [DPRequest resetWithEmail:self.viewModel.email password:self.viewModel.password rpwd:self.viewModel.rpwd code:self.viewModel.code callback:^(id data, DPNetError error, NSString *msg) {
            if(!error){
                [MBProgressHUD showMBProgressHudWithTitle:msg hideAfterDelay:1.0];
            }
        }];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
