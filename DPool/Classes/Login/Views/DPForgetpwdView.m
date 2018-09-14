//
//  DPPasswordView.m
//  DPool
//
//  Created by anchao on 2018/9/11.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPForgetpwdView.h"

@implementation DPForgetpwdView

- (void)setUpUI{
    self.emailTfd = ({
        DPLoginTextField *emailTfd = [[DPLoginTextField  alloc]init];
        emailTfd.placeholder = @"请输入邮箱";
        [self addSubview:emailTfd];
        emailTfd;
    });
    
    self.passwordTfd = ({
        DPLoginTextField *passwordTfd= [[DPLoginTextField alloc]init];
        passwordTfd.placeholder = @"请输入密码";
        passwordTfd.secureTextEntry = YES;
        [self addSubview:passwordTfd];
        passwordTfd;
    });
    
    self.rpwdTfd = ({
        DPLoginTextField *rpwdTfd= [[DPLoginTextField alloc]init];
        rpwdTfd.placeholder = @"请再次输入密码";
        rpwdTfd.secureTextEntry = YES;
        [self addSubview:rpwdTfd];
        rpwdTfd;
    });
    
    self.codeTfd = ({
        DPLoginTextField *codeTfd= [[DPLoginTextField alloc]init];
        codeTfd.placeholder = @"请输入验证码";
        codeTfd.secureTextEntry = YES;
        [self addSubview:codeTfd];
        codeTfd;
    });
    
    self.sendCodeBtn = ({
        CLTimerButton *sendCodeBtn = [CLTimerButton buttonWithType:UIButtonTypeCustom];
        sendCodeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [sendCodeBtn setFrame:CGRectMake(0, 0, 110, 30)];
        [sendCodeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        [sendCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        [sendCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sendCodeBtn.backgroundColor = DPColor;
        sendCodeBtn.timeInterval = 60;
        [self addSubview:sendCodeBtn];
        sendCodeBtn;
    });
    
    self.registerBtn = ({
        DPDoneButton *registerBtn = [DPDoneButton buttonWithType:UIButtonTypeCustom];
        [registerBtn setTitle:@"确定" forState:UIControlStateNormal];
        [self addSubview:registerBtn];
        registerBtn;
    });
    
}

- (void)layoutSubviews{
    self.emailTfd.frame = CGRectMake(45, 70 * AUTO_Y, self.width - 90, 50);
    self.passwordTfd.frame = CGRectMake(self.emailTfd.left, self.emailTfd.maxY + 28, self.emailTfd.width, self.emailTfd.height);
    self.rpwdTfd.frame = CGRectMake(self.passwordTfd.left, self.passwordTfd.maxY + 28, self.passwordTfd.width, self.passwordTfd.height);
    
    self.codeTfd.frame = CGRectMake(self.rpwdTfd.left, self.rpwdTfd.maxY + 28, self.rpwdTfd.width - 150, self.rpwdTfd.height);
    
    self.sendCodeBtn.frame = CGRectMake(self.codeTfd.maxX + 10, self.codeTfd.maxY - 40, 140, 40);
    self.sendCodeBtn.layer.cornerRadius = 20;
    
    self.registerBtn.frame = CGRectMake(self.codeTfd.left - 3, self.codeTfd.maxY + 75, self.passwordTfd.width + 6, self.codeTfd.height);
    self.registerBtn.layer.cornerRadius = 25;
    
}

- (void)bindViewModel:(DPForgetpwdViewModel *)viewModel{
    self.viewModel = viewModel;
    RAC(self.viewModel, email) = self.emailTfd.rac_textSignal;
    RAC(self.viewModel, password) = self.passwordTfd.rac_textSignal;
    RAC(self.viewModel, rpwd) = self.rpwdTfd.rac_textSignal;
    RAC(self.viewModel, code) = self.codeTfd.rac_textSignal;
}

@end
