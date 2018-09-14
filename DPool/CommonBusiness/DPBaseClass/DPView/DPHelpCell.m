//
//  GHHelpCell.m
//  GeihuiDemo
//
//  Created by dengchenglin on 17/4/28.
//  Copyright © 2017年 peikua. All rights reserved.
//

#import "DPHelpCell.h"

@implementation DPHelpCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _imgView = [[UIImageView alloc]init];
        [self.contentView addSubview:_imgView];
        
        _titleLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_imgView setBounds:CGRectMake(0, 0, 60, 60)];
    [_imgView setCenter:CGPointMake(40, self.height/2)];
    [_titleLabel setFrame:CGRectMake(_imgView.maxX + 10, 0, 100, self.height)];
    if(_isNotice){
        [_imgView setBounds:CGRectMake(0, 0, 45, 45)];
    }
}

@end
