//
//  DPTemplateChart.m
//  DPool
//
//  Created by dengchenglin on 2018/9/12.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPTemplateChart.h"

#import "DPChartSelectView.h"

@interface DPTemplateChart ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *contentView;

@property (nonatomic, strong) UIScrollView *hotrizontalScrollView;

@property (nonatomic, assign) NSUInteger index;


@end

@implementation DPTemplateChart{
    CAShapeLayer *lineLayer;
    DPChartSelectView *_selectView;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        _selectView = [[DPChartSelectView alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
        [self addSubview:_selectView];
        @weakify(self)
        [_selectView setDidClick:^(NSUInteger index) {
         @strongify(self)
            self.index = index;
            [self reloadView];
        }];
    }
    return self;
}
- (void)layoutSubviews{
    [_selectView setCenter:CGPointMake(self.width/2, 40)];
}

- (DPTemplateChartViewModel *)viewModel{
    return _index?_d_viewModel:_h_viewModel;
}

- (void)setH_viewModel:(DPTemplateChartViewModel *)h_viewModel{
    _h_viewModel = h_viewModel;
}

- (void)setD_viewModel:(DPTemplateChartViewModel *)d_viewModel{
    _d_viewModel = d_viewModel;
}

- (void)reloadView{
   
    for(UIView * view in self.subviews){
        if(![view isKindOfClass:[DPChartSelectView class]]){
            [view removeFromSuperview];
        }
    }

  if(![self viewModel]) return;
    CGFloat titleWidth = [self viewModel].titleMaxWidth;
    UIColor *lineColor = RGBColor(150, 150, 150);
    CALayer *line = [CALayer layer];
    [line setFrame:CGRectMake(50 , 20, 1, self.height - 60)];
    line.backgroundColor = lineColor.CGColor;
    [self.layer addSublayer:line];

    {
   
     
        for(int i = 0;i < [self viewModel].verticals.count;i ++){
            CALayer *intervalLine = [CALayer layer];
            [intervalLine setBounds:CGRectMake(0, 0, 10, 1)];
            intervalLine.position = CGPointMake(line.frame.origin.x - intervalLine.bounds.size.width/2 , CGRectGetMaxY(line.frame) - i * [self viewModel].itemHeight);
            intervalLine.backgroundColor = lineColor.CGColor;
            [self.layer addSublayer:intervalLine];
            if(i == 0){
                [intervalLine setBounds:CGRectZero];
            }
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(line.frame.origin.x - 50, 0,  40, [self viewModel].itemHeight)];
            [label setCenterY:intervalLine.position.y];
            label.text = [self viewModel].verticals[i];
            label.textAlignment = NSTextAlignmentCenter;
            label.adjustsFontSizeToFitWidth = YES;
            label.font = [UIFont systemFontOfSize:8];
            label.textColor = RGBColor(80, 80, 80);
            [self addSubview:label];
        }
        
        UIImageView *arrow = [[UIImageView alloc]init];
        [arrow setBounds:CGRectMake(0, 0, 8, 8)];
        [arrow setCenter:CGPointMake(line.position.x, line.frame.origin.y - 4)];
        arrow.image = [UIImage imageNamed:@"vertical_arrow"];
        [self addSubview:arrow];
    }
    
    _contentView = [[UIScrollView alloc]init];
    _contentView.showsVerticalScrollIndicator = NO;
    _contentView.showsHorizontalScrollIndicator = NO;
    _contentView.delegate = self;
    _contentView.bounces = NO;
    [self addSubview:_contentView];
    [_contentView setFrame:CGRectMake(CGRectGetMaxX(line.frame), line.frame.origin.y, self.width - line.frame.origin.x - 50, line.frame.size.height)];
    _contentView.contentSize = CGSizeMake([self viewModel].contentSize.width, _contentView.height);
    
    
    _hotrizontalScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(_contentView.left, _contentView.maxY, _contentView.width, 30)];
    _hotrizontalScrollView.showsVerticalScrollIndicator = NO;
    _hotrizontalScrollView.showsHorizontalScrollIndicator = NO;
    _hotrizontalScrollView.delegate = self;
    _hotrizontalScrollView.bounces = NO;
    [self addSubview:_hotrizontalScrollView];
    _hotrizontalScrollView.contentSize = CGSizeMake([self viewModel].contentSize.width, _hotrizontalScrollView.height);
    
    {
        CALayer *horizontalLine = [CALayer layer];
        [horizontalLine setFrame:CGRectMake(0, _contentView.height - 1, [self viewModel].horizontals.count * [self viewModel].itemWidth, 1)];
        horizontalLine.backgroundColor = lineColor.CGColor;
        [_contentView.layer addSublayer:horizontalLine];
        
        for(int i = 1;i < [self viewModel].horizontals.count;i ++){
            
            CALayer *intervalLine = [CALayer layer];
            [intervalLine setBounds:CGRectMake(0, 0, 1, 10)];
            intervalLine.position = CGPointMake(i * [self viewModel].itemWidth,  intervalLine.bounds.size.height/2);
            intervalLine.backgroundColor = lineColor.CGColor;
            [_hotrizontalScrollView.layer addSublayer:intervalLine];
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(i * [self viewModel].itemWidth - [self viewModel].itemWidth/2 , 10, [self viewModel].itemWidth, 18)];
            [label setCenterX:intervalLine.position.x];
            label.text = [self viewModel].horizontals[i].title;
            label.textAlignment = NSTextAlignmentCenter;
            label.numberOfLines = 0;
            label.font = [UIFont systemFontOfSize:7];
            label.textColor = RGBColor(80, 80, 80);
            [_hotrizontalScrollView addSubview:label];
        }
        
        UIImageView *arrow = [[UIImageView alloc]init];
        [arrow setBounds:CGRectMake(0, 0, 8, 8)];
        [arrow setCenter:CGPointMake(CGRectGetMaxX(horizontalLine.frame) - arrow.bounds.size.width/2, horizontalLine.position.y)];
        arrow.image = [UIImage imageNamed:@"horizontal_arrow"];
        [_contentView addSubview:arrow];
    }
    
    
    [self startAnimation];

    [self addSubview:_selectView];
}

