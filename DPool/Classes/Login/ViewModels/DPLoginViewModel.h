//
//  DPLoginViewModel.h
//  DPool
//
//  Created by dengchenglin on 2018/9/10.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPViewModel.h"

@interface DPLoginViewModel : DPViewModel

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *password;

@property (nonatomic, strong) RACSignal *validLoginSignal;

@end
