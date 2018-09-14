//
//  DPPasswordViewModel.h
//  DPool
//
//  Created by anchao on 2018/9/11.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPViewModel.h"

@interface DPForgetpwdViewModel : DPViewModel
@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *password;

@property (nonatomic, copy) NSString *rpwd;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *email;
@end
