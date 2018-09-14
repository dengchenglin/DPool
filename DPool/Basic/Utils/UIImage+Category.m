//
//  UIImage+Category.m
//  YMKMain
//
//  Created by dengchenglin on 2018/6/29.
//  Copyright © 2018年 Property. All rights reserved.
//

#import "UIImage+Category.h"

@implementation UIImage (Category)

@end
@implementation UIImage (Color)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext(); return image;
}

@end

