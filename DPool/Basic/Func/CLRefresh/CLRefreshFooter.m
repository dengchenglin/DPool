//
//  CLRefreshFooter.m
//  CLRefreshDemo
//
//  Created by dengchenglin on 2018/9/1.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "CLRefreshFooter.h"

#import "CLRefreshManager.h"

NSString *const CLRefreshFooterKeyPathContentOffset = @"contentOffset";

NSString *const CLRefreshFooterKeyPathContentSize = @"contentSize";

@implementation CLRefreshFooter
{
    __weak UIScrollView *_scrollView;

    CGFloat _refreshDistance;
}

- (instancetype)initWithScrollView:(UIScrollView *)scrollView{
    if(self = [super init]){
        _scrollView = scrollView;
        [_scrollView insertSubview:self atIndex:0];
        
        _refreshDistance = [CLRefreshManager shareInsatnce].config.loadMoreDistance;
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [self.superview removeObserver:self forKeyPath:CLRefreshFooterKeyPathContentOffset];
    [self.superview removeObserver:self forKeyPath:CLRefreshFooterKeyPathContentSize];
    if(newSuperview){
        [newSuperview addObserver:self forKeyPath:CLRefreshFooterKeyPathContentOffset options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        [newSuperview addObserver:self forKeyPath:CLRefreshFooterKeyPathContentSize options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    CGFloat minTop = self.scrollView.contentSize.height;
    if(minTop < self.scrollView.bounds.size.height){
        minTop = self.scrollView.bounds.size.height;
    }

    
    if([keyPath isEqualToString:CLRefreshFooterKeyPathContentSize]){
         self.frame = CGRectMake(0, minTop, self.scrollView.bounds.size.width, 60);
    }
    if(self.showNulMore){
        return;
    }
   
    if ([keyPath isEqualToString:CLRefreshFooterKeyPathContentOffset]) {
        
        CGPoint contentOffset = [[change valueForKey:NSKeyValueChangeNewKey] CGPointValue];
        CGFloat originOffest = minTop - self.scrollView.bounds.size.height;
        if (contentOffset.y >= originOffest) {
            CGFloat progress = MAX(0.0, MIN((contentOffset.y - originOffest)/_refreshDistance, 1.0));
            
            if(!_loading){
                self.progress = progress;
            }
            if(self.progress >= 1.0 && !self.scrollView.tracking && !self.loading){
                self.loading = YES;
                [UIView animateWithDuration:0.3 animations:^{
                    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, self.bounds.size.height, 0);
                }];
                if(self.refreshBlock){
                    self.refreshBlock();
                }
            }
            CGFloat diff = contentOffset.y - originOffest - _refreshDistance;
            if(diff > 0 && !_loading){
                self.diff = diff;
            }
        }

    }
    
}

- (void)beginRefreshing{
    [self.scrollView setContentOffset:CGPointMake(0,  -_refreshDistance) animated:YES];
}

- (void)endRefreshing{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    } completion:^(BOOL finished) {
        self.loading = NO;
    }];
}

- (void)showNulMoreView{
    self.showNulMore = YES;
}

- (void)hiddenNulMoreView{
    self.showNulMore = NO;
}

@end
