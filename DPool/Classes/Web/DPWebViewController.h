//
//  DPWebViewController.h
//  DPMain
//
//  Created by dengchenglin on 2018/7/5.
//  Copyright © 2018年 Property. All rights reserved.
//

#import "DPBaseViewController.h"

@interface DPWebViewController : DPBaseViewController

@property (nonatomic,copy)NSString *url;

@property (nonatomic, copy) NSString *s_title;

+ (UIViewController *_Nullable)webViewControllerWithUrl:(NSString *_Nullable)url title:(NSString *_Nullable)title;;

+ (void)showWebFromViewController:(UIViewController * _Nonnull)viewController url:(NSString * _Nonnull)url;


@end
