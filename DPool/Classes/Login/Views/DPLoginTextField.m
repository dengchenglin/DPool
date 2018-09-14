//
//  DPLoginTextField.m
//  DPool
//
//  Created by dengchenglin on 2018/9/10.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPLoginTextField.h"

@implementation DPLoginTextField
{
    CALayer *_bottomLineLayer;
}
ViewInstance(setUp)

- (void)setUp{
    self.font = FONT_PFRG_SIZE(15);
    self.textColor = [UIColor whiteColor];
    self.returnKeyType = UIReturnKeyDone;
    _bottomLineLayer = [CALayer layer];
    _bottomLineLayer.backgroundColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:_bottomLineLayer];
}

- (void)setPlaceholder:(NSString *)placeholder{
    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc]initWithString:placeholder];
    [mutableAttributedString addAttributes:@{NSFontAttributeName:FONT_PFRG_SIZE(15),NSForegroundColorAttributeName:RGBAColor(200, 200, 200, 0.5)} range:NSMakeRange(0, placeholder.length)];
    self.attributedPlaceholder = mutableAttributedString;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _bottomLineLayer.frame = CGRectMake(0, self.height - LINE_WIDTH, self.width, LINE_WIDTH);
    
}

@end
