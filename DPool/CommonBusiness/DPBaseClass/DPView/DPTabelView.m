//
//  GCTabelView.m
//  GeihuiCould
//
//  Created by dengchenglin on 2018/8/31.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPTabelView.h"

@implementation DPTabelView

ViewInstance(tabview_init)

- (void)tabview_init{

    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
}

- (void)registerNibWithClass:(Class)_class{
    [self registerNib:[UINib nibWithNibName:NSStringFromClass(_class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(_class)];
}

@end
