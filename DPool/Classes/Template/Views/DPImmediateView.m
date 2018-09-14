//
//  DPImmediateView.m
//  DPool
//
//  Created by dengchenglin on 2018/9/12.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPImmediateView.h"

@implementation DPImmediateView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.layer.contents = (__bridge id)[UIImage imageNamed:@"template_bg"].CGImage;
}

- (void)setModel:(DPTemplateModel *)model{
    _model = model;
    _immediateLabel.text = [NSString stringWithFormat:@"%@ TH/S",_model.stats.shares_15m];
    _yesterdayLabel.text = _model.payment.yesterdayearn;
    _vaildLabel.text = _model.stats.workers_active;
    _totalLabel.text = _model.payment.total_earn;
    
}

@end
