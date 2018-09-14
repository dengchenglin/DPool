//
//  GCViewModel.m
//  GeihuiCould
//
//  Created by dengchenglin on 2018/8/29.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPViewModel.h"

@implementation DPViewModel

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    DPViewModel *viewModel = [super allocWithZone:zone];
    [viewModel initialize];
    return viewModel;
}

- (void)initialize{}

+ (id)bindModel:(id)model{
    
    return nil;
}

+ (NSArray *)bindModels:(NSArray *)models{
    
    return nil;
}

@end
