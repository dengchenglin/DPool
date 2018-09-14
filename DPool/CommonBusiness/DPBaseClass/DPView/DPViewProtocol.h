//
//  GCViewProtocol.h
//  GeihuiCould
//
//  Created by dengchenglin on 2018/8/29.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DPViewProtocol <NSObject>

@optional

- (void)setUpUI;

- (void)bindViewModel:(id)viewModel;

@end
