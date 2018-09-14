//
//  DPOremachineView.h
//  DPool
//
//  Created by dengchenglin on 2018/9/12.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DPTemplateView.h"

@interface DPOremachineView : DPTemplateView
@property (weak, nonatomic) IBOutlet UILabel *activeLabel;
@property (weak, nonatomic) IBOutlet UILabel *unactiveLabel;
@property (weak, nonatomic) IBOutlet UILabel *disabledLabel;
@property (nonatomic, strong) DPTemplateModel *model;
@end
