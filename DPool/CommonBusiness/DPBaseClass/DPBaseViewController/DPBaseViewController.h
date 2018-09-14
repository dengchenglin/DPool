//
//  GHBaseViewController.h
//  GeihuiCould
//
//  Created by dengchenglin on 2018/8/29.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DPBaseControllerProtocol.h"

@interface DPBaseViewController : UIViewController<DPBaseControllerProtocol>

@property (nonatomic, strong, readonly) UIScrollView *scrollView;

@property (nonatomic, strong, readonly) UIView *containerView;

@property (nonatomic, assign) BOOL  useScrollViewAsView;

@property (nonatomic, assign) BOOL showBackItem;

- (void)setLeftDefaultItem;

- (void)setRightButtonWithTitle:(NSString *)title size:(CGSize)size selector:(SEL)selector;

- (void)setRightButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor size:(CGSize)size selector:(SEL)selector;

- (void)setRightButtonWithImageName:(NSString *)imageName selector:(SEL)selector;

- (void)setRightButtonWithImageName:(NSString *)imageName size:(CGSize)size selector:(SEL)selector;

- (void)setRightButtonWithImageName:(NSString *)imageName imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets selector:(SEL)selector;

- (void)back;

@end
