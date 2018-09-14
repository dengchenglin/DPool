//
//  DPChartSelectView.m
//  DPool
//
//  Created by dengchenglin on 2018/9/13.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPChartSelectView.h"

@implementation DPChartSelectView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp{
    NSArray *titles = @[@"1小时",@"1天"];
    for (int i = 0;i < titles.count;i ++){
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:button];
        button.tag = 100 + i;
        button.titleLabel.font = FONT_PFRG_SIZE(13);
        [button setFrame:CGRectMake(0 + i * 50, 0, 50, self.height)];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button setTitleColor:RGBColor(100, 100, 100) forState:UIControlStateNormal];
        button.layer.borderWidth = LINE_WIDTH;
        button.layer.borderColor = RGBColor(230, 230, 230).CGColor;
        [button addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];

        
   
        if(i == 0){
            button.selected = YES;
            button.backgroundColor = DPColor;
        }
    }
}

- (void)tapAction:(UIButton *)button{

    for(int i = 0;i < 2;i ++){
        UIButton *btn = [self viewWithTag:100 + i];
        if(btn.tag == button.tag){
            btn.backgroundColor = DPColor;
            btn.selected = YES;
        }
        else{
            btn.backgroundColor = [UIColor whiteColor];
            btn.selected = NO;
        }
    }

    if(self.didClick){
        self.didClick(button.tag - 100);
    }
}



@end
