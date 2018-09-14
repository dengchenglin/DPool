//
//  CLRefreshCurveLayer.m
//  CLRefreshDemo
//
//  Created by dengchenglin on 2018/9/3.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "CLRefreshCurveLayer.h"

#import <UIKit/UIKit.h>

@implementation CLRefreshCurveLayer


- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    [self setNeedsDisplay];
}
-(void)drawInContext:(CGContextRef)ctx{
    
    [super drawInContext:ctx];
    
    UIGraphicsPushContext(ctx);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //Draw
    CGFloat radius = self.bounds.size.width/2;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius) radius:radius - 3 startAngle:- M_PI_4 endAngle:-M_PI_4 + (2 * M_PI - M_PI/8)* _progress clockwise:YES];
    [[UIColor colorWithRed:255/255.0f green:51/255.0f blue:0/255.0f alpha:1] setStroke];
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 3);
    [path stroke];
    CGContextSaveGState(context);
    CGContextRestoreGState(context);
    
    [[UIColor blackColor] setStroke];
    UIGraphicsPopContext();
    
}


#pragma mark -- Help Method

-(CGPoint)getMiddlePointWithPoint1:(CGPoint)point1 point2:(CGPoint)point2{
    
    CGFloat middle_x = (point1.x + point2.x)/2;
    CGFloat middle_y = (point1.y + point2.y)/2;
    
    return CGPointMake(middle_x, middle_y);
    
}

-(CGFloat)getDistanceWithPoint1:(CGPoint)point1 point2:(CGPoint)point2{
    
    return sqrtf(pow(fabs(point1.x - point2.x), 2) + pow(fabs(point1.y - point2.y), 2));
    
}


@end
