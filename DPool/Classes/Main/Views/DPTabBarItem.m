//
//  DPTabBarItem.m
//  DPool
//
//  Created by dengchenglin on 2018/9/10.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPTabBarItem.h"

@interface DPTabBarItem ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, strong) UITapGestureRecognizer *tap;

@property (nonatomic, copy) void(^block)(id sender);

@end

@implementation DPTabBarItem


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (UITapGestureRecognizer *)tap{
    if(!_tap){
        _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    }
    return _tap;
}

- (void)setUp{
    
    _imageView = [[UIImageView alloc]init];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_imageView];
    _textLabel = [[UILabel alloc]init];
    _textLabel.font = [UIFont systemFontOfSize:10];
    _textLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    _textLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_textLabel];
    
}

- (void)layoutSubviews{
    {
     [_imageView setBounds:CGRectMake(0, 0, 21, 21)];
     [_imageView setCenter:CGPointMake(self.width/2, self.height/2 - 7)];
     [_textLabel setFrame:CGRectMake(0, _imageView.maxY, self.width, self.height - _imageView.maxY)];
     }
    {/*
        [_imageView setBounds:CGRectMake(0, 0, 37, 37)];
        [_imageView setCenter:CGPointMake(self.width/2, self.height/2)];
        [_textLabel setFrame:CGRectZero];
        
    */}
}

- (void)setTitle:(NSString *)title{
    _title = title;
    _textLabel.text = title;
}

- (void)setImage:(NSString *)image{
    _image = image;
    [self reloadData];
}

- (void)setSelectedImage:(NSString *)selectedImage{
    _selectedImage = selectedImage;
    [self reloadData];
}


- (void)setSelected:(BOOL)selected{
    _selected = selected;
    [self reloadData];
}

- (void)reloadData{
    if(_selected){
        if([_selectedImage hasPrefix:@"http"]){
            [_imageView sd_setImageWithURL:[NSURL URLWithString:_selectedImage]];
        }
        else{
            _imageView.image = [UIImage imageNamed:_selectedImage];
        }
        
        _textLabel.textColor = [UIColor whiteColor];
    }
    else{
        if([_image hasPrefix:@"http"]){
            [_imageView sd_setImageWithURL:[NSURL URLWithString:_image]];
        }
        else{
            _imageView.image = [UIImage imageNamed:_image];
        }
        _textLabel.textColor = RGBColor(122, 179, 204);
    }
}

#pragma mark - TargetEvents

- (void)tapAction{
    if(self.block){
        self.block(self);
    }
}

- (void)addTapGestureRecognizerWithBlock:(void(^)(id sender))block{
    self.block = block;
    [self addGestureRecognizer:self.tap];
}


@end
