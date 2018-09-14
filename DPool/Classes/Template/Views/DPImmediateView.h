//
//  DPImmediateView.h
//  DPool
//
//  Created by dengchenglin on 2018/9/12.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DPTemplateModel.h"

@interface DPImmediateView : UIView
@property (weak, nonatomic) IBOutlet UILabel *immediateLabel;
@property (weak, nonatomic) IBOutlet UILabel *yesterdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *vaildLabel;

@property (nonatomic, strong) DPTemplateModel *model;

@end
