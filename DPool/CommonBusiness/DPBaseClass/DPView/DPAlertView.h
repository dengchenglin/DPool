//
//  DPAlertView.h
//  GeihuiCould
//
//  Created by dengchenglin on 2018/8/31.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DPAlertView : UIView

+ (void)showNoticeViewWithTitle:(NSString *)title;

+ (void)showErrorViewWithTitle:(NSString *)title;

+ (void)showOKViewWithTitle:(NSString *)title;

+ (void)showUpdateViewWithTitle:(NSString *)title didClick:(void(^)(NSUInteger index))didClick;

+ (void)showNoticeViewWithTitle:(NSString *)title didClick:(void(^)(NSUInteger index))didClick;

+ (void)showOptionalAlertViewWithLogoName:(NSString *)logoName title:(NSString *)title didClick:(void(^)(NSUInteger index))didClick;

@end
