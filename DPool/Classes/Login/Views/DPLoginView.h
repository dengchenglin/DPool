//
//  DPLoginView.h
//  DPool
//
//  Created by dengchenglin on 2018/9/10.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPView.h"

#import "DPLoginTextField.h"

#import "DPDoneButton.h"

#import "DPLoginViewModel.h"

@interface DPLoginView : DPView

@property (nonatomic, strong) DPLoginTextField *usernameTextField;

@property (nonatomic, strong) DPLoginTextField *passwordTextField;

@property (nonatomic, strong) UIButton *registerBtn;

@property (nonatomic, strong) UIButton *forgetpwdBtn;

@property (nonatomic, strong) DPDoneButton *loginBtn;

@property (nonatomic, strong) DPLoginViewModel *viewModel;

@end
