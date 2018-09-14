
//
//  DPLoginNavBar.m
//  DPool
//
//  Created by dengchenglin on 2018/9/10.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPLoginNavBar.h"

@implementation DPLoginNavBar
{
    UIButton *_leftBtn;
    UILabel *_titleLabel;
}

+ (DPLoginNavBar *)navBar{
    return [[DPLoginNavBar alloc]initWithFrame:CGRectZero];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVBAR_HEIGHT)];
    if (self) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];

        [self addSubview:_leftBtn];
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_titleLabel];
    }
    return self;
}


- (void)layoutSubviews{
    [_leftBtn setFrame:CGRectMake(10, self.height - 37, 30, 30)];
    _leftBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [_titleLabel setFrame:CGRectMake(60, self.height - 44, self.width - 120, 44)];
}

- (void)setTitle:(NSString *)title{
    _title = title;
    _titleLabel.text = _title;
}

- (void)addBackTarget:(id)target selector:(SEL)selector{
    [_leftBtn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
}

@end
