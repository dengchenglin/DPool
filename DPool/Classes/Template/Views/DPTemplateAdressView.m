
//
//  DPTemplateAdressView.m
//  DPool
//
//  Created by dengchenglin on 2018/9/12.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPTemplateAdressView.h"

@implementation DPTemplateAdressView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.hidden = YES;
}

- (void)setModel:(DPTemplateModel *)model{
    _model = model;
    self.hidden = NO;
}

@end
