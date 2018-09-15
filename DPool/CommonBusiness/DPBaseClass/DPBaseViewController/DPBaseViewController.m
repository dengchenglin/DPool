//
//  GHBaseViewController.m
//  GeihuiCould
//
//  Created by dengchenglin on 2018/8/29.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPBaseViewController.h"

@interface DPBaseViewController ()

@end

@implementation DPBaseViewController

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    DPBaseViewController *viewController = [super allocWithZone:zone];
    [viewController initialize];
    @weakify(viewController)
    [[viewController rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
        @strongify(viewController)
        [viewController setUpUI];
        [viewController reloadView];
        [viewController request];
        [viewController setUpEvent];
        [viewController bindViewModel];
    }];
    [[viewController rac_signalForSelector:@selector(viewDidLayoutSubviews)] subscribeNext:^(id x) {
        @strongify(viewController)
        [viewController layout];
    }];

    return viewController;
}

- (void)setUseScrollViewAsView:(BOOL)useScrollViewAsView{
    _useScrollViewAsView = useScrollViewAsView;
    if(!self.viewLoaded)return;
    if(!self.scrollView)
    {
        //为了防止有些子视图是frame设置 从而能正确初始化子视图frame
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
        _scrollView.alwaysBounceVertical = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_scrollView];
        if(!_containerView){
            _containerView = [[UIView alloc]init];
        }
        
        [_scrollView addSubview:_containerView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view);
        }];
        [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.scrollView);
            make.width.mas_equalTo(self.scrollView);
        }];
        
        if (@available(iOS 11.0, *)) {
            self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
    }
    
}

- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = DPBackGroundColor;
    self.extendedLayoutIncludesOpaqueBars = YES;
    if(!IOS_11){
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
   
    if(self.navigationController.viewControllers.count > 1){
        [self setLeftDefaultItem];
    }
    [self configureNavBar];
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if([self.navigationController.viewControllers indexOfObject:self] > 0){
        self.tabBarController.tabBar.hidden = YES;
        self.hidesBottomBarWhenPushed = YES;
        self.edgesForExtendedLayout = UIRectEdgeBottom;
    }
    else{
        self.tabBarController.tabBar.hidden = NO;
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
}


- (void)setLeftDefaultItem{
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setFrame:CGRectMake(0, 0, 40, 30)];
//    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
    backBtn.titleLabel.font = FONT_PFRG_SIZE(15);
    UIBarButtonItem * item =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = item;
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    if(IOS_11){
        [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(backBtn.size);
        }];
    }
}

- (void)setRightButtonWithImageName:(NSString *)imageName selector:(SEL)selector{
    [self setRightButtonWithImageName:imageName size:CGSizeZero selector:selector];
}

- (void)setRightButtonWithTitle:(NSString *)title size:(CGSize)size selector:(SEL)selector{
    [self setRightButtonWithTitle:title titleColor:nil size:size selector:selector];
}

- (void)setRightButtonWithImageName:(NSString *)imageName size:(CGSize)size selector:(SEL)selector{
    [self setRightButtonWithImageName:imageName size:size imageEdgeInsets:UIEdgeInsetsZero selector:selector];
}

- (void)setRightButtonWithImageName:(NSString *)imageName imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets selector:(SEL)selector{
    [self setRightButtonWithImageName:imageName size:CGSizeZero imageEdgeInsets:imageEdgeInsets selector:selector];
}

- (void)setRightButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor size:(CGSize)size selector:(SEL)selector{
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, size.width, size.height)];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitle:title forState:UIControlStateNormal];
    
    [button setTitleColor:(titleColor?titleColor:RGBColor(102, 102, 102)) forState:UIControlStateNormal];
    
    if(selector){
        [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
    if(IOS_11){
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(size);
        }];
    }
}



- (void)setRightButtonWithImageName:(NSString *)imageName size:(CGSize)size imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets selector:(SEL)selector{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    if(size.width == 0 || size.height == 0){
        size = CGSizeMake(30, 30);
    }
    if(!UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsZero, imageEdgeInsets)){
        button.imageEdgeInsets = imageEdgeInsets;
    }
    [button setFrame:CGRectMake(0, 0, size.width, size.height)];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    UIBarButtonItem * item =[[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
    if(IOS_11){
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(button.size);
        }];
    }
}



- (void)configureNavBar{
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:DPNavTitleColor,NSFontAttributeName:FONT_PFRG_SIZE(17)}];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:RGBColor(240, 240, 240)]];
}

- (void)back{
    if(self.navigationController.viewControllers.count > 1){
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)setShowBackItem:(BOOL)showBackItem{
    _showBackItem = showBackItem;
    if(_showBackItem){
        [self setLeftDefaultItem];
    }
    else{
        self.navigationItem.leftBarButtonItem = nil;
    }
}

- (void)initialize{}

- (void)setUpUI{}

- (void)reloadView{}

- (void)request{}

- (void)layout{}

- (void)setUpEvent{}

- (void)bindViewModel{}

- (void)reloadData:(id)data{};


@end
