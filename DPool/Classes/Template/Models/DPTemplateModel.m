//
//  DPTemplateModel.m
//  DPool
//
//  Created by dengchenglin on 2018/9/12.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPTemplateModel.h"
@implementation History
@end

@implementation Payment
@end

@implementation Stats
@end

@implementation DPTemplateModel

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"history_h":[History class],@"history_d":[History class],@"payment":[Payment class],@"stats":[Stats class]};
}

@end
