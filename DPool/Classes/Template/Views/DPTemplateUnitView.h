//
//  DPTemplateUnitView.h
//  DPool
//
//  Created by dengchenglin on 2018/9/12.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DPTemplateView.h"

#import "DPTemplateModel.h"

@interface DPTemplateUnitView : DPTemplateView

@property (weak, nonatomic) IBOutlet UILabel *calculate_15_label;
@property (weak, nonatomic) IBOutlet UILabel *calculate_1_label;
@property (weak, nonatomic) IBOutlet UILabel *calculate_24_label;

@property (nonatomic, strong) DPTemplateModel *model;

@end
