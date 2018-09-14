//
//  CLRefreshFooter.h
//  CLRefreshDemo
//
//  Created by dengchenglin on 2018/9/1.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLRefreshFooter : UIView

@property (nonatomic, weak, readonly)UIScrollView *scrollView;

@property (nonatomic, copy) void (^refreshBlock)(void);

@property (nonatomic, assign) CGFloat progress;

@property (nonatomic, assign) BOOL loading;

@property (nonatomic, assign) CGFloat diff;

@property (nonatomic, assign) BOOL showNulMore;

- (instancetype)initWithScrollView:(UIScrollView *)scrollView;

- (void)beginRefreshing;

- (void)endRefreshing;

- (void)showNulMoreView;

- (void)hiddenNulMoreView;

@end
