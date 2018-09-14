//
//  DPDoneButton.m
//  DPool
//
//  Created by dengchenglin on 2018/9/10.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPDoneButton.h"

@implementation DPDoneButton

ViewInstance(setUp)

- (void)setUp{
    self.backgroundColor = DPColor;
    self.layer.cornerRadius = 4;
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    @weakify(self);
//    [[self rac_valuesForKeyPath:@"enabled" observer:self] subscribeNext:^(id x) {
//        @strongify(self)
//        BOOL enabled = [x boolValue];
//        self.backgroundColor = enabled ?DPColor : LightGrayColor;
//    }];
}

@end
