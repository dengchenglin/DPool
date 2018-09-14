//
//  DPHomeViewController.m
//  DPool
//
//  Created by dengchenglin on 2018/9/10.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPHomeViewController.h"

@interface DPHomeViewController ()

@end

@implementation DPHomeViewController

- (void)setUpUI{
    [self setRightButtonWithImageName:@"user" imageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5) selector:@selector(login)];
}

- (void)login{
    
    [DPModuleManager showLoginFromViewController:self callback:nil];
}

@end
