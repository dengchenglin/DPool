//
//  GCViewModelProtocol.h
//  GeihuiCould
//
//  Created by dengchenglin on 2018/8/29.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DPViewModelProtocol <NSObject>

@optional

- (void)initialize;

+ (id)bindModel:(id)model;

+ (NSArray *)bindModels:(NSArray *)models;

@end
