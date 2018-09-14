//
//  GHSetCell.m
//  GeihuiDemo
//
//  Created by dengchenglin on 2017/5/12.
//  Copyright © 2017年 peikua. All rights reserved.
//

#import "DPSetCell.h"

@interface DPSetCell ()

@property (nonatomic, strong) UISwitch *switchBtn;

@end

@implementation DPSetCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        _switchBtn = [[UISwitch alloc]init];
        _switchBtn.hidden = YES;
        [_switchBtn setOn:YES];
        [self.contentView addSubview:_switchBtn];
        
        _rightLabel = [[UILabel alloc]init];
        _rightLabel.font = [UIFont systemFontOfSize:14];
        _rightLabel.textColor = RGBColor(100, 100, 100);
        _rightLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_rightLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_switchBtn setCenter:CGPointMake(self.width - 40, self.height/2)];
    [self.imgView setBounds:CGRectMake(0, 0, 30, 30)];
    
    [_rightLabel setFrame:CGRectMake(self.width - 120, 0, 100, self.height)];
    
}


- (void)setIsPush:(BOOL)isPush{
    _isPush = isPush;
    _switchBtn.hidden = !_isPush;
}


@end
