//
//  DPChartSelectView.h
//  DPool
//
//  Created by dengchenglin on 2018/9/13.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DPChartSelectView : UIView

@property (nonatomic, copy) void (^didClick)(NSUInteger index);

@end
