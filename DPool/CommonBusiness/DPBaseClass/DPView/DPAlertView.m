//
//  DPAlertView.m
//  GeihuiCould
//
//  Created by dengchenglin on 2018/8/31.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPAlertView.h"


@interface DPAlertContentView:UIView

@property (nonatomic, strong)UIImageView *logoImageView;

@property (nonatomic, strong)UILabel *contentLabel;

@property (nonatomic, strong)UIView *bottomLine;

@property (nonatomic, strong)UIButton *cancelBtn;

@property (nonatomic, strong)UIButton *doneBtn;

@end

@implementation DPAlertContentView

- (instancetype)initWithFrame:(CGRect)frame logoName:(NSString *)logoName content:(NSString *)content cancelTitle:(NSString *)cancelTitle doneTitle:(NSString *)doneTitle{
    if(self = [super initWithFrame:frame]){

        
        CGFloat top = 25;
        if(logoName.length){
            _logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.width - 37)/2, 25, 37, 37)];
            _logoImageView.image = [UIImage imageNamed:logoName];
            [self addSubview:_logoImageView];
            top = _logoImageView.maxY + 18;
        }
        
        if(content.length){
            _contentLabel = [[UILabel alloc]init];
            _contentLabel.text = content;
            _contentLabel.textColor = RGBColor(102, 102, 102);
            _contentLabel.font = FONT_PFRG_SIZE(14);
            _contentLabel.textAlignment = NSTextAlignmentCenter;
            _contentLabel.numberOfLines = 0;
            [self addSubview:_contentLabel];
            
            CGSize size = [content sizeWithFont:_contentLabel.font constrainedToSize:CGSizeMake(self.width - 40, 400)];
            _contentLabel.frame = CGRectMake(20, top, self.width - 40, size.height + 1);
            top = _contentLabel.maxY + 26;
        }
        
        _bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, top, self.width, LINE_WIDTH)];
        _bottomLine.backgroundColor = RGBColor(225, 225, 225);
        [self addSubview:_bottomLine];
        top = _bottomLine.maxY;
        
        if(cancelTitle.length){
            _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [_cancelBtn setTitle:cancelTitle forState:UIControlStateNormal];
            _cancelBtn.titleLabel.font = FONT_PFRG_SIZE(15);
            [_cancelBtn setTitleColor:RGBColor(51, 51, 51) forState:UIControlStateNormal];
            [self addSubview:_cancelBtn];

        }
        
        if(doneTitle.length){
            _doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [_doneBtn setTitle:doneTitle forState:UIControlStateNormal];
            _doneBtn.titleLabel.font = FONT_PFRG_SIZE(15);
            [_doneBtn setTitleColor:DPColor forState:UIControlStateNormal];
            [self addSubview:_doneBtn];
        }
        
        CGFloat btnHeight = 44;
        if(cancelTitle.length && doneTitle.length){
            _cancelBtn.frame = CGRectMake(0, top, self.width/2, btnHeight);
            UIView *centerline = [[UIView alloc]initWithFrame:CGRectMake(0, 0, LINE_WIDTH, 20)];
            centerline.center = CGPointMake(self.width/2, top + btnHeight/2);
            centerline.backgroundColor = RGBColor(240, 240, 240);
            [self addSubview:centerline];
        }
        else if (cancelTitle.length){
            _cancelBtn.frame = CGRectMake(0, top, self.width, btnHeight);
        }
        else{
            _doneBtn.frame = CGRectMake(0, top, self.width, btnHeight);
        }

        [self setHeight:top + btnHeight];
        
    }
    return self;
}


@end

@interface DPAlertView ()

@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) DPAlertContentView *contentView;

@property (nonatomic, copy) void(^didClick)(NSUInteger index);

@end


@implementation DPAlertView

+ (void)showNoticeViewWithTitle:(NSString *)title{
    DPAlertView *alertView = [[DPAlertView alloc]initWithLogoName:@"notice" content:title cancelTitle:nil doneTitle:@"知道了"];
  
    [[UIApplication sharedApplication].keyWindow addSubview:alertView];
}

+ (void)showErrorViewWithTitle:(NSString *)title{
    DPAlertView *alertView = [[DPAlertView alloc]initWithLogoName:@"error" content:title cancelTitle:nil doneTitle:@"确定"];
    
    [[UIApplication sharedApplication].keyWindow addSubview:alertView];
}

+ (void)showOKViewWithTitle:(NSString *)title{
    DPAlertView *alertView = [[DPAlertView alloc]initWithLogoName:nil content:title cancelTitle:nil doneTitle:@"确定"];
    [[UIApplication sharedApplication].keyWindow addSubview:alertView];
}

+ (void)showUpdateViewWithTitle:(NSString *)title didClick:(void(^)(NSUInteger index))didClick{
    DPAlertView *alertView = [[DPAlertView alloc]initWithLogoName:@"error" content:title cancelTitle:nil doneTitle:@"升级"];
    alertView.didClick = didClick;
    [[UIApplication sharedApplication].keyWindow addSubview:alertView];
}

+ (void)showNoticeViewWithTitle:(NSString *)title didClick:(void(^)(NSUInteger index))didClick{
    DPAlertView *alertView = [[DPAlertView alloc]initWithLogoName:@"error" content:title cancelTitle:nil doneTitle:@"确定"];
    alertView.didClick = didClick;
    [[UIApplication sharedApplication].keyWindow addSubview:alertView];
}

+ (void)showOptionalAlertViewWithLogoName:(NSString *)logoName title:(NSString *)title didClick:(void(^)(NSUInteger index))didClick{
    DPAlertView *alertView = [[DPAlertView alloc]initWithLogoName:logoName content:title cancelTitle:@"取消" doneTitle:@"确定"];
    alertView.didClick = didClick;
    [[UIApplication sharedApplication].keyWindow addSubview:alertView];
}


- (instancetype)initWithLogoName:(NSString *)logoName content:(NSString *)content cancelTitle:(NSString *)cancelTitle doneTitle:(NSString *)doneTitle
{
    self = [super initWithFrame:SCREEN_BOUNDS];
    if (self) {
        _backgroundImageView = [[UIImageView alloc]initWithFrame:self.bounds];
        _backgroundImageView.alpha = 0.7;
        _backgroundImageView.backgroundColor = [UIColor blackColor];
        [self addSubview:_backgroundImageView];
        
        _contentView = [[DPAlertContentView alloc]initWithFrame:CGRectMake(46,self.height/2 - 83, self.width - 92, 166) logoName:logoName content:content cancelTitle:cancelTitle doneTitle:doneTitle];
        [_contentView setCenterY:self.height/2 - 30];
        
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.cornerRadius = 8;
        _contentView.clipsToBounds = YES;
        [self addSubview:_contentView];
        
       
        @weakify(self)
        [_contentView.cancelBtn touchUpInsideSubscribeNext:^(id x) {
         @strongify(self)
            [self remove];
            if(self.didClick){
                self.didClick(0);
            }
        }];
        [_contentView.doneBtn touchUpInsideSubscribeNext:^(id x) {
            @strongify(self)
            [self remove];
            if(self.didClick){
                self.didClick(1);
            }
        }];
         [self startAnimation];
    }
    return self;
}

-(void)startAnimation{
    self.backgroundImageView.alpha = 0.0;
    self.contentView.transform = CGAffineTransformMakeScale(0.05, 0.05);
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:5 initialSpringVelocity:30 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self.backgroundImageView.alpha = 0.5;
        self.contentView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {

    }];
}

- (void)remove{
    [self removeFromSuperview];
}


@end
