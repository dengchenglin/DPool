//
//  DPTemplateUnitView.m
//  DPool
//
//  Created by dengchenglin on 2018/9/12.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPTemplateUnitView.h"

@implementation DPTemplateUnitView

- (void)awakeFromNib{
    [super awakeFromNib];
    
}

- (void)setModel:(DPTemplateModel *)model{
    _model = model;
    _calculate_15_label.text = [NSString stringWithFormat:@"%@ TH/S",[NSString stringWithFormat:@"%.2f",_model.stats.shares_15m.floatValue]];
    _calculate_1_label.text = [NSString stringWithFormat:@"%@ TH/S",[NSString stringWithFormat:@"%.2f",_model.stats.shares_1h.floatValue]];
    _calculate_24_label.text = [NSString stringWithFormat:@"%@ TH/S",[NSString stringWithFormat:@"%.2f",_model.stats.shares_24h.floatValue]];
}

@end
