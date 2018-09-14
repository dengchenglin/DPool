//
//  KeyboardManager.m
//  DPool
//
//  Created by dengchenglin on 2018/9/10.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "KeyboardManager.h"
#import "IQKeyboardManager.h"

@implementation KeyboardManager

+ (void)config{
    IQKeyboardManager.sharedManager.enableAutoToolbar = NO;
    IQKeyboardManager.sharedManager.shouldResignOnTouchOutside = YES;
    IQKeyboardManager.sharedManager.keyboardDistanceFromTextField = 0;
}

@end
