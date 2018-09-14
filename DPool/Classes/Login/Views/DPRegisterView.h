//
//  DPRegisterView.h
//  DPool
//
//  Created by dengchenglin on 2018/9/11.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPView.h"

#import "DPLoginTextField.h"

#import "CLTimerButton.h"

#import "DPDoneButton.h"

#import "DPRegisterViewModel.h"

@interface DPRegisterView : DPView

@property (nonatomic, strong) DPLoginTextField *emailTfd;

@property (nonatomic, strong) DPLoginTextField *passwordTfd;

@property (nonatomic, strong) DPLoginTextField *rpwdTfd;

@property (nonatomic, strong) DPLoginTextField *codeTfd;

@property (nonatomic, strong) CLTimerButton *sendCodeBtn;

@property (nonatomic, strong) DPDoneButton *registerBtn;

@property (nonatomic, strong) DPRegisterViewModel *viewModel;

@end
