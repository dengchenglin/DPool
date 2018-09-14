//
//  DPTemplateView.m
//  DPool
//
//  Created by dengchenglin on 2018/9/12.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPTemplateView.h"

@implementation DPTemplateView

ViewInstance(setUp)

- (void)setUp{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderWidth = LINE_WIDTH;
    self.layer.cornerRadius = 2;
    self.layer.borderColor = RGBColor(220, 220, 220).CGColor;
}

@end
