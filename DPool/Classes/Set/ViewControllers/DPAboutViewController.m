//
//  GHAboutViewController.m
//  GeihuiDemo
//
//  Created by dengchenglin on 17/4/29.
//  Copyright © 2017年 peikua. All rights reserved.
//

#import "DPAboutViewController.h"

@interface DPAboutViewController ()

@end

@implementation DPAboutViewController

- (void)configureView{
    self.title = @"关于";
    self.imageView.layer.cornerRadius = 8;
    [self setLeftDefaultItem];
}

@end
