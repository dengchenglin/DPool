//
//  DPLoginBaseViewController.m
//  DPool
//
//  Created by dengchenglin on 2018/9/10.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPLoginBaseViewController.h"

#import "DPLoginNavBar.h"

@interface DPLoginBaseViewController ()
{
    DPLoginNavBar *_navbar;
}
@end

@implementation DPLoginBaseViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad{

    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor= RGBColor(35, 56, 73);
    
    
    _navbar = [DPLoginNavBar navBar];
    [_navbar addBackTarget:self selector:@selector(back)];
    [self.view addSubview:_navbar];
    
    self.view.layer.contents = (__bridge id)[UIImage imageNamed:@"login_bg"].CGImage;
}

- (void)setTitle:(NSString *)title{
    [super setTitle:title];
    _navbar.title = title;
}



@end
