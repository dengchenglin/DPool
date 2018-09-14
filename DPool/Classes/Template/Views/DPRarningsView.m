//
//  DPRarningsView.m
//  DPool
//
//  Created by dengchenglin on 2018/9/12.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPRarningsView.h"

@implementation DPRarningsView

- (void)awakeFromNib{
    [super awakeFromNib];

}

- (void)setModel:(DPTemplateModel *)model{
    _model = model;
    _totalLabel.text = _model.payment.total_earn;
    _yesterdayLabel.text = _model.payment.yesterdayearn;
    _payedLabel.text = _model.payment.pay_amount;
}

@end