- (void)startAnimation{
    
   
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    for(int i = 0;i < [self viewModel].horizontals.count;i ++){
        CGPoint point = [self viewModel].horizontals[i].point;
        point = CGPointMake(point.x, _contentView.height - point.y);
        if(i == 0){
            [path moveToPoint:point];
        }
        else{
           
            [path addLineToPoint:point];
        }
    }
    
    lineLayer = [CAShapeLayer layer];
    lineLayer.lineWidth = 1.0;
    lineLayer.strokeColor = DPColor.CGColor;
    lineLayer.fillColor = nil;
    [_contentView.layer addSublayer:lineLayer];
    lineLayer.path = path.CGPath;
    lineLayer.strokeEnd = 0;
    
    CABasicAnimation *baseAinmation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    baseAinmation.duration = [self viewModel].horizontals.count * 0.1f;
    baseAinmation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    baseAinmation.fromValue = [NSNumber numberWithFloat:0.0f];
    baseAinmation.toValue = [NSNumber numberWithFloat:1.0f];
    baseAinmation.fillMode = kCAFillModeForwards;
    baseAinmation.removedOnCompletion = NO;
    
    
    CGPoint lastPoint = [self viewModel].horizontals.lastObject.point;
    lastPoint = CGPointMake(lastPoint.x, _contentView.height);
    CGPoint startPoint = CGPointMake(0, _contentView.height);
    
    
    UIBezierPath *areaPath = [UIBezierPath bezierPath];
    [areaPath appendPath:path];
    [areaPath addLineToPoint:lastPoint];
    [areaPath addLineToPoint:startPoint];
    [areaPath closePath];
    
    CAShapeLayer *areaLayer = [CAShapeLayer layer];
    areaLayer.path = areaPath.CGPath;
    areaLayer.fillColor = RGBColor(244, 251, 249).CGColor;
    [self.contentView.layer insertSublayer:areaLayer atIndex:0];

    [lineLayer addAnimation:baseAinmation forKey:nil];
    [CATransaction commit];
    
    
    

    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(scrollView == _hotrizontalScrollView){
        _contentView.contentOffset = _hotrizontalScrollView.contentOffset;
    }
    if(scrollView == _contentView){
        _hotrizontalScrollView.contentOffset = _contentView.contentOffset;
    }
}


@end
