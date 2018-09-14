//
//  GHBaseControllerProtocol.h
//  GeihuiCould
//
//  Created by dengchenglin on 2018/8/29.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DPBaseControllerProtocol <NSObject>

@optional

- (void)initialize;

- (void)setUpUI;

- (void)layout;

- (void)reloadView;

- (void)request;

- (void)bindViewModel;

- (void)setUpEvent;

- (void)reloadData:(id)data;


@end
