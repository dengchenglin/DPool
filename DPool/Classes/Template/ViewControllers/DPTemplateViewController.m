//
//  DPTemplateViewController.m
//  DPool
//
//  Created by dengchenglin on 2018/9/10.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "DPTemplateViewController.h"

#import "DPNetworkEngine+App.h"

#import "DPImmediateView.h"

#import "DPTemplateChart.h"

#import "DPTemplateUnitView.h"

#import "DPRarningsView.h"

#import "DPOremachineView.h"

#import "DPTemplateAdressView.h"

#import "UIScrollView+CLRefresh.h"

@interface DPTemplateViewController ()

@property (nonatomic, strong)DPImmediateView *immediateView;

@property (nonatomic, strong)DPTemplateChart *templateChart;

@property (nonatomic, strong)DPTemplateUnitView *templateUnitView;

@property (nonatomic, strong)DPRarningsView *rarningsView;

@property (nonatomic, strong)DPOremachineView *oremachineView;

@property (nonatomic, strong)DPTemplateAdressView *templateAdressView;

@property (nonatomic, strong)DPTemplateModel *model;

@end

@implementation DPTemplateViewController

- (DPImmediateView *)immediateView{
    if(!_immediateView){
        _immediateView = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(DPImmediateView.class) owner:self options:nil][0];
        [self.containerView addSubview:_immediateView];
    }
    return _immediateView;
}
- (DPTemplateChart *)templateChart{
    if(!_templateChart){
        _templateChart = [[DPTemplateChart alloc]init];
        [self.containerView addSubview:_templateChart];
    }
    return _templateChart;
}

- (DPTemplateUnitView *)templateUnitView{
    if(!_templateUnitView){
        _templateUnitView = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(DPTemplateUnitView.class) owner:self options:nil][0];
        [self.containerView addSubview:_templateUnitView];
    }
    return _templateUnitView;
}
- (DPRarningsView *)rarningsView{
    if(!_rarningsView){
         _rarningsView = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(DPRarningsView.class) owner:self options:nil][0];
        [self.containerView addSubview:_rarningsView];
    }
    return _rarningsView;
}
- (DPOremachineView *)oremachineView{
    if(!_oremachineView){
        _oremachineView = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(DPOremachineView.class) owner:self options:nil][0];
        [self.containerView addSubview:_oremachineView];
    }
    return _oremachineView;
}
- (DPTemplateAdressView *)templateAdressView{
    if(!_templateAdressView){
        _templateAdressView = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(DPTemplateAdressView.class) owner:self options:nil][0];
        [self.containerView addSubview:_templateAdressView];
    }
    return _templateAdressView;
}



- (void)setUpUI{
    self.useScrollViewAsView = YES;
    @weakify(self);
    [self.scrollView addHeaderRefreshWithCallBack:^{
        @strongify(self);
        [self request];
    }];
}

- (void)setUpEvent{
    @weakify(self)
    [[[NSNotificationCenter defaultCenter]rac_addObserverForName:DP_NOTIFITION_LOGIN object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self)
        [self request];
    }];
}

- (void)layout{
    [self.immediateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(130);
    }];
    
    [self.templateChart setFrame:CGRectMake(10, 140, SCREEN_WIDTH - 10, DPTEMPLATECHART_VERTICAL_HGIGHT)];
    
    [self.templateUnitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.templateChart.maxY + 10);
        make.height.mas_equalTo(80);
    }];
    
    [self.rarningsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.templateUnitView.mas_bottom).offset(10);
        make.height.mas_equalTo(80);
    }];
    
    [self.oremachineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.rarningsView.mas_bottom).offset(10);
        make.height.mas_equalTo(80);
    }];
    
    [self.templateAdressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.oremachineView.mas_bottom).offset(10);
        make.height.mas_equalTo(120);
        make.bottom.mas_equalTo(self.containerView.mas_bottom).offset(-10);
    }];
}

- (void)request{
    [DPRequest userInfoWithPuid:[DPUserManager sharedInstance].cuid callback:^(id data, DPNetError error, NSString *msg) {
        [self.scrollView endRefreshing];
        [self reloadData:data];
    }];
}


- (void)reloadData:(id)data{
    self.model = [DPTemplateModel yy_modelWithDictionary:data];
    self.immediateView.model = self.model;
    self.templateUnitView.model = self.model;
    self.rarningsView.model = self.model;
    self.oremachineView.model = self.model;
    self.templateAdressView.model = self.model;
    self.templateChart.h_viewModel = [DPTemplateChartViewModel viewModelWithModels:self.model.history_h];
    self.templateChart.d_viewModel = [DPTemplateChartViewModel viewModelWithModels:self.model.history_d];
    [self.templateChart reloadView];
}


@end
