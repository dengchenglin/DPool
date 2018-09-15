//
//  MBProgressHUD+Helper.m
//  YMKMain
//
//  Created by dengchenglin on 2018/7/3.
//  Copyright © 2018年 Property. All rights reserved.
//

#import "MBProgressHUD+Helper.h"

#import <MBProgressHUD/MBProgressHUD.h>

@implementation MBProgressHUD (Helper)


+ (void)showMBProgressHudOnView:(UIView *)view{
    if(!view)return;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.contentColor = [UIColor whiteColor];
    [hud showAnimated:YES];

}

+ (void)showMBProgressHudWithTitle:(NSString *)title hideAfterDelay:(NSTimeInterval)hideAfterDelay{
    [self showMBProgressHudOnView:nil title:title hideAfterDelay:hideAfterDelay];

}

+ (void)showMBProgressHudOnView:(UIView *)view title:(NSString *)title hideAfterDelay:(NSTimeInterval)hideAfterDelay{
    if(!title.length)return;
    if(!view){
        view = [UIApplication sharedApplication].keyWindow;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabel.font = [UIFont systemFontOfSize:16];
    hud.detailsLabel.text = title;
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.contentColor = [UIColor whiteColor];
    hud.mode = MBProgressHUDModeText;
    [hud hideAnimated:YES afterDelay:hideAfterDelay];
}

+ (void)hideAllMBProgressHudOnView:(UIView *)view{
    for(UIView * v in view.subviews){
        if([v isKindOfClass:[MBProgressHUD class]]){
            [v removeFromSuperview];
        }
    }
}

@end
