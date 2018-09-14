//
//  DPRarningsView.h
//  DPool
//
//  Created by dengchenglin on 2018/9/12.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DPTemplateView.h"

@interface DPRarningsView : DPTemplateView
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *yesterdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *payedLabel;

@property (nonatomic, strong) DPTemplateModel *model;

@end
