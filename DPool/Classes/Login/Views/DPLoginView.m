//
//  DPLoginView.m
//  DPool
//
//  Created by dengchenglin on 2018/9/10.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPLoginView.h"

@implementation DPLoginView
{
    UIView *_splitLine;
}

- (void)setUpUI{

    self.usernameTextField = ({
        DPLoginTextField *usernameTfd = [[DPLoginTextField  alloc]init];
        usernameTfd.placeholder = @"请输入邮箱";
        [self addSubview:usernameTfd];
        usernameTfd;
    });
    
    self.passwordTextField = ({
        DPLoginTextField *passwordTfd= [[DPLoginTextField alloc]init];
        passwordTfd.placeholder = @"请输入密码";
        passwordTfd.secureTextEntry = YES;
        [self addSubview:passwordTfd];
        passwordTfd;
    });
    
    self.registerBtn = ({
        UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        registerBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [registerBtn setTitle:@"我要注册" forState:UIControlStateNormal];
        registerBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [self addSubview:registerBtn];
        registerBtn;
    });
    
    self.loginBtn = ({
        DPDoneButton *loginBtn = [DPDoneButton buttonWithType:UIButtonTypeCustom];

        [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [self addSubview:loginBtn];
        loginBtn;
    });
    
    self.forgetpwdBtn = ({
        UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        forgetBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [forgetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [forgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
        forgetBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self addSubview:forgetBtn];
        forgetBtn;
    });
    
    _splitLine = ({
        UIView *line = [UIView new];
        line.backgroundColor = [UIColor whiteColor];
        [self addSubview:line];
        line;
    });
    
}

- (void)layoutSubviews{
    self.usernameTextField.frame = CGRectMake(45, 70 * AUTO_Y, self.width - 90, 50);
    self.passwordTextField.frame = CGRectMake(self.usernameTextField.left, self.usernameTextField.maxY + 28, self.usernameTextField.width, self.usernameTextField.height);
    
    self.loginBtn.frame = CGRectMake(self.passwordTextField.left - 3, self.passwordTextField.maxY + 75, self.passwordTextField.width + 6, self.passwordTextField.height);
    
    self.loginBtn.layer.cornerRadius = 25;
    
    self.registerBtn.bounds = CGRectMake(0, 0, 70, 30);
    self.registerBtn.center = CGPointMake(_loginBtn.centerX - 45, self.loginBtn.maxY + 30);
    
    self.forgetpwdBtn.bounds = self.registerBtn.bounds;
    self.forgetpwdBtn.center = CGPointMake(_loginBtn.centerX + 45, self.registerBtn.centerY);
    
    _splitLine.bounds = CGRectMake(0, 0, LINE_WIDTH, 16);
    _splitLine.center = CGPointMake(self.width/2, self.registerBtn.centerY);

}


- (void)bindViewModel:(id)viewModel{
    self.viewModel = viewModel;
    RAC(self.viewModel, username) = self.usernameTextField.rac_textSignal;
    RAC(self.viewModel, password) = self.passwordTextField.rac_textSignal;

}

@end
