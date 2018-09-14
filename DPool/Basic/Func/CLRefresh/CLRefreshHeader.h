//
//  CLRefreshHeader.h
//  CLRefreshDemo
//
//  Created by dengchenglin on 2018/9/1.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLRefreshHeader : UIView

@property (nonatomic, weak, readonly)UIScrollView *scrollView;

@property (nonatomic, copy) void (^refreshBlock)(void);

//
@property (nonatomic, assign)CGFloat progress;

@property (nonatomic, assign)BOOL loading;

@property (nonatomic, assign)CGFloat diff;

- (instancetype)initWithScrollView:(UIScrollView *)scrollView;

/**
 *  立即触发下拉刷新
 */
- (void)beginRefreshing;

/**
 *  结束刷新
 */
- (void)endRefreshing;




@end
