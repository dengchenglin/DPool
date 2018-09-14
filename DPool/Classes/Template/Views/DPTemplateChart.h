//
//  DPTemplateChart.h
//  DPool
//
//  Created by dengchenglin on 2018/9/12.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DPTemplateView.h"

#import "DPTemplateChartViewModel.h"

@interface DPTemplateChart : DPTemplateView

@property (nonatomic, strong) DPTemplateChartViewModel *h_viewModel;

@property (nonatomic, strong) DPTemplateChartViewModel *d_viewModel;

- (void)reloadView;

@end
