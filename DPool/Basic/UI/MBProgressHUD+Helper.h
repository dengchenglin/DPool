//
//  MBProgressHUD+Helper.h
//  YMKMain
//
//  Created by dengchenglin on 2018/7/3.
//  Copyright © 2018年 Property. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Helper)

+ (void)showMBProgressHudOnView:(UIView *)view;

+ (void)showMBProgressHudWithTitle:(NSString *)title hideAfterDelay:(NSTimeInterval)hideAfterDelay;


@end
