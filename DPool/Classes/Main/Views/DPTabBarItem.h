//
//  DPTabBarItem.h
//  DPool
//
//  Created by dengchenglin on 2018/9/10.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DPTabBarItem : UIView

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *selectedImage;


@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) BOOL selected;

- (void)addTapGestureRecognizerWithBlock:(void(^)(id sender))block;

@end
