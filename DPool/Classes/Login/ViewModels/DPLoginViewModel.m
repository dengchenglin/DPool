//
//  DPLoginViewModel.m
//  DPool
//
//  Created by dengchenglin on 2018/9/10.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPLoginViewModel.h"

@implementation DPLoginViewModel

- (void)initialize{
    //账号和密码不能为空
//    self.validLoginSignal = [RACSignal combineLatest:@[RACObserve(self, username),RACObserve(self, password)] reduce:^(NSString *username,NSString *password){
//        return @(username.length && (password.length>=6));
//    }];
}


@end
